using System.Text.Json.Serialization;

namespace Route1Service.Models
{
    public class DistanceResponse
    {
        [JsonPropertyName("placeId1")]
        public int PlaceId1 { get; set; }

        [JsonPropertyName("placeId2")]
        public int PlaceId2 { get; set; }

        [JsonPropertyName("distance")]
        public double Distance { get; set; }
    }
}
