// ***********************************************************************
// Assembly         : OpenAuth.Mvc
// Author           : yubaolee
// Created          : 04-07-2016
//
// Last Modified By : yubaolee
// Last Modified On : 04-07-2016
// ***********************************************************************
// <copyright file="moduleElementMan.js" company="www.cnblogs.com/yubaolee">
//     模块按钮管理
// </copyright>
// <summary></summary>
// ***********************************************************************

var moduleId = $("#selectedModuleId").val();  //外部传递的moduleId

$(function () {
    $('#btnAddElement').on('click', function () {  //添加菜单
        add();
    });

    $('#btnEditElement').on('click', function () {  //编辑菜单
        edit();
    });

    $('#btnDelElement').on('click', function () {  //删除菜单
        del();
    });
});

//grid列表模块
function MainGrid() {
    var url = '/ModuleElementManager/Get?moduleId=';
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
                    label: '名称'
                },
                 {
                     index: 'DomId',
                     name: 'DomId',
                     label: 'DOM ID'
                 },
                 {
                     index: 'Icon',
                     name: 'Icon',
                     label:'图标'
                 },

                {
                    index: 'Remark',
                    name: 'Remark',
                    label: '描述'

                },
            {
                index: 'Class',
                name: 'Class',
                label: '样式'
            },
             {
                 index: 'Script',
                 name: 'Script',
                 label: '脚本'
             },
              {
                  index: 'Sort',
                  name: 'Sort',
                  label: '排序'
              },
               {
                   index: 'ModuleId',
                   name: 'ModuleId',
                  hidden:true
               }
            ],
            url: url + moduleId,
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

    this.reload = function () {
        this.maingrid.jqGrid("setGridParam", { url: url + moduleId })
            .trigger("reloadGrid", [{ page: 1 }]);  //重载JQGrid

    };
};
MainGrid.prototype = new Grid();
var list = new MainGrid();
var vm = new Vue({
    el: '#editDlg'
});

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
                $.post("/ModuleElementManager/AddOrEditButton", vm.$data, function (data) {
                    layer.msg(data.Message);
                    if (data.Status) {
                        list.reload();
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
                Sort: 1,
                ModuleId:moduleId
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
    list.del("Id", "/ModuleElementManager/Del", function () {
        list.reload();
     });

    var selected = list.getSelectedProperties("Id");
    if (selected == null) return;
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
