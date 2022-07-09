using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SystemBenchmarking.Shared
{
    public static class Calculations
    {
        public static double CalculateDistance(double latitude1, double longitude1, double latitude2, double longitude2)
        {
            var lat1Rad = latitude1.ToRadians();
            var lat2Rad = latitude2.ToRadians();

            return Math.Acos(Math.Sin(lat1Rad) * Math.Sin(lat2Rad) + Math.Cos(lat1Rad) * Math.Cos(lat2Rad) * Math.Cos((longitude1 - longitude2).ToRadians())) * 6371;
        }

        public static double FindDistance(int place1id, int place2id)
            => throw new NotImplementedException();

        public static double FindDistance(string cord1, string cord2)
        {
            throw new NotImplementedException();
        }

        public static List<List<int>> ComputePermutationRecursive(int[] elements)
            => ComputePermutationRecursive(elements.Length, elements, new());

        public static List<List<int>> ComputePermutationRecursive(int n, int[] elements, List<List<int>> listOfPermutations)
        {
            if (n == 1)
                listOfPermutations.Add(elements.ToList());

            else
            {
                for (var i = 0; i < n; i++)
                {
                    ComputePermutationRecursive(n - 1, elements, listOfPermutations);
                    if (n % 2 == 0)
                        elements.Swap(i, n - 1);

                    else
                        elements.Swap(0, n - 1);
                }

                ComputePermutationRecursive(n - 1, elements, listOfPermutations);
            }

            return listOfPermutations;
        }

        public static List<int> ComputeRoute(int[] places)
        {
            throw new NotImplementedException();
        }
    }
}
