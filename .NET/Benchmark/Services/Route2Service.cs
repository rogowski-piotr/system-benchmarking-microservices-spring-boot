using Benchmark.Repositories;

namespace Benchmark.Services
{
    public class Route2Service
    {
        private readonly SphericalDistanceService _distanceService;
        private readonly PlaceRepository _placeRepository;

        public Route2Service(SphericalDistanceService distanceService, PlaceRepository placeRepository)
        {
            _distanceService = distanceService;
            _placeRepository = placeRepository;
        }

        public double FindDistance(int place1Id, int place2Id)
        {
            var cords1 = _placeRepository.FindById(place1Id);
            var cords2 = _placeRepository.FindById(place2Id);

            return _distanceService.CalculateDistance(cords1.GetPoint(), cords2.GetPoint());
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

        public List<int> ComputeRoute(List<int> places)
        {
            //Created array - places[1] ... places[length - 1], is this the thing which java is doing?
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

                    distance += FindDistance(place1Id, place2Id);
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
