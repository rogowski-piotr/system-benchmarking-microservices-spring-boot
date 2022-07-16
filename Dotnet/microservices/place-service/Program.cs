using PlaceService.Repositories;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddSingleton<PlaceRepository>();
builder.Services.AddControllers();

var app = builder.Build();

app.MapControllers();

app.Run();