using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.Json;
using System.Threading.Tasks;

using SystemBenchmarking.Data.Models;

namespace SystemBenchmarking.Data.Services
{
    public static class DataProvider
    {
        public static List<Place> Places;

        static DataProvider()
        {
            Places = JsonSerializer.Deserialize<List<Place>>(Properties.Resources.coordinates);
        }

        public static Place FindById(int id)
            => Places.FirstOrDefault(x => x.Id == id); //xD
    }
}
