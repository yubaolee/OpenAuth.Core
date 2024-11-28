FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS base
WORKDIR /app
# WebApi
EXPOSE 52789
# Mvc
EXPOSE 1802
# Identity
EXPOSE 12796

FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
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

# 发布 WebApi
WORKDIR "/src/OpenAuth.WebApi"
RUN dotnet publish -c Release -o /app/publish/webapi

# 发布 Mvc
WORKDIR "/src/OpenAuth.Mvc"
RUN dotnet publish -c Release -o /app/publish/mvc

# 发布 Identity
WORKDIR "/src/OpenAuth.Identity"
RUN dotnet publish -c Release -o /app/publish/identity

FROM base AS final
WORKDIR /app
# 复制 WebApi 发布文件
COPY --from=build /app/publish/webapi ./webapi
# 复制 Mvc 发布文件
COPY --from=build /app/publish/mvc ./mvc
# 复制 Identity 发布文件
COPY --from=build /app/publish/identity ./identity

# 启动 WebApi, Mvc, 和 Identity,就算失败也保持运行，方便查询日志
ENTRYPOINT ["sh", "-c", "cd webapi && dotnet OpenAuth.WebApi.dll & cd mvc && dotnet OpenAuth.Mvc.dll & cd identity && dotnet OpenAuth.IdentityServer.dll || tail -f /dev/null"]

