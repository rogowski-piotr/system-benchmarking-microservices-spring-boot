using System.Text.Json.Serialization;
using DistanceService.Models;

namespace DistanceService.Responses
{
    public class DistanceResponse
    {
        [JsonPropertyName("placeId1")]
        public int PlaceId1 { get; set; }

        [JsonPropertyName("placeId2")]
        public int PlaceId2 { get; set; }

        [JsonPropertyName("distance")]
        public double Distance { get; set; }

        private DistanceResponse(int placeId1, int placeId2, double distance)
        {
            PlaceId1 = placeId1;
            PlaceId2 = placeId2;
            Distance = distance;
        }

        public static List<DistanceResponse> EntityToDtoMapper(List<Point> points, List<double> distances)
        {
            List<DistanceResponse> distanceResponseList = new List<DistanceResponse>();
            for (int iter = 0; iter < points.Count; iter++)
            {
                distanceResponseList.Add(
                    new DistanceResponse(points[iter].PlaceId1, points[iter].PlaceId2, distances[iter]));
            }
            return distanceResponseList;
        }
    }
}
