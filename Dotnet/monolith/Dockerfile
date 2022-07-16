#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 8080

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY [".", "Monolith/"]
RUN dotnet restore "Monolith/Monolith.csproj"
COPY . .
WORKDIR "/src/Monolith"
RUN dotnet build "Monolith.csproj" -r linux-x64 -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "Monolith.csproj" -r linux-x64 -c Release --no-self-contained -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENV ASPNETCORE_URLS http://*:8080
ENTRYPOINT ["dotnet", "Monolith.dll"]