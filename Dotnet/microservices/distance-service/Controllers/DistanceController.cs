using DistanceService.Requests;
using DistanceService.Responses;
using DistanceService.Services;
using DistanceService.Models;

using Microsoft.AspNetCore.Mvc;

namespace DistanceService.Controllers
{
    [ApiController]
    public class DistanceController : ControllerBase
    {
        private readonly SphericalDistanceService _sphericalDistanceService;

        public DistanceController(SphericalDistanceService sphericalDistanceService)
        {
            _sphericalDistanceService = sphericalDistanceService;
        }

        [Route("api/distance")]
        [HttpPost]
        public IActionResult Distance(List<DistanceRequest> req)
        {
            List<Point> points = DistanceRequest.DtoToEntityMapper(req);
            List<double> distances = points.Select(pointPair =>
                _sphericalDistanceService.CalculateDistance(
                    pointPair.Latitude1, pointPair.Longitude1, pointPair.Latitude2, pointPair.Longitude2)
            ).ToList();
            return Ok(DistanceResponse.EntityToDtoMapper(points, distances));
        }
    }
}
