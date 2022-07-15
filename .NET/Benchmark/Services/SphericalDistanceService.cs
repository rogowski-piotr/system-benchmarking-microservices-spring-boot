using Benchmark.Models;

namespace Benchmark.Services
{
    public class SphericalDistanceService
    {
        private const double RADIANS_MULTIPLICATION = Math.PI / 180.00;

        public double CalculateDistance(Point p1, Point p2)
            => CalculateDistance(p1.Latitude, p1.Longitude, p2.Latitude, p2.Longitude);

        public double CalculateDistance(double lat1, double long1, double lat2, double long2)
            => Math.Acos(Math.Sin(ToRadians(lat1)) * Math.Sin(ToRadians(lat2)) +
                Math.Cos(ToRadians(lat1)) * Math.Cos(ToRadians(lat2)) *
                Math.Cos(ToRadians(long1 - long2))) * 6371;

        private double ToRadians(double val)
            => RADIANS_MULTIPLICATION * val;
    }
}
