// ***********************************************************************
// Assembly         : OpenAuth.Domain
// Author           : Yubao Li
// Created          : 11-30-2015
//
// Last Modified By : Yubao Li
// Last Modified On : 11-30-2015
// ***********************************************************************
// <copyright file="IRelevanceRepository.cs" company="">
//     Copyright (c) . All rights reserved.
// </copyright>
// <summary>多对多关系统一处理</summary>
// ***********************************************************************

using System;
using System.Collections.Generic;
using System.Linq;

namespace OpenAuth.Domain.Interface
{
    public interface IRelevanceRepository : IRepository<Relevance>
    {
        void DeleteBy(string key, params Guid[] firstIds);
        void DeleteBy(string key, ILookup<Guid, Guid> idMaps);

        void AddRelevance( string key, ILookup<Guid, Guid>  idMaps);
    }
}
