FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 7777

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
# 将当前目录下的所有文件和文件夹复制到容器的当前工作目录中
COPY *.sln ./
COPY ["OpenAuth.WebApi/", "./OpenAuth.WebApi/"]
COPY ["Infrastructure/", "./Infrastructure/"]
COPY ["OpenAuth.App/", "./OpenAuth.App/"]
COPY ["OpenAuth.Repository/", "./OpenAuth.Repository/"]


# 发布
WORKDIR "/src/OpenAuth.WebApi"
RUN dotnet restore 

FROM build AS publish
RUN dotnet publish -c Release -o /app/publish

FROM base AS final
WORKDIR /app
# 将publish阶段生成的发布文件复制到当前工作目录 /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "OpenAuth.WebApi.dll"]
