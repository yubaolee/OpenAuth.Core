//左边分类导航树
var ztree = function () {
    var nodes = [
     {
         name: "流程处理", children: [
             { name: "我的申请",value:'me' },
            { name: "待办事项",value:'inbox' },
            { name: "已办事项",value:'outbox' }
         ],
         value:'me'
     }
    ];
    var setting = {
        view: { selectedMulti: false },
        callback: {
            onClick: function (event, treeId, treeNode) {
                list.reload(treeNode.value);
            }
        }
    };
    var zTreeObj = $.fn.zTree.init($("#tree"), setting, nodes);
    zTreeObj.expandAll(true);
}();
//grid列表模块
function MainGrid() {
    var url = '/CommonApplies/Load?type=';
    var selectedNode = 'me';  
    this.maingrid = $('#maingrid').datagrid({
        showToolbar: false,
        loadType:'GET',
        filterThead: false,
        target: $(this),
        columns: [
               {
                   name: 'Id',
                   hide: true
               },
               {
                   name: 'Name',
                   label: '申请名称',
                   width: 100
               },
               {
                   name: 'Comment',
                   label: '申请描述',
                   width: 100
               },
               
               {
                   name: 'StateName',
                   label: '流程状态',
                   width: 100
               },
               {
                   name: 'State',
                   hide:true
               }
        ],
        dataUrl: url + selectedNode,
        fullGrid: true,
        showLinenumber: true,
        showCheckboxcol: true,
        paging: true,
        filterMult: false,
        showTfoot: false
    });
    this.reload = function (selected) {
        if (selected != undefined) selectedNode = selected;
        this.maingrid.datagrid('reload', { dataUrl: url + selectedNode });
    };
};
MainGrid.prototype = new Grid();
var list = new MainGrid();

var selectScheme = function(val) {
    $("#WorkflowName").empty();
    $.getJSON('/workflowschemas/Load',
        function (data) {
            $.each(data.list, function (i, n) {
                $("#WorkflowName").append("<option value='" + this.Code + "'>" + this.Code + "</option>");
            });

            if (val != undefined) {
                $('#WorkflowName').val(val);
            }
        });
}


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
            selectScheme();
            $.CurrentDialog.find("form")[0].reset();  //reset方法只能通过dom调用
            $("#Id").val('00000000-0000-0000-0000-000000000000');
        },
        update: function (ret) {  //弹出编辑框
            show();
            $('#Id').val(ret.Id);
            $('#Name').val(ret.Name);
            $('#Comment').val(ret.Comment);
            selectScheme(ret.WorkflowName);
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

    $.post('/CommonApplies/Delete?Id=' + selected.Id, function (data) {
        if (data.statusCode == "200") {
            list.reload();
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

//进度详情
function detail() {
    var selected = list.getSelectedObj();
    if (selected == null) {
        return;
    }
    BJUI.dialog({ 
        id: 'detailDlg',
        url: '/CommonApplies/Detail?id=' + selected.Id,
        title: '进度详情',
        width: 900,
        height: 600,
        mask:true
    });
    $(document).on('bjui.beforeCloseDialog',function(e) {
                    list.reload();
   });
}

function add() {
    editDlg.add();
}

function refresh() {
    list.reload();
}

//@@ sourceURL=goodsApply.js