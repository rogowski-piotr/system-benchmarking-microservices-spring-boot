using Microsoft.AspNetCore.Mvc;

using Route2Service.Services;

var builder = WebApplication.CreateBuilder(args);

var app = builder.Build();

//Services
var placeRepository = new PlaceRepository(app.Configuration["PlaceServiceUri"]);
var distanceRepository = new DistanceRepository(app.Configuration["DistanceServiceUri"]);
var routeService = new RouteService(distanceRepository, placeRepository);

app.MapGet("/api/route2", async ([FromQuery(Name = "id")] string placeQueryString) =>
{
    //To support query string like ?id=1,2,3,4...
    var ids = Array.ConvertAll(placeQueryString.Split(','), x => Int32.Parse(x)).ToList();

    return Results.Ok(await routeService.ComputeRouteAsync(ids));
});

app.Run();