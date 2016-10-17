//grid列表模块
function MainGrid() {
    var url = '/workflowschemas/Load';
    this.maingrid = $('#maingrid').datagrid({
        showToolbar: false,
        filterThead: false,
        loadType: 'GET',
        target: $(this),
        columns: [
               {
                   name: 'Code',
                   label: '模板名称'
               }
        ],
        data:[],
        fullGrid: true,
        showLinenumber: true,
        showCheckboxcol: true,
        paging: true,
        filterMult: false,
        showTfoot: false,
      
    });
    this.reload = function (id) {
        this.maingrid.datagrid('reload', { dataUrl: url });
    };
};
MainGrid.prototype = new Grid();
var list = new MainGrid();
list.reload();

//删除
function del() {
    var selected = list.getSelectedObj();
    if (selected == null) return;

    $.post('/StockManager/Delete?Id=' + selected.Id, function (data) {
        if (data.Status) {
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
    window.location = '/designer/index?schemeName=' + selected.Code;
}

function add() {

    window.location = '/designer/index?schemeName=';
}


//删除
function del() {
    var selected = list.getSelectedObj();
    if (selected == null) return;

    $.post('/WorkflowSchemas/Del?code=' +selected.Code, function (data) {
        if (data.Status) {
            list.reload();
        }
        else {
            $(this).alertmsg('warn', data.message);
        }
    }, "json");
}

 
