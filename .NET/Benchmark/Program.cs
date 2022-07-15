using Benchmark.Benchmarks;

using BenchmarkDotNet.Running;

Console.WriteLine("Benchmarking...");

var choice = Environment.GetEnvironmentVariable("BENCHMARK_TARGET");
var benchClass = choice.ToUpper() switch
{
    "DISTANCE" => typeof(DistanceBenchmark),
    "PLACE" => typeof(PlaceBenchmark),
    "ROUTE1" => typeof(Route1Benchmark),
    "ROUTE2" => typeof(Route2Benchmark)
};

var summary = BenchmarkRunner.Run(benchClass);

//Compilation conditions
#if DISTANCE

var summary = BenchmarkRunner.Run<DistanceBenchmark>();

#elif PLACE

var summary = BenchmarkRunner.Run<PlaceBenchmark>();

#elif ROUTE1

var summary = BenchmarkRunner.Run<Route1Benchmark>();

#elif ROUTE2

var summary = BenchmarkRunner.Run<Route2Benchmark>();

#endif