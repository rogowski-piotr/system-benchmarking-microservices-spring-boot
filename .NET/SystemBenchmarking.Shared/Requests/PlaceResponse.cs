
using SystemBenchmarking.Shared.Models;

namespace SystemBenchmarking.Shared.Requests
{
    public class PlaceResponse
    {
        public int Id { get; set; }
        public string City { get; set; }
        public string Coordinates { get; set; }

        public PlaceResponse()
        {

        }

        public PlaceResponse(Place place)
            => (Id, City, Coordinates) = (place.Id, place.City, place.Coordinates);
    }
}
