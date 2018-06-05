// ***********************************************************************
// Assembly         : Infrastructure
// Author           : Yubao Li
// Created          : 11-23-2015
//
// Last Modified By : Yubao Li
// Last Modified On : 11-23-2015
// ***********************************************************************
// <copyright file="ObjectHelper.cs" company="">
//     Copyright (c) . All rights reserved.
// </copyright>
// <summary>
//对象COPY/初始化帮助，通常是防止从视图中传过来的对象属性为空，这其赋初始值
//</summary>
// ***********************************************************************

using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;

namespace Infrastructure
{
    public static class ObjectHelper
    {
        public static T CopyTo<T>(this object source) where T:class, new()
        {
            var result = new T();
            source.CopyTo(result);
            return result;
        }
      
        public static void CopyTo<T>(this object source, T target)
            where T : class,new()
        {
            if (source == null)
                return;

            if (target == null)
            {
                target = new T();
            }

            foreach (var property in target.GetType().GetProperties())
            {
                var propertyValue = source.GetType().GetProperty(property.Name).GetValue(source, null);
                if (propertyValue != null)
                {
                    if (propertyValue.GetType().IsClass)
                    {

                    }
                    target.GetType().InvokeMember(property.Name, BindingFlags.SetProperty, null, target, new object[] { propertyValue });
                }

            }

            foreach (var field in target.GetType().GetFields())
            {
                var fieldValue = source.GetType().GetField(field.Name).GetValue(source);
                if (fieldValue != null)
                {
                    target.GetType().InvokeMember(field.Name, BindingFlags.SetField, null, target, new object[] { fieldValue });
                }
            }
        }
    }
}
