using System.Text.Json.Serialization;

namespace Route2Service.Models
{
    public class DistanceRequest
    {
        [JsonPropertyName("placeId1")]
        public int PlaceId1 { get; set; }

        [JsonPropertyName("placeId2")]
        public int PlaceId2 { get; set; }

        [JsonPropertyName("coordinates1")]
        public string Coordinates1 { get; set; }

        [JsonPropertyName("coordinates2")]
        public string Coordinates2 { get; set; }

        public DistanceRequest()
        {
        }

        public DistanceRequest(int placeId1, int placeId2, string coordinates1, string coordinates2)
        {
            PlaceId1 = placeId1;
            PlaceId2 = placeId2;
            Coordinates1 = coordinates1;
            Coordinates2 = coordinates2;
        }
    }
}
