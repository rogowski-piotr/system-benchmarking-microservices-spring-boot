namespace Monolith.Models
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
