// ***********************************************************************
// Assembly         : OpenAuth.Mvc
// Author           : yubaolee
// Created          : 11-05-2015
//
// Last Modified By : yubaolee
// Last Modified On : 11-05-2015
// ***********************************************************************
// <copyright file="BJUIResponse.cs" company="www.cnblogs.com/yubaolee">
//     Copyright (c) www.cnblogs.com/yubaolee. All rights reserved.
// </copyright>
// <summary>B-JUI框架返回</summary>
// ***********************************************************************

namespace OpenAuth.Mvc.Models
{
    public class BjuiResponse
    {
        public string statusCode
        {
            get; set;
            
        }

        public string message
        {
            get; set;
            
        }

        public string tabid
        {
            get; set;
            
        }

        public bool closeCurrent
        {
            get; set;
            
        }

        public string forward { get; set; }
        public string forwardConfirm { get; set; }


        public BjuiResponse()
        {
            statusCode = "200";
            message = "操作成功";
            tabid = "";
            closeCurrent = false;
            forward = "";
            forwardConfirm = "";
        }
    }
}