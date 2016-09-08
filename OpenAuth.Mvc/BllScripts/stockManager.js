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
    var url = '/StockManager/Load?parentId=';
    var selectedId = '00000000-0000-0000-0000-000000000000';  //ztree选中的模块
    this.maingrid = $('#maingrid').datagrid({
        showToolbar: false,
        filterThead: false,
        loadType: 'GET',
        target: $(this),
        columns: [
               {
                   name: 'Id',
                   label: '数据ID',
                   hide: true
               },
               {
                   name: 'OrgId',
                   label: '组织ID',
                   hide:true
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
                   name: 'Price',
                   label: '产品单价',
                   width: 100
               },
               {
                   name: 'Status',
                   label: '出库/入库',
                   width: 100
                     , align: 'center',
                   items: [{ '0': '出库' }, { '1': '入库' }],
               },
               {
                   name: 'Viewable',
                   label: '可见范围（测试资源使用）',
                   width: 100,
                   items: [{ '': '全部可见' }, { 'ADMIN': '管理员可见' },{'DEV':'开发可见'}],
               },
               {
                   name: 'Time',
                   label: '操作时间',
                   width: 100
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

//编辑时，选择上级弹出的树
var parentTree = function () {
    var nameDom = "#ParentName";
    var idDom = "#OrgId";
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
            $.getJSON('/OrgManager/LoadOrg', function (json) {
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
            $("#Id").val('00000000-0000-0000-0000-000000000000');
            parentTree.show();
        },
        update: function (ret) {  //弹出编辑框
            update = true;
            show();
            $('#Id').val(ret.Id);
            $('#Name').val(ret.Name);
            $('#Number').val(ret.Number);
            $('#Price').val(ret.Price);
            $('#Status').selectpicker('val', ret.Status);
            $('#Viewable').selectpicker('val', ret.Viewable);
            $('#Time').val(ret.Time);
            $('#OrgId').val(ret.OrgId);
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

    $.post('/StockManager/Delete?Id=' + selected.Id, function (data) {
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

//@@ sourceURL=StockManager.js