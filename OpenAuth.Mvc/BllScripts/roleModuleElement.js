// ***********************************************************************
// Assembly         : OpenAuth.Mvc
// Author           : yubaolee
// Created          : 04-13-2016
//
// Last Modified By : yubaolee
// Last Modified On : 04-13-2016
// ***********************************************************************
// <copyright file="RoleModuleElement.js" company="www.cnblogs.com/yubaolee">
//     版权所有(C) 2015
// </copyright>
// <summary>为角色分配模块菜单</summary>
// ***********************************************************************


$(document).ready(function () {
    $.CurrentDialog.find("#btnAccess").on("click", function () {
        var ids = list.getSelectedProperties('Id');
        if (ids == null) return;

        $.post("/ModuleElementManager/AssignForRole",
            {
                RoleId: $('#roleId').val(),
                menuIds: ids,
            }, function (json) {
                list.reload();
            });
    });
    $.CurrentDialog.find("#btnDelAccess").on("click", function () {
        var ids = list.getSelectedProperties('Id');
        if (ids == null) return;

        $.post("/ModuleElementManager/CancelForRole",{
            RoleId: $('#roleId').val(),
            menuIds: ids,
        }, function (json) {
            list.reload();
        });
    });
});

//grid列表模块
function RoleMEGrid() {
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
        dataUrl: '/ModuleElementManager/LoadForRole?moduleId=' + selectedId + '&RoleId=' + $('#roleId').val(),
        fullGrid: true,
        showLinenumber: true,
        showCheckboxcol: true,
        paging: true,
        filterMult: false,
        showTfoot: false,
        height: '100%'
    });
    this.reload = function(id) {
        if (id != undefined) selectedId = id;
        this.maingrid.datagrid('reload', { dataUrl: '/ModuleElementManager/LoadForRole?moduleId=' + selectedId + '&RoleId=' + $('#roleId').val() });
    };
};
RoleMEGrid.prototype = new Grid();
var list = new RoleMEGrid();

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
    $.getJSON('/ModuleManager/LoadForRole?RoleId=' + $('#roleId').val(), function (json) {
        var zTreeObj = $.fn.zTree.init($.CurrentDialog.find("#tree"), setting, json);
        zTreeObj.expandAll(true);
    });
}();
function zTreeOnClick(event, treeId, treeNode) {
    list.reload(treeNode.Id);
}
//@@ sourceURL=RoleModuleElement.js
