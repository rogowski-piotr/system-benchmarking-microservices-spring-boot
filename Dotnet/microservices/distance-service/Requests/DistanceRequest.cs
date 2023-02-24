using DistanceService.Models;

using System.Globalization;
using System.Text.Json.Serialization;
using System.Text.RegularExpressions;

namespace DistanceService.Requests
{
    public class DistanceRequest
    {
        private static readonly Regex regex = new Regex("([0-9]+.[0-9]+), ([0-9]+.[0-9]+)");

        [JsonPropertyName("placeId1")]
        public int PlaceId1 { get; set; }

        [JsonPropertyName("placeId2")]
        public int PlaceId2 { get; set; }

        [JsonPropertyName("coordinates1")]
        public string Coordinates1 { get; set; }

        [JsonPropertyName("coordinates2")]
        public string Coordinates2 { get; set; }

        private static double ParseToLatitude(string cord)
            => Double.Parse(regex.Match(cord).Groups[1].Value, CultureInfo.InvariantCulture);

        private static double ParseToLongitude(string cord)
            => Double.Parse(regex.Match(cord).Groups[2].Value, CultureInfo.InvariantCulture);

        public static List<Point> DtoToEntityMapper(List<DistanceRequest> req)
            => req.Select(p => new Point(
                p.PlaceId1,
                p.PlaceId2,
                ParseToLatitude(p.Coordinates1),
                ParseToLongitude(p.Coordinates1),
                ParseToLatitude(p.Coordinates2),
                ParseToLongitude(p.Coordinates2)
            )).ToList();
            // => new()
            // {
            //     new(ParseToLatitude(req.Coordinate1), ParseToLongitude(req.Coordinate1)),
            //     new(ParseToLatitude(req.Coordinate2), ParseToLongitude(req.Coordinate2))
            // };
    }
}
