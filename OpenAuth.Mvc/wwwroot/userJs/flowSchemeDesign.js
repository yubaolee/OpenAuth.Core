layui.config({
    base: "/js/"
}).use(['form', 'vue', 'ztree', 'layer', 'utils', 'element', 'jquery', 'table', 'droptree', 'openauth', 'flow/gooflow', 'flowlayout'], function () {
    var form = layui.form, element = layui.element,
        layer = layui.layer,
        $ = layui.jquery;
    var table = layui.table;
    var openauth = layui.openauth;

    var index = layer.getFrameIndex(window.name); //获取窗口索引
    var id = $.getUrlParam("id");   //ID
    var update = (id != null && id != '');
    //提交的URL
    var url = "/FlowSchemes/Add";

    var vm = new Vue({
        el: "#formEdit"
    });

    //表单选择
    var frmTree = function () {
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
                    name: 'Name',
                    title: 'Name'
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
                    $.getJSON("/forms/get?id=" + treeNode.Id, function (data) {
                        $("#frmPreview").html(data.Result.Html);
                    });
                },
                onCheck: function (event, treeId, treeNode) {
                    $("#FrmId").val(treeNode.Id);
                    $.getJSON("/forms/get?id=" + treeNode.Id, function (data) {
                        $("#frmPreview").html(data.Result.Html);
                    });
                }
            }
        };

        var url = '/forms/load';
        $.ajax(url,
            {
                async: false

                , success: function (data) {
                    var json = JSON.parse(data);
                    zTreeObj = $.fn.zTree.init($("#frmTree"), setting);
                    zTreeObj.addNodes(null, json.data);

                    $("#menutree").html("点击预览表单效果");
                    zTreeObj.expandAll(true);
                }
            });

        var setCheck = function (id) {    //设置已经选中的表单
            if (id == null | id == '') return;
            var node = zTreeObj.getNodeByParam("Id", id, null);
            zTreeObj.checkNode(node, true, false);

            $.getJSON("/forms/get?id=" + id, function (data) {
                $("#frmPreview").html(data.Result.Html);
            });
        }

        return {
            setCheck: setCheck
        }
    }();

    /*=========流程设计（begin）======================*/
    var flowDesignPanel = $('#flowPanel').flowdesign({
        height: 300,
        widht: 300,
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

    if (update) {
        $.getJSON('/flowschemes/get?id=' + id,
            function (data) {
                var obj = data.Result;
                url = "/FlowSchemes/Update";
                vm.$set('$data', obj);

                $('input:checkbox[name="Disabled"][value="' + obj.Disabled + '"]').prop('checked', true);
                form.render();

                flowDesignPanel.loadData(JSON.parse(obj.SchemeContent));
                frmTree.setCheck(obj.FrmId);
            });
    } else {
        vm.$set('$data',
            {
                Id: ''
                , SchemeCode: new Date().getTime()
                , SortCode: '1'
            });
    }

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
            $.post(url,
                data.field,
                function (result) {
                    layer.msg(result.Message);
                },
                "json");

            return false; //阻止表单跳转。
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