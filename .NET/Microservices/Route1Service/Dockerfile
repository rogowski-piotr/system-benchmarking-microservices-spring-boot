#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 8083

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY [".", "Route1Service/"]
RUN dotnet restore "Route1Service/Route1Service.csproj"
COPY . .
WORKDIR "/src/Route1Service"
RUN dotnet build "Route1Service.csproj" -r linux-x64 -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "Route1Service.csproj" -r linux-x64 --no-self-contained -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENV ASPNETCORE_URLS http://*:8083
ENTRYPOINT ["dotnet", "Route1Service.dll"]