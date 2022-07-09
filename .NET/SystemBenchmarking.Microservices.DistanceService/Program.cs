namespace SystemBenchmarking.Microservices.DistanceService
{
    public class Program
    {
        public static void Main(string[] args)
        {
            var builder = WebApplication.CreateBuilder(args);

            var app = builder.Build();

            app.UseRouting();

            app.Run();
        }
    }
}