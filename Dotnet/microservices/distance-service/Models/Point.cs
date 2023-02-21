namespace DistanceService.Models
{
    public class Point
    {
        public int PlaceId1 { get; set; }
        public int PlaceId2 { get; set; }
        public double Latitude1 { get; set; }
        public double Longitude1 { get; set; }
        public double Latitude2 { get; set; }
        public double Longitude2 { get; set; }

        public Point()
        {

        }

        public Point(int id1, int id2, double lat1, double lon1, double lat2, double lon2)
            => (PlaceId1, PlaceId2, Latitude1, Longitude1, Latitude2, Longitude2) = (id1, id2, lat1, lon1, lat2, lon2);
    }
}
