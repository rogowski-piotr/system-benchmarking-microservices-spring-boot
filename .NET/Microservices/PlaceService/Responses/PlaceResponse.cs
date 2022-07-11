using PlaceService.Models;

using System.Text.Json.Serialization;

namespace PlaceService.Responses
{
    public class PlaceResponse
    {
        [JsonPropertyName("id")]
        public int Id { get; set; }

        [JsonPropertyName("city")]
        public string City { get; set; }

        [JsonPropertyName("coordinates")]
        public string Coordinates { get; set; }

        public PlaceResponse()
        {

        }

        public PlaceResponse(int id, string city, string coordinates)
        {
            Id = id;
            City = city;
            Coordinates = coordinates;
        }

        public PlaceResponse(Place place)
        {
            Id = place.Id;
            City = place.City;
            Coordinates = place.Coordinates;
        }
    }
}
