# 切换sdk版本

OpenAuth.Net最新版默认使用.Net SDK 9.0.100。如果你使用的是其他版本的sdk（如.net 6.0/7.0等）打开项目，需要调整csproj项目文件的TargetFramework。用记事本等工具，打开 `Infrastructure.csproj` `OpenAuth.Repository.csproj` `OpenAuth.App.csproj` `OpenAuth.Mvc.csproj` `OpenAuth.WebApi.csproj` `OpenAuth.IdentityServer.csproj`，将
```csharp
  <PropertyGroup>
    <TargetFramework>net9.0</TargetFramework>
  </PropertyGroup>
```
修改为
```csharp
  <PropertyGroup>
    <TargetFramework>net6.0</TargetFramework>
  </PropertyGroup>
```
 保存，然后依次编译，如果报错，按照提示修改，直到成功。


 ## VS2019打开6.0及以后版本

VS2019不支持.net 6.0及以后的版本。如果打开项目需要调整csproj项目文件。调整为
```csharp
  <PropertyGroup>
      <TargetFrameworks>net5.0</TargetFrameworks>
      <TargetFrameworks Condition=" '$(MSBuildVersion)' &gt;= '17.0' ">$(TargetFrameworks);net6.0</TargetFrameworks>
  </PropertyGroup>
```
当然建议使用最新版visual studio