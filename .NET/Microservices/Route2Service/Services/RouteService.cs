namespace Route2Service.Services
{
    public class RouteService
    {
        private readonly DistanceRepository _distanceRepository;
        private readonly PlaceRepository _placeRepository;

        public RouteService(DistanceRepository distanceRepository, PlaceRepository placeRepository)
        {
            _distanceRepository = distanceRepository;
            _placeRepository = placeRepository;
        }

        public async Task<double> FindDistanceAsync(int place1Id, int place2Id)
        {
            var cords1 = _placeRepository.FindPlaceCoordinatesAsync(place1Id);
            var cords2 = _placeRepository.FindPlaceCoordinatesAsync(place2Id);

            return await _distanceRepository.FindDistanceAsync(await cords1, await cords2);
        }
    }
}
