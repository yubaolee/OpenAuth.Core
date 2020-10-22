layui.config({
    base: "/js/"
}).use(['form', 'vue', 'ztree', 'layer', 'jquery', 'table', 'droptree', 'openauth', 'utils'], function () {
    var form = layui.form,
        layer = layui.layer,
        $ = layui.jquery;
    var table = layui.table;
    var openauth = layui.openauth;
    var toplayer = (top == undefined || top.layer === undefined) ? layer : top.layer;  //顶层的LAYER

    $("#menus").loadMenus("SysLog");


    //加载表头
    $.getJSON('/SysLogs/Load',
	    { page: 1, limit: 1 },
	    function (data) {
		    table.render({
                elem: '#mainList'
			   , page: true,
                url: '/SysLogs/Load',
                cols: [[ //表头
                     { field: 'Content', title: '内容' }
                    , { field: 'Href', title: '访问地址' }
                    , { field: 'CreateName', title: '操作人' }
                    , { field: 'Application', title: '所属应用' }
                    , { field: 'Result', title: '操作结果', templet: '#Result' }
                    , { field: 'CreateTime', title: '记录时间' }
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
                url: '/SysLogs/Load',
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
        if (obj.event === 'detail') {      //查看
            layer.msg('ID：' + data.Id + ' 的查看操作');
        }
    });


    //监听页面主按钮操作
    var active = {
        btnDel: function () {      //批量删除
            var checkStatus = table.checkStatus('mainList')
                , data = checkStatus.data;
            openauth.del("/SysLogs/Delete",
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
