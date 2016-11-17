using System;

namespace Helper.Cache
{
    [Serializable]
    public class CacheObj<T>
    {
        public string key { get; set; }

        public T Obj { get; set; }

        public DateTime InvalidTime { get; set; }

        public DateTime CreateTime { get; set; }
    }
}