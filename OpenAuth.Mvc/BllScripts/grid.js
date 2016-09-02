// ***********************************************************************
// Assembly         : OpenAuth.Mvc
// Author           : yubaolee
// Created          : 04-12-2016
//
// Last Modified By : yubaolee
// Last Modified On : 04-12-2016
// ***********************************************************************
// <copyright file="grid.js" company="www.cnblogs.com/yubaolee">
//     版权所有(C) 2015
// </copyright>
// <summary>grid基类</summary>
// ***********************************************************************

function Grid() {
    this.maingrid = undefined;
    this.selectObjs = function () {
        var selectedDatas = this.maingrid.data('selectedDatas');
        if (selectedDatas == undefined || selectedDatas.length == 0) {
            $(this).alertmsg('warn', '至少选择一个对象');
            return null;
        }
        return selectedDatas;
    };
}

//选择单行对象
Grid.prototype.getSelectedObj = function () {
    var selectedDatas = this.selectObjs();
    return selectedDatas == null ? null : selectedDatas[0];
};
//选择多行对象
Grid.prototype.getSelectedMany = function () {
    return this.selectObjs();
};
//返回选择多行的属性JSON，默认选择id属性，如果选择其他属性，可重写
Grid.prototype.getSelectedProperties = function (propName) {
    var selected = this.selectObjs();
    var result = new Array();
    if (selected != null) {
        result = selected.map(function (elem) { return  elem[propName] ; });
    }
    return result;
};