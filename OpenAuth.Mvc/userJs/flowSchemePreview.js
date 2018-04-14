/// <reference path="flowInstanceOp.js" />
layui.config({
    base: "/js/"
}).use(['form', 'vue', 'ztree', 'layer', 'utils', 'element', 'jquery', 'slimscroll',  'flow/gooflow', 'flowlayout'], function () {
    var form = layui.form, element = layui.element,
        layer = layui.layer,
        $ = layui.jquery;

    var index = layer.getFrameIndex(window.name); //获取窗口索引
    var id = $.getUrlParam("id");   //ID
    
    /*=========流程设计（begin）======================*/
    var flowDesignPanel = $('#flowPanel').flowdesign({
        height: 300,
        widht: 300,
        haveTool: false,
        OpenNode: function (object) {
            FlowDesignObject = object;  //为NodeInfo窗口提供调用

            if (object.type == 'start round mix' || object.type == 'end round') {
                layer.msg("开始节点与结束节点不能设置");
                return false;
            }

            layer.open({
                type: 2,
                area: ['500px', '450px'], //宽高
                maxmin: true, //开启最大化最小化按钮
                title: '节点设置【' + object.name + '】',
                content: '/flowschemes/nodeInfo',
                btn: ['确定', '取消'],
                yes: function (index, layero) {
                    var body = layer.getChildFrame('body', index);
                    var iframeWin = window[layero.find('iframe')[0]['name']]; //得到iframe页的窗口对象，执行iframe页的方法：iframeWin.method();
                    var nodedata = iframeWin.getVal();
                    flowDesignPanel.SetNodeEx(object.id, nodedata);
                    layer.close(index);
                },
                cancel: function (index) {
                    layer.close(index);
                }
            });
        },
        OpenLine: function (id, object) {
            lay.msg("暂不能设置分支条件");
            return;
        }
    });
    /*=========流程设计（end）=====================*/


    $.getJSON('/flowschemes/get?id=' + id,
        function (data) {
            var obj = data.Result;
            
            flowDesignPanel.loadData(JSON.parse(obj.SchemeContent));

            $.getJSON("/forms/get?id=" + obj.FrmId, function (data) {
                $("#frmPreview").html(data.Result.Html);
            });
        });


    flowDesignPanel.reinitSize($(window).width() - 30, $(window).height() - 100);
    $(window).resize(function () {
        flowDesignPanel.reinitSize($(window).width() - 30, $(window).height() - 100);
    });

    //让层自适应iframe
    layer.iframeAuto(index);

    $(".GooFlow_work").slimScroll({
        height: 'auto'
    });
})