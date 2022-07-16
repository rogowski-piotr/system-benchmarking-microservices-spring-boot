using Route2Service.Models;

namespace Route2Service.Services
{
    public class PlaceRepository
    {
        private readonly HttpClient _httpClient;

        public PlaceRepository(IConfiguration configuration)
        {
            _httpClient = new() { BaseAddress = new(configuration["PlaceServiceUri"]) };
        }

        public async Task<string> FindPlaceCoordinatesAsync(int placeId)
        {
            var response = await _httpClient.GetFromJsonAsync<PlaceResponse>($"places/{placeId}");

            return response.Coordinates;
        }
    }
}
