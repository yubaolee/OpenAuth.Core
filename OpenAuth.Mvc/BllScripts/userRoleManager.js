// ***********************************************************************
// Assembly         : OpenAuth.Mvc
// Author           : yubaolee
// Created          : 04-13-2016
//
// Last Modified By : yubaolee
// Last Modified On : 04-13-2016
// ***********************************************************************
// <copyright file="userRoleManager.js" company="www.cnblogs.com/yubaolee">
//     版权所有(C) 2015
// </copyright>
// <summary>用户分配角色模块</summary>
// ***********************************************************************


$(document).ready(function () {
    $.CurrentDialog.find("#btnAccess").on("click", function () {
        var ids = userRolesList.getSelectedProperties('Id');
        if (ids == null) return;

        $.post('/RoleManager/AccessRoles', {
            userId: $('#userId').val(),
            ids: ids
        }, function (json) {
            userRolesList.reload();
        });
    });
    $.CurrentDialog.find("#btnDelAccess").on("click", function () {
        var ids = userRolesList.getSelectedProperties('Id');
        if (ids == null) return;

        $.post('/RoleManager/DelAccessRoles', {
            userId: $('#userId').val(),
            ids: ids
        }, function (json) {
            userRolesList.reload();
        });
    });
});

//grid列表模块
function UserRolesList() {
    var selectedId = 0; //选中的ID
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
                label: '角色名称',
                width: 100
            },
              {
                  name: 'OrgName',
                  label: '所属组织',
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
        dataUrl: '/RoleManager/LoadForOrgAndUser?orgId=' + selectedId + '&userId=' + $('#userId').val(),
        fullGrid: true,
        showLinenumber: true,
        showCheckboxcol: true,
        paging: true,
        filterMult: false,
        showTfoot: false,
        height: '100%'
    });
    this.reload = function (id) {
        if (id != undefined) selectedId = id;
        this.maingrid.datagrid('reload', { dataUrl: '/RoleManager/LoadForOrgAndUser?orgId=' + selectedId + '&userId=' + $('#userId').val() });
    }
};
UserRolesList.prototype = new Grid();
var userRolesList = new UserRolesList();

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
    $.getJSON('/OrgManager/LoadOrg', function (json) {
        var zTreeObj = $.fn.zTree.init($.CurrentDialog.find("#tree"), setting, json);
        zTreeObj.expandAll(true);
    });
}();
function zTreeOnClick(event, treeId, treeNode) {
    userRolesList.reload(treeNode.Id);
}
//@@ sourceURL=userRoleManager.js
