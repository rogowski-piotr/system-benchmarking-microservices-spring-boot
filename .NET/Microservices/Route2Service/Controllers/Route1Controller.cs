using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

using Route2Service.Services;

namespace Route2Service.Controllers
{
    [ApiController]
    public class Route1Controller : ControllerBase
    {
        private readonly RouteService _routeService;
        public Route1Controller(RouteService routeService)
        {
            _routeService = routeService;
        }

        [Route("api/route2")]
        [HttpGet]
        public async Task<IActionResult> Route(string id)
        {
            var ids = Array.ConvertAll(id.Split(','), x => Int32.Parse(x)).ToList();

            return Ok(await _routeService.ComputeRouteAsync(ids));
        }
    }
}
