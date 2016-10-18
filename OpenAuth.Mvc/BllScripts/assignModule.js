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


$(document).ready(function () {
    $.CurrentDialog.find("#btnAccess").on("click", function () {
        var ids = ztree.getSelected();
        if (ids == null) return;

        $.post('/RelevanceManager/Assign', {
            type: $("#moduleType").val(),
            firstId: $('#firstId').val(),
            secIds: ids
        }, function (json) {
            json = $.parseJSON(json);
            if (json.statusCode != "200") {
                $(this).alertmsg('warn', json.message);
                return;
            }
            selected.reLoad();
        });
    });
    $.CurrentDialog.find("#btnDelAccess").on("click", function () {
        var ids = selected.getSelected();
        if (ids == null) return;

        $.post('/RelevanceManager/UnAssign', {
            type: $("#moduleType").val(),
            firstId: $('#firstId').val(),
            secIds: ids
        }, function (json) {
            json = $.parseJSON(json);
            if (json.statusCode != "200") {
                $(this).alertmsg('warn', json.message);
                return;
            }
            selected.reLoad();
        });
    });
});

 
