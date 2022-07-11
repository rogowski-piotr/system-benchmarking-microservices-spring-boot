using System.Text.Json.Serialization;

namespace PlaceService.Models
{
    public class Place
    {
        [JsonPropertyName("id")]
        public int Id { get; set; }

        [JsonPropertyName("city")]
        public string City { get; set; }

        [JsonPropertyName("coordinates")]
        public string Coordinates { get; set; }
    }
}
