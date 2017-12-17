layui.config({
    base: "/js/"
}).use(['form','vue', 'ztree', 'layer', 'jquery', 'table','droptree','openauth','queryString'], function () {
    var //layer = (parent == undefined || parent.layer === undefined )? layui.layer : parent.layer,
        layer = layui.layer,
        $ = layui.jquery;
    var table = layui.table;
    var openauth = layui.openauth;
    var id = $.getUrlParam("id");      //待分配的id
    var type = $.getUrlParam("type");  //待分配的类型
    var menuType = $.getUrlParam("menuType");  //待分配菜单的类型
  
    //菜单列表
    var menucon = {};  //table的参数，如搜索key，点击tree的id
    //菜单树状列表，等lay table没问题了，可以换成table
    var menutree = function () {
        var url = '/ModuleManager/LoadMenus';
        var menuTree;
        var setting = {
            view: { selectedMulti: true },
            check: {
                enable: true,
                chkStyle: "checkbox",
                chkboxType: { "Y": "", "N": "" } //去掉勾选时级联
            },
            data: {
                key: {
                    name: 'Name',
                    title: 'Name'
                },
                simpleData: {
                    enable: true,
                    idKey: 'Id',
                    pIdKey: 'ParentId',
                    rootPId: 'null'
                }
            },
            callback: {
                onClick: function (event, treeId, treeNode) {
                   //
                },
                onCheck: function (event, treeId, treeNode) {
                    var url = "/RelevanceManager/Assign";
                    if (!treeNode.checked) {
                        url = "/RelevanceManager/UnAssign";
                    }

                    $.post(url, { type: menuType, firstId: id, secIds: [treeNode.Id] }
                        , function (data) {
                            layer.msg(data.Message);
                        }
                       , "json");
                }
            }
        };
        var load = function (options) {
            if (options != undefined) {
                $.extend(menucon, options);
            }

            $.getJSON(url, menucon, function (json) {
                menuTree = $.fn.zTree.init($("#menutree"), setting);
                menuTree.addNodes(null, json.data);
                //如果该用户已经分配菜单了，则设置相应的状态
                var url = "/ModuleManager/LoadMenusForUser";
                if (type.indexOf("Role") != -1) {
                    url = "/ModuleManager/LoadMenusForRole";
                }
                $.getJSON(url,
                    {
                        firstId: id
                        , moduleId: options.moduleId
                    }
                    , function (data) {
                        $.each(data,
                            function (i) {
                                var that = this;
                                var node = menuTree.getNodeByParam("Id", that.Id, null);
                                menuTree.checkNode(node, true, false);
                            });
                    });
                menuTree.expandAll(true);
            });
        };
        return {
            load: load
        }
    }();

    //模块列表
    var ztree = function () {
        var url = '/UserSession/QueryModuleList';
        var zTreeObj;
        var setting = {
            view: { selectedMulti: true },
            check: {
                enable: true,
                chkStyle: "checkbox",
                chkboxType: { "Y": "", "N": "" } //去掉勾选时级联
            },
            data: {
                key: {
                    name: 'Name',
                    title: 'Name'
                },
                simpleData: {
                    enable: true,
                    idKey: 'Id',
                    pIdKey: 'ParentId',
                    rootPId: 'null'
                }
            },
            callback: {
                onClick: function (event, treeId, treeNode) {
                    menutree.load({ moduleId: treeNode.Id });
                },
                onCheck: function (event, treeId, treeNode) {
                    var url = "/RelevanceManager/Assign";
                    if (!treeNode.checked) {
                        url = "/RelevanceManager/UnAssign";
                    }

                    $.post(url, { type: type, firstId: id, secIds: [treeNode.Id] }
                        , function (data) {
                            layer.msg(data.Message);
                        }
                       , "json");
                }
            }
        };
        var load = function () {
            $.getJSON(url, function (json) {
                zTreeObj = $.fn.zTree.init($("#tree"), setting);
                zTreeObj.addNodes(null, json);
                //如果该用户已经分配模块了，则设置相应的状态
                var url = "/ModuleManager/LoadForUser";
                if (type.indexOf("Role") != -1) {
                    url = "/ModuleManager/LoadForRole";
                }
                $.getJSON(url, { firstId: id }
                    , function (data) {
                        $.each(data,
                            function(i) {
                                var that = this;
                                var node = zTreeObj.getNodeByParam("Id", that.Id, null);
                                zTreeObj.checkNode(node, true, false);
                            });
                    });

                menutree.load({ moduleId: json[0].Id });
                zTreeObj.expandAll(true);
            });
        };
        load();
        return {
            reload: load
        }
    }();
    //监听页面主按钮操作 end
})