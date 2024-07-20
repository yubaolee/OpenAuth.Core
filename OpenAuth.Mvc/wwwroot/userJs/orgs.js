    layui.config({
    base: "/js/"
}).use(['form', 'ztree', 'layer', 'jquery', 'table','droptree','openauth','utils'], function () {
    var form = layui.form,
        layer = layui.layer,
        $ = layui.jquery;
    var table = layui.table;
    var openauth = layui.openauth;

    $("#menus").loadMenus("Org");
    
    var initVal = {  //初始化的值
        Id: '',
        Name: '',
        SortNo: '',
        ParentName: '',
        ParentId: ''
    }
   
    //主列表加载，可反复调用进行刷新
    var config= {};  //table的参数，如搜索key，点击tree的id
    var mainList = function (options) {
        if (options != undefined) {
            $.extend(config, options);
        }
        table.reload('mainList', {
            url: '/UserSession/GetSubOrgs',
            where: config
            , response: {
                statusCode: 200 //规定成功的状态码，默认：0
            } 
        });
    }
    //左边树状机构列表
    var ztree = function () {
        var url = '/UserSession/GetOrgs';
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
                    mainList({ orgId: treeNode.Id });
                }
            }
        };
        var load = function () {
            $.getJSON(url, function (json) {
                zTreeObj = $.fn.zTree.init($("#tree"), setting);
                var newNode = { Name: "根节点", Id: null, ParentId: "" };
                json.Result.push(newNode);
                zTreeObj.addNodes(null, json.Result);
                mainList({ orgId: "" });
                zTreeObj.expandAll(true);
            });
        };
        load();
        return {
            reload: load
        }
    }();
    $("#tree").height($("div.layui-table-view").height());

    //添加（编辑）对话框
    var editDlg = function() {
        var show = function (update, data) {
            var title = update ? "编辑信息" : "添加";
            layer.open({
                title: title,
                area: ["500px", "400px"],
                type: 1,
                content: $('#divEdit'),
                success: function() {
                    layui.droptree("/UserSession/GetOrgs", "#ParentName", "#ParentId", false);
                    if (data == undefined) {
                        form.val("formEdit", initVal);
                    } else {
                        form.val("formEdit", data);
                    }
                },
                end: mainList
            });
            var url = "/OrgManager/Add";
            if (update) {
                url = "/OrgManager/Update"; //暂时和添加一个地址
            }
            //提交数据
            form.on('submit(formSubmit)',
                function(data) {
                    $.post(url,
                        data.field,
                        function(data) {
                            layer.msg(data.Message);
                            if ((!update) && data.Code == 200) {  //添加成功要刷新左边的树
                                ztree.reload();
                            }
                        },
                        "json");
                    return false;
                });
        }
        return {
            add: function() { //弹出添加
                show(false);
            },
            update: function(data) { //弹出编辑框
                show(true,data);
            }
        };
    }();
    
    //监听表格内部按钮
    table.on('tool(list)', function (obj) {
        var data = obj.data;
        if (obj.event === 'detail') {      //查看
            layer.msg('ID：' + data.Id + ' 的查看操作');
        } 
    });


    //监听页面主按钮操作
    var active = {
        btnDel: function () {      //批量删除
            var checkStatus = table.checkStatus('mainList')
                , data = checkStatus.data;
            openauth.del("/OrgManager/Delete",
                data.map(function (e) { return e.Id; }),
                function() {
                    mainList();
                    ztree.reload();
                });
        }
        , btnAdd: function () {  //添加
            editDlg.add();
        }
         , btnEdit: function () {  //编辑
             var checkStatus = table.checkStatus('mainList')
               , data = checkStatus.data;
             if (data.length != 1) {
                 layer.msg("请选择编辑的行，且同时只能编辑一行");
                 return;
             }
             editDlg.update(data[0]);
         }

        , search: function () {   //搜索
            mainList({ key: $('#key').val() });
        }
        , btnRefresh: function() {
            mainList();
        }
        , btnAccessModule: function () {
            var index = layer.open({
                title: "为用户分配模块/可见字段",
                type: 2,
                content: "newsAdd.html",
                success: function(layero, index) {
                    
                }
            });
        }
        , btnAssignOrgUser: function () {
            var checkStatus = table.checkStatus('mainList')
                , data = checkStatus.data;
            if (data.length != 1) {
                toplayer.msg("请选择要分配的角色");
                return;
            }
            layer.msg("开发中...   ");
        }
    };

    $('.toolList .layui-btn').on('click', function () {
        var type = $(this).data('type');
        active[type] ? active[type].call(this) : '';
    });

    //监听页面主按钮操作 end
})