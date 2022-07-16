using Microsoft.AspNetCore.Mvc;

using Monolith.Services;

namespace Monolith.Controllers
{
    [ApiController]
    public class Route1Controller : ControllerBase
    {
        private readonly Route1Service _routeService;
        public Route1Controller(Route1Service routeService)
        {
            _routeService = routeService;
        }

        [Route("api/route1")]
        [HttpGet]
        public IActionResult Route(string id)
        {
            var ids = Array.ConvertAll(id.Split(','), x => Int32.Parse(x)).ToList();

            return Ok(_routeService.ComputeRoute(ids));
        }
    }
}
