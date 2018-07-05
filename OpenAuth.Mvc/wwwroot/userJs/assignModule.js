layui.config({
    base: "/js/"
}).use(['form','vue', 'ztree', 'layer', 'jquery','utils','table'], function () {
    var layer = (top == undefined || top.layer === undefined )? layui.layer : top.layer,
        $ = layui.jquery;
    var table = layui.table;
    var id = $.getUrlParam("id");      //待分配的id
    var type = $.getUrlParam("type");  //待分配的类型
    var menuType = $.getUrlParam("menuType");  //待分配菜单的类型
  
    //菜单列表
    var menucon = {};  //table的参数，如搜索key，点击tree的id

    var mainList = function (options) {
        if (options != undefined) {
            $.extend(menucon, options);
        }
        table.reload('mainList', {
            url: '/ModuleManager/LoadMenus',
            where: menucon
            , done: function (res, curr, count) {
                //如果是异步请求数据方式，res即为你接口返回的信息。
                //如果是直接赋值的方式，res即为：{data: [], count: 99} data为当前页数据、count为数据总长度
                var url = "/ModuleManager/LoadMenusForUser";
                if (type.indexOf("Role") != -1) {
                    url = "/ModuleManager/LoadMenusForRole";
                }

                $.ajax(url, {
                    async: false
                    , data: {
                        firstId: id
                        , moduleId: options.moduleId
                    }
                    ,dataType:"json"
                    , success: function (roles) {
                       
                        //循环所有数据，找出对应关系，设置checkbox选中状态
                        for (var i = 0; i < res.data.length; i++) {
                            for (var j = 0; j < roles.length; j++) {
                                if (res.data[i].Id != roles[j].Id) continue;

                                //这里才是真正的有效勾选
                                res.data[i]["LAY_CHECKED"] = true;
                                //找到对应数据改变勾选样式，呈现出选中效果
                                var index = res.data[i]['LAY_TABLE_INDEX'];
                                $('.layui-table-fixed-l tr[data-index=' + index + '] input[type="checkbox"]').prop('checked', true);
                                $('.layui-table-fixed-l tr[data-index=' + index + '] input[type="checkbox"]').next().addClass('layui-form-checked');
                            }

                        }

                        //如果构成全选
                        var checkStatus = table.checkStatus('mainList');
                        if (checkStatus.isAll) {
                            $('.layui-table-header th[data-field="0"] input[type="checkbox"]').prop('checked', true);
                            $('.layui-table-header th[data-field="0"] input[type="checkbox"]').next().addClass('layui-form-checked');
                        }
                    }
                });




            }
        });
    }

    //模块列表
    var ztree = function () {
        var url = '/UserSession/GetModules';
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
                    mainList({ moduleId: treeNode.Id });
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
             
                zTreeObj.expandAll(true);
            });
        };
        load();
        return {
            reload: load
        }
    }();
    

    $("#tree").height($("div.layui-table-view").height());


    //分配及取消分配
    table.on('checkbox(list)', function (obj) {
        console.log(obj.checked); //当前是否选中状态
        console.log(obj.data); //选中行的相关数据
        console.log(obj.type); //如果触发的是全选，则为：all，如果触发的是单选，则为：one

        var url = "/RelevanceManager/Assign";
        if (!obj.checked) {
            url = "/RelevanceManager/UnAssign";
        }
        $.post(url, { type: menuType, firstId: id, secIds: [obj.data.Id] }
                       , function (data) {
                           layer.msg(data.Message);
                       }
                      , "json");
    });
    //监听页面主按钮操作 end
})