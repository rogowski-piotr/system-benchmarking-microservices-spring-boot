#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.
FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 8084

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY [".", "Route2Service/"]
RUN dotnet restore "Route2Service/Route2Service.csproj"
COPY . .
WORKDIR "/src/Route2Service"
RUN dotnet build "Route2Service.csproj" -r linux-x64 -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "Route2Service.csproj" -r linux-x64 --no-self-contained -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENV ASPNETCORE_URLS http://*:8084
ENTRYPOINT ["dotnet", "Route2Service.dll"]