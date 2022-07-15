using System.Text.Json.Serialization;

namespace Benchmark.Models.Responses
{
    public class PlacesResponse
    {
        [JsonPropertyName("id")]
        public int Id { get; set; }

        [JsonPropertyName("city")]
        public string City { get; set; }

        private PlacesResponse(int id, string city)
        {
            Id = id;
            City = city;
        }

        public static List<PlacesResponse> GetPlacesResponses(List<Place> collection)
            => collection.ConvertAll(new Converter<Place, PlacesResponse>(c => new(c.Id, c.City)));
    }
}
