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

var moduleId = $.CurrentDialog.find("#selectedModuleId").val();  //外部传递的moduleId

$(document).ready(function () {
    $.CurrentDialog.find('#btnAddElement').on('click', function () {  //添加菜单
        editEleDlg.add();
    });

    $.CurrentDialog.find('#btnEditElement').on('click', function () {  //编辑菜单
        var selected = thisDlg.getSelectedObj();
        if (selected == null) {
            return;
        }
        editEleDlg.update(selected);
    });

    $.CurrentDialog.find('#btnDelElement').on('click', function () {  //删除菜单
        var selected = thisDlg.getSelectedMany(); //可以一次删除多个
        if (selected == null) {
            return;
        }

        $.post("/ModuleElementManager/Del",
        {
            moduleElements: JSON.stringify(selected)
        },
       function (data) {
           data = $.parseJSON(data);
           if (data.statusCode != "200") {
               $(this).alertmsg('warn', json.message);
               return;
           }

           thisDlg.reload();
       });
    });
});

//本对话框
var thisDlg = function () {
    var maingrid = $('#moduleEleList').datagrid({
        showToolbar: false,
        filterThead: false,
        target: $(this),
        columns: [
                {
                    name: 'Id',
                    label: '流水号',
                    hide: true
                },
                {
                    name: 'ModuleId',
                    label: '功能模块Id',
                    hide: true
                },
               {
                   name: 'DomId',
                   label: 'DOM ID',
                   width: 100
               },
               {
                   name: 'Name',
                   label: '名称',
                   width: 100
               },
               {
                   name: 'Type',
                   label: '类型',
                   width: 100
               },

               {
                   name: 'Attr',
                   label: '元素附加属性',
                   width: 100
               },
               {
                   name: 'Script',
                   label: '元素调用脚本',
                   width: 100
               },
               {
                   name: 'Icon',
                   label: '元素图标',
                   width: 100
               },
               {
                   name: 'Class',
                   label: '元素样式',
                   width: 100
               },
               {
                   name: 'Remark',
                   label: '备注',
                   width: 100
               },
               {
                   name: 'Sort',
                   label: '排序字段',
                   width: 100
               }
        ],
        dataUrl: '/ModuleElementManager/Get?moduleId=' + moduleId,
        fullGrid: true,
        showLinenumber: true,
        showCheckboxcol: true,
        paging: false,
        filterMult: false,
        showTfoot: false,

    });

    var getSelectDatas = function () {
        var selectedDatas = maingrid.data('selectedDatas');
        if (selectedDatas == undefined || selectedDatas.length == 0) {
            $(this).alertmsg('warn', '至少选择一个对象');
            return null;
        }
        return selectedDatas;
    }

    return {
        reload: function (id) {
            if (id != undefined) moduleId = id;
            maingrid.datagrid('reload', { dataUrl: '/ModuleElementManager/Get?moduleId=' + moduleId });
        },
        getSelectedObj: function () {  //选择单行
            var results = getSelectDatas();
            if (results != null) return results[0];
            return null;
        },
        getSelectedMany: function () {  //选择多行
            return getSelectDatas();
        },
    };
}();

//添加（编辑）对话框
var editEleDlg = function () {
    var update = false;
    var show = function () {
        BJUI.dialog({ id: 'editEleDlg', title: '菜单编辑', target: '#editEleDlg' });
        $("#btnEleChange").on("click", function () {
            editEleDlg.save();
        });
    }
    return {
        add: function () {  //弹出添加
            update = false;
            show();
            $("#editElementForm")[0].reset();  //reset方法只能通过dom调用
            $.CurrentDialog.find("#Id").val('00000000-0000-0000-0000-000000000000');
            $.CurrentDialog.find("#Sort").val('0');
            $.CurrentDialog.find("#ModuleId").val(moduleId);
        },
        update: function (ret) {  //弹出编辑框
            update = true;
            show();
            $.CurrentDialog.find('#Id').val(ret.Id);
            $.CurrentDialog.find('#DomId').val(ret.DomId);
            $.CurrentDialog.find('#Name').val(ret.Name);
            $.CurrentDialog.find('#Type').selectpicker('val', ret.Type);
            $.CurrentDialog.find('#ModuleId').val(ret.ModuleId);
            $.CurrentDialog.find('#Script').val(ret.Script);
            $.CurrentDialog.find('#Icon').selectpicker('val', ret.Icon);
            $.CurrentDialog.find('#Class').selectpicker('val', ret.Class);
            $.CurrentDialog.find('#Remark').val(ret.Remark);
            $.CurrentDialog.find('#Sort').val(ret.Sort);
        },
        save: function () {  //编辑-->保存
            $('#editElementForm').isValid(function (v) {
                if (!v) return;  //验证没通过
                $("#editElementForm").bjuiajax('ajaxForm', {
                    reload: false,
                    callback: function (json) {
                        if (json.statusCode != "200") {
                            $(this).alertmsg('warn', json.message);
                            return;
                        }
                        thisDlg.reload();
                    }
                });
            });
        }
    };
}();

//@ sourceURL= moduleElementMan.js