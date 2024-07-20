layui.config({
    base: "/js/"
}).use(['form', 'ztree', 'layer', 'jquery', 'table', 'droptree', 'openauth', 'utils'], function () {
    var form = layui.form,
        layer = layui.layer,
        $ = layui.jquery;
    var table = layui.table;
    var openauth = layui.openauth;
    var toplayer = (top == undefined || top.layer === undefined) ? layer : top.layer;  //顶层的LAYER

    $("#menus").loadMenus("OpenJob");
    
    var initVal = {  //初始化的值
        Id: '',
        JobName: '',
        JobCall: '',
        JobCallParams: '',
        Cron: '',
        Remark: ''
    }
    
    //主列表加载，可反复调用进行刷新
    var config = {};  //table的参数，如搜索key，点击tree的id
    var mainList = function(options) {
        if (options != undefined) {
            $.extend(config, options);
        }
        table.reload('mainList',
            {
                url: '/OpenJobs/Load',
                where: config
                , response: {
                    statusCode: 200 //规定成功的状态码，默认：0
                } 
            });
    };
    mainList();
 
    //添加（编辑）对话框
    var editDlg = function () {
        var show = function (update, data) {
            var title = update ? "编辑信息" : "添加";
            layer.open({
                title: title,
                area: ["500px", "400px"],
                type: 1,
                content: $('#divEdit'),
                success: function () {
                    if (data == undefined) {
                        form.val("formEdit", initVal);
                    } else {
                        form.val("formEdit", data);
                    }
                },
                end: mainList
            });
            var url = "/OpenJobs/Add";
            if (update) {
                url = "/OpenJobs/Update";
            }
            //提交数据
            form.on('submit(formSubmit)',
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
        if (obj.event === 'changStatus') {      //启动暂停任务
            var currentStatus = 1 - data.Status;
            layer.confirm('确定执行该操作？', function(index){
                $.post("/OpenJobs/ChangeStatus",
                    {
                        id: data.Id,
                        status:currentStatus
                    },
                    function (data) {
                        obj.update({
                            Status: currentStatus
                        });
                        layer.msg(data.Message);
                    },
                    "json");
                layer.close(index);
            });
        }
    });


    //监听页面主按钮操作
    var active = {
        btnDel: function () {      //批量删除
            var checkStatus = table.checkStatus('mainList')
                , data = checkStatus.data;
            openauth.del("/OpenJobs/Delete",
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
