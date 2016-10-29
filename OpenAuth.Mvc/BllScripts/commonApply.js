//左边分类导航树
var ztree = function() {
    var nodes = [
        {
            name: "流程处理",
            children: [
                { name: "我的申请", value: "me" },
                { name: "待办事项", value: "inbox" },
                { name: "已办事项", value: "outbox" }
            ],
            value: "me"
        }
    ];
    var setting = {
        view: { selectedMulti: false },
        callback: {
            onClick: function(event, treeId, treeNode) {
                list.reload(treeNode.value);
            }
        }
    };
    var zTreeObj = $.fn.zTree.init($("#orgtree"), setting, nodes);
    zTreeObj.expandAll(true);
}();

var selectScheme = function(val) {
    $("#WorkflowName").empty();
    $.getJSON("/workflowschemas/Load",
        function(data) {
            $.each(data.rows,
                function(i, n) {
                    $("#WorkflowName").append("<option value='" + this.Code + "'>" + this.Code + "</option>");
                });

            if (val != undefined) {
                $("#WorkflowName").val(val);
            }
        });
};


//grid列表模块
function MainGrid() {
    var url = "/CommonApplies/Load?type=";
    var selectedId = "me"; //ztree选中的模块
    this.maingrid = $("#maingrid")
        .jqGrid({
            colModel: [
                {
                    name: "Id",
                    index: "Id",
                    hidden: true
                },
                {
                    index: "Name",
                    name: "Name",
                    label: "申请名称"
                },
                {
                    index: "Comment",
                    name: "Comment",
                    label: "申请描述"
                },
                {
                    index: "StateName",
                    name: "StateName",
                    label: "流程状态"
                },
                {
                    index: "WorkflowName",
                    name: "WorkflowName",
                    label: "流程名称"
                }
            ],
            url: url + selectedId,
            datatype: "json",

            viewrecords: true,
            rowNum: 18,
            pager: "#grid-pager",
            altRows: true,
            height: "auto",
            multiselect: true,
            multiboxonly: true,

            loadComplete: function() {
                var table = this;
                setTimeout(function() {
                        updatePagerIcons(table);
                    },
                    0);
            }
        })
        .jqGrid("navGrid",
            "#grid-pager",
            {
                edit: false,
                add: false,
                del: false,
                refresh: false,
                search: false
            });

    this.reload = function(id) {
        if (id != undefined) selectedId = id;
        this.maingrid.jqGrid("setGridParam", { url: url + selectedId })
            .trigger("reloadGrid", [{ page: 1 }]); //重载JQGrid

    };
};

MainGrid.prototype = new Grid();
var list = new MainGrid();
var vm = new Vue({
    el: "#editDlg"
});

//添加（编辑）对话框
var editDlg = function() {
    var update = false;
    var show = function() {
        layer.open({
            type: 1,
            skin: "layui-layer-rim", //加上边框
            title: "申请管理", //不显示标题
            area: ["400px", "300px"], //宽高
            content: $("#editDlg"), //捕获的元素
            btn: ["保存", "关闭"],
            yes: function(index, layero) {
                $.post("/CommonApplies/Add",
                    vm.$data,
                    function(data) {
                        layer.msg(data.Message);
                        if (data.Status) {
                            list.reload();
                            ztree.reload();
                        }
                    },
                    "json");
            },
            cancel: function(index) {
                layer.close(index);
            }
        });
    };
    return {
        add: function() { //弹出添加
            update = false;
            selectScheme();
            show();
            vm.$set("$data",
            {
                Id: "00000000-0000-0000-0000-000000000000",
            });
        },
        update: function(ret) { //弹出编辑框
            update = true;
            show();
            vm.$set("$data", ret);
            selectScheme(vm.WorkflowName);
        }
    };
}();

//删除
function del() {
    list.del("Id",
        "/CommonApplies/Delete",
        function() {
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

//进度详情
function detail() {
    var selected = list.getSelectedObj();
    if (selected == null) {
        return;
    }

    layer.open({
        type: 2,
        title: selected.Name,
        skin: "layui-layer-rim", //加上边框
        area: ["800px", "600px"], //宽高
        content: "/CommonApplies/Detail?id=" + selected.Id,
        maxmin: true, //开启最大化最小化按钮
        end: function() {
            list.reload();
        }
    });
}

function add() {
    editDlg.add();
}

function refresh() {
    list.reload();
}

 
