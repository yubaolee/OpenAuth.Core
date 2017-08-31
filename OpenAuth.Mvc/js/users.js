layui.config({
    base: "/js/"
}).use(['form','ztree', 'layer', 'jquery', 'table'], function () {
    var form = layui.form,
		layer = parent.layer === undefined ? layui.layer : parent.layer,
		$ = layui.jquery;
    var table = layui.table;

    var ztree = function () {
        var url = '/OrgManager/LoadOrg';
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
                   // list.reload(treeNode.Id);
                }
            }
        };
        var load = function () {
            $.getJSON(url, function (json) {
                var zTreeObj = $.fn.zTree.init($("#tree"), setting, json);
               // list.reload();
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
            layer.msg('ID：' + data.id + ' 的查看操作');
        } else if (obj.event === 'del') {
            layer.confirm('真的删除行么', function (index) {
                obj.del();
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
        }, addData:function() {  //添加
            var index = layui.layer.open({
                title: "添加",
                type: 2,
                content: "addUser.html",
                success: function (layero, index) {
                    setTimeout(function () {
                        layui.layer.tips('点击此处返回列表',
                            '.layui-layer-setwin .layui-layer-close', {
                            tips: 3
                        });
                    }, 500);
                }
            });
            //改变窗口大小时，重置弹窗的高度，防止超出可视区域（如F12调出debug的操作）
            $(window).resize(function () {
                layui.layer.full(index);
            });
            layui.layer.full(index);
        }, search:function() {  //搜索
            var key = $('#key');

            table.reload('mainList', {
                where: {
                    key: key.val(),
                    para1:"1"
                }
            });
        }
    };

    $('.toolList .layui-btn').on('click', function () {
        var type = $(this).data('type');
        active[type] ? active[type].call(this) : '';
    });
})