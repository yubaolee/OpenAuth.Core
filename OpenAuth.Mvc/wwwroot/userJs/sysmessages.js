layui.config({
    base: "/js/"
}).use(['form', 'vue', 'ztree', 'layer', 'jquery', 'table', 'droptree', 'openauth', 'utils'], function () {
    var form = layui.form,
        layer = layui.layer,
        $ = layui.jquery;
    var table = layui.table;
    var openauth = layui.openauth;
    var toplayer = (top == undefined || top.layer === undefined) ? layer : top.layer;  //顶层的LAYER

    $("#menus").loadMenus("SysMessage");


    //加载表头
    $.getJSON('/SysMessages/Load',
	    { page: 1, limit: 1 },
	    function (data) {
		   
		    table.render({
                elem: '#mainList'
                , size: 'sm' //小尺寸的表格
			    ,page: true,
                url: '/SysMessages/Load',
                cols: [[ //表头
                    { field: 'Title', title: '消息标题' }
                   , { field: 'Content', title: '内容' }
                    , { field: 'FromName', title: '消息来源' }
                    , { field: 'TypeName', title: '消息分类' }
                    , { field: 'ToStatus', title: '状态', templet: '#ToStatus' }
                    , { field: 'CreateTime', title: '消息时间' }
                    , { field: 'Id', hide:true }
                ]]
			    , response: {
				    statusCode: 200 //规定成功的状态码，默认：0
			    }
		    });
        });


    //主列表加载，可反复调用进行刷新
    var config = {};  //table的参数，如搜索key，点击tree的id
    var mainList = function(options) {
        if (options != undefined) {
            $.extend(config, options);
        }
        table.reload('mainList',
            {
                url: '/SysMessages/Load',
                where: config
                , response: {
                    statusCode: 200 //规定成功的状态码，默认：0
                } 
            });
    };
    mainList();
 
    //监听表格内部按钮
    table.on('tool(list)', function (obj) {
        var data = obj.data;
        if (obj.event === 'edit') {      //查看
            layer.msg('ID：' + data.Id + ' 的查看操作');
        } else if (obj.event === 'del') {
            openauth.del("/SysMessages/Delete",
                data.Id,
                mainList);
        }
    });


    //监听页面主按钮操作
    var active = {
        btnDel: function () {      //批量删除
            var checkStatus = table.checkStatus('mainList')
                , data = checkStatus.data;
            openauth.del("/SysMessages/Delete",
                data.map(function (e) { return e.Id; }),
                mainList);
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
