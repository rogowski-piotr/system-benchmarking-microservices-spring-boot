using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

using Monolith.Services;

namespace Monolith.Controllers
{
    [ApiController]
    public class Route2Controller : ControllerBase
    {
        private readonly Route2Service _routeService;
        public Route2Controller(Route2Service routeService)
        {
            _routeService = routeService;
        }

        [Route("api/route2")]
        [HttpGet]
        public IActionResult Route(string id)
        {
            var ids = Array.ConvertAll(id.Split(','), x => Int32.Parse(x)).ToList();

            return Ok(_routeService.ComputeRoute(ids));
        }
    }
}
