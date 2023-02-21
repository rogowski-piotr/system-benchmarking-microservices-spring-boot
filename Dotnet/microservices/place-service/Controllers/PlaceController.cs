using Microsoft.AspNetCore.Mvc;

using PlaceService.Repositories;
using PlaceService.Responses;

namespace PlaceService.Controllers
{
    [ApiController]
    public class PlaceController : ControllerBase
    {
        private readonly PlaceRepository _placeRepository;
        public PlaceController(PlaceRepository placeRepository)
        {
            _placeRepository = placeRepository;
        }

        [Route("api/places/all")]
        public IActionResult Places()
        {
            return Ok(PlacesAllResponse.GetPlacesResponses(_placeRepository.Places));
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

        [Route("api/places")]
        [HttpGet]
        public IActionResult PlacesById(string ids)
        {
            var idsList = Array.ConvertAll(ids.Split(','), x => Int32.Parse(x)).ToList();
            var places = _placeRepository.FindByIds(idsList);
            var responseDto = PlacesResponse.GetPlacesResponses(places);
            return Ok(responseDto);
        }
    }
}
