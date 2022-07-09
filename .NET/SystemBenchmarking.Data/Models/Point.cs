using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SystemBenchmarking.Data.Models
{
    public class Point
    {
        public double Latitude { get; set; }
        public double Longitude { get; set; }

        public Point()
        {

        }

        public Point(double lat, double lon)
            => (Latitude, Longitude) = (lat, lon);
    }
}
