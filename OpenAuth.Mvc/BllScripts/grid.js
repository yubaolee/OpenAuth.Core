// ***********************************************************************
// Assembly         : OpenAuth.Mvc
// Author           : yubaolee
// Created          : 04-12-2016
//
// Last Modified By : yubaolee
// Last Modified On : 04-12-2016
// ***********************************************************************
// <copyright file="maingrid.js" company="www.cnblogs.com/yubaolee">
//     版权所有(C) 2015
// </copyright>
// <summary>maingrid基类</summary>
// ***********************************************************************

function Grid() {}

Grid.prototype.selectObjs = function() {
    var ids = this.maingrid.jqGrid("getGridParam", "selarrrow");
    if (ids.length == 0) {
        return null;
    }
    var ret = new Array();
    var maingrid = this.maingrid;
    $(ids)
        .each(function() {
            var obj = maingrid.jqGrid("getRowData", this);
            ret.push(obj);
        });
    return ret;
};

//选择多行对象
Grid.prototype.getSelectedMany = function() {
    return this.selectObjs();
};

//选择单行对象
Grid.prototype.getSelectedObj = function() {
    var row = this.maingrid.jqGrid("getGridParam", "selrow");
    if (row) {
        var ret = this.maingrid.jqGrid("getRowData", row);
        return ret;
    } else {
        return null;
    }
};

//返回选择多行的属性JSON，默认选择id属性，如果选择其他属性，可重写
Grid.prototype.getSelectedProperties = function(propName) {
    var selected = this.selectObjs();
    var result = new Array();
    if (selected != null) {
        result = selected.map(function(elem) { return elem[propName]; });
    }
    return result;
};

//删除操作，服务端的接收必须是post且参数为string[] ids
Grid.prototype.del = function(idname, url, callback) {
    var selected = this.getSelectedProperties(idname);
    if (selected == null) return;

    var lid = layer.confirm("确定要删除所选？",
        null,
        function() {
            layer.close(lid);
            $.post(url,
                { ids: selected },
                function(data) {
                    if (data.Status) {
                        callback();
                    } else {
                        layer.msg(data.Message);
                    }
                },
                "json");
        });
};