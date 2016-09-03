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
        callback: {
            onClick: function (event, treeId, treeNode) {
                list.reload(treeNode.Id);
            }
        }
    };
    var load = function () {
        $.getJSON(url, function (json) {
            var zTreeObj = $.fn.zTree.init($("#tree"), setting, json);
            var firstId;  //tree的第一个ID
            if (json.length > 0) {
                firstId = json[0].Id;
            } else {
                firstId = -1;
            }
            list.reload(firstId);
            zTreeObj.expandAll(true);
        });
    };
    load();

    return {
        reload: load
    }
}();
//grid列表模块
function MainGrid() {
    var url = '/GoodsApplies/Load?parentId=';
    var selectedId = '00000000-0000-0000-0000-000000000000';  //ztree选中的模块
    this.maingrid = $('#maingrid').datagrid({
        showToolbar: false,
        filterThead: false,
        target: $(this),
        columns: [
               {
                   name: 'Id',
                   hide: true
               },
               {
                   name: 'Name',
                   label: '产品名称',
                   width: 100
               },
               {
                   name: 'Number',
                   label: '产品数量',
                   width: 100
               },
               
               {
                   name: 'StateName',
                   label: '当前流程',
                   width: 100
               },
               {
                   name: 'State',
                   hide:true
               }
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


//添加（编辑）对话框
var editDlg = function () {
    var show = function () {
        BJUI.dialog({ id: 'editDlg', title: '编辑对话框', target: '#editDlg' });
        $("#btnSave").on("click", function () {
            editDlg.save();
        });
    }
    return {
        add: function () {  //弹出添加
            show();
            $.CurrentDialog.find("form")[0].reset();  //reset方法只能通过dom调用
            $("#Id").val('00000000-0000-0000-0000-000000000000');
        },
        update: function (ret) {  //弹出编辑框
            show();
            $('#Id').val(ret.Id);
            $('#Name').val(ret.Name);
            $('#Number').val(ret.Number);
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

    $.getJSON('/GoodsApplies/Delete?Id=' + selected.Id, function (data) {
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

//进度详情
function detail() {
    var selected = list.getSelectedObj();
    if (selected == null) {
        return;
    }
    $(this).dialog({ 
        id: 'detailDlg',
        url: '/GoodsApplies/Detail?id=' + selected.Id,
        title: '进度详情',
        width: 800,
        height:600
    });
}

function add() {
    editDlg.add();
}

function refresh() {
    list.reload();
}

//@@ sourceURL=StockManager.js