layui.config({
    base: "/js/"
}).use(['form','table', 'vue', 'layer', 'utils', 'element', 'jquery', 'slimscroll', 'flow/gooflow', 'flowlayout'], function () {
    var form = layui.form, element = layui.element,
        table = layui.table,
		layer = (top == undefined || top.layer === undefined )? layui.layer : top.layer,
        $ = layui.jquery;
    var index = layer.getFrameIndex(window.name); //获取窗口索引

    var id = $.getUrlParam("id");   //ID
    var flowDesignPanel;

    table.render({
        elem: '#mainList',
        page: false,
        url: '/FlowInstances/QueryHistories',
        cols: [[ //标题栏
            { field: 'Content', title: '流转记录' }
            , { field: 'CreateUserName', title: '操作人' }
            , { field: 'CreateDate', title: '流转时间' }
        ]]
        , where: {
            FlowInstanceId:id
        }
        , parseData: function (res) { //res 即为原始返回的数据
            return {
                "code": res.Code, //解析接口状态
                "data": res.Result //解析数据列表
            };
        }
        , response: {
            statusCode: 200 //规定成功的状态码，默认：0
        }
    });
   
    $.getJSON('/FlowInstances/get?id=' + id,
        function (data) {
            var obj = data.Result;
            var schemeContent = JSON.parse(obj.SchemeContent);
            flowDesignPanel = $('#flowPanel').flowdesign({
                haveTool: false
                , isprocessing: true
                , activityId: obj.ActivityId
                , nodeData: schemeContent.nodes
                , flowcontent:schemeContent
            });

            $(".GooFlow_work").slimScroll({
                height:'auto'
            });
            if (data.Result.FrmType == 0) {
	            $("#frmPreview").html(data.Result.FrmPreviewHtml);
            } else {
	            $("#frmPreview").html("复杂表单暂时只能在<a href='http://demo.openauth.me:1803'>企业版</a>查看，开源版预计会在以后的开源版本中发布");
            }

            flowDesignPanel.reinitSize($(window).width() - 30, $(window).height() - 120);
        });

    $(window).resize(function() {
        flowDesignPanel.reinitSize($(window).width()-30, $(window).height()-120);
    });

    //让层自适应iframe
     //layer.iframeAuto(index);
})