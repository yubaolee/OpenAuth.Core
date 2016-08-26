using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Infrastructure.Cache
{
    public interface ICache
    {
        /// <summary>
        /// 加入缓存项
        /// </summary>
        /// <param name="key">缓存项标识</param>
        /// <param name="value">缓存项</param>
        /// <param name="timeSpan">缓存失效时间</param>
        void Add(string key, object value, TimeSpan timeSpan);
        /// <summary>
        /// 加入依赖物理文件的缓存项
        /// </summary>
        /// <param name="key">缓存项标识</param>
        /// <param name="value">缓存项</param>
        /// <param name="fullFileNameOfFileDependency">依赖的文件全路径</param>
        void AddWithFileDependency(string key, object value, string fullFileNameOfFileDependency);
        /// <summary>
        /// 获取缓存项
        /// </summary>
        /// <param name="cacheKey"></param>
        /// <returns></returns>
        object Get(string cacheKey);
        T Get<T>(string cacheKey) where T : class;
        void Remove(string cacheKey);
        /// <summary>
        /// 如果不存在缓存项则添加，否则更新（相对过期）
        /// </summary>
        /// <param name="key">缓存项标识</param>
        /// <param name="value">缓存项</param>
        /// <param name="timeSpan">缓存失效时间</param>
        void Set(string key, object value, TimeSpan timeSpan);
        /// <summary>
        /// 设置绝对过期时间
        /// </summary>
        /// <param name="key">缓存项标识</param>
        /// <param name="value">缓存项</param>
        /// <param name="timeSpan">缓存失效时间</param>
        void SetAbsoluteExpiration(string key, object value, TimeSpan timeSpan);
    }
}
