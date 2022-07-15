using Benchmark.Benchmarks;

using BenchmarkDotNet.Running;

#if Distance

var summary = BenchmarkRunner.Run<DistanceBenchmark>();

#elif Place

var summary = BenchmarkRunner.Run<PlaceBenchmark>();

#elif Route1

var summary = BenchmarkRunner.Run<Route1Benchmark>();

#elif Route2

var summary = BenchmarkRunner.Run<Route2Benchmark>();

#endif