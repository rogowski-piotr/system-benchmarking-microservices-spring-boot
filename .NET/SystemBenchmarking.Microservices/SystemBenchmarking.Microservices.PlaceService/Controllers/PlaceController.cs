using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

using SystemBenchmarking.Data.Models;
using SystemBenchmarking.Data.Requests;
using SystemBenchmarking.Data.Services;

namespace SystemBenchmarking.Microservices.PlaceService.Controllers
{
    [ApiController]
    [Route("api/places")]
    public class PlaceController : ControllerBase
    {
        [HttpGet]
        public List<Place> GetAllPlaces()
        {
            return DataProvider.Places;
        }

        [HttpGet("{id}")]
        public IActionResult GetSinglePlace(int id)
        {
            var place = DataProvider.FindById(id);

            if (place == null)
                return NotFound();

            return Ok(place);
        }
    }
}
