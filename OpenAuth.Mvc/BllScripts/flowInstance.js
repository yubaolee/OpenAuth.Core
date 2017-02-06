//左边分类导航树
var ztree = function () {
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
            onClick: function (event, treeId, treeNode) {
                list.reload(treeNode.value);
            }
        }
    };
    var zTreeObj = $.fn.zTree.init($("#orgtree"), setting, nodes);
    zTreeObj.expandAll(true);
}();

var selectScheme = function (val) {
    $("#WorkflowName").empty();
    $.getJSON("/workflowschemas/Load",
        function (data) {
            $.each(data.rows,
                function (i, n) {
                    $("#WorkflowName").append("<option value='" + this.Code + "' v-bind:value='" + this.Code + "'>" + this.Code + "</option>");
                });

            if (val != undefined) {
                $("#WorkflowName").val(val);
            }
        });
};


//grid列表模块
function MainGrid() {
    var url = "/FlowInstances/Load?type=";
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
                     name: "ProcessSchemeId",
                     index: "ProcessSchemeId",
                     hidden: true
                 },
                  {
                      name: "ActivityId",
                      index: "ActivityId",
                      hidden: true
                  },
                   {
                       name: "CreateUserId",
                       index: "CreateUserId",
                       hidden: true
                   },

                {
                    index: "Code",
                    name: "Code",
                    label: "流程编号"
                },
                
                {
                    index: "CustomName",
                    name: "CustomName",
                    label: "申请标题"
                },
                {
                    name: "CreateUserName",
                    index: "CreateUserName",
                    label: "申请人"
                },
                {
                    index: "ActivityName",
                    name: "ActivityName",
                    label: "当前节点"
                },
                {
                    index: "CreateDate",
                    name: "CreateDate",
                    label: "创建时间"
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

            loadComplete: function () {
                var table = this;
                setTimeout(function () {
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

    this.reload = function (id) {
        if (id != undefined) selectedId = id;
        this.maingrid.jqGrid("setGridParam", { url: url + selectedId })
            .trigger("reloadGrid", [{ page: 1 }]); //重载JQGrid

    };
};

MainGrid.prototype = new Grid();
var list = new MainGrid();


//删除
function del() {
    list.del("Id",
        "/FlowInstances/Delete",
        function () {
            list.reload();
            ztree.reload();
        });

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
        content: "/FlowManage/FlowInstances/ProcessLookForm?processSchemeId=" + selected.ProcessSchemeId + "&activityId=" + selected.ActivityId,
        maxmin: true, //开启最大化最小化按钮
        end: function () {
            list.reload();
        }
    });
}

//审核
function verificationForm() {
    var selected = list.getSelectedObj();
    if (selected == null) {
        return;
    }

    layer.open({
        type: 2,
        title: selected.Name,
        skin: "layui-layer-rim", //加上边框
        area: ["1200px", "700px"], //宽高
        content: "/FlowManage/FlowInstances/VerificationForm?processSchemeId="
            + selected.ProcessSchemeId + "&activityId="
            + selected.ActivityId + "&processInstanceId="
            + selected.Id + "&createuserid="
            + selected.CreateUserId + "&createusername=" + selected.CreateUserName + "&description="
            + selected.Description,
        maxmin: true, //开启最大化最小化按钮
        end: function () {
            list.reload();
        }
    });
}

function add() {
    layer.msg('请在流程设计列表中发起流程！');
}

function refresh() {
    list.reload();
}


