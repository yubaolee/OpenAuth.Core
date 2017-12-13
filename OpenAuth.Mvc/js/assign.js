layui.config({
    base: "/js/"
}).use(['form','vue', 'ztree', 'layer', 'jquery', 'table','droptree','openauth'], function () {
    var form = layui.form,
		//layer = (parent == undefined || parent.layer === undefined )? layui.layer : parent.layer,
        layer = layui.layer,
        $ = layui.jquery;
    var table = layui.table;
    var openauth = layui.openauth;
  
    //菜单列表
    var menucon = {};  //table的参数，如搜索key，点击tree的id
    var menuList = function (options) {
        if (options != undefined) {
            $.extend(menucon, options);
        }
        table.reload('menuList', {
            url: '/ModuleManager/LoadMenus',
            where: menucon
        });
    }

    //左边树状机构列表
    var ztree = function () {
        var url = '/UserSession/QueryModuleList';
        var zTreeObj;
        var setting = {
            view: { selectedMulti: false },
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
                    menuList({ moduleId: treeNode.Id });
                }
            }
        };
        var load = function () {
            $.getJSON(url, function (json) {
                zTreeObj = $.fn.zTree.init($("#tree"), setting);
                zTreeObj.addNodes(null, json);
                menuList({ moduleId: json[0].Id });
                zTreeObj.expandAll(true);
            });
        };
        load();
        return {
            reload: load
        }
    }();

    //监听菜单表格内部按钮
    table.on('tool(menulist)', function (obj) {
        var data = obj.data;
        if (obj.event === 'del') {      //删除菜单
            openauth.del("/moduleManager/delMenu",
                data.Id,menuList);
        }
    });

    //监听页面主按钮操作 end
})