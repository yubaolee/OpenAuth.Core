layui.config({
    base: "/js/"
}).use(['form', 'vue', 'ztree', 'layer', 'utils', 'element', 'slimscroll', 'jquery', 'droptree', 'openauth', 'flow/gooflow', 'flowlayout'], function () {
    var form = layui.form, element = layui.element,
		layer = (top == undefined || top.layer === undefined )? layui.layer : top.layer,
        $ = layui.jquery;
    var openauth = layui.openauth;
    var index = layer.getFrameIndex(window.name); //获取窗口索引

   var id = $.getUrlParam("id");   //ID
    $("#FlowInstanceId").val(id);

   
    $.getJSON('/FlowInstances/get?id=' + id,
        function (data) {
            var obj = data.Result;
            var schemeContent = JSON.parse(obj.SchemeContent);
            var flowDesignPanel = $('#flowPanel').flowdesign({
                haveTool: false
                , isprocessing: true
                , activityId: obj.ActivityId
                , nodeData: schemeContent.nodes
                , flowcontent:schemeContent
            });

            $("#frmPreview").html(data.Result.FrmPreviewHtml);

            //让层自适应iframe
            layer.iframeAuto(index);

            $(".GooFlow_work").slimScroll({
                height: 'auto'
            });
        });

    //提交数据
    form.on('submit(formSubmit)',
        function (data) {
            $.post("/FlowInstances/Verification",
                data.field,
                function (result) {
                    layer.msg(result.Message);
                },
                "json");

            return false; //阻止表单跳转。
        });

    //$(window).resize(function() {
    //    flowDesignPanel.reinitSize($(window).width()-30, $(window).height()-100);
    //});

    //该函数供给父窗口确定时调用
    submit = function () {
        //只能用隐藏的submit btn才行，用form.submit()时data.field里没有数据
        $("#btnSubmit").click();
    }
})