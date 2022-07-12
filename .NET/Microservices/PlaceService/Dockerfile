#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 8081

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY [".", "PlaceService/"]
RUN dotnet restore "PlaceService/PlaceService.csproj"
COPY . .
WORKDIR "/src/PlaceService"
RUN dotnet build "PlaceService.csproj" -r linux-x64 -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "PlaceService.csproj" -r linux-x64 -c Release --no-self-contained -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENV ASPNETCORE_URLS http://*:8081
ENTRYPOINT ["dotnet", "PlaceService.dll"]