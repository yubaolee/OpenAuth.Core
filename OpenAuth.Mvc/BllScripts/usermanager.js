// ***********************************************************************
// Assembly         : OpenAuth.Mvc
// Author           : yubaolee
// Created          : 04-12-2016
//
// Last Modified By : yubaolee
// Last Modified On : 04-12-2016
// ***********************************************************************
// <copyright file="usermanager.js" company="www.cnblogs.com/yubaolee">
//     版权所有(C) 2015
// </copyright>
// <summary>用户管理前端模块</summary>
// ***********************************************************************

$(function () {
});

//ztree模块
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
        callback: {
            onClick: function (event, treeId, treeNode) {
                grid.reload(treeNode.Id);
            }
        }
    };
    $.getJSON('/OrgManager/LoadOrg', function (json) {
        var zTreeObj = $.fn.zTree.init($('#maintree'), setting, json);
        zTreeObj.expandAll(true);
    });
}();

//grid列表模块
var grid = function () {
    var selectedId = 0;  //选中的ID
    var maingrid = $('#maingrid', '#detail').datagrid({
        showToolbar: false,
        filterThead: false,
        target: $(this),
        columns: [
            {
                name: 'Id',
                label: 'Id',
                attrs: { readonly: 'readonly' },
                hide: true
            },
            {
                name: 'Account',
                label: '用户账号',
                width: 142,
                attrs: { readonly: 'readonly' }
            },
            {
                name: 'Name',
                label: '姓名/昵称',
                width: 226
            },
            {
                name: 'Organizations',
                label: '所属机构',
                width: 150
            },
            {
                name: 'Status',
                label: '状态',
                type: 'select',
                align: 'center',
                width: 80,
                items: [{ '0': '正常' }, { '1': '禁用' }]
            },
            {
                name: 'Sex',
                label: '性别',
                type: 'select',
                align: 'center',
                width: 80,
                items: [{ '0': '男' }, { '1': '女' }]
            },
            {
                name: 'CreateTime',
                label: '登记日期',
                type: 'date',
                width: 180,
                pattern: 'yyyy-MM-dd HH:mm:ss'
            }
        ],
        dataUrl: '/UserManager/Load?orgId=' + selectedId,
        fullGrid: true,
        showLinenumber: true,
        showCheckboxcol: true,
        paging: true,
        filterMult: false,
        showTfoot: false,
        height: '100%'
    });

    return {
        reload: function (id) {
            if (id != undefined) selectedId = id;
            maingrid.datagrid('reload', { dataUrl: '/UserManager/Load?orgId=' + selectedId });
        },
        getSelectedObj: function () {  //选择单行
            var selectedDatas = maingrid.data('selectedDatas');
            if (selectedDatas == undefined || selectedDatas.length == 0) {
                $(this).alertmsg('warn', '至少选择一个对象', {
                    displayMode: 'slide',
                    title: '重要提示'
                });
                return null;
            }
            return selectedDatas[0];
        },
        getSelectedMany: function () {  //选择多行
            return maingrid.data('selectedDatas');
        },
    };
}();

//删除
function delUser() {
    var selected = grid.getSelectedObj();
    if (selected == null) return;

    $.getJSON('/UserManager/Delete?Id=' + selected.Id, function (data) {
        if (data.statusCode == "200")
            grid.reload();
        else {
            $(this).alertmsg('warn', data.message);
        }
    });
}

//自定义的编辑按钮
function editUser() {
    var selected = grid.getSelectedObj();
    if (selected == null) return;

    $(this).dialog({
        id: 'editDialog',
        url: '/UserManager/Add?id=' + selected.Id,
        title: '编辑',
        onClose: function () {
            grid.reload();
        }
    });
}

function refreshUserGrid() {
    grid.reload();
}

//用户模块授权按钮
function openUserModuleAccess(obj) {
    var selected = grid.getSelectedObj();
    if (selected == null) return;

    $(obj).dialog({
        id: 'accessUserModule',
        url: '/ModuleManager/LookupMultiForUser',
        title: '为用户分配模块',
        data: {
            userId: selected.Id
        }
    });
}

//用户可见组织授权按钮
function openUserOrgAccess(obj) {
    var selected = grid.getSelectedObj();
    if (selected == null) return;

    $(obj).dialog({
        id: 'accessUserOrg',
        url: '/OrgManager/LookupMultiForUser',
        title: '为用户分配可见部门',
        data: {
            userId: selected.Id
        }
    });
}

//用户角色授权
function openUserRoleAccess(obj) {
    var selected = grid.getSelectedObj();
    if (selected == null) return;

    $(obj).dialog({
        id: 'accessUserRole',
        url: '/RoleManager/LookupMulti',
        title: '为用户分配角色',
        width: 600,
        height: 380,
        data: {
            userId: selected.Id
        }
    });
}

//为用户分配资源
function openUserReourceAccess(obj) {
    var selected = grid.getSelectedObj();
    if (selected == null) return;

    $(obj).dialog({
        id: 'accessUserRole',
        url: '/ResourceManager/LookupMultiForUser',
        title: '为用户分配资源',
        width: 600,
        height: 380,
        data: {
            userId: selected.Id
        }
    });
}

//分配菜单
function openAssignUserElement(obj) {
    var selected = grid.getSelectedObj();
    if (selected == null) return;

    $(obj).dialog({
        id: 'assignElement',
        url: '/ModuleElementManager/AssignForUser?userId=' + selected.Id,
        title: '为用户分配菜单',
        width: 700,
        height: 380
    });
}