layui.config({
    base: "/js/"
}).use(['form', 'ztree', 'layer', 'jquery', 'table', 'droptree', 'openauth', 'iconPicker', 'utils'], function () {
    var form = layui.form,
        layer = layui.layer,
        $ = layui.jquery;
    var iconPicker = layui.iconPicker;
    var btnIconPicker = layui.iconPicker;
    var moduleInitVal = {  //模块初始化的值
        Id: "",
        SortNo: 1,
        IconName: 'layui-icon-app',
        ParentId: '',
        ParentName: '',
        Name: '',
        Url: '',
        Status: 0,
        Remark: '',
        Code: ''
    };
    var menuInital={ //菜单初始化的值
        Id: "",
        ModuleId: "",
        Name:'',
        DomeId:'',
        Class:'',
        Sort: 1,
        Icon: 'layui-icon-app'
    }

    iconPicker.render({
        // 选择器，推荐使用input
        elem: '#IconName',
        type: 'fontClass',
        // 每个图标格子的宽度：'43px'或'20%'
        cellWidth: '43px',
    });
    btnIconPicker.render({   //按钮的图标
        // 选择器，推荐使用input
        elem: '#Icon',
        type: 'fontClass',
        // 每个图标格子的宽度：'43px'或'20%'
        cellWidth: '43px',
    });

    var table = layui.table;
    var openauth = layui.openauth;

    $("#menus").loadMenus("Module");

    //主列表加载，可反复调用进行刷新
    var config = {};  //table的参数，如搜索key，点击tree的id
    var mainList = function (options) {
        if (options != undefined) {
            $.extend(config, options);
        }
        table.reload('mainList', {
            url: '/UserSession/GetModulesTable',
            where: config
            , response: {
                statusCode: 200 //规定成功的状态码，默认：0
            }
        });
    }

    //菜单列表
    var menucon = {};  //table的参数，如搜索key，点击tree的id
    var menuList = function (options) {
        if (options != undefined) {
            $.extend(menucon, options);
        }
        table.reload('menuList', {
            url: '/ModuleManager/LoadMenus',
            where: menucon
            , response: {
                statusCode: 200 //规定成功的状态码，默认：0
            }
        });
    }

    //左边树状机构列表
    var ztree = function () {
        var url = '/UserSession/GetModules';
        var zTreeObj;
        var setting = {
            view: {selectedMulti: false},
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
                    mainList({pId: treeNode.Id});
                }
            }
        };
        var load = function () {
            $.getJSON(url, function (json) {
                zTreeObj = $.fn.zTree.init($("#tree"), setting);
                var newNode = {Name: "根节点", Id: null, ParentId: ""};
                json.Result.push(newNode);
                zTreeObj.addNodes(null, json.Result);
                mainList({pId: ""});
                zTreeObj.expandAll(true);
            });
        };
        load();
        return {
            reload: load
        }
    }();
    $("#tree").height($("div.layui-table-view").height());
    //添加（编辑）模块对话框
    var editDlg = function () {
        var show = function (update, data) {
            var title = update ? "编辑信息" : "添加";
            layer.open({
                title: title,
                area: ["500px", "480px"],
                type: 1,
                content: $('#divEdit'),
                success: function () {
                    layui.droptree("/UserSession/GetModules", "#ParentName", "#ParentId", false);
                    if (data == undefined) {
                        form.val("formEdit", moduleInitVal);
                    } else {
                        form.val("formEdit", data);
                        iconPicker.checkIcon('iconPicker', data.IconName);
                    }
                },
                end: mainList
            });
            var url = "/moduleManager/Add";
            if (update) {
                url = "/moduleManager/Update";
            }
            //提交数据
            form.on('submit(formSubmit)',
                function (data) {
                    $.post(url,
                        data.field,
                        function (data) {
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
            add: function () { //弹出添加
                show(false);
            },
            update: function (data) { //弹出编辑框
                show(true,data);
            }
        };
    }();

    //添加菜单对话框
    var meditDlg = function () {
        var show = function (update, data) {
            var title = update ? "编辑信息" : "添加";
            layer.open({
                title: title,
                area: ["500px", "450px"],
                type: 1,
                content: $('#divMenuEdit'),
                success: function () {
                    if (data == undefined) {
                        form.val("mfromEdit", menuInital);
                    } else {
                        form.val("mfromEdit", data);
                        btnIconPicker.checkIcon('btnIconPicker', data.Icon);
                    }
                },
                end: menuList
            });
            var url = "/moduleManager/AddMenu";
            if (update) {
                url = "/moduleManager/UpdateMenu";
            }
            //提交数据
            form.on('submit(mformSubmit)',
                function (data) {
                    $.post(url,
                        data.field,
                        function (data) {
                            layer.msg(data.Message);
                        },
                        "json");
                    return false;
                });
        }
        return {
            add: function (moduleId) { //弹出添加
                show(false);
            },
            update: function (data) { //弹出编辑框
                show(true,data);
            }
        };
    }();

    //监听行单击事件
    table.on('row(list)', function (obj) {
        menuList({moduleId: obj.data.Id});
    });

    //监听页面主按钮操作
    var active = {
        btnDel: function () {      //删除模块
            var checkStatus = table.checkStatus('mainList')
                , data = checkStatus.data;
            openauth.del("/moduleManager/Delete",
                data.map(function (e) {
                    return e.Id;
                }),
                function () {
                    mainList();
                    ztree.reload();
                });
        }
        , btnDelMenu: function () {      //删除菜单
            var checkStatus = table.checkStatus('menuList')
                , data = checkStatus.data;
            openauth.del("/moduleManager/DelMenu",
                data.map(function (e) {
                    return e.Id;
                }),
                menuList);
        }
        , btnAdd: function () {  //添加模块
            editDlg.add();
        }
        , btnAddMenu: function () {  //添加菜单
            var checkStatus = table.checkStatus('mainList')
                , data = checkStatus.data;
            if (data.length != 1) {
                layer.msg("请选择一个要添加菜单的模块");
                return;
            }
            meditDlg.add(data[0].Id);
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

        , btnEditMenu: function () {  //编辑菜单
            var checkStatus = table.checkStatus('menuList')
                , data = checkStatus.data;
            if (data.length != 1) {
                layer.msg("请选择编辑的菜单");
                return;
            }
            meditDlg.update(data[0]);
        }

        , search: function () {   //搜索
            mainList({key: $('#key').val()});
        }
        , btnRefresh: function () {
            mainList();
        }
    };

    $('.toolList .layui-btn').on('click', function () {
        var type = $(this).data('type');
        active[type] ? active[type].call(this) : '';
    });

    //监听页面主按钮操作 end
})