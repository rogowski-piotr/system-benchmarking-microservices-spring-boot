using Route2Service.Models;

namespace Route2Service.Services
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

        public List<List<int>> ComputePermutationRecursive(int[] elements)
            => ComputePermutationRecursive(elements.Length, elements, new());

        public List<List<int>> ComputePermutationRecursive(int n, int[] elements, List<List<int>> listOfPermutations)
        {
            if (n == 1)
            {
                listOfPermutations.Add(elements.ToList());
            }

            else
            {
                for (var i = 0; i < n - 1; i++)
                {
                    ComputePermutationRecursive(n - 1, elements, listOfPermutations);
                    if (n % 2 == 0)
                        Swap(elements, i, n - 1);

                    else
                        Swap(elements, 0, n - 1);
                }

                ComputePermutationRecursive(n - 1, elements, listOfPermutations);
            }

            return listOfPermutations;
        }

        public async Task<List<int>> ComputeRouteAsync(List<int> places)
        {
            List<PlaceResponse> placesCoordinates = await _placeRepository.FindPlacesCoordinatesAsync(places);
            this._placesDistanceMap = await _distanceRepository.FindDistancesAsync(placesCoordinates);
            
            var listOfPermutations = ComputePermutationRecursive(places.Skip(1).ToArray());

            foreach (var permutationList in listOfPermutations)
            {
                var firstElem = places[0];
                permutationList.Insert(0, firstElem);
                permutationList.Add(firstElem);
            }

            List<int> shortestWay = null;
            double? shortestDistance = null;

            foreach (var singlePermutationList in listOfPermutations)
            {
                double distance = 0;
                for (var i = 0; i < singlePermutationList.Count - 1; i++)
                {
                    var place1Id = singlePermutationList[i];
                    var place2Id = singlePermutationList[i + 1];

                    distance += await FindDistanceAsync(place1Id, place2Id);
                }

                if (shortestDistance == null || shortestDistance?.CompareTo(distance) > 0)
                {
                    shortestDistance = distance;
                    shortestWay = singlePermutationList;
                }
            }

            return shortestWay;
        }

        #region Helpers

        private void Swap(int[] arr, int idx1, int idx2)
        {
            var tmp = arr[idx1];
            arr[idx1] = arr[idx2];
            arr[idx2] = tmp;
        }

        #endregion
    }
}
