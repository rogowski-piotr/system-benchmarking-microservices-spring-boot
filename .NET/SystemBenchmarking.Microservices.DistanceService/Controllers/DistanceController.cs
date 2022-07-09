using Microsoft.AspNetCore.Mvc;

using SystemBenchmarking.Shared;
using SystemBenchmarking.Shared.Requests;
using SystemBenchmarking.Shared.Responses;

namespace SystemBenchmarking.Microservices.DistanceService.Controllers
{
    [ApiController]
    public class DistanceController : ControllerBase
    {
        [Route("api/distance/")]
        public DistanceResponse CalculateDistance(DistanceRequest request)
        {
            var points = request.GetPoints();

            var point1 = points[0];
            var point2 = points[1];

            var distance = Calculations.CalculateDistance(point1.Latitude, point1.Longitude, point2.Latitude, point2.Longitude);

            return new DistanceResponse { Distance = distance };
        }
    }
}
