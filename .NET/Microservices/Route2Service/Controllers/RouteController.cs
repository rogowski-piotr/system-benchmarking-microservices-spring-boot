using Microsoft.AspNetCore.Mvc;

using Route2Service.Services;

namespace Route2Service.Controllers
{
    [ApiController]
    public class RouteController : ControllerBase
    {
        private readonly RouteService _routeService;
        public RouteController(RouteService routeService)
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
