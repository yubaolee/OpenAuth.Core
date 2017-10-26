// ***********************************************************************
// Assembly         : OpenAuth.Mvc
// Author           : yubaolee
// Created          : 10-16-2016
//
// Last Modified By : yubaolee
// Last Modified On : 10-16-2016
// ***********************************************************************
// <copyright file="droptree.js" company="www.cnblogs.com/yubaolee">
//     版权所有 玉宝(C) 2017
// </copyright>
//单击文本框弹出的选择列表,可以多选。调用： 
//var droptree = layui.droptree("/UserSession/GetOrgs", "#Organizations", "#OrganizationIds");
// droptree.render();
// ***********************************************************************

layui.define(['jquery', 'layer'], function (exports) {
    var $ = layui.jquery;
    var layer = layui.layer;
    var zTreeObj;
    var inst;   //droptree实体

    //显示下拉菜单
    var showMenu = function () {
        $("#menuContent").css({
            left: "10px",
            top: $(inst.config.nameDOM).outerHeight() + "px"
        }).slideDown("fast");
        $("body").bind("mousedown", onBodyDown);
    };

    //隐藏下拉菜单
    var hideMenu = function () {
        $("#menuContent").fadeOut("fast");
        $("body").unbind("mousedown", onBodyDown);
    }

    //滚动条下拉
    function onBodyDown(event) {
        if (!(event.target.id == "menuContent" || $(event.target).parents("#menuContent").length > 0)) {
            hideMenu();
        }
    }

    //点击tree
    var onClick = function (e, treeId, treeNode) {
        var nodes = zTreeObj.getSelectedNodes();

        for (var i = 0, l = nodes.length; i < l; i++) {
            $(inst.config.nameDOM).val(nodes[i].Name);
            $(inst.config.idDOM).val(nodes[i].Id);
            break;
        }
        $(inst.config.idDOM).change();  //如果不调change，VUE不会监听idDom
        hideMenu();
    }

    //tree复选框
    var onCheck = function (e, treeId, treeNode) {
        var nodes = zTreeObj.getCheckedNodes(true);

        var ids = nodes.map(function (e) { return e.Id; }).join(",");
        var names = nodes.map(function (e) { return e.Name; }).join(",");
        $(inst.config.nameDOM).val(names);
        $(inst.config.idDOM).val(ids);
        $(inst.config.idDOM).change();  //如果不调change，VUE不会监听idDom
    }

    //构造器
    var  Class = function (options) {
        var that = this;
        that.config = $.extend({}, that.config, options);

        //上级机构选择框
        $(that.config.nameDOM).on("click", function () {
            that.render();
        });
     };
    //默认配置
    Class.prototype.config = {
        text: 'Name',
        key: 'Id',
        parentKey: 'ParentId',
        selectedMulti: true    //默认是多选
    };

    //加载数据
    Class.prototype.render = function () {
        var that = this;
        var setting = {
            view: { selectedMulti: that.config.selectedMulti },
            check: {
                enable: that.config.selectedMulti,
                chkStyle: "checkbox",
                chkboxType: { "Y": "", "N": "" } //去掉勾选时级联
            },
            data: {
                key: {
                    name: that.config.text,
                    title: that.config.text
                },
                simpleData: {
                    enable: true,
                    idKey: that.config.key,
                    pIdKey: that.config.parentKey,
                    rootPId: 'null'
                }
            },
            callback: {
                onClick: onClick,
                onCheck: onCheck
            }
        };
        var index = layer.load();
        $.getJSON(this.config.url,
            {
                page: 1, rows: 10000
            },
            function (json) {
                layer.close(index);
                if (json.length == 0) {
                    $(that.config.nameDOM).val('');
                    $(that.config.idDOM).val('');
                    return;
                }
                zTreeObj = $.fn.zTree.init($("#org"), setting, json);
                that.setCheck();
                zTreeObj.expandAll(true);
                showMenu();
            });
    }

    //设置初始选中的值
    Class.prototype.setCheck = function () {   
        zTreeObj.checkAllNodes(false);

        var value = $(this.config.idDOM).val();
        if (value == undefined) return;
        var nodeids = value.split(",");
        $.each(nodeids,
            function () {
                var node = zTreeObj.getNodeByParam("Id", this, null);
                if (node != null) {
                    zTreeObj.checkNode(node, true, false);
                }
            });
    }

    exports('droptree', function (url, name, id, selectedMulti) {
      var options = {
            nameDOM: name,   //显示的文本框ID，如："#catetoryName"
            idDOM: id,   //隐藏的文本框，如："#categoryId"
            url: url,
            selectedMulti: selectedMulti  //是否为多选
        }
        inst = new Class(options);
        return inst;
    });
});