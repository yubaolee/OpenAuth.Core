// ***********************************************************************
// Assembly         : OpenAuth.Mvc
// Author           : yubaolee
// Created          : 04-06-2016
//
// Last Modified By : yubaolee
// Last Modified On : 04-06-2016
// ***********************************************************************
// <copyright file="modulemanager.js" company="www.cnblogs.com/yubaolee">
//     版权所有(C) 2015
// </copyright>
// <summary>模块管理脚本</summary>
// ***********************************************************************

$(document).ready(function () {
});

//ztree模块
var ztree = function () {
    var zTreeObj = undefined;
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
    $.getJSON('/ModuleManager/LoadModuleWithRoot', function (json) {
        zTreeObj = $.fn.zTree.init($('#maintree'), setting, json);
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
                label: '功能模块流水号',
                hide: true
            },
            {
                name: 'CascadeId',
                label: '节点语义ID',
                width: 80
            },
            {
                name: 'Name',
                label: '功能模块名称',
                width: 80
            },
            {
                name: 'Url',
                label: '主页面URL',
                width: 80
            },
            {
                name: 'ParentId',
                label: '父节点流水号',
                hide: true
            },
            {
                name: 'IconName',
                width: 80,
                label: '节点图标文件名称'
            },
            {
                name: 'Status',
                width: 80,
                label: '当前状态'
            },
            {
                name: 'ParentName',
                width: 80,
                label: '父节点名称'
            },
            {
                name: 'Vector',
                width: 80,
                label: '矢量图标'
            },
            {
                name: 'SortNo',
                width: 80,
                label: '排序号'
            },
        ],
        dataUrl: '/ModuleManager/Load?orgId=' + selectedId,
        fullGrid: true,
        showLinenumber: true,
        showCheckboxcol: true,
        paging: true,
        filterMult: false,
        showTfoot: false,
        height: 'auto'
    });

    return {
        reload: function (id) {
            if (id != undefined) selectedId = id;
            maingrid.datagrid('reload', { dataUrl: '/ModuleManager/Load?orgId=' + selectedId });
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

function zTreeOnClick(event, treeId, treeNode) {
    grid.reload(treeNode.Id);
}

//删除
function delModule() {
    var selected = grid.getSelectedObj();
    if (selected == null) return;

    $.getJSON('/ModuleManager/Delete?Id=' + selected.Id, function (data) {
        if (data.statusCode == "200")
            grid.reload();
        else {
            $(this).alertmsg('warn', data.message);
        }
    });
}

//自定义的编辑按钮
function editModule() {
    var selected = grid.getSelectedObj();
    if (selected == null) return;

    $(this).dialog({
        id: 'editDialog',
        url: '/ModuleManager/Add?id=' + selected.Id,
        title: '编辑',
        onClose: function () {
            grid.reload();
        }
    });
}

//为模块分配按钮
function assignButton() {
    var selected = grid.getSelectedObj();
    if (selected == null) return;

    //BJUI.dialog({ id: 'assignDialog', title: '菜单编辑', target: '#moduleElementManager' });

    BJUI.dialog({
        id: 'assignDialog',
        mask: true,
        url: '/ModuleElementManager/Index?id=' + selected.Id,
        title: '为模块分配按钮'
    });
}

function refreshModuleGrid() {
    grid.reload();
}