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
// <summary>分配资源模块处理</summary>
// ***********************************************************************


$(document).ready(function () {
    $.CurrentDialog.find("#btnAccess").on("click", function () {
        var ids = dlgList.getSelectedProperties('Id');
        if (ids == null) return;

        $.post('/RelevanceManager/Assign', {
            type: $("#moduleType").val(),
            firstId: $('#firstId').val(),
            secIds: ids
        }, function (json) {
            json = $.parseJSON(json);
            if (json.statusCode != "200") {
                json = $.parseJSON(json);
                $(this).alertmsg('warn', json.message);
                return;
            }
            dlgList.reload();
        });
    });
    $.CurrentDialog.find("#btnDelAccess").on("click", function () {
        var ids = dlgList.getSelectedProperties('Id');
        if (ids == null) return;

        $.post('/RelevanceManager/UnAssign', {
            type: $("#moduleType").val(),
            firstId: $('#firstId').val(),
            secIds: ids
        }, function (json) {
            json = $.parseJSON(json);
            if (json.statusCode != "200") {
                json = $.parseJSON(json);
                $(this).alertmsg('warn', json.message);
                return;
            }
            dlgList.reload();
        });
    });
});

//grid列表模块
function DialogList() {
    var selectedId = 0; //选中的ID
    var url = '/ResourceManager/LoadWithAccess?cId=';
    this.maingrid = $.CurrentDialog.find('#maingrid').datagrid({
        showToolbar: false,
        filterThead: false,
        target: $(this),
        columns: [
              {
                  name: 'Id',
                  label: '角色ID',
                  hide: true
              },
              {
                  name: 'Name',
                  label: '资源名称',
                  width: 100
              },

              {
                  name: 'IsBelongUser',
                  label: '是否已经授权',
                  type: 'select',
                  align: 'center',
                  items: [{ 'false': '未授权', 'true': '已授权' }],
                  width: 100
              }
        ],
        dataUrl: url + selectedId + '&key=' + $('#moduleType').val() + '&firstId=' + $('#firstId').val(),
        fullGrid: true,
        showLinenumber: true,
        showCheckboxcol: true,
        paging: true,
        filterMult: false,
        showTfoot: false,
      
    });
    this.reload = function (id) {
        if (id != undefined) selectedId = id;
        this.maingrid.datagrid('reload', { dataUrl: url + selectedId + '&key=' + $('#moduleType').val() + '&firstId=' + $('#firstId').val() });
    }
};
DialogList.prototype = new Grid();
var dlgList = new DialogList();

var ztree = function () {
    var setting = {
        view: { selectedMulti: false },
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
        callback: { onClick: zTreeOnClick }
    };
    $.getJSON('/CategoryManager/LoadForTree', function (json) {
        var zTreeObj = $.fn.zTree.init($.CurrentDialog.find("#tree"), setting, json);
        zTreeObj.expandAll(true);
    });
}();
function zTreeOnClick(event, treeId, treeNode) {
    dlgList.reload(treeNode.Id);
}