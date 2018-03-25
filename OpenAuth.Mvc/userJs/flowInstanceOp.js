layui.config({
    base: "/js/"
}).use(['form', 'vue', 'ztree', 'layer', 'utils', 'element', 'jquery', 'droptree', 'openauth', 'flow/gooflow', 'flowlayout'], function () {
    var form = layui.form, element = layui.element,
		//layer = (parent == undefined || parent.layer === undefined )? layui.layer : parent.layer,
        layer = layui.layer,
        $ = layui.jquery;
    var openauth = layui.openauth;
    var index = parent.layer.getFrameIndex(window.name); //获取窗口索引

    var vm = new Vue({
        el: "#formEdit"
    });

    var id = $.getUrlParam("id");   //ID
    $("#FlowInstanceId").val(id);

    //标签切换
    element.on('tab(tab)', function (data) {
        parent.layer.iframeAuto(index);
    });

    /*=========流程设计（begin）======================*/
    var flowDesignPanel = $('#flowPanel').flowdesign({
        height: 300,
        widht: 300,
        haveTool: false
    });
    /*=========流程设计（end）=====================*/

    $.getJSON('/FlowInstances/get?id=' + id,
        function (data) {
            var obj = data.Result;
            flowDesignPanel.loadData(JSON.parse(obj.SchemeContent));

            //取表单的结构数据
            $.getJSON("/forms/get?id=" + obj.FrmId, function (data) {
                if (data.Code != 500) {
                    $("#frmPreview").html(data.Result.Html);
                }
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

    //让层自适应iframe
    parent.layer.iframeAuto(index);
})