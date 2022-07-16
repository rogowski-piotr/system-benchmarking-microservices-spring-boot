using DistanceService.Services;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddSingleton<SphericalDistanceService>();
builder.Services.AddControllers();

var app = builder.Build();

app.MapControllers();

app.Run();