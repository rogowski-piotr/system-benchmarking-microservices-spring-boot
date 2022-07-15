using Benchmark.Repositories;
using Benchmark.Services;

using BenchmarkDotNet.Attributes;

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Benchmark.Benchmarks
{
    public class Route1Benchmark
    {
        private Route1Service _routeService;

        private List<int> _places;

        [GlobalSetup]
        public void Setup()
        {
            var distanceSvc = new SphericalDistanceService();
            var placeSvc = new PlaceRepository();
            _routeService = new(distanceSvc, placeSvc);

            _places = new List<int>() { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20 };
        }

        [Benchmark]
        public List<int> Routing1Benchmark()
        {
            return _routeService.ComputeRoute(_places);
        }
    }
}
