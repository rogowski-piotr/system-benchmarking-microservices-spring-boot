using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.Json;
using System.Text.Json.Serialization;
using System.Threading.Tasks;

using SystemBenchmarking.Data.Properties;

namespace SystemBenchmarking.Data.Models
{
    public class Coordinate
    {
        [JsonPropertyName("id")]
        public int Id { get; set; }

        [JsonPropertyName("city")]
        public string City { get; set; }

        [JsonPropertyName("coordinates")]
        public string Coordinates { get; set; }

        public static List<Coordinate> GetCoordinates()
            => JsonSerializer.Deserialize<List<Coordinate>>(Resources.coordinates);
    }
}
