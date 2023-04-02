using PlaceService.Models;

using System.Text.Json.Serialization;

namespace PlaceService.Responses
{
    public class PlacesAllResponse
    {
        [JsonPropertyName("id")]
        public int Id { get; set; }

        [JsonPropertyName("city")]
        public string City { get; set; }

        [JsonPropertyName("coordinates")]
        public string Coordinates { get; set; }

        private PlacesAllResponse(int id, string city, string coordinates)
        {
            Id = id;
            City = city;
            Coordinates = coordinates;
        }

        public static List<PlacesAllResponse> GetPlacesResponses(List<Place> collection)
            => collection.ConvertAll(new Converter<Place, PlacesAllResponse>(c => new(c.Id, c.City, c.Coordinates)));
    }
}
