using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

using Monolith.Models.Responses;
using Monolith.Repositories;

namespace Monolith.Controllers
{
    [ApiController]
    public class PlaceController : ControllerBase
    {
        private readonly PlaceRepository _placeRepository;
        public PlaceController(PlaceRepository placeRepository)
        {
            _placeRepository = placeRepository;
        }

        [Route("api/places")]
        public IActionResult Places()
        {
            return Ok(PlacesResponse.GetPlacesResponses(_placeRepository.Places));
        }

        [Route("api/places/{id}")]
        [HttpGet]
        public IActionResult Places(int id)
        {
            var place = _placeRepository.FindById(id);

            if (place == null)
                return NotFound();

            return Ok(PlaceResponse.EntityToDtoMapper(place));
        }
    }
}
