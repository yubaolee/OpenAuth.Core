#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/core/aspnet:3.1-buster-slim AS base
WORKDIR /app
EXPOSE 80

FROM mcr.microsoft.com/dotnet/core/sdk:3.1-buster AS build
WORKDIR /src
COPY ["OpenAuth.Mvc/OpenAuth.Mvc.csproj", "OpenAuth.Mvc/"]
COPY ["OpenAuth.Repository/OpenAuth.Repository.csproj", "OpenAuth.Repository/"]
COPY ["Infrastructure/Infrastructure.csproj", "Infrastructure/"]
COPY ["OpenAuth.App/OpenAuth.App.csproj", "OpenAuth.App/"]
RUN dotnet restore "OpenAuth.Mvc/OpenAuth.Mvc.csproj"
COPY . .
WORKDIR "/src/OpenAuth.Mvc"
RUN dotnet build "OpenAuth.Mvc.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "OpenAuth.Mvc.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "OpenAuth.Mvc.dll"]
