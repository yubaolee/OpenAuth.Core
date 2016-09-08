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

//grid列表模块
function MainGrid() {
    var url = '/ModuleManager/Load?orgId=';
    var selectedId = '00000000-0000-0000-0000-000000000000';  //ztree选中的模块
    this.maingrid = $('#maingrid').datagrid({
        showToolbar: false,
        filterThead: false,
        loadType: 'GET',
        target: $(this),
        columns: [
               {
                   name: 'Id',
                   label: '功能模块流水号',
                   width: 100
                    , hide: true
               },
               {
                   name: 'CascadeId',
                   label: '节点语义ID',
                   width: 100
               },
               {
                   name: 'Name',
                   label: '功能模块名称',
                   width: 100
               },
               {
                   name: 'Url',
                   label: '主页面URL',
                   width: 100
               },

               {
                   name: 'IsLeaf',
                   label: '是否叶子节点',
                   width: 100
                     , type: 'select',
                   align: 'center',
                   items: [{ 'false': '否' }, { 'true': '是' }],
               },
               {
                   name: 'IsAutoExpand',
                   label: '是否自动展开',
                   width: 100
                     , type: 'select',
                   align: 'center',
                   items: [{ 'false': '否' }, { 'true': '是' }],
               },
               {
                   name: 'Status',
                   label: '当前状态',
                   width: 100
                     , type: 'select',
                   align: 'center',
                   items: [{ '0': '默认' }, { '1': '状态1' }],
               },
               {
                   name: 'ParentName',
                   label: '父节点名称',
                   width: 100
               },
               {
                   name: 'Vector',
                   label: '矢量图标',
                   width: 100
               },
               {
                   name: 'SortNo',
                   label: '排序号',
                   width: 100
               },
        ],
        dataUrl: url + selectedId,
        fullGrid: true,
        showLinenumber: true,
        showCheckboxcol: true,
        paging: true,
        filterMult: false,
        showTfoot: false,
      
    });
    this.reload = function (id) {
        if (id != undefined) selectedId = id;
        this.maingrid.datagrid('reload', { dataUrl: url + selectedId });
    };
};
MainGrid.prototype = new Grid();
var list = new MainGrid();

//左边分类导航树
var ztree = function () {
    var url = '/ModuleManager/LoadModuleWithRoot';
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
    $.getJSON(url, function (json) {
        $.fn.zTree.init($("#tree"), setting, json).expandAll(true);
    });
    function zTreeOnClick(event, treeId, treeNode) {
        list.reload(treeNode.Id);
    }

    return {
        reload: function () {
            $.getJSON(url, function (json) {
                $.fn.zTree.init($("#tree"), setting, json).expandAll(true);
            });
        }
    }
}();

//编辑时，选择上级弹出的树
var parentTree = function () {
    var nameDom = "#ParentName";
    var idDom = "#ParentId";
    var zTreeObj;
    var setting = {
        view: {
            selectedMulti: false
        },
        check: {
            enable: true,
            chkStyle: "radio",  //单选
            radioType: "all"
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

    function zTreeCheck(event, treeId, treeNode) {
        var nodes = zTreeObj.getCheckedNodes(true);
        var ids = nodes.map(function (e) { return e.Id; }).join(",");
        var names = nodes.map(function (e) { return e.Name; }).join(",");

        $(nameDom).val(names);
        $(idDom).val(ids);
    }
    function zTreeOnClick(event, treeId, treeNode) {
        zTreeObj.checkNode(treeNode, !treeNode.checked, true, true);
        event.preventDefault();
    }

    return {
        show: function () {
            $.getJSON('/moduleManager/LoadForTree', function (json) {
                zTreeObj = $.fn.zTree.init($('#j_select_tree1'), setting, json);
                var orgstr = $(idDom).val();
                var name = '';
                if (orgstr != '') {
                    var nodeIds = orgstr.split(',');
                    $.each(nodeIds, function () {
                        var node = zTreeObj.getNodeByParam("Id", this, null);
                        name += ',' + node.Name;
                        zTreeObj.checkNode(node, true, true);
                    });
                    $(nameDom).val(name.substr(1));  //显示名称
                }
                zTreeObj.expandAll(true);
            });
        }
    };
}();

//添加（编辑）对话框
var editDlg = function () {
    var update = false;
    var show = function () {
        BJUI.dialog({ id: 'editDlg', title: '编辑', target: '#editDlg' });
        $("#btnSave").on("click", function () {
            editDlg.save();
        });
    }
    return {
        add: function () {  //弹出添加
            update = false;
            show();
            $.CurrentDialog.find("form")[0].reset();  //reset方法只能通过dom调用
            $("#Id").val('00000000-0000-0000-0000-000000000000');

            parentTree.show()
        },
        update: function (ret) {  //弹出编辑框
            update = true;
            show();
            $('#Id').val(ret.Id);
            $('#CascadeId').val(ret.CascadeId);
            $('#Name').val(ret.Name);
            $('#Url').val(ret.Url);
            $('#HotKey').val(ret.HotKey);
            $('#ParentId').val(ret.ParentId);
            $('#IsLeaf').selectpicker('val', ret.IsLeaf?"true":"false");
            $('#IsAutoExpand').selectpicker('val', ret.IsAutoExpand?"true":"false");
            $('#IconName').val(ret.IconName);
            $('#Status').val(ret.Status);
            $('#ParentName').val(ret.ParentName);
            $('#Vector').val(ret.Vector);
            $('#SortNo').val(ret.SortNo);
            parentTree.show()
        },
        save: function () {  //编辑-->保存
            $('#editForm').isValid(function (v) {
                if (!v) return;  //验证没通过
                $("#editForm").bjuiajax('ajaxForm', {
                    reload: false,
                    callback: function (json) {
                        if (json.statusCode != "200") {
                            $(this).alertmsg('warn', json.message);
                            return;
                        }
                        list.reload();
                        ztree.reload();
                    }
                });
            });
        }
    };
}();


//删除
function del() {
    var selected = list.getSelectedObj();
    if (selected == null) return;

    $.post('/moduleManager/Delete?Id=' + selected.Id, function (data) {
        if (data.statusCode == "200") {
            list.reload();
            ztree.reload();
        }
        else {
            $(this).alertmsg('warn', data.message);
        }
    }, "json");
}

//自定义的编辑按钮
function edit() {
    var selected = list.getSelectedObj();
    if (selected == null) {
        return;
    }
    editDlg.update(selected);
}

function add() {
    editDlg.add();
}

function refresh() {
    list.reload();
}

//为模块分配按钮
function assignButton() {
    var selected = list.getSelectedObj();
    if (selected == null) return;

    //BJUI.dialog({ id: 'assignDialog', title: '菜单编辑', target: '#moduleElementManager' });

    BJUI.dialog({
        id: 'assignDialog',
        mask: true,
        url: '/ModuleElementManager/Index?id=' + selected.Id,
        title: '为模块分配按钮',
        width: '800',
        height:'600'
    });
}

//@@ sourceURL=moduleManager.js