var builder = WebApplication.CreateBuilder(args);

var app = builder.Build();

app.MapGet("/api/route2", () =>
{
    
});

app.Run();