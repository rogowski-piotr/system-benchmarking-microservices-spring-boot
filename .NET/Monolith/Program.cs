using Monolith.Repositories;
using Monolith.Services;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddSingleton<PlaceRepository>();
builder.Services.AddSingleton<SphericalDistanceService>();
builder.Services.AddSingleton<Route1Service>();
builder.Services.AddSingleton<Route2Service>();

builder.Services.AddControllers();

var app = builder.Build();

app.MapControllers();

app.Run();