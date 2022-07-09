using System.Text.RegularExpressions;

using SystemBenchmarking.Shared.Models;

namespace SystemBenchmarking.Shared.Requests
{
    public class DistanceRequest
    {
        private static readonly Regex regex = new Regex("([0-9]+.[0-9]+), ([0-9]+.[0-9]+)");

        public string Coordinate1 { get; set; }
        public string Coordinate2 { get; set; }

        public DistanceRequest()
        {

        }

        public DistanceRequest(string cord1, string cord2)
            => (Coordinate1, Coordinate2) = (cord1, cord2);

        private double ParseToLatitude(string cord)
            => Double.Parse(regex.Match(cord).Groups[1].Value);

        private double ParseToLongitude(string cord)
            => Double.Parse(regex.Match(cord).Groups[2].Value);

        public List<Point> GetPoints()
            => new()
            {
                new(ParseToLatitude(Coordinate1), ParseToLongitude(Coordinate1)),
                new(ParseToLatitude(Coordinate2), ParseToLongitude(Coordinate2))
            };
    }
}
