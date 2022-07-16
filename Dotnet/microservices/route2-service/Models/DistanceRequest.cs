using System.Text.Json.Serialization;

namespace Route2Service.Models
{
    public class DistanceRequest
    {
        [JsonPropertyName("coordinate1")]
        public string Coordinate1 { get; set; }

        [JsonPropertyName("coordinate2")]
        public string Coordinate2 { get; set; }
    }
}
