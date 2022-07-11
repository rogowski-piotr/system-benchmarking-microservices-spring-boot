namespace Route1Service.Services
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

        private async Task<int> FindClosestNeighborAsync(int placeStart, List<int> places)
        {
            int? closesNeighborId = null;
            double? closestNeighborDistance = null;

            foreach (var placeId in places)
            {
                if (closesNeighborId == null)
                {
                    closesNeighborId = placeId;
                    closestNeighborDistance = await FindDistanceAsync(placeStart, placeId);
                }

                else
                {
                    var distance = await FindDistanceAsync(placeStart, placeId);
                    if (distance < closestNeighborDistance)
                    {
                        closesNeighborId = placeId;
                        closestNeighborDistance = distance;
                    }
                }
            }

            return closesNeighborId.Value;
        }

        public async Task<List<int>> ComputeRoute(List<int> places)
        {
            var currentPlace = places[0];
            var placeAmount = places.Count;

            var visitedPlaces = new List<int>(places.Count);
            visitedPlaces.Add(currentPlace);
            places.Remove(currentPlace);

            for (var i = 1; i < placeAmount; i++)
            {
                currentPlace = await FindClosestNeighborAsync(currentPlace, places);
                visitedPlaces.Add(currentPlace);
                places.Remove(currentPlace);
            }

            return visitedPlaces;
        }
    }
}
