// ***********************************************************************
// Assembly         : Infrastructure
// Author           : Yubao Li
// Created          : 09-07-2015
//
// Last Modified By : Yubao Li
// Last Modified On : 09-07-2015
// ***********************************************************************
// <copyright file="GuidConverter.cs" company="">
//     Copyright (c) . All rights reserved.
// </copyright>
// <summary>解决JSON转换空GUID问题</summary>
// ***********************************************************************

using System;
using Newtonsoft.Json;

namespace Infrastructure
{
    public class GuidConverter : JsonConverter
    {
        public override bool CanConvert(Type objectType)
        {
            return objectType.IsAssignableFrom(typeof(Guid));
        }

        public override object ReadJson(JsonReader reader, Type objectType, object existingValue, JsonSerializer serializer)
        {
            Guid result = Guid.Empty;
            if (reader.Value == null) return result;
            Guid.TryParse(reader.Value.ToString(), out result);
            return result;
        }

        public override void WriteJson(JsonWriter writer, object value, JsonSerializer serializer)
        {
            serializer.Serialize(writer, value);
        }
    }

    public class DecimalConverter : JsonConverter
    {
        public override bool CanConvert(Type objectType)
        {
            return objectType.IsAssignableFrom(typeof(decimal));
        }

        public override object ReadJson(JsonReader reader, Type objectType, object existingValue, JsonSerializer serializer)
        {
            decimal result = 0;
            if (reader.Value == null) return result;
            decimal.TryParse(reader.Value.ToString(), out result);
            return result;
        }

        public override void WriteJson(JsonWriter writer, object value, JsonSerializer serializer)
        {
            serializer.Serialize(writer, value);
        }
    }
}