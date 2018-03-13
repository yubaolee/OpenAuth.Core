layui.config({
    base: "/js/"
}).use(['form', 'vue', 'layer', 'jquery', 'table', 'flow-ui/gooflow', 'utils/flowlayout', 'droptree', 'queryString'], function () {
    var form = layui.form,
        element = layui.element,
		//layer = (parent == undefined || parent.layer === undefined )? layui.layer : parent.layer,
        layer = layui.layer,
        $ = layui.jquery;

    var postData = {};//提交数据
    var flowData = {};
    var frmData = {};
    var SchemeContentOld;
    var frmapp;
    var shcemeAuthorizeData = "";
    var AllAuthorizeCheckData = {};


    /*=========流程设计（begin）======================*/
    var FlowDesignPanel;
    var FlowDesignObject;//
    var LineId;
    var nodePramData = [];
    FlowDesignPanel = $('#flowPanel').flowdesign({
        height: ($(window).height() - 87),
        widht: 1000,
        OpenNode: function (object) {
            FlowDesignObject = object;
            if (object.$nodeData[object.$focus].type == 'startround') {
                return false;
            }

            layer.open({
                type: 2,
                skin: 'layui-layer-rim', //加上边框
                area: ['800px', '450px'], //宽高
                maxmin: true, //开启最大化最小化按钮
                title: '节点设置【' + object.$nodeData[object.$focus].name + '】',
                content: '/FlowManage/FlowDesign/FlowNodeForm',
                btn: ['保存', '关闭'],
                yes: function (index, layero) {
                    var body = layer.getChildFrame('body', index);
                    var iframeWin = window[layero.find('iframe')[0]['name']]; //得到iframe页的窗口对象，执行iframe页的方法：iframeWin.method();
                    iframeWin.AcceptClick();
                },
                cancel: function (index) {
                    layer.close(index);
                }
            });
        },
        OpenLine: function (id, object) {
            FlowDesignObject = object;
            LineId = id;
            var _line = object.$lineData[id];
            var _fromNode = object.$nodeData[_line.from];
            if (_fromNode.type == "shuntnode") {
                dialogTop("前一个节点是分流节点无法设置流转条件", "error");
                return false;
            }

            layer.open({
                type: 2,
                skin: 'layui-layer-rim', //加上边框
                area: ['800px', '450px'], //宽高
                maxmin: true, //开启最大化最小化按钮
                title: '流转条件设置',
                content: '/FlowManage/FlowDesign/FlowLineForm',
                btn: ['保存', '关闭'],
                yes: function (index, layero) {
                    var body = layer.getChildFrame('body', index);
                    var iframeWin = window[layero.find('iframe')[0]['name']]; //得到iframe页的窗口对象，执行iframe页的方法：iframeWin.method();
                    iframeWin.AcceptClick();
                },
                cancel: function (index) {
                    layer.close(index);
                }
            });

        }
    });
    function setFlowInfo(data) {
        FlowDesignPanel.loadData(data);
    }
    function callBackNode(id, data, _nodePramData) {
        nodePramData = _nodePramData;
        FlowDesignPanel.SetNodeEx(id, data);
    }
    function callBackLine(id, data) {
        FlowDesignPanel.SetLineEx(id, data);
    }
    function bindingFlow() {
        var _content = FlowDesignPanel.exportDataEx();
        if (_content == -1) {
            return false;
        }
        flowData["SchemeContent"] = JSON.stringify({ "Frm": frmData, "Flow": _content });
        return true;
    }
    /*=========流程设计（end）=====================*/

})