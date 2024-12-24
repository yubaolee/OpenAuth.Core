﻿using System;
using System.ComponentModel;
using SqlSugar;

namespace OpenAuth.Repository.Core
{
    /// <summary>
    /// 主键为字符串的实体基类，为系统默认的实体类型
    /// </summary>
    public class StringEntity : BaseEntity
    {
        [Browsable(false)]
        [SugarColumn(IsPrimaryKey = true)]
        public string Id { get; set; }
        
        /// <summary>
        /// 判断主键是否为空，常用做判定操作是【添加】还是【编辑】
        /// </summary>
        /// <returns></returns>
        public override bool KeyIsNull()
        {
            return string.IsNullOrEmpty(Id);
        }

        /// <summary>
        /// 创建默认的主键值
        /// <para>当构造函数执行时如果Id为空，则会自动执行该函数</para>
        /// </summary>
        public override void GenerateDefaultKeyVal()
        {
            Id = Guid.NewGuid().ToString();
        }
    }
}
