new Vue({
    el: "#formEdit",
    data() {
        return {
            tmp: {
                Id: '',
                Code: new Date().getTime(),
                SchemeCode:'',
                SchemeId: '',
                FrmData:''
            }
        }
    },
    mounted() {
        let _this = this;
        layui.config({
            base: "/js/"
        }).use(['form', 'dtree', 'layer', 'utils', 'element', 'jquery', 'cookie','table', 'slimscroll', 'openauth', 'flow/gooflow', 'flowlayout'], function () {
            var form = layui.form,
                element = layui.element,
                layer = layui.layer,
                dtree = layui.dtree,
                $ = layui.jquery;
            var index = layer.getFrameIndex(window.name); //获取窗口索引
            var id = $.getUrlParam("id"); //ID
            var update = (id != null && id != '');
            //提交的URL
            var url = "/FlowInstances/Add";

            /*=========流程设计（begin）======================*/
            var flowDesignPanel = $('#flowPanel').flowdesign({
                height: 300,
                widht: $(window).width() - 250,
                haveTool: false,
                preview: 1,
                OpenNode: function (object) {
                    FlowDesignObject = object; //为NodeInfo窗口提供调用

                    if (object.type == 'start round mix' || object.type == 'end round') {
                        return false;
                    }

                    layer.open({
                        type: 2,
                        area: ['550px', '450px'], //宽高
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

            //流程模板选择列表
            function initTree(option) {
                var treeObj = dtree.render({
                    elem: "#tree",
                    url: '/flowschemes/load',
                    method: 'GET',
                    dataFormat: 'list',
                    dataStyle: 'layuiStyle',
                    initLevel: "4",
                    record: true, //记录节点数据
                    response: {
                        statusName: "code", //返回标识（必填）
                        statusCode: 200, //返回码（必填）
                        message: "msg", //返回信息（必填）
                        rootName: "data", //根节点名称（必填）
                        treeId: "Id", //节点ID（必填）
                        parentId: "ParentId", //父节点ID（必填）
                        title: "SchemeName", //节点名称（必填）
                    },
                    done: function (data, obj) { //使用异步加载回调
                        if (option) {
                            dtree.dataInit("tree", option); // 初始化复选框的值
                        }
                    }
                });
                dtree.on("node('tree')", function (obj) { //节点点击事件
                    var record = JSON.parse(obj.param.recordData);  //从记录中取节点数据
                    _this.tmp.SchemeId = record.Id;
                    _this.tmp.SchemeCode = record.SchemeCode;

                    //取表单的结构数据
                    $.getJSON("/forms/get?id=" + record.FrmId, function (data) {
                        if (data.Code != 500) {
                            if (data.Result.FrmType == 0) {
                                $("#frmPreview").html(data.Result.Html);
                            } else {
                                $("#frmPreview").html('复杂表单暂时只能在<a href="http://demo.openauth.me:1803">企业版</a>查看，开源版预计会在以后的开源版本中发布');
                            }
                        }
                    });

                    //预览流程
                    flowDesignPanel.loadData(JSON.parse(record.SchemeContent));

                });

            }

            if (update) {
                $.getJSON('/FlowInstances/get?id=' + id,
                    function (data) {
                        var obj = data.Result;
                        url = "/FlowInstances/Update";

                        _this.tmp = $.extend({}, obj)
                        flowDesignPanel.loadData(JSON.parse(obj.SchemeContent));
                        initTree(obj.SchemeId);
                    });
            } else {
                initTree();
            }

            //提交数据
            form.on('submit(formSubmit)',
                function (data) {
                    var content = flowDesignPanel.exportData();
                    if (content == -1) {
                        return false; //阻止表单跳转。
                    }

                    delete data.field.CustomName;
                    delete data.field.Code;
                    delete data.field.Description;
                    _this.tmp.OrgId = $.cookie('defaultorgid');

                    _this.tmp.FrmData = JSON.stringify(data.field);
                    $.post(url,
                        _this.tmp,
                        function (result) {
                            layer.msg(result.Message);
                        },
                        "json");

                    return false; //阻止表单跳转。
                });

            $(window).resize(function () {
                flowDesignPanel.reinitSize($(window).width() - 250, $(window).height() - 100);
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

    }
});