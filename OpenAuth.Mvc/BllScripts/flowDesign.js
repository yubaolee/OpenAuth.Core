//grid列表模块
function MainGrid() {
    var url = '/workflowschemas/Load';
    this.maingrid = $('#maingrid')
        .jqGrid({
            colModel: [
                { label: '主键', name: 'id', hidden: true },
                { label: '流程编号', name: 'schemecode', index: 'schemecode', width: 100, align: 'left' },
                { label: '流程名称', name: 'schemename', index: 'schemename', width: 150, align: 'left' },
                {
                    label: "表单类型", name: "frmtype", index: "frmtype", width: 80, align: "left",
                    formatter: function (cellvalue, options, rowObject) {
                        return (cellvalue == 1 ? '系统表单' : '自定义表单')
                    }
                },
                { label: '模板版本', name: 'schemeversion', index: 'schemeversion', width: 180, align: 'left' },
                { label: '状态Id', name: 'enabledmark', index: 'enabledmark', hidden: true },
                {
                    label: "状态", name: "enabledmarklabel", index: "enabledmarklabel", width: 50, align: "center",
                    formatter: function (cellvalue, options, rowObject) {
                        if (rowObject.enabledmark == 1) {
                            return '<span  class=\"label label-success\">启用</span>';
                        } else if (rowObject.enabledmark == 0) {
                            return '<span  class=\"label label-danger\">停用</span>';
                        } else {
                            return '<span  class=\"label label-info\">草稿</span>';
                        }
                    }
                },
               
                { label: "最近编辑用户", name: "modifyusername", index: "modifyusername", width: 90, align: "left" },
                {
                    label: "最近编辑时间", name: "modifydate", index: "modifydate", width: 150, align: "left",
                    formatter: function (cellvalue, options, rowObject) {
                        return formatDate(cellvalue, 'yyyy-MM-dd hh:mm:ss');
                    }
                },
                { label: "创建用户", name: "createusername", index: "createusername", width: 80, align: "left" },
                {
                    label: "创建时间", name: "createdate", index: "createdate", width: 150, align: "left",
                    formatter: function (cellvalue, options, rowObject) {
                        return formatDate(cellvalue, 'yyyy-MM-dd hh:mm:ss');
                    }
                },

                { label: "备注", name: "description", index: "description", width: 200, align: "left" }
              
            ],
            url: url,
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
        this.maingrid.jqGrid("setGridParam", { url: url })
            .trigger("reloadGrid", [{ page: 1 }]);  //重载JQGrid

    };
};
MainGrid.prototype = new Grid();
var list = new MainGrid();
var vm = new Vue({
    el: '#editDlg'
});

//删除
function del() {
    list.del("Code", "/WorkflowSchemas/Del", function () {
        list.reload();
    });
}

//自定义的编辑按钮
function edit() {
    var selected = list.getSelectedObj();
    if (selected == null) {
        return;
    }

    layer.open({
        type: 2,
        title:selected.Code,
        skin: 'layui-layer-rim', //加上边框
        area: ['800px', '600px'], //宽高
        maxmin: true, //开启最大化最小化按钮
        content: '/designer/index?schemeName=' + selected.Code
    });

}

function add() {
    layer.open({
        type: 2,
        skin: 'layui-layer-rim', //加上边框
        area: ['800px', '600px'], //宽高
        maxmin: true, //开启最大化最小化按钮
        content: '/designer/index?schemeName=',
        end: function() {
            list.reload();
        }
    });
}


 
