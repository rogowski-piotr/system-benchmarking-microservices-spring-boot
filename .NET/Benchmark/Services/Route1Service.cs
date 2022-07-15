using Benchmark.Repositories;

namespace Benchmark.Services
{
    public class Route1Service
    {
        private readonly SphericalDistanceService _distanceService;
        private readonly PlaceRepository _placeRepository;

        public Route1Service(SphericalDistanceService distanceService, PlaceRepository placeRepository)
        {
            _distanceService = distanceService;
            _placeRepository = placeRepository;
        }

        public double FindDistance(int place1Id, int place2Id)
        {
            var place1 = _placeRepository.FindById(place1Id);
            var place2 = _placeRepository.FindById(place2Id);

            return _distanceService.CalculateDistance(place1.GetPoint(), place2.GetPoint());
        }

        private int FindClosestNeighbor(int placeStart, List<int> places)
        {
            int? closesNeighborId = null;
            double? closestNeighborDistance = null;

            foreach (var placeId in places)
            {
                if (closesNeighborId == null)
                {
                    closesNeighborId = placeId;
                    closestNeighborDistance = FindDistance(placeStart, placeId);
                }

                else
                {
                    var distance = FindDistance(placeStart, placeId);
                    if (distance < closestNeighborDistance)
                    {
                        closesNeighborId = placeId;
                        closestNeighborDistance = distance;
                    }
                }
            }

            return closesNeighborId.Value;
        }

        public List<int> ComputeRoute(List<int> places)
        {
            var currentPlace = places[0];
            var placeAmount = places.Count;

            var visitedPlaces = new List<int>(places.Count);
            visitedPlaces.Add(currentPlace);
            places.Remove(currentPlace);

            for (var i = 1; i < placeAmount; i++)
            {
                currentPlace = FindClosestNeighbor(currentPlace, places);
                visitedPlaces.Add(currentPlace);
                places.Remove(currentPlace);
            }

            return visitedPlaces;
        }
    }
}
