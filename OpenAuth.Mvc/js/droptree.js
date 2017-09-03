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

        //构造器
     var  Class = function (options) {
            var that = this;
            that.config = $.extend({}, that.config, options);
     };
    //默认配置
    Class.prototype.config = {
        text: 'Name',
        key: 'Id',
        parentKey: 'ParentId'
    };


    //显示下拉菜单
    Class.prototype.showMenu =function () {
        $("#menuContent").css({ left: "10px", top: $(this.config.nameDOM).outerHeight() + "px" }).slideDown("fast");
        $("body").bind("mousedown", onBodyDown);
    };

    //隐藏下拉菜单
    Class.prototype.hideMenu =function () {
        $("#menuContent").fadeOut("fast");
        $("body").unbind("mousedown", onBodyDown);
    }

    //加载数据
    Class.prototype.render = function () {
        var that = this;
        var setting = {
            view: { selectedMulti: true },
            check: {
                enable: true,
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
                onClick: that.onClick,
                onCheck: that.onCheck
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
                    $(this.config.nameDOM).val('');
                    $(this.config.idDOM).val('');
                    return;
                }
                zTreeObj = $.fn.zTree.init($("#org"), setting, json);
                that.setCheck();
                zTreeObj.expandAll(true);
                that.showMenu();
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

    Class.prototype.onClick =function(e, treeId, treeNode) {
        var nodes = zTreeObj.getSelectedNodes();

        for (var i = 0, l = nodes.length; i < l; i++) {
            $(inst.config.nameDOM).val(nodes[i].Name);
            $(inst.config.idDOM).val(nodes[i].Id);
            break;
        }
        inst.hideMenu();
    }
    Class.prototype.onCheck= function(e, treeId, treeNode) {
        var nodes = zTreeObj.getCheckedNodes(true);

        var ids = nodes.map(function (e) { return e.Id; }).join(",");
        var names = nodes.map(function (e) { return e.Name; }).join(",");
        $(inst.config.nameDOM).val(names);
        $(inst.config.idDOM).val(ids);
    }

    function onBodyDown(event) {
        if (!(event.target.id == "menuContent" || $(event.target).parents("#menuContent").length > 0)) {
            inst.hideMenu();
        }
    }

    exports('droptree', function (url, name, id) {
      var   options = {
            nameDOM: name,   //显示的文本框ID，如："#catetoryName"
            idDOM: id,   //隐藏的文本框，如："#categoryId"
            url: url
        }
        inst = new Class(options);
        return inst;
    });
});