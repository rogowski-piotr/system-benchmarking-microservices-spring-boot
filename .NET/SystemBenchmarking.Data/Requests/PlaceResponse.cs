using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using SystemBenchmarking.Data.Models;

namespace SystemBenchmarking.Data.Requests
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
