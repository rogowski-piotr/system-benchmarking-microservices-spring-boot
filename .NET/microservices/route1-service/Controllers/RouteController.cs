using Microsoft.AspNetCore.Mvc;

using Route1Service.Services;

namespace Route1Service.Controllers
{
    [ApiController]
    public class RouteController : ControllerBase
    {
        private readonly RouteService _routeService;
        public RouteController(RouteService routeService)
        {
            _routeService = routeService;
        }

        [Route("api/route1")]
        [HttpGet]
        public async Task<IActionResult> Route(string id)
        {
            var ids = Array.ConvertAll(id.Split(','), x => Int32.Parse(x)).ToList();

            return Ok(await _routeService.ComputeRouteAsync(ids));
        }
    }
}
