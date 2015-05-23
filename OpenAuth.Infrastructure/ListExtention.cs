// ***********************************************************************
// Assembly         : OpenAuth.Infrastructure
// Author           : yubaolee
// Created          : 05-23-2015
//
// Last Modified By : yubaolee
// Last Modified On : 05-23-2015
// ***********************************************************************
// <copyright file="ListExtention.cs" company="Microsoft">
//     Copyright (c) Microsoft. All rights reserved.
// </copyright>
// <summary>两个相同结构List之间的复制</summary>
// ***********************************************************************
using System;
using System.Collections.Generic;
using System.Linq;

namespace OpenAuth.Infrastructure
{
    static class ListExtension
    {
        public static IList<T> Clone<T>(this IList<T> listToClone) where T : ICloneable
        {
            return listToClone.Select(item => (T)item.Clone()).ToList();
        }
    }
}
