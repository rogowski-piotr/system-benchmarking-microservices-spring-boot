using Route1Service.Models;

namespace Route1Service.Services
{
    public class DistanceRepository
    {
        private readonly HttpClient _httpClient;

        public DistanceRepository(string uri)
        {
            _httpClient = new() { BaseAddress = new(uri) };
        }

        public async Task<double> FindDistanceAsync(string cord1, string cord2)
        {
            var response = await _httpClient.PostAsJsonAsync("distance", new DistanceRequest { Coordinate1 = cord1, Coordinate2 = cord2 });
            return (await response.Content.ReadFromJsonAsync<DistanceResponse>()).Distance;
        }
    }
}
