using PlaceService.Models;

using System.Text.Json;

namespace PlaceService.Repositories
{
    public class PlaceRepository
    {
        public List<Place> Places { get; private set; }

        public PlaceRepository()
        {
            Places = JsonSerializer.Deserialize<List<Place>>(Properties.Resources.coordinates);
        }

        public Place FindById(int id)
            => Places.FirstOrDefault(f => f.Id == id);
    }
}
