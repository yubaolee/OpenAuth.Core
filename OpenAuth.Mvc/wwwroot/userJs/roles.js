layui.config({
    base: "/js/"
}).use(['form','vue', 'ztree', 'layer', 'jquery', 'table','droptree','openauth','utils'], function () {
    var form = layui.form,
        layer = layui.layer,
        $ = layui.jquery;
    var table = layui.table;
    var openauth = layui.openauth;
    var toplayer = (top == undefined || top.layer === undefined) ? layer : top.layer;  //顶层的LAYER
   
    $("#menus").loadMenus("Role");

    //主列表加载，角色后台没有分页，直接前端分页
    var config= {};  //table的参数，如搜索key，点击tree的id
    var mainList = function(options) {
        if (options != undefined) {
            $.extend(config, options);
        }

        $.getJSON('/RoleManager/Load',
            config,
            function(data) {
                table.render({
                    elem: '#mainList',
                    cols: [[
                        { checkbox: true, fixed: true },
                        { field: 'Name', title: '角色名称' },
                        { field: 'Status', templet: '#Status', title:'角色状态'},
                        { fixed: 'right', toolbar: '#userList', title:'用户列表' }
                    ]],
                    data: data.Result,
                    height: 'full-80',
                    limits: [10, 20, 50], //显示
                    limit: 20 //每页默认显示的数量
                })
            })
    }

    mainList();

    //添加（编辑）对话框
    var editDlg = function() {
        var vm;
        var update = false;  //是否为更新
        var show = function (data) {
            var title = update ? "编辑信息" : "添加";
            layer.open({
                title: title,
                area: ["500px", "400px"],
                type: 1,
                content: $('#divEdit'),
                success: function() {
                     if(vm == undefined){
                        vm = new Vue({
                            el: "#formEdit",
                            data(){
                                return {
                                    tmp:data  //使用一个tmp封装一下，后面可以直接用vm.tmp赋值
                                }
                            },
                            watch:{
                                tmp(val){
                                    this.$nextTick(function () {
                                        form.render();  //刷新select等
                                    })
                                }
                            },
                            mounted(){
                                form.render();

                            }
                        });
                       }else{
                        vm.tmp = Object.assign({}, vm.tmp,data)
                       }
                },
                end: mainList
            });
            var url = "/RoleManager/Add";
            if (update) {
                url = "/RoleManager/Update"; 
            }
            //提交数据
            form.on('submit(formSubmit)',
                function(data) {
                    $.post(url,
                        data.field,
                        function(data) {
                            layer.msg(data.Message);
                        },
                        "json");
                    return false;
                });
        }
        return {
            add: function() { //弹出添加
                update = false;
                show({
                    Id: ''
                });
            },
            update: function(data) { //弹出编辑框
                update = true;
                show(data);
            }
        };
    }();
    
    //监听表格内部按钮
    table.on('tool(list)', function (obj) {
        var data = obj.data;
        if (obj.event === 'userList') {      //查看
            layer.msg('ID：' + data.Id + ' 的查看操作');
        } 
    });


    //监听页面主按钮操作
    var active = {
        btnDel: function () {      //批量删除
            var checkStatus = table.checkStatus('mainList')
                , data = checkStatus.data;
            openauth.del("/RoleManager/Delete",
                data.map(function (e) { return e.Id; }),
                mainList);
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
            var checkStatus = table.checkStatus('mainList')
               , data = checkStatus.data;
            if (data.length != 1) {
                layer.msg("请选择要分配的角色");
                return;
            }

            var index = layer.open({
                title: "为角色【" + data[0].Name + "】分配模块/可见字段",
                type: 2,
                area: ['750px', '600px'],
                content: "/ModuleManager/Assign?type=RoleModule&menuType=RoleElement&id=" + data[0].Id,
                success: function (layero, index) {

                }
            });
        }
        , btnAssignReource: function () {
            var checkStatus = table.checkStatus('mainList')
                , data = checkStatus.data;
            if (data.length != 1) {
                toplayer.msg("请选择要分配的角色");
                return;
            }

            var index = toplayer.open({
                title: "为角色【" + data[0].Name + "】分配资源",
                type: 2,
                area: ['750px', '600px'],
                content: "/Resources/Assign?type=RoleResource&id=" + data[0].Id,
                success: function (layero, index) {

                }
            });
        }
        , btnRoleAccessUser: function () {
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