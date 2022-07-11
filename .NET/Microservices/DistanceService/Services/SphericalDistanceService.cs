namespace DistanceService.Services
{
    public class SphericalDistanceService
    {
        private const double RADIANS_MULTIPLICATION = Math.PI / 180.00;

        public double CalculateDistance(double lat1, double long1, double lat2, double long2)
            => Math.Acos(Math.Sin(ToRadians(lat1)) * Math.Sin(ToRadians(lat2)) +
                Math.Cos(ToRadians(lat1)) * Math.Cos(ToRadians(lat2)) *
                Math.Cos(ToRadians(long1 - long2))) * 6371;

        //public double CalculateDistance(double lat1, double long1, double lat2, double long2)
        //{
        //    var radlat1 = ToRadians(lat1);
        //    var radlat2 = ToRadians(lat2);

        //    var sinRadLat1 = Math.Sin(radlat1);
        //    var sinRadLat2 = Math.Sin(radlat2);

        //    var cosRadLat1 = Math.Cos(radlat1);
        //    var cosRadLat2 = Math.Cos(radlat2);

        //    var radLong1Long2 = ToRadians(long1 - long2);
        //    var cosRadLong1Long2 = Math.Cos(radLong1Long2);

        //    var inside = sinRadLat1 * sinRadLat2 + cosRadLat1 * cosRadLat2 * cosRadLong1Long2;
        //    var acos = Math.Acos(inside);

        //    var result = acos * 6371;
        //    return result;
        //}

        private double ToRadians(double val)
            => RADIANS_MULTIPLICATION * val;
    }
}
