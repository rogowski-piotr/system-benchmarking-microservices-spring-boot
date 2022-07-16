using System.Globalization;
using System.Text.Json.Serialization;
using System.Text.RegularExpressions;

namespace Monolith.Models.Requests
{
    public class DistanceRequest
    {
        private static readonly Regex regex = new Regex("([0-9]+.[0-9]+), ([0-9]+.[0-9]+)");

        [JsonPropertyName("coordinate1")]
        public string Coordinate1 { get; set; }

        [JsonPropertyName("coordinate2")]
        public string Coordinate2 { get; set; }

        private static double ParseToLatitude(string cord)
            => Double.Parse(regex.Match(cord).Groups[1].Value, CultureInfo.InvariantCulture);

        private static double ParseToLongitude(string cord)
            => Double.Parse(regex.Match(cord).Groups[2].Value, CultureInfo.InvariantCulture);

        public static List<Point> DtoToEntityMapper(DistanceRequest req)
            => new()
            {
                new(ParseToLatitude(req.Coordinate1), ParseToLongitude(req.Coordinate1)),
                new(ParseToLatitude(req.Coordinate2), ParseToLongitude(req.Coordinate2))
            };
    }
}
