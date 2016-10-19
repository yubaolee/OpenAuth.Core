// ***********************************************************************
// Assembly         : OpenAuth.Mvc
// Author           : yubaolee
// Created          : 04-16-2016
//
// Last Modified By : yubaolee
// Last Modified On : 04-16-2016
// ***********************************************************************
// <copyright file="userRes.js" company="www.cnblogs.com/yubaolee">
//     版权所有(C) 2015
// </copyright>
// <summary>分配组织</summary>
// ***********************************************************************
layui.use(['layer', 'form'], function () {
    var form = layui.form();

    form.on('checkbox', function (data) {
        if (data.elem.checked)
        {
            $.post('/RelevanceManager/Assign', {
                type: $("#moduleType").val(),
                firstId: $('#firstId').val(),
                secIds: data.value
            }, function (json) {
                json = $.parseJSON(json);
                
            });
        }
        else
        {
            $.post('/RelevanceManager/UnAssign', {
                type: $("#moduleType").val(),
                firstId: $('#firstId').val(),
                secIds: data.value
            }, function (json) {
                json = $.parseJSON(json);
               
            });
        }
    });
});
 
