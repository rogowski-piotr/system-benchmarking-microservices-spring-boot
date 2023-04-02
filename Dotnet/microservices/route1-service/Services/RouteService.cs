using Route1Service.Models;

namespace Route1Service.Services
{
    public class RouteService
    {
        private readonly DistanceRepository _distanceRepository;
        private readonly PlaceRepository _placeRepository;
        private Dictionary<(int, int), double> _placesDistanceMap;

        public RouteService(DistanceRepository distanceRepository, PlaceRepository placeRepository)
        {
            _distanceRepository = distanceRepository;
            _placeRepository = placeRepository;
            _placesDistanceMap = new Dictionary<(int, int), double>();
        }

        public async Task<double> FindDistanceAsync(int place1Id, int place2Id)
        {
            var key = (place1Id, place2Id);
            return this._placesDistanceMap[key];
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

        public async Task<List<int>> ComputeRouteAsync(List<int> places)
        {
            List<PlaceResponse> placesCoordinates = await _placeRepository.FindPlacesCoordinatesAsync(places);
            this._placesDistanceMap = await _distanceRepository.FindDistancesAsync(placesCoordinates);

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
