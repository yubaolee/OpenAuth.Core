//grid列表模块
function MainGrid() {
    var url = '/FlowDesign/Load';
    this.maingrid = $('#maingrid')
        .jqGrid({
            colModel: [
                { label: '主键', name: 'Id', hidden: true },
                { label: '流程编号', name: 'SchemeCode', index: 'SchemeCode', width: 100, align: 'left' },
                { label: '流程名称', name: 'SchemeName', index: 'SchemeName', width: 150, align: 'left' },
               
                { label: '模板版本', name: 'SchemeVersion', index: 'SchemeVersion', width: 180, align: 'left' },
                { label: '状态Id', name: 'EnabledMark', index: 'EnabledMark', hidden: true },
                {
                    label: "状态", name: "EnabledMarklabel", index: "EnabledMarklabel", width: 50, align: "center",
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
               
                { label: "最近编辑用户", name: "ModifyUserName", index: "ModifyUserName", width: 90, align: "left" },
                {label: "最近编辑时间", name: "ModifyDate", index: "ModifyDate", width: 150, align: "left"},

                { label: "备注", name: "Description", index: "Description", width: 200, align: "left" }
              
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

//删除
function del() {
    list.del("Id", "/FlowManage/FlowDesign/RemoveForm", function () {
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
        area: ['1200px', '700px'], //宽高
        maxmin: true, //开启最大化最小化按钮
        content: '/FlowManage/FlowDesign/FlowSchemeBuider?keyValue=' + selected.Id,
        end: function () {
            list.reload();
        }
    });

}

//创建流程模版
function add() {
    layer.open({
        type: 2,
        skin: 'layui-layer-rim', //加上边框
        area: ['1200px', '700px'], //宽高
        maxmin: true, //开启最大化最小化按钮
        content: '/FlowManage/FlowDesign/FlowSchemeBuider',
        end: function() {
            list.reload();
        }
    });
}

//预览
function preview() {
    var selected = list.getSelectedObj();
    if (selected == null) {
        return;
    }

    layer.open({
        type: 2,
        skin: 'layui-layer-rim', //加上边框
        area: ['1200px', '700px'], //宽高
        maxmin: true, //开启最大化最小化按钮
        content: '/FlowManage/FlowDesign/PreviewIndex?keyValue=' + selected.Id + "&schemeVersion=" + selected.SchemeVersion,
        end: function () {
            list.reload();
        }
    });
}


//创建新实例
function addInstance() {
    var selected = list.getSelectedObj();
    if (selected == null) {
        return;
    }

    layer.open({
        type: 2,
        skin: 'layui-layer-rim', //加上边框
        area: ['1200px', '700px'], //宽高
        maxmin: true, //开启最大化最小化按钮
        content: '/FlowManage/FlowInstances/FlowProcessNewForm?keyValue=' + selected.Id,
    });
}


 
