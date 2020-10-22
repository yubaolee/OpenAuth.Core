new Vue({
    el: "#formEdit",
    data() {
        return {
            tmp: {
                Id: '',
                SchemeCode: new Date().getTime(),
                SortCode: '1',
                FrmId:''
            },
            forms: [],
            frmPreview: ''
        }
    },
    updated() {  //如果layui有刷新失败的可以在这里面处理
        //layui.form.render(null,'formChangeFilter'); //只能 class="layui-form" 所在元素的 lay-filter="" 的值???
        layui.form.render();
    },
    mounted() {
        var _this = this
        layui.config({
            base: "/js/"
        }).use(['form', 'ztree', 'layer', 'utils', 'element', 'jquery', 'cookie','table', 'droptree', 'openauth', 'flow/gooflow', 'flowlayout'], function () {
            var form = layui.form,
                element = layui.element,
                layer = layui.layer,
                $ = layui.jquery;
            var table = layui.table;
            var openauth = layui.openauth;

            var index = layer.getFrameIndex(window.name); //获取窗口索引
            var id = $.getUrlParam("id"); //ID
            var update = (id != null && id != '');
            //提交的URL
            var url = "/FlowSchemes/Add";
            if (update) {
                 url = "/FlowSchemes/Update";
            }

            $.getJSON('/forms/load', function (json) { //加载所有表单
                _this.forms = json.data
            })

            var changeForm = function (id) { //切换表单
                _this.tmp.FrmId = id;
                $.getJSON("/forms/get?id=" + id, function (data) {
                    if (data.Result.FrmType == 0) {
                        _this.frmPreview = data.Result.Html
                    } else {
                        _this.frmPreview = '复杂表单暂时只能在<a href="http://demo.openauth.me:1803">企业版</a>查看，开源版预计会在以后的开源版本中发布'
                    }
                });
            }


            /*=========流程设计（begin）======================*/
            var flowDesignPanel = $('#flowPanel').flowdesign({
                height: 300,
                widht: 300,
                OpenNode: function (object) {
                    FlowDesignObject = object; //为NodeInfo窗口提供调用

                    if (object.type == 'start round mix' || object.type == 'end round') {
                        layer.msg("开始节点与结束节点不能设置");
                        return false;
                    }

                    layer.open({
                        type: 2,
                        area: ['550px', '450px'], //宽高
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
                    layer.msg("分支条件暂时只对企业版开放");
                    return;
                }
            });

            if (update) {
                $.getJSON('/flowschemes/get?id=' + id, function (obj) {
                    _this.tmp = $.extend({}, obj.Result)
                    changeForm(obj.Result.FrmId)
                    flowDesignPanel.loadData(JSON.parse(obj.Result.SchemeContent));
                })
            }
            /*=========流程设计（end）=====================*/

            //提交数据
            form.on('submit(formSubmit)',
                function (data) {
                    var content = flowDesignPanel.exportDataEx();
                    if (content == -1) {
                        return false; //阻止表单跳转。
                    }
                    var schemecontent = {
                        SchemeContent: JSON.stringify(content)
                    }

                    $.extend(data.field, schemecontent);
                    $.extend(data.field, {OrgId: $.cookie('defaultorgid')});
                    $.post(url,
                        data.field,
                        function (result) {
                            layer.msg(result.Message);
                        },
                        "json");

                    return false; //阻止表单跳转。
                });

            form.on('select(formChangeFilter)', function (obj) {
                changeForm(obj.value)
            });

            flowDesignPanel.reinitSize($(window).width() - 30, $(window).height() - 100);
            $(window).resize(function () {
                flowDesignPanel.reinitSize($(window).width() - 30, $(window).height() - 100);
            });

            //该函数供给父窗口确定时调用
            submit = function () {
                //只能用隐藏的submit btn才行，用form.submit()时data.field里没有数据
                $("#btnSubmit").click();
            }

            //让层自适应iframe
            layer.iframeAuto(index);
        })
    }
});