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


//待选的树
var ztree = function () {
    var moduleIds = new Array();
    var zTreeObj;
    var setting = {
        view: {
            selectedMulti: false
        },
        check: {
            enable: true,
            chkStyle: "checkbox",
            chkboxType: { "Y": "", "N": "" } //去掉勾选时级联
        },
        data: {
            key: {
                name: 'Name',
                title: 'Name'
            },
            simpleData: {
                enable: true,
                idKey: 'Id',
                pIdKey: 'ParentId',
                rootPId: 'null'
            }
        },
        callback: {
            onClick: zTreeOnClick,
            onCheck: zTreeCheck
        }
    };

    function zTreeCheck(e, treeId, treeNode) {
        var nodes = zTreeObj.getCheckedNodes(true);
        if (nodes.length != 0) {
            moduleIds = nodes.map(function(e) { return e.Id; });
        }
    }
    function zTreeOnClick(event, treeId, treeNode) {
        zTreeObj.checkNode(treeNode, !treeNode.checked, true, true);
        event.preventDefault();
    }

    $.getJSON('/ModuleManager/LoadForTree', function (json) {
        zTreeObj = $.fn.zTree.init($.CurrentDialog.find("#tree"), setting, json);
        zTreeObj.expandAll(true);
    });

    return {
        getSelected: function() {
            return moduleIds;
        }
}
}();


//已分配的机构
var selected = function () {
    var moduleIds = new Array();
    var zTreeObj;
    var setting = {
        view: {
            selectedMulti: false
        },
        check: {
            enable: true,
            chkStyle: "checkbox",
            chkboxType: { "Y": "", "N": "" } //去掉勾选时级联
        },
        data: {
            key: {
                name: 'Name',
                title: 'Name'
            },
            simpleData: {
                enable: true,
                idKey: 'Id',
                pIdKey: 'ParentId',
                rootPId: 'null'
            }
        },
        callback: {
            onClick: zTreeOnClick,
            onCheck: zTreeCheck
        }
    };

    function zTreeCheck(e, treeId, treeNode) {
        var nodes = zTreeObj.getCheckedNodes(true);
        if (nodes.length != 0) {
            moduleIds = nodes.map(function (e) { return e.Id; });
        }
    }
    function zTreeOnClick(event, treeId, treeNode) {
        zTreeObj.checkNode(treeNode, !treeNode.checked, true, true);
        event.preventDefault();
    }

    var load = function() {
        var url;
        var type = $("#moduleType").val();
        if (type == "UserModule") {
            url = '/ModuleManager/LoadForUser';
        } else {
            url = '/ModuleManager/LoadForRole';
        }
        $.getJSON(url, {
            firstId: $('#firstId').val()
        }, function (json) {
            zTreeObj = $.fn.zTree.init($.CurrentDialog.find("#selected"), setting, json);
            zTreeObj.expandAll(true);
        });
    }

    return {
        getSelected: function () {
            return moduleIds;
        },
        reLoad: function() {
            return load();
        }
    }
}();

selected.reLoad();

//@@ sourceURL=assignModule.js
