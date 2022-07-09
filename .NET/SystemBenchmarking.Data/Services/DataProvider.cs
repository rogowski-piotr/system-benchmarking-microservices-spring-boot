using System.Text.Json;

using SystemBenchmarking.Shared.Models;

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
