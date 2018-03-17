layui.config({
    base: "/js/"
}).use(['form', 'vue', 'ztree', 'layer', 'queryString', 'element', 'jquery', 'table', 'droptree', 'openauth', 'flow-ui/gooflow', 'utils/flowlayout'], function () {
    var form = layui.form, element = layui.element,
		//layer = (parent == undefined || parent.layer === undefined )? layui.layer : parent.layer,
        layer = layui.layer,
        $ = layui.jquery;
    var table = layui.table;
    var openauth = layui.openauth;
     var id = $.getUrlParam("id");   //ID
    var update = (id != '');
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
                chkStyle: "checkbox",
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
                    var id = treeNode.Id;
                    $.get("/forms/previewdata?id=" + id, function (data) {
                        $("#frmPreview").html(data);
                    });
                },
                onCheck: function (event, treeId, treeNode) {
                    $("#FrmId").val(treeNode.Id);
                }
            }
        };

        var load = function () {
            var url = '/forms/load';
            $.getJSON(url, function (json) {
                zTreeObj = $.fn.zTree.init($("#frmTree"), setting);
                zTreeObj.addNodes(null, json.data);

                $("#menutree").html("点击预览表单效果");
                zTreeObj.expandAll(true);
            });
        };

        var setCheck = function (id) {    //设置已经选中的表单
            if (id == null | id == '') return;
            var node = zTreeObj.getNodeByParam("Id", id, null);
            zTreeObj.checkNode(node, true, false);

            $.get("/forms/previewdata?id=" + id, function (data) {
                $("#frmPreview").html(data);
            });
        }

        return {
            load: load,
            setCheck: setCheck
        }
    }();

    /*=========流程设计（begin）======================*/
    var flowDesignPanel = $('#flowPanel').flowdesign({
        height: 500,
        widht: 700,
        OpenNode: function (object) {
            FlowDesignObject = object;  //为NodeInfo窗口提供调用

            if (object.$nodeData[object.$focus].type == 'startround') {
                return false;
            }

            layer.open({
                type: 2,
                area: ['500px', '450px'], //宽高
                maxmin: true, //开启最大化最小化按钮
                title: '节点设置【' + object.$nodeData[object.$focus].name + '】',
                content: '/flowschemes/nodeInfo',
                btn: ['保存', '关闭'],
                yes: function (index, layero) {
                    var body = layer.getChildFrame('body', index);
                    var iframeWin = window[layero.find('iframe')[0]['name']]; //得到iframe页的窗口对象，执行iframe页的方法：iframeWin.method();
                    var nodedata = iframeWin.getVal();
                    flowDesignPanel.SetNodeEx(object.$focus, nodedata);
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


    frmTree.load();

    if (update) {
        $.get('/fllowschemes/get?id=' + id,
            function (data) {
                url = "/FlowSchemes/Update";
                vm.$set('$data', data);
                flowDesignPanel.loadData(JSON.parse(data.SchemeContent));
                frmTree.setCheck(data.FrmId);
            });
    } else {
        vm.$set('$data',
            {
                Id: ''
            });
    }


    //提交数据
    form.on('submit()',
        function (data) {
            var content = flowDesignPanel.exportDataEx();
            if (content == -1) return false;
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
            return false;
        });

      submit = function() {
         $("#formEdit").submit();
     }
})