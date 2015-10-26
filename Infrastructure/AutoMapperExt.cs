// ***********************************************************************
// Assembly         : FairUtility
// Author           : Yubao Li
// Created          : 08-27-2015
//
// Last Modified By : Yubao Li
// Last Modified On : 08-27-2015
// ***********************************************************************
// <copyright file="AutoMapperExt.cs" company="">
//     Copyright (c) . All rights reserved.
// </copyright>
// <summary></summary>
// ***********************************************************************

using AutoMapper;

namespace Infrastructure
{
    public class AutoMapperExt
    {
        public static TResult ConvertTo<T, TResult>(T source)
        {
            var mapper = Mapper.CreateMap<T, TResult>();
            return Mapper.Map<TResult>(source);
        }
    }
}
