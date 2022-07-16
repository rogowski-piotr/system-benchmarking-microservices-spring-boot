using System.Text.Json.Serialization;

namespace Route2Service.Models
{
    public class DistanceResponse
    {
        [JsonPropertyName("distance")]
        public double Distance { get; set; }
    }
}
