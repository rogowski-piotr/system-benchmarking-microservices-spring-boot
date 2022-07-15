using System.Globalization;
using System.Text.Json.Serialization;
using System.Text.RegularExpressions;

namespace Benchmark.Models
{
    public class Place
    {
        [JsonPropertyName("id")]
        public int Id { get; set; }

        [JsonPropertyName("city")]
        public string City { get; set; }

        [JsonPropertyName("coordinates")]
        public string Coordinates { get; set; }

        public Point GetPoint()
        {
            var regex = new Regex("(?<latitude>\\d+\\.?\\d*),\\s{1}(?<longitude>\\d+\\.?\\d*)");
            var matched = regex.Match(Coordinates);

            return new(Double.Parse(matched.Groups["latitude"].Value, CultureInfo.InvariantCulture),
                Double.Parse(matched.Groups["longitude"].Value, CultureInfo.InvariantCulture));
        }
    }
}
