FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 52789

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
# 将当前目录下的所有文件和文件夹复制到容器的当前工作目录中
COPY *.sln ./
COPY ["OpenAuth.WebApi/", "./OpenAuth.WebApi/"]
COPY ["OpenAuth.Mvc/", "./OpenAuth.Mvc/"]
COPY ["OpenAuth.Identity/", "./OpenAuth.Identity/"]
COPY ["Infrastructure/", "./Infrastructure/"]
COPY ["OpenAuth.App/", "./OpenAuth.App/"]
COPY ["OpenAuth.Repository/", "./OpenAuth.Repository/"]

RUN dotnet restore OpenAuth.Net.sln

# 发布
WORKDIR "/src/OpenAuth.WebApi"

FROM build AS publish
RUN dotnet publish -c Release -o /app/publish

FROM base AS final
WORKDIR /app
# 将publish阶段生成的发布文件复制到当前工作目录 /app
COPY --from=publish /app/publish .
# 就算容器启动失败，也会保持运行。这样可以进入容器分析原因
ENTRYPOINT ["sh", "-c", "dotnet OpenAuth.WebApi.dll || tail -f /dev/null"]

