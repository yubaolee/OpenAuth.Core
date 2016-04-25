
//grid列表模块
function MainGrid() {
    var url = '/OrgManager/LoadChildren?Id=';
    var selectedId = 0; //ztree选中的模块
    this.maingrid = $('#maingrid').datagrid({
        showToolbar: false,
        filterThead: false,
        target: $(this),
        columns: [
               {
                   name: 'Id',
                   label: '流水号',
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
                   label: '组织名称',
                   width: 100
               },
               {
                   name: 'ParentName',
                   label: '父节点名称',
                   width: 100
               },
               {
                   name: 'IsLeaf',
                   label: '是否叶子节点',
                   width: 100
                     , 
                   align: 'center',
                   items: [{ 'false': '否' }, { 'true': '是' }],
               },
               {
                   name: 'IsAutoExpand',
                   label: '是否自动展开',
                   width: 100
                     , 
                   align: 'center',
                   items: [{ 'false': '否' }, { 'true': '是' }],
               },
               {
                   name: 'IconName',
                   label: '节点图标文件名称',
                   width: 100
               },
               {
                   name: 'SortNo',
                   label: '排序号',
                   width: 100 , 
                   align: 'center'
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
    var url = '/OrgManager/LoadOrg';
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
            $.getJSON('/OrgManager/LoadForTree', function (json) {
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
        BJUI.dialog({ id: 'editDlg', title: '编辑对话框', target: '#editDlg' });
        $("#btnSave").on("click", function () {
            editDlg.save();
        });
    }
    return {
        add: function () {  //弹出添加
            update = false;
            show();
            $.CurrentDialog.find("form")[0].reset();  //reset方法只能通过dom调用
            $("#Id").val(0);

            parentTree.show()
        },
        update: function (ret) {  //弹出编辑框
            update = true;
            show();
            $('#Id').val(ret.Id);
            $('#Name').val(ret.Name);
            $('#ParentId').val(ret.ParentId);
            $('#ParentName').val(ret.ParentName);
            $('#IsLeaf').selectpicker('val', ret.IsLeaf?"true":"false");
            $('#IsAutoExpand').selectpicker('val', ret.IsAutoExpand?"true":"false");
            $('#SortNo').val(ret.SortNo);
            parentTree.show();
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

    $.getJSON('/OrgManager/DelOrg?Id=' + selected.Id, function (data) {
        if (data.statusCode == "200") {
            list.reload();
            ztree.reload();
        }
        else {
            $(this).alertmsg('warn', data.message);
        }
    });
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

//@@ sourceURL=OrgManager.js