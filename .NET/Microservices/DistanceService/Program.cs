using DistanceService.Requests;
using DistanceService.Responses;
using DistanceService.Services;

var builder = WebApplication.CreateBuilder(args);

var app = builder.Build();

var distanceService = new SphericalDistanceService();

//Should be GET
app.MapPost("/api/distance", (DistanceRequest req) =>
{
    var points = DistanceRequest.DtoToEntityMapper(req);

    var point1 = points[0];
    var point2 = points[1];

    var distance = distanceService.CalculateDistance(point1.Latitude, point1.Longitude, point2.Latitude, point2.Longitude);

    return Results.Ok(DistanceResponse.EntityToDtoMapper(distance));
});

app.Run();