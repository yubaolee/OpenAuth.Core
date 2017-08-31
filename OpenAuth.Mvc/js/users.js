layui.config({
    base: "/js/"
}).use(['form', 'ztree', 'layer', 'jquery', 'table'], function () {
    var form = layui.form,
		layer = parent.layer === undefined ? layui.layer : parent.layer,
		$ = layui.jquery;
    var dataurl = '/UserManager/Load';
    var table = layui.table;
   
    //左边树状机构列表
    var ztree = function () {
        var url = '/UserSession/GetOrgs';
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
                    table.reload('mainList', {
                        where: {
                            url:dataurl,
                            orgId: treeNode.Id
                        }
                    });
                }
            }
        };
        var load = function () {
            $.getJSON(url, function (json) {
                var zTreeObj = $.fn.zTree.init($("#tree"), setting, json);
                table.reload('mainList', {
                    url: dataurl,
                    where: {
                        orgId: json[0].Id
                    } //设定异步数据接口的额外参数
                    //,height: 300
                });
                zTreeObj.expandAll(true);
            });
        };
        load();

        return {
            reload: load
        }
    }();

    //监听表格复选框选择
    table.on('checkbox(list)', function (obj) {
        console.log(obj);
    });
    //监听表格内部按钮
    table.on('tool(list)', function (obj) {
        var data = obj.data;
        if (obj.event === 'detail') {
            layer.msg('ID：' + data.Id + ' 的查看操作');

        } else if (obj.event === 'del') {  //删除
            layer.confirm('真的删除么', function (index) {
                $.post("/UserManager/Delete", { ids: data.Id },
                    function (data) {
                        if (data.Status) {
                            obj.del();
                        } else {
                            layer.msg(data.Message);
                        }
                    },"json");
                layer.close(index);
            });
        } else if (obj.event === 'edit') {
            layer.alert('编辑行：<br>' + JSON.stringify(data));
        }
    });

    //监听页面主按钮操作
    var active = {
        del: function () { //批量删除
            var checkStatus = table.checkStatus('mainList')
                , data = checkStatus.data;
            layer.alert(JSON.stringify(data));
        }, addData: function () {  //添加
            var index = layui.layer.open({
                title: "添加",
                area: ["500px", "400px"],
                type: "1",
                content: $('#formEdit')
            });
        }, search: function () {  //搜索
            var key = $('#key');

            table.reload('mainList', {
                where: {
                    url: dataurl,
                    key: key.val()
                }
            });
        }
    };

    $('.toolList .layui-btn').on('click', function () {
        var type = $(this).data('type');
        active[type] ? active[type].call(this) : '';
    });

    //监听页面主按钮操作 end

    //编辑或添加对话框
    form.on('submit(formEdit)', function (data) {
        $.post("/UserManager/Add", data.field, function (data) {
            layer.msg(data.Message);
            if (data.Status) {
               
            }
        }, "json");
        return false;
    });
})