using PlaceService.Repositories;
using PlaceService.Responses;

var builder = WebApplication.CreateBuilder(args);
var app = builder.Build();

var repository = new PlaceRepository();

//Get all places
app.MapGet("/api/places", () => Results.Ok(PlacesResponse.GetPlacesResponses(repository.Places)));

//Get single place
app.MapGet("/api/places/{id}", (int id) =>
{
    var place = repository.FindById(id);

    if (place == null)
        return Results.NotFound();

    return Results.Ok(new PlaceResponse(place));
});

app.Run();