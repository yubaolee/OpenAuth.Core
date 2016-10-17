// ***********************************************************************
// Assembly         : OpenAuth.Mvc
// Author           : yubaolee
// Created          : 10-16-2016
//
// Last Modified By : yubaolee
// Last Modified On : 10-16-2016
// ***********************************************************************
// <copyright file="parentTree.js" company="www.cnblogs.com/yubaolee">
//     版权所有(C) 2015
// </copyright>
// <summary>单击文本框弹出的选择列表,可以多选</summary>
// ***********************************************************************

function ParentTreeMultiple(url, name, id) {
    var zTreeObj;
    var options = {
        text: 'Name',
        key: 'Id',
        parentKey: 'ParentId',
        nameDOM: name,   //显示的文本框ID，如："#catetoryName"
        idDOM: id   //隐藏的文本框，如："#categoryId"
    }
    var setting = {
        view: { selectedMulti: true },
        check: {
            enable: true,
            chkStyle: "checkbox",
            chkboxType: { "Y": "", "N": "" } //去掉勾选时级联
        },
        data: {
            key: {
                name: options.text,
                title: options.text
            },
            simpleData: {
                enable: true,
                idKey: options.key,
                pIdKey: options.parentKey,
                rootPId: 'null'
            }
        },
        callback: {
            onClick: onClick,
            onCheck: onCheck
        }
    };
    var showMenu = function () {
        $("#menuContent").css({ left: "10px", top: $("#" + options.nameDOM).outerHeight() + "px" }).slideDown("fast");
        $("body").bind("mousedown", onBodyDown);
    };

    var setCheck = function () {   //设置初始选中的值
        zTreeObj.checkAllNodes(false);

        var value = vm.$get(options.idDOM);
        if (value == undefined) return;
        var nodeids = value.split(",");
        $.each(nodeids,
            function() {
                var node = zTreeObj.getNodeByParam("Id", this, null);
                if (node != null) {
                    zTreeObj.checkNode(node, true, false);
                }
            });
       
    }
    function onClick(e, treeId, treeNode) {
        var nodes = zTreeObj.getSelectedNodes();

        for (var i = 0, l = nodes.length; i < l; i++) {
            vm.$set(options.nameDOM, nodes[i].Name);
            vm.$set(options.idDOM, nodes[i].Id);
            break;
        }
        hideMenu();
    }
    function onCheck(e, treeId, treeNode) {
        var nodes = zTreeObj.getCheckedNodes(true);

        var ids = nodes.map(function (e) { return e.Id; }).join(",");
        var names = nodes.map(function (e) { return e.Name; }).join(",");

        vm.$set(options.nameDOM, names);
        vm.$set(options.idDOM, ids);
    }

    function onBodyDown(event) {
        if (!(event.target.id == "menuContent" || $(event.target).parents("#menuContent").length > 0)) {
            hideMenu();
        }
    }
    function hideMenu() {
        $("#menuContent").fadeOut("fast");
        $("body").unbind("mousedown", onBodyDown);
    }
    return {
        reload: function () {
            var index = layer.load();
            $.getJSON(url,
                {
                    page: 1, rows: 10000
                },
            function (json) {
                layer.close(index);
                if (json.length == 0) {
                    vm.$set(options.nameDOM, '');
                    vm.$set(options.idDOM, '');
                    return;
                }
                zTreeObj = $.fn.zTree.init($("#org"), setting, json);
                setCheck();
                zTreeObj.expandAll(true);
                showMenu();
            });
        }
    }
}