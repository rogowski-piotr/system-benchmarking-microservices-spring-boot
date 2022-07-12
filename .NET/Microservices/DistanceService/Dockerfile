#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 8082

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY [".", "DistanceService/"]
RUN dotnet restore "DistanceService/DistanceService.csproj"
COPY . .
WORKDIR "/src/DistanceService"
RUN dotnet build "DistanceService.csproj" -r linux-x64 -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "DistanceService.csproj" -r linux-x64 -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENV ASPNETCORE_URLS http://*:8082
ENTRYPOINT ["dotnet", "DistanceService.dll"]