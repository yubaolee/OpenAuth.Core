// ***********************************************************************
// Assembly         : OpenAuth.Mvc
// Author           : yubaolee
// Created          : 04-13-2016
//
// Last Modified By : yubaolee
// Last Modified On : 04-13-2016
// ***********************************************************************
// <copyright file="userModuleElement.js" company="www.cnblogs.com/yubaolee">
//     版权所有(C) 2015
// </copyright>
// <summary>为用户分配模块菜单</summary>
// ***********************************************************************


$(document).ready(function () {
    $.CurrentDialog.find("#btnAccess").on("click", function () {
        var ids = userMenuList.getSelectedProperties('Id');
        if (ids == null) return;

        $.post("/ModuleElementManager/AssignForUser",
            {
                userId: $('#userId').val(),
                menuIds: ids,
            }, function (json) {
                userMenuList.reload();
            });
    });
    $.CurrentDialog.find("#btnDelAccess").on("click", function () {
        var ids = userMenuList.getSelectedProperties('Id');
        if (ids == null) return;

        $.post("/ModuleElementManager/CancelForUser",{
            userId: $('#userId').val(),
            menuIds: ids,
        }, function (json) {
            userMenuList.reload();
        });
    });
});

//grid列表模块
function UserMEGrid() {
    var selectedId = 0; //ztree选中的模块
    this.maingrid = $.CurrentDialog.find('#maingrid').datagrid({
        showToolbar: false,
        filterThead: false,
        target: $(this),
        columns: [
                   {
                       name: 'Id',
                       label: '元素名称',
                       hide: true
                   },
                {
                    name: 'Name',
                    label: '元素名称',
                    width: 80
                },
                {
                    name: 'ModuleName',
                    label: '所属模块',
                    width: 80
                },
                {
                    name: 'Accessed',
                    label: '是否已经授权',
                    type: 'select',
                    align: 'center',
                    items: [{ 'false': '未授权', 'true': '已授权' }],
                    width: 80
                }
        ],
        dataUrl: '/ModuleElementManager/LoadForUser?moduleId=' + selectedId + '&userId=' + $('#userId').val(),
        fullGrid: true,
        showLinenumber: true,
        showCheckboxcol: true,
        paging: true,
        filterMult: false,
        showTfoot: false,
      
    });
    this.reload = function(id) {
        if (id != undefined) selectedId = id;
        this.maingrid.datagrid('reload', { dataUrl: '/ModuleElementManager/LoadForUser?moduleId=' + selectedId + '&userId=' + $('#userId').val() });
    };
};
UserMEGrid.prototype = new Grid();
var userMenuList = new UserMEGrid();

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
    $.getJSON('/ModuleManager/LoadForUser?userId=' + $('#userId').val(), function (json) {
        var zTreeObj = $.fn.zTree.init($.CurrentDialog.find("#tree"), setting, json);
        zTreeObj.expandAll(true);
    });
}();
function zTreeOnClick(event, treeId, treeNode) {
    userMenuList.reload(treeNode.Id);
}
//@@ sourceURL=userModuleElement.js
