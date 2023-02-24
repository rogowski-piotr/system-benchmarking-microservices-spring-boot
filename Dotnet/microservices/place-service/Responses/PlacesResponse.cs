using PlaceService.Models;

using System.Text.Json.Serialization;

namespace PlaceService.Responses
{
    public class PlacesResponse
    {
        [JsonPropertyName("id")]
        public int Id { get; set; }

        [JsonPropertyName("coordinates")]
        public string Coordinates { get; set; }

        private PlacesResponse(int id, string coordinates)
        {
            Id = id;
            Coordinates = coordinates;
        }

        public static List<PlacesResponse> GetPlacesResponses(List<Place> collection)
            => collection.ConvertAll(new Converter<Place, PlacesResponse>(c => new(c.Id, c.Coordinates)));
    }
}
