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

        public async Task<List<PlaceResponse>> FindPlacesCoordinatesAsync(List<int> ids)
        {
            String idsParam = string.Join(",", ids);
            var response = await _httpClient.GetFromJsonAsync<List<PlaceResponse>>($"places?ids={idsParam}");
            return response;
        }
    }
}
