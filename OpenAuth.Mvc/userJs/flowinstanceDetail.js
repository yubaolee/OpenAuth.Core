layui.config({
    base: "/js/"
}).use(['form', 'vue', 'ztree', 'layer', 'utils', 'element', 'jquery', 'droptree', 'openauth', 'flow/gooflow', 'flowlayout'], function () {
    var form = layui.form, element = layui.element,
		layer = (top == undefined || top.layer === undefined )? layui.layer : top.layer,
        $ = layui.jquery;
    var openauth = layui.openauth;
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

            $("#frmPreview").html(data.Result.FrmPreviewHtml);
            flowDesignPanel.reinitSize($(window).width() - 30, $(window).height() - 100);
        });

    $(window).resize(function() {
        flowDesignPanel.reinitSize($(window).width()-30, $(window).height()-100);
    });

    //让层自适应iframe
     //layer.iframeAuto(index);
})