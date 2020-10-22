layui.config({
    base: "/js/"
}).use(['form', 'vue', 'ztree', 'layer', 'jquery', 'table', 'droptree', 'openauth', 'utils'], function () {
    var form = layui.form, element = layui.element,
        layer = (top == undefined || top.layer === undefined) ? layui.layer : top.layer,
        $ = layui.jquery;
    var table = layui.table;
    var openauth = layui.openauth;
    var thiswin = (top == undefined) ? window : top.window;

    layui.droptree("/UserSession/GetOrgs", "#Organizations", "#OrganizationIds");

    $("#menus").loadMenus("FlowScheme");

    //主列表加载，可反复调用进行刷新
    var config = {};  //table的参数，如搜索key，点击tree的id
    var mainList = function (options) {
        if (options != undefined) {
            $.extend(config, options);
        }
        table.reload('mainList', {
            url: '/FlowSchemes/Load',
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
    var editDlg = function () {

        var update = false;  //是否为更新
        var show = function (data) {
            var title = update ? "编辑信息" : "添加";

            layer.open({
                type: 2,
                area: ['800px', '700px'], //宽高
                maxmin: true, //开启最大化最小化按钮
                title: title,
                content: '/flowschemes/design?id=' + data.Id,
                btn: ['保存', '关闭'],
                yes: function (index, layero) {
                    var iframeWin = thiswin[layero.find('iframe')[0]['name']]; //得到iframe页的窗口对象，执行iframe页的方法：iframeWin.method();
                    iframeWin.submit();
                },
                btn2: function (index) {
                    layer.close(index);
                    mainList();
                },
                cancel: function (index) {
                    layer.close(index);
                    mainList();
                }
            });
        }
        return {
            add: function () { //弹出添加
                update = false;
                show({
                    Id: ''
                });
            },
            update: function (data) { //弹出编辑框
                update = true;
                show(data);
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
            openauth.del("/FlowSchemes/Delete",
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

        , btnPreview: function () {  //预览
            var checkStatus = table.checkStatus('mainList')
                , data = checkStatus.data;
            if (data.length != 1) {
                layer.msg("请选择要处理的流程，且同时只能选择一条");
                return;
            }

            layer.open({
                type: 2,
                area: ['800px', '600px'], //宽高
                maxmin: true, //开启最大化最小化按钮
                title: '进度详情',
                content: ['/flowSchemes/preview?id=' + data[0].Id, 'no'],
                btn: ['关闭']
            });
        }

        , search: function () {   //搜索
            mainList({ key: $('#key').val() });
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