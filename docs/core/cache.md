# 缓存机制

## 服务器缓存

在OpenAuth中，缓存通过`ICacheContext`接口实现的。系统有两个实现方式：

* 基于.net自带的`MemoryCache`实现的`CacheContext`

* 基于`Enyim Memcache`实现的`EnyimMemcachedContext`

可以根据自己需要，扩展Redis等缓存。OpenAuth.Mvc和OpenAuth.Api默认使用的是CacheContext。可以在`AutofacExt.cs`跟换自己喜欢的缓存：
```csharp
public static void InitAutofac(ContainerBuilder builder)
{
    ...
    //更换缓存
    builder.RegisterType(typeof(CacheContext)).As(typeof(ICacheContext));
    
}
```


## 服务器缓存有效时间


服务器默认缓存时间为10天，在`LoginParse.cs`中设置
```csharp
_cacheContext.Set(currentSession.Token, currentSession, DateTime.Now.AddDays(10));
```

::: warning 注意
默认使用的是.net的内存Cache，在用IIS发布后，由于IIS本身存在自动回收的机制，会导致系统缓存20分钟就会失效。

:::


