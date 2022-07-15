using Microsoft.AspNetCore.Mvc;

using Route2Service.Services;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddSingleton<PlaceRepository>();
builder.Services.AddSingleton<DistanceRepository>();
builder.Services.AddSingleton<RouteService>();

builder.Services.AddControllers();

var app = builder.Build();

app.MapControllers();

app.Run();