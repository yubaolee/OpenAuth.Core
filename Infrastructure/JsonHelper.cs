// ***********************************************************************
// Assembly         : FairUtility
// Author           : Yubao Li
// Created          : 08-12-2015
//
// Last Modified By : Yubao Li
// Last Modified On : 08-12-2015
// ***********************************************************************
// <copyright file="JsonHelper.cs" company="">
//     Copyright (c) . All rights reserved.
// </copyright>
// <summary>json序列化帮助类</summary>
// ***********************************************************************

using Newtonsoft.Json;
using Newtonsoft.Json.Converters;

namespace Infrastructure
{
    public class JsonHelper
    {
        private static JsonHelper _jsonHelper = new JsonHelper();
        public static JsonHelper Instance { get { return _jsonHelper; } }

        public string Serialize(object obj)
        {
            return JsonConvert.SerializeObject(obj, new IsoDateTimeConverter { DateTimeFormat = "yyyy-MM-dd HH:mm:ss" });
        }

        public string SerializeByConverter(object obj, params JsonConverter[] converters)
        {
            return JsonConvert.SerializeObject(obj, converters);
        }

        public T Deserialize<T>(string input)
        {
            return JsonConvert.DeserializeObject<T>(input);
        }

        public T DeserializeByConverter<T>(string input,params JsonConverter[] converter)
        {
            return JsonConvert.DeserializeObject<T>(input, converter);
        }

        public T DeserializeBySetting<T>(string input, JsonSerializerSettings settings)
        {
            return JsonConvert.DeserializeObject<T>(input, settings);
        }

        private object NullToEmpty(object obj)
        {
            return null;
        }
    }
}