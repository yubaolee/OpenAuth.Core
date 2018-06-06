layui.config({
    base: "/js/"
}).use(['form', 'vue', 'ztree', 'layer', 'utils', 'element', 'jquery', 'table', 'slimscroll', 'openauth', 'flow/gooflow', 'flowlayout'], function () {
    var form = layui.form, element = layui.element,
        layer = layui.layer,
        $ = layui.jquery;
    var index = layer.getFrameIndex(window.name); //获取窗口索引
     var id = $.getUrlParam("id");   //ID
    var update = (id !=null && id != '');
    //提交的URL
    var url = "/FlowInstances/Add";

    var vm = new Vue({
        el: "#formEdit"
    });

    ////标签切换
    //element.on('tab(tab)', function (data) {
    //    layer.iframeAuto(index);
    //});

    /*=========流程设计（begin）======================*/
    var flowDesignPanel = $('#flowPanel').flowdesign({
        height: 300,
        widht: $(window).width() - 250,
        haveTool: false,
        preview:1,
        OpenNode: function (object) {
            FlowDesignObject = object;  //为NodeInfo窗口提供调用

            if (object.type == 'start round mix' || object.type == 'end round') {
                return false;
            }

            layer.open({
                type: 2,
                area: ['500px', '450px'], //宽高
                maxmin: true, //开启最大化最小化按钮
                title: '节点设置【' + object.name + '】',
                content: '/flowschemes/nodeInfo',
                btn: ['关闭'],
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

    //流程模板选择
    var tree = function () {
        var zTreeObj;
        var setting = {
            view: { selectedMulti: true },
            check: {
                enable: true,
                chkStyle: "radio",
                radioType: "all",  //整个节点一个分组
                chkboxType: { "Y": "", "N": "" } //去掉勾选时级联
            },
            data: {
                key: {
                    name: 'SchemeName',
                    title: 'SchemeName'
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
                    //预览表单
                    //取表单的结构数据
                    $.getJSON("/forms/get?id=" + treeNode.FrmId, function (data) {
                        if (data.Code != 500) {
                            $("#frmPreview").html(data.Result.Html);
                        }
                    });

                    //预览流程
                    flowDesignPanel.loadData(JSON.parse(treeNode.SchemeContent));
                },
                onCheck: function (event, treeId, treeNode) {
                    $("#FrmId").val(treeNode.FrmId);   //把流程模板的表单ID设置成流程实例的表单ID
                    $("#SchemeContent").val(treeNode.SchemeContent);

                    //取表单的结构数据
                    $.getJSON("/forms/get?id=" + treeNode.FrmId, function (data) {
                        if (data.Code != 500) {
                            $("#FrmContentData").val(data.Result.ContentData);
                            $("#FrmContentParse").val(data.Result.ContentParse);
                            $("#frmPreview").html(data.Result.Html);
                        }
                    });

                    //预览流程
                    flowDesignPanel.loadData(JSON.parse(treeNode.SchemeContent));
                }
            }
        };

        var url = '/flowschemes/load';
        $.ajax(url,
            {
                async: false
                , success: function (data) {
                    var json = JSON.parse(data);
                    zTreeObj = $.fn.zTree.init($("#frmTree"), setting);
                    zTreeObj.addNodes(null, json.data);
                    zTreeObj.expandAll(true);
                }
            });

        var setCheck = function (id) {    //设置已经选中的表单
            if (id == null | id == '') return;
            var node = zTreeObj.getNodeByParam("Id", id, null);
            zTreeObj.checkNode(node, true, false);
        }
        return {
            setCheck: setCheck
        }
    }();

    if (update) {
        $.getJSON('/FlowInstances/get?id=' + id,
            function (data) {
                var obj = data.Result;
                url = "/FlowInstances/Update";
                vm.$set('$data', obj);
                flowDesignPanel.loadData(JSON.parse(obj.SchemeContent));
                tree.setCheck(obj.FrmId);
            });
    } else {
        vm.$set('$data',
            {
                Id: ''
                , Code: new Date().getTime()
            });
    }

    //提交数据
    form.on('submit(formSubmit)',
        function (data) {
            var content = flowDesignPanel.exportData();
            if (content == -1) {
                return false; //阻止表单跳转。
            }

            $.extend(data.field,
            {
                SchemeContent: JSON.stringify(content)
            });

            $.post(url,
                data.field,
                function (result) {
                    layer.msg(result.Message);
                },
                "json");

            return false; //阻止表单跳转。
        });

    $(window).resize(function() {
        flowDesignPanel.reinitSize($(window).width()-250, $(window).height()-100);
    });

    //该函数供给父窗口确定时调用
    submit = function () {
        //只能用隐藏的submit btn才行，用form.submit()时data.field里没有数据
        $("#btnSubmit").click();
    }

    $(".GooFlow_work").slimScroll({
        height: 'auto'
    });

})