//grid列表模块
function MainGrid() {
    var url = '/workflowschemas/Load';
    this.maingrid = $('#maingrid')
        .jqGrid({
            colModel: [
                {
                    name: 'Id',
                    index: 'Id',
                    hidden: true
                },
                {
                    index: 'Code',
                    name: 'Code',
                    label: '模板名称'
                }
              
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
    var selected = list.getSelectedProperties("Code");
    if (selected == null) return;

    $.post('/WorkflowSchemas/Delete',
    { codes: selected },
    function (data) {
        if (data.Status) {
            list.reload();
        }
        else {
            layer.msg(data.Message);
        }
    }, "json");
}

//自定义的编辑按钮
function edit() {
    var selected = list.getSelectedObj();
    if (selected == null) {
        return;
    }

    layer.open({
        type: 2,
        skin: 'layui-layer-rim', //加上边框
        area: ['800px', '600px'], //宽高
        content: '/designer/index?schemeName=' + selected.Code
    });

}

function add() {
    layer.open({
        type: 2,
        skin: 'layui-layer-rim', //加上边框
        area: ['800px', '600px'], //宽高
        content: '/designer/index?schemeName='
    });
}


 
