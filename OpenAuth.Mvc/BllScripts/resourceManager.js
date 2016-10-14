$(function () {
    $("#ParentName").on("click", function () {
        parent.reload();
    });
});

//左边导航
var ztree = function () {
    var url = '/CategoryManager/LoadForTree';
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
            var zTreeObj = $.fn.zTree.init($("#orgtree"), setting, json);
            list.reload();
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
    var url = '/ResourceManager/Load?categoryId=';
    var selectedId = '00000000-0000-0000-0000-000000000000';  //ztree选中的模块
    this.maingrid = $('#maingrid')
        .jqGrid({
            colModel: [
                {
                    name: 'Id',
                    index: 'Id',
                    hidden: true
                },
                {
                    index: 'Key',
                    name: 'Key',
                    label: '资源标识'
                },
                {
                    index: 'Name',
                    name: 'Name',
                    label: '分类名称'
                },
                {
                    index: 'CategoryName',
                    name: 'CategoryName',
                    label: '所属分类'
                },
                 {
                     index: 'CategoryId',
                     name: 'CategoryId',
                     hidden: true
                 },

                {
                    index: 'SortNo',
                    name: 'SortNo',
                    label: '排序号'

                }
            ],
            url: url + selectedId,
            datatype: "json",

            viewrecords: true,
            rowNum: 18,
            pager: "#grid-pager",
            altRows: true,
            height: 'auto',
            multiselect: true,
            multiboxonly: true,

            loadComplete: function () {
                var table = this;
                setTimeout(function () {
                    updatePagerIcons(table);
                },
                    0);
            }
        }).jqGrid('navGrid', "#grid-pager", {
            edit: false, add: false, del: false, refresh: false, search: false
        });

    this.reload = function (id) {
        if (id != undefined) selectedId = id;
        this.maingrid.jqGrid("setGridParam", { url: url + selectedId })
            .trigger("reloadGrid", [{ page: 1 }]);  //重载JQGrid

    };
};
MainGrid.prototype = new Grid();
var list = new MainGrid();
var vm = new Vue({
    el: '#editDlg'
});

//上级机构选择框
var parent = function (name,id) {   //ztree搜索框
    var zTreeObj;
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
            onClick: onClick
        }
    };
    var showMenu = function () {
        $("#menuContent").css({ left: "10px", top: $("#"+name).outerHeight() + "px" }).slideDown("fast");
        $("body").bind("mousedown", onBodyDown);
    };
    function onClick(e, treeId, treeNode) {
        var nodes = zTreeObj.getSelectedNodes();

        for (var i = 0, l = nodes.length; i < l; i++) {
            vm.$set(name, nodes[i].Name);
            vm.$set(id, nodes[i].Id);
            break;
        }
        hideMenu();
    }
    function onBodyDown(event) {
        if (!(event.target.id == "menuContent" || $(event.target).parents("#menuContent").length > 0)) {
            hideMenu();
        }
    }
    function hideMenu() {
        $("#menuContent").fadeOut("fast");
        $("body").unbind("mousedown", onBodyDown);
    }
    return {
        reload: function () {
            var index = layer.load();
            $.getJSON("/CategoryManager/LoadForTree", {
                page: 1, rows: 10000
            }, function (json) {
                layer.close(index);
                if (json.length == 0) {
                    vm.$set(name, '');
                    vm.$set(id, '');
                    return;
                }
                zTreeObj = $.fn.zTree.init($("#org"), setting, json);
                zTreeObj.expandAll(true);
                showMenu();
            });
        }
    }
}("CategoryName","CategoryId");

//添加（编辑）对话框
var editDlg = function () {
    var update = false;
    var show = function () {
        layer.open({
            type: 1,
            skin: 'layui-layer-rim', //加上边框
            title: "用户管理", //不显示标题
            area: ['400px', '300px'], //宽高
            content: $('#editDlg'), //捕获的元素
            btn: ['保存', '关闭'],
            yes: function (index, layero) {
                $.post("/CategoryManager/Add", vm.$data, function (data) {
                    layer.msg(data.Message);
                    if (data.Status) {
                        list.reload();
                        ztree.reload();
                    }
                }, "json");
            },
            cancel: function (index) {
                layer.close(index);
            }
        });
    }
    return {
        add: function () {  //弹出添加
            update = false;
            show();
            vm.$set('$data', {
                Id: '00000000-0000-0000-0000-000000000000',
                SortNo: 0
            });
        },
        update: function (ret) {  //弹出编辑框
            update = true;
            show();
            vm.$set('$data', ret);
        }
    };
}();

//删除
function del() {
    var selected = list.getSelectedProperties("Id");
    if (selected == null) return;

    $.post('/ResourceManager/Delete',
    { ids: selected }, function (data) {
        if (data.Status) {
            list.reload();
            ztree.reload();
        }
        else {
            $(this).alertmsg('warn', data.Message);
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

//@@ sourceURL=ResourceManager.js