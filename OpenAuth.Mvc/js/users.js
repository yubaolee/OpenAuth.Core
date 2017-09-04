layui.config({
    base: "/js/"
}).use(['form','vue', 'ztree', 'layer', 'jquery', 'table','droptree','openauth'], function () {
    var form = layui.form,
		layer = (parent == undefined || parent.layer === undefined )? layui.layer : parent.layer,
		$ = layui.jquery;
    var table = layui.table;
    var openauth = layui.openauth;
    var droptree = layui.droptree("/UserSession/GetOrgs", "#Organizations", "#OrganizationIds");
   
    //主列表加载，可反复调用进行刷新
    var config= {};  //table的参数，如搜索key，点击tree的id
    var mainList = function (options) {
        if (options != undefined) {
            $.extend(config, options);
        }
        table.reload('mainList', {
            url: '/UserManager/Load',
            where: config
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
                zTreeObj = $.fn.zTree.init($("#tree"), setting, json);
                mainList({ orgId: json[0].Id });
                zTreeObj.expandAll(true);
            });
        };
        load();
        return {
            reload: load
        }
    }();

    //上级机构选择框
    $("#Organizations").on("click", function () {
        droptree.render();
    });

    //监听表格复选框选择
    table.on('checkbox(list)', function (obj) {
        console.log(obj);
    });
    //监听表格内部按钮
    table.on('tool(list)', function (obj) {
        var data = obj.data;
        if (obj.event === 'detail') {      //查看
            layer.msg('ID：' + data.Id + ' 的查看操作');

        } else if (obj.event === 'del') {  //删除
            openauth.del("/UserManager/Delete", data.Id, obj.del);
        } else if (obj.event === 'edit') {  //编辑
            layer.alert('编辑行：<br>' + JSON.stringify(data));
        }
    });

    var vm = new Vue({
        el: "#formEdit"
    });

    //监听页面主按钮操作
    var active = {
        del: function () {      //批量删除
            var checkStatus = table.checkStatus('mainList')
                , data = checkStatus.data;
            openauth.del("/UserManager/Delete", data.map(function (e) { return e.Id; }), mainList);
        }
        , addData: function () {  //添加
            var index = layer.open({
                title: "添加"
                ,area: ["500px", "400px"]
                ,type: "1"
                ,content: $('#formEdit')
                , success: function () {
                    vm.$set('$data', {});
                    //todo:droptree没有还原
                }
                ,end:mainList
            });
        }
        , search: function () {   //搜索
            mainList({ key: $('#key').val() });
        }      
    };

    $('.toolList .layui-btn').on('click', function () {
        var type = $(this).data('type');
        active[type] ? active[type].call(this) : '';
    });

    //监听页面主按钮操作 end

    //编辑或添加对话框
    form.on('submit(formSubmit)', function (data) {
        $.post("/UserManager/Add", data.field, function (data) {
            layer.msg(data.Message);
            if (data.Status) {
               
            }
        }, "json");
        return false;
    });
})