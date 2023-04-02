using System.Text.Json.Serialization;

namespace Route1Service.Models
{
    public class PlaceResponse
    {
        [JsonPropertyName("id")]
        public int Id { get; set; }

        [JsonPropertyName("coordinates")]
        public string Coordinates { get; set; }
    }
}
