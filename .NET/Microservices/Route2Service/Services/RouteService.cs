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
    }
}
