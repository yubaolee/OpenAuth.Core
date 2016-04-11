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
    $.CurrentDialog.find('#btnAddElement').on('click', function () {
        editDlg.add();
    });

    $.CurrentDialog.find('#btnEditElement').on('click', function () {
        var selected = thisDlg.getSelectedObj();
        if (selected == null) {
            return;
        }
        editDlg.update(selected);
    });

    $.CurrentDialog.find('#btnDelElement').on('click', function () {
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
           if (data.statusCode == "200") {
               thisDlg.reload();
           }
       });
    });
});

//本对话框
var thisDlg = function () {
    var maingrid = $.CurrentDialog.find('#maingrid').datagrid({
        showToolbar: false,
        filterThead: false,
        target: $(this),
        columns: [
            {
                name: 'Id',
                label: '功能模块流水号',
                hide: true
            },
            {
                name: 'DomId',
                label: 'DOM标识',
            },
            {
                name: 'Name',
                label: '功能模块名称',
            },
            {
                name: 'Icon',
                label: '图标',
            },
            {
                name: 'SortNo',
                label: '排序号'
            }
        ],
        dataUrl: '/ModuleElementManager/Get?moduleId=' + moduleId,
        fullGrid: true,
        showLinenumber: true,
        showCheckboxcol: true,
        paging: false,
        filterMult: false,
        showTfoot: false,
        height: 'auto'
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

var editDlg = function () {
    var update = false;
    //在B-JUI中，不能在这里获取DOM，否则下面赋值会不成功
    //只能直接 $("#Id").val(ret.Id);
    // Id = $("#Id");     
    var show = function () {
        BJUI.dialog({ id: 'editDlg', title: '菜单编辑', target: '#editDlg' });
    }
    return {
        add: function () {
            show();
            $("#editElementForm")[0].reset();  //reset方法只能通过dom调用
            $("#Id").val(0);
            $("#Sort").val('0');
            $("#ModuleId").val(moduleId);
        },
        update: function (ret) {
            update = true;
            show();
            $("#Id").val(ret.Id);
            $("#DomId").val(ret.DomId);
            $("#Name").val(ret.Name);
            $("#Type").val(ret.Type);
            $("#ModuleId").val(ret.ModuleId);
            $("#Attr").val(ret.Attr);
            $("#Script").val(ret.Script);
            $("#Icon").val(ret.Icon);
            $("#Class").val(ret.Class);
            $("#Remark").val(ret.Remark);
            $("#Sort").val(ret.Sort);
        }
    };
}();

//@ sourceURL= moduleElementMan.js