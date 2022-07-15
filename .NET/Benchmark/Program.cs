using Benchmark.Benchmarks;

using BenchmarkDotNet.Running;

Console.WriteLine("Benchmarking...");

#if DISTANCE

var summary = BenchmarkRunner.Run<DistanceBenchmark>();

#elif PLACE

var summary = BenchmarkRunner.Run<PlaceBenchmark>();

#elif ROUTE1

var summary = BenchmarkRunner.Run<Route1Benchmark>();

#elif ROUTE2

var summary = BenchmarkRunner.Run<Route2Benchmark>();

#endif