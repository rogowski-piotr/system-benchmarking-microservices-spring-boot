using Route2Service.Models;

namespace Route2Service.Services
{
    public class PlaceRepository
    {
        private readonly HttpClient _httpClient;

        public PlaceRepository(string uri)
        {
            _httpClient = new() { BaseAddress = new(uri) };
        }

        public async Task<string> FindPlaceCoordinatesAsync(int placeId)
        {
            var response = await _httpClient.GetFromJsonAsync<PlaceResponse>($"places/{placeId}");

            return response.Coordinates;
        }
    }
}
