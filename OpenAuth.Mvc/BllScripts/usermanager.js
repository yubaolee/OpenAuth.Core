$(function () {
    $("#Organizations").on("click", function () {
        parent.reload();
    });
});

//左边导航
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
    var url = '/UserManager/Load?orgId=';
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
                    index: 'Name',
                    name: 'Name',
                    label: '姓名'
                },
                {
                    index: 'Account',
                    name: 'Account',
                    label: '账号'
                },
                {
                    index: 'Sex',
                    name: 'Sex',
                    label: '性别'

                },
                {
                    index: 'OrganizationIds',
                    name: 'OrganizationIds',
                    hidden:true
                },
                {
                    index: 'Organizations',
                    name: 'Organizations',
                    label: '所属机构'

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
var parent = new ParentTreeMultiple("/OrgManager/LoadOrg","Organizations","OrganizationIds");

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
                $.post("/UserManager/Add", vm.$data, function (data) {
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
            vm.$set('$data',
            {
                Id:'00000000-0000-0000-0000-000000000000',
                Sex:0
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
    list.del("Id", "/UserManager/Delete", function () {
        list.reload();
        ztree.reload();
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


//用户模块授权按钮
function openUserModuleAccess(obj) {
    var selected = list.getSelectedObj();
    if (selected == null) return;
    layer.open({
        type: 2,
        skin: 'layui-layer-rim', //加上边框
        area: ['410px', '390px'], //宽高
        content: '/ModuleManager/Assign?key=UserModule&firstId=' + selected.Id
    });
}

//用户角色授权
function openUserRoleAccess(obj) {
    var selected = list.getSelectedObj();
    if (selected == null) return;

    layer.open({
        type: 2,
        skin: 'layui-layer-rim', //加上边框
        area: ['600px', '300px'], //宽高
        content: '/RoleManager/LookupMulti?key=UserRole&firstId=' + selected.Id
    });
}

//为用户分配资源
function openUserReourceAccess(obj) {
    var selected = list.getSelectedObj();
    if (selected == null) return;

    layer.open({
        type: 2,
        skin: 'layui-layer-rim', //加上边框
        area: ['600px', '300px'], //宽高
        content: '/ResourceManager/AssignRes?key=UserResource&firstId=' + selected.Id
    });
}

//分配菜单
function openAssignUserElement(obj) {
    var selected = list.getSelectedObj();
    if (selected == null) return;

    layer.open({
        type: 2,
        skin: 'layui-layer-rim', //加上边框
        area: ['600px', '300px'], //宽高
        content: '/ModuleElementManager/AssignModuleElement?key=UserElement&firstId=' + selected.Id
    });
}