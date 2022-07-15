using Benchmark.Models;
using Benchmark.Models.Requests;
using Benchmark.Services;

using BenchmarkDotNet.Attributes;

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Benchmark.Benchmarks
{
    public class DistanceBenchmark
    {
        private SphericalDistanceService _distanceService;

        private Point p1;
        private Point p2;

        [GlobalSetup]
        public void Setup()
        {
            _distanceService = new();

            var distanceRequest = new DistanceRequest
            {
                Coordinate1 = "54.367, 18.633",
                Coordinate2 = "50.05, 19.95"
            };

            var points = DistanceRequest.DtoToEntityMapper(distanceRequest);
            p1 = points[0];
            p2 = points[1];
        }

        [Benchmark]
        public double CalculateDistance()
        {
            return _distanceService.CalculateDistance(p1, p2);
        }
    }
}
