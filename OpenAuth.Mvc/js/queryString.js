// ***********************************************************************
// Assembly         : OpenAuth.Mvc
// Author           : yubaolee
// Created          : 09-04-2016
//
// Last Modified By : yubaolee
// Last Modified On : 09-04-2016
// ***********************************************************************
// <copyright file="queryString.js" company="www.cnblogs.com/yubaolee">
//     版权所有(C) 2015
// </copyright>
// <summary>解析URL中的参数</summary>
// ***********************************************************************

layui.define("jquery",function(exports){
    var jQuery=layui.jquery;
(function ($) {
    $.getUrlParam = function (name) {
        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
        var r = window.location.search.substr(1).match(reg);
        if (r != null) return unescape(r[2]); return null;
    }
})(jQuery);
exports('queryString');
});