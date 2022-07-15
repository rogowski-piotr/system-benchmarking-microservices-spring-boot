using Benchmark.Models;
using Benchmark.Properties;

using System.Text.Json;

namespace Benchmark.Repositories
{
    public class PlaceRepository
    {
        public List<Place> Places { get; private set; }

        public PlaceRepository()
        {
            Places = JsonSerializer.Deserialize<List<Place>>(Resources.coordinates);
        }

        public Place FindById(int id)
            => Places.FirstOrDefault(f => f.Id == id);
    }
}
