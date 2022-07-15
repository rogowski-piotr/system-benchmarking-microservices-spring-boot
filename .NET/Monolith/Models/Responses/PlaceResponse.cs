using System.Text.Json.Serialization;

namespace Monolith.Models.Responses
{
    public class PlaceResponse
    {
        [JsonPropertyName("id")]
        public int Id { get; set; }

        [JsonPropertyName("city")]
        public string City { get; set; }

        [JsonPropertyName("coordinates")]
        public string Coordinates { get; set; }

        private PlaceResponse(int id, string city, string coordinates)
        {
            Id = id;
            City = city;
            Coordinates = coordinates;
        }

        public static PlaceResponse EntityToDtoMapper(Place place)
            => new(place.Id, place.City, place.Coordinates);
    }
}
