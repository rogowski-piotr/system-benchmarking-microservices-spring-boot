using Benchmark.Models;
using Benchmark.Repositories;

using BenchmarkDotNet.Attributes;

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Benchmark.Benchmarks
{
    public class PlaceBenchmark
    {
        private PlaceRepository _placeRepository;

        [GlobalSetup]
        public void Setup()
        {
            _placeRepository = new PlaceRepository();
        }

        [Params(1)]
        public int PlaceId;

        [Benchmark]
        public Place FindPlaceById()
        {
            return _placeRepository.FindById(PlaceId);
        }

        [Benchmark]
        public List<Place> GetAllPlaces()
        {
            return _placeRepository.Places;
        }
    }
}
