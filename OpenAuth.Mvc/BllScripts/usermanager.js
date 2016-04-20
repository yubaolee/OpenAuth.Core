
//grid列表模块
function MainGrid() {
    var url = '/UserManager/Load?orgId=';
    var selectedId = 0; //ztree选中的模块
    this.maingrid = $('#maingrid').datagrid({
        showToolbar: false,
        filterThead: false,
        target: $(this),
        columns: [
               {
                   name: 'Id',
                   label: 'Id',
                   width: 100
                    , hide: true
               },
               {
                   name: 'Account',
                   label: '账号',
                   width: 100
               },
               {
                   name: 'Name',
                   label: '名称',
                   width: 100
               },
               {
                   name: 'Sex',
                   label: '性别',
                   width: 100
                     , align: 'center',
                   items: [{ '0': '男' }, { '1': '女' }],
               },
               {
                   name: 'Status',
                   label: '状态',
                   width: 100
                     , align: 'center',
                   items: [{ '0': '默认' }, { '1': '状态1' }],
               },
               {
                   name: 'Type',
                   label: '用户类型',
                   width: 100
                     , align: 'center',
                   items: [{ '0': '默认' }, { '1': '类型' }],
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
    var nameDom = "#Organizations";
    var idDom = "#OrganizationIds";
    var zTreeObj;
    var setting = {
        view: {
            selectedMulti: false
        },
        check: {
            enable: true,
            chkStyle: "checkbox",
            chkboxType: { "Y": "", "N": "" } //去掉勾选时级联
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
            $("#Id").val(0);
            parentTree.show();

        },
        update: function (ret) {  //弹出编辑框
            update = true;
            show();
            $('#Id').val(ret.Id);
            $('#Account').val(ret.Account);
            $('#Password').val(ret.Password);
            $('#Name').val(ret.Name);
            $('#Sex').selectpicker('val', ret.Sex);
            $('#Status').selectpicker('val', ret.Status);
            $('#Type').selectpicker('val', ret.Type);
            $("#OrganizationIds").val(ret.OrganizationIds);
            parentTree.show();
        },
        save: function () {  //编辑-->保存
            $('#editForm').isValid(function (v) {
                if (!v) return;  //验证没通过
                $("#editForm").bjuiajax('ajaxForm', {
                    reload: false,
                    callback: function (json) {
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

    $.getJSON('/UserManager/Delete?Id=' + selected.Id, function (data) {
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


//用户模块授权按钮
function openUserModuleAccess(obj) {
    var selected = list.getSelectedObj();
    if (selected == null) return;

    $(obj).dialog({
        id: 'accessUserOrg',
        url: '/ModuleManager/Assign',
        title: '为用户分配可见部门',
        width: 620,
        height: 500,
        data: {
            firstId: selected.Id,
            key: "UserModule"
        }
    });
}

//用户可见组织授权按钮
function openUserOrgAccess(obj) {
    var selected = list.getSelectedObj();
    if (selected == null) return;

    $(obj).dialog({
        id: 'accessUserOrg',
        url: '/OrgManager/Assign',
        title: '为用户分配可见部门',
        width: 620,
        height: 500,
        data: {
            firstId: selected.Id,
            key: "UserAccessedOrg"
        }
    });
}

//用户角色授权
function openUserRoleAccess(obj) {
    var selected = list.getSelectedObj();
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
    var selected = list.getSelectedObj();
    if (selected == null) return;

    $(obj).dialog({
        id: 'accessUserRole',
        url: '/ResourceManager/AssignRes',
        title: '为用户分配资源',
        width: 600,
        height: 380,
        data: {
            firstId: selected.Id,
            key:"UserResource"
        }
    });
}

//分配菜单
function openAssignUserElement(obj) {
    var selected = list.getSelectedObj();
    if (selected == null) return;

    $(obj).dialog({
        id: 'accessUserElement',
        url: '/ModuleElementManager/AssignModuleElement',
        title: '为用户分配资源',
        width: 600,
        height: 380,
        data: {
            firstId: selected.Id,
            key: "UserElement"
        }
    });
}

//@@ sourceURL=UserManager.js