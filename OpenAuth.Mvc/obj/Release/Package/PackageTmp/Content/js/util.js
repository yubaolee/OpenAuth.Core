// ***********************************************************************
// Assembly         : OpenAuth.Mvc
// Author           : yubaolee
// Created          : 04-20-2016
//
// Last Modified By : yubaolee
// Last Modified On : 04-20-2016
// Contact : www.cnblogs.com/yubaolee
// File: util.js
// ***********************************************************************


//获取URL参数
function getURLParameter(name) {
    return decodeURIComponent((new RegExp('[?|&]' + name + '=' + '([^&;]+?)(&|#|;|$)').exec(location.search) || [, ""])[1].replace(/\+/g, '%20')) || null;
}