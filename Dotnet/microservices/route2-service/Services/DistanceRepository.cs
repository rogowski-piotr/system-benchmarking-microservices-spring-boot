using Route2Service.Models;

namespace Route2Service.Services
{
    public class DistanceRepository
    {
        private readonly HttpClient _httpClient;

        public DistanceRepository(IConfiguration configuration)
        {
            _httpClient = new() { BaseAddress = new(configuration["DistanceServiceUri"]) };
        }

        public async Task<double> FindDistanceAsync(string cord1, string cord2)
        {
            var response = await _httpClient.PostAsJsonAsync("distance", new DistanceRequest { Coordinate1 = cord1, Coordinate2 = cord2 });
            return (await response.Content.ReadFromJsonAsync<DistanceResponse>()).Distance;
        }
    }
}
