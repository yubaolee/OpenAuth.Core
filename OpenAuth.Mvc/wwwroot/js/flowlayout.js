layui.define(["jquery", "layer", "bootstrap"],
    function (exports) {
        var $ = layui.jquery;
        var layer = layui.layer;
        //初始化设计流程器
        $.fn.flowdesign = function (options) {
            var $frmpreview = $(this);
            if (!$frmpreview.attr('id')) {
                return false;
            }
            $frmpreview.html("");

            var defaultcnf = {
                width: 500,
                height: 400,

                haveHead: false,
                haveTool: true,
                headLabel: true,
                toolBtns: ["start round mix", "end round", "node", "join", "fork"],
                haveGroup: true,
                useOperStack: true
            };
            if (options != undefined) {
                $.extend(defaultcnf, options);
            }

            var flowPanel = $.createGooFlow($(this), defaultcnf);
            flowPanel.setNodeRemarks({
                cursor: "选择指针",
                direct: "转换连线",
                dashed: "关联虚线",
                start: "开始结点",
                end: "结束结点",
                task: "任务结点",
                node: "任务结点",
                chat: "决策结点",
                state: "状态结点",
                plug: "附加插件",
                fork: "分支结点",
                join: "联合结点",
                complex: "复合结点",
                group: "组织划分框编辑开"
            });
            if (options != undefined
                && options.flowcontent != undefined
                && options.flowcontent != null) {  //加载内容
                flowPanel.loadData(options.flowcontent);
            }

            //导出数据扩展方法
            //所有节点必须有进出线段
            //必须有开始结束节点（且只能为一个）
            //分流合流节点必须成对出现
            //分流合流节点必须一一对应且中间必须有且只能有一个普通节点
            //分流节点与合流节点之前的审核节点必须有且只能有一条出去和进来节点
            flowPanel.exportDataEx = function () {
                var data = flowPanel.exportData();
                var fromlines = {},
                    tolines = {},
                    nodes = {},
                    fnodes = [],   //会签分流节点
                    hnodes = [],  //会签合流节点
                    startroundFlag = 0,   //开始节点标识
                    endroundFlag = 0;   //结束节点标识
                for (var i in data.lines) {
                    if (fromlines[data.lines[i].from] == undefined) {
                        fromlines[data.lines[i].from] = [];
                    }
                    fromlines[data.lines[i].from].push(data.lines[i].to);

                    if (tolines[data.lines[i].to] == undefined) {
                        tolines[data.lines[i].to] = [];
                    }
                    tolines[data.lines[i].to].push(data.lines[i].from);
                }
                for (var j in data.nodes) {
                    var _node = data.nodes[j];
                    var _flag = false;
                    switch (_node.type) {
                        case "start round mix":
                            startroundFlag++;
                            if (fromlines[_node.id] == undefined) {
                                layer.msg("开始节点无法流转到下一个节点");
                                return -1;
                            }
                            break;
                        case "end round":
                            endroundFlag++;
                            if (tolines[_node.id] == undefined) {
                                layer.msg("无法流转到结束节点");
                                return -1;
                            }
                            break;
                        case "node":
                            if (_node.setInfo == null) {
                                layer.msg("请设置节点【"+_node.name+"】操作人员");
                                return -1;
                            }
                            _flag = true;
                            break;
                        case "fork":
                            _flag = true;
                            fnodes.push(_node.id);
                            break;
                        case "join":
                            hnodes.push(_node.id);
                            _flag = true;
                            break;
                        default:
                            layer.msg("节点数据异常！");
                            return -1;
                            break;
                    }
                    nodes[_node.id] = _node;
                }
                if (startroundFlag == 0) {
                    layer.msg("必须有开始节点");
                    return -1;
                }

                if (endroundFlag == 0) {
                    layer.msg("必须有结束节点");
                    return -1;
                }

                if (fnodes.length != hnodes.length) {
                    layer.msg("分流节点必须等于合流节点");
                    return -1;
                }
                return data;
            }

            flowPanel.SetNodeEx = function (id, data) {
                flowPanel.setName(id, data.NodeName, "node", data);
            }
            flowPanel.SetLineEx = function (id, data) {
                flowPanel.setName(id, data.LineName, "line", data);
            }
            flowPanel.onItemDbClick = function (id, type) {
                var obj = flowPanel.getItemInfo(id, type);
                switch (type) {
                    case "node":
                        options.OpenNode(obj);
                        break;
                    case "line":
                        options.OpenLine(obj);
                        break;
                }
                return false;
            }
            if (options.isprocessing) //如果是显示进程状态
            {
                var tipHtml =
                    '<div style="position:absolute;left:10px;margin-top: 10px;padding:10px;border-radius:5px;background:rgba(0,0,0,0.05);z-index:1000;display:inline-block;">';
                tipHtml +=
                    '<div style="display: inline-block;"><i style="padding-right:5px;color:#5cb85c;" class="layui-icon">&#xe612;</i><span>已处理</span></div>';
                tipHtml +=
                    '<div style="display: inline-block;margin-left: 10px;"><i style="padding-right:5px;color:#5bc0de;" class="layui-icon">&#xe612;</i><span>正在处理</span></div>';
                tipHtml +=
                    '<div style="display: inline-block;margin-left: 10px;"><i style="padding-right:5px;color:#d9534f;" class="layui-icon">&#xe612;</i><span>不通过</span></div>';
                tipHtml +=
                    '<div style="display: inline-block;margin-left: 10px;"><i style="padding-right:5px;color:#f0ad4e;" class="layui-icon">&#xe612;</i><span>驳回</span></div>';
                tipHtml +=
                    '<div style="display: inline-block;margin-left: 10px;"><i style="padding-right:5px;color:#999;" class="layui-icon">&#xe612;</i><span>未处理</span></div></div>';

                $('.GooFlow_work .GooFlow_work_inner').css('background-image', 'none');
                $('td').css('color', '#fff');
                $frmpreview.css('background', '#fff');
                $('.ico').remove();
                $('.GooFlow_item').css('border', '0px');
                $frmpreview.append(tipHtml);
                $.each(options.nodeData,
                    function (i, item) {
                        $("#" + item.id).css("background", "#999");
                        if (item.type == "start round mix") {
                            $("#" + item.id).css("background", "#5cb85c");
                        } else {
                            if (item.id == options.activityId) {
                                $("#" + item.id).css("background", "#5bc0de"); //正在处理
                            }
                            if (item.setInfo != undefined && item.setInfo.Taged != undefined) {
                                if (item.setInfo.Taged == -1) {
                                    $("#" + item.id).css("background", "#d9534f"); //不通过
                                } else if (item.setInfo.Taged == 1) {
                                    $("#" + item.id).css("background", "#5cb85c"); //通过
                                } else {
                                    $("#" + item.id).css("background", "#f0ad4e"); //驳回
                                }
                            }
                        }
                        if (item.setInfo != undefined && item.setInfo.Taged != undefined) {
                            var tips = '<div style="text-align:left">';
                            var tagname = { "-1": "不通过", "1": "通过", "0": "驳回" };
                            tips += "<p>处理人：" + item.setInfo.UserName + "</p>";
                            tips += "<p>结果：" + tagname[item.setInfo.Taged] + "</p>";
                            tips += "<p>处理时间：" + item.setInfo.TagedTime + "</p>";
                            tips += "<p>备注：" + item.setInfo.Description + "</p></div>";

                            $('#' + item.id).click(function () {
                                layer.tips(tips, '#' + item.id);
                            });
                        } else {
                            $('#' + item.id).click(function () {
                                layer.tips('暂无处理信息', '#' + item.id);
                            });
                        }
                    });
            }
            if (options.preview == 1) {
                preview();
            }

            //预览
            function preview() {
                var _frmitems = {};
                for (var i in options.frmData) {
                    var _frmitem = options.frmData[i];
                    _frmitems[_frmitem.control_field] = _frmitem.control_label;
                }
                var DataBaseLinkData = {};


                var _NodeRejectType = { "0": "前一步", "1": "第一步", "2": "某一步", "3": "用户指定", "4": "不处理" };
                var _NodeIsOver = { "0": "不允许", "1": "允许" };
                var _NodeDesignate = {
                    "NodeDesignateType1": "所有成员",
                    "NodeDesignateType2": "指定成员",
                    "NodeDesignateType3": "发起者领导",
                    "NodeDesignateType4": "前一步骤领导",
                    "NodeDesignateType5": "发起者部门领导",
                    "NodeDesignateType6": "发起者公司领导"
                };
                var _NodeConfluenceType = { "0": "所有步骤通过", "1": "一个步骤通过即可", "2": "按百分比计算" };
                if (options.flowcontent == undefined) return;
                $.each(options.flowcontent.nodes,
                    function (i, item) {
                        if (item.setInfo != undefined) {
                            var _popoverhtml = "";
                            _popoverhtml +=
                                '<div class="flow-portal-panel-title"><i class="fa fa-navicon"></i>&nbsp;&nbsp;基本信息</div>';
                            _popoverhtml += '<ul>';
                            _popoverhtml += '<li>节点标识:' + item.setInfo.NodeCode + '</li>';
                            _popoverhtml += '<li>驳回类型:' + _NodeRejectType[item.setInfo.NodeRejectType] + '</li>';
                            _popoverhtml += '<li>终止流程:' + _NodeIsOver[item.setInfo.NodeIsOver] + '</li>';
                            if (item.setInfo.Description != "") {
                                _popoverhtml += '<li>备注:' + item.setInfo.Description + '</li>';
                            }
                            if (item.setInfo.NodeConfluenceType != "") {
                                _popoverhtml += '<li>会签策略:' +
                                    _NodeConfluenceType[item.setInfo.NodeConfluenceType] +
                                    '</li>';
                                if (item.setInfo.NodeConfluenceType == 2) {
                                    _popoverhtml += '<li>会签比例:' + item.setInfo.NodeConfluenceRate + '</li>';
                                }
                            }
                            if (item.setInfo.NodeDataBase != "") {
                                _popoverhtml += '<li>绑定数据库:' + DataBaseLinkData[item.setInfo.NodeDataBase] + '</li>';
                            }
                            if (item.setInfo.NodeTable != "") {
                                _popoverhtml += '<li>绑定表名:' + item.setInfo.NodeTable + '</li>';
                            }
                            if (item.setInfo.NodePram != "") {
                                _popoverhtml += '<li>绑定字段:' + item.setInfo.NodePram + '</li>';
                            }
                            _popoverhtml += '</ul>';

                            _popoverhtml +=
                                '<div class="flow-portal-panel-title"><i class="fa fa-navicon"></i>&nbsp;&nbsp;审核者</div>';
                            _popoverhtml += '<ul>';
                            _popoverhtml += '<li>类型:' + _NodeDesignate[item.setInfo.NodeDesignate] + '</li>';
                            if (item.setInfo.NodeDesignateData != undefined) {
                                var _rowstr = "";
                                for (var i in item.setInfo.NodeDesignateData.roles) {
                                    var _postitem = item.setInfo.NodeDesignateData.roles[i];
                                    var _one = top.clientroleData[_postitem];
                                    _rowstr += ' <span class="label label-success">' +
                                        (_one == undefined ? _postitem : _one.FullName) +
                                        '</span>';
                                    if (i == item.setInfo.NodeDesignateData.roles.length - 1) {
                                        _popoverhtml += '<li>角色:' + _rowstr + '</li>';
                                    }
                                }

                                _rowstr = "";
                                for (var i in item.setInfo.NodeDesignateData.users) {
                                    var _postitem = item.setInfo.NodeDesignateData.users[i];
                                    var _one = clientuserData[_postitem];
                                    _rowstr += ' <span class="label label-danger">' +
                                        (_one == undefined ? _postitem : _one.RealName) +
                                        '</span>';
                                    if (i == item.setInfo.NodeDesignateData.users.length - 1) {
                                        _popoverhtml += '<li>用户:' + _rowstr + '</li>';
                                    }
                                }
                            }
                            _popoverhtml += '</ul>';

                            var _row = "";
                            for (var i in item.setInfo.frmPermissionInfo) {
                                var _item = item.setInfo.frmPermissionInfo[i];
                                var _downtext = "";
                                if (_item.down) {
                                    _downtext = ' | 可下载';
                                } else if (_item.down != undefined) {
                                    _downtext = ' | 不可下载';
                                }
                                _row += '<li>' +
                                    _frmitems[_item.fieldid] +
                                    ': ' +
                                    (_item.look ? '可查看' : '不可查看') +
                                    _downtext +
                                    '</li>';
                                if (i == item.setInfo.frmPermissionInfo.length - 1) {
                                    _popoverhtml +=
                                        '<div class="flow-portal-panel-title"><i class="fa fa-navicon"></i>&nbsp;&nbsp;权限分配</div>';
                                    _popoverhtml += '<ul>';
                                    _popoverhtml += _row;
                                    _popoverhtml += '</ul>';
                                }
                            }

                            if (item.setInfo.NodeDataBaseToSQL != "" || item.setInfo.NodeSQL != "") {
                                _popoverhtml +=
                                    '<div class="flow-portal-panel-title"><i class="fa fa-navicon"></i>&nbsp;&nbsp;执行SQL</div>';
                                _popoverhtml += '<ul>';
                                _popoverhtml += '<li>数据库:' + DataBaseLinkData[item.setInfo.NodeDataBaseToSQL] + '</li>';
                                _popoverhtml += '<li>SQL语句:' + item.setInfo.NodeSQL + '</li>';
                                _popoverhtml += '</ul>';
                            }

                            $('#' + item.id).attr('title', item.name);
                            $('#' + item.id).attr('data-toggle', 'popover');
                            $('#' + item.id).attr('data-placement', 'bottom');
                            $('#' + item.id).attr('data-content', _popoverhtml);
                        } else {
                            $('#' + item.id).attr('title', item.name);
                            $('#' + item.id).attr('data-toggle', 'popover');
                            $('#' + item.id).attr('data-placement', 'bottom');
                            $('#' + item.id).attr('data-content', "该节点未被设置");
                        }
                    });
                //$('.GooFlow_item').popover({ html: true });
            }

           return flowPanel;
        }

        exports('flowlayout');
    });





