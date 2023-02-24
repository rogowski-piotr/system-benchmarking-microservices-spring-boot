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

        public async Task<Dictionary<(int, int), double>> FindDistancesAsync(List<PlaceResponse> places)
        {
            List<DistanceRequest> requestBody = PrepareRequestBody(places);
            var response = _httpClient.PostAsJsonAsync("distance", requestBody).Result;
            List<DistanceResponse> dto = response.Content.ReadFromJsonAsync<List<DistanceResponse>>().Result;
            Dictionary<(int, int), double> result = new Dictionary<(int, int), double>();
            dto.ForEach(place => {
                var key = (place.PlaceId1, place.PlaceId2);
                if (!result.ContainsKey(key)) {
                    result.Add(key, place.Distance);
                }

            });
            return result;
        }

        private static List<DistanceRequest> PrepareRequestBody(List<PlaceResponse> placesResponse)
        {
            List<DistanceRequest> requestBodyList = new List<DistanceRequest>();
            placesResponse.ForEach(place1 => {
                placesResponse.ForEach(place2 => {
                    var singleElem = new DistanceRequest(place1.Id, place2.Id, place1.Coordinates, place2.Coordinates);
                    requestBodyList.Add(singleElem);
                });
            });
            return requestBodyList;
        }
    }
}
