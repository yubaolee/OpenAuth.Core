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
            $("#frmPreview").html(data.Result.FrmPreviewHtml);
            flowDesignPanel.reinitSize($(window).width() - 30, $(window).height() - 120);
        });

    $(window).resize(function() {
        flowDesignPanel.reinitSize($(window).width()-30, $(window).height()-120);
    });

    //让层自适应iframe
     //layer.iframeAuto(index);
})