layui.config({
    base: "/js/"
}).use(['form', 'vue', 'layer', 'utils', 'element', 'jquery', 'slimscroll', 'flow/gooflow', 'flowlayout'], function () {
    var form = layui.form, element = layui.element,
		layer = (top == undefined || top.layer === undefined )? layui.layer : top.layer,
        $ = layui.jquery;
    var index = layer.getFrameIndex(window.name); //获取窗口索引

    var id = $.getUrlParam("id");   //ID
    var flowDesignPanel;
   
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
	            $("#frmPreview").html("复杂表单暂时只能在<a href='http://demo.openauth.me:1803'>企业版</a>查看，开源版预计会在v1.5发布");
            }

            flowDesignPanel.reinitSize($(window).width() - 30, $(window).height() - 120);
        });

    $(window).resize(function() {
        flowDesignPanel.reinitSize($(window).width()-30, $(window).height()-120);
    });

    //让层自适应iframe
     //layer.iframeAuto(index);
})