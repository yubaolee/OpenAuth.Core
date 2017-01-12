//初始化设计流程器
$.fn.flowdesign = function (options) {
    var $frmpreview = $(this);
    if (!$frmpreview.attr('id')) {
        return false;
    }
    var FlowPanel;
    $frmpreview.html("");
    var defaults = {
        flowcontent: "",
        frmtype: 0,//自定义表单0,系统表单1
        frmData: "",
        width: $(window).width(),
        height: $(window).height() + 2,
        OpenNode: function () { return false},
        OpenLine: function () { return false },
        NodeRemarks: {
            cursor: "选择指针",
            direct: "步骤连线",
            startround: "开始节点",
            endround: "结束节点",
            stepnode: "普通节点",
            shuntnode: "分流节点",
            confluencenode: "合流节点",
            group: "区域规划"
        },
        haveTool:true,
        toolBtns: ["startround", "endround", "stepnode", "shuntnode", "confluencenode"],
        isprocessing: false,
        nodeData: null,
        activityId: "",
        preview:0
    };
    var options = $.extend(defaults, options);
    FlowPanel = $.createGooFlow($(this), {
        width: options.width,
        height: options.height,
        haveHead: true,
        headBtns: ["undo", "redo"],
        haveTool: options.haveTool,
        toolBtns: options.toolBtns,
        haveGroup: true,
        useOperStack: true
    });
    FlowPanel.setNodeRemarks(options.NodeRemarks);
    FlowPanel.loadData(options.flowcontent);
    OpenNode = options.OpenNode;
    OpenLine = options.OpenLine;
    //导出数据扩展方法
    //所有节点必须有进出线段
    //必须有开始结束节点（且只能为一个）
    //分流合流节点必须成对出现
    //分流合流节点必须一一对应且中间必须有且只能有一个普通节点
    //分流节点与合流节点之前的审核节点必须有且只能有一条出去和进来节点
    FlowPanel.exportDataEx = function () {
        var _data = FlowPanel.exportData();
        var _fromlines = {}, _tolines = {}, _nodes = {}, _fnodes = [], _hnodes = [], _startroundFlag = 0, _endroundFlag = 0;
        for (var i in _data.lines)
        {
            if (_fromlines[_data.lines[i].from] == undefined)
            {
                _fromlines[_data.lines[i].from] = [];
            }
            _fromlines[_data.lines[i].from].push(_data.lines[i].to);

            if (_tolines[_data.lines[i].to] == undefined) {
                _tolines[_data.lines[i].to] = [];
            }
            _tolines[_data.lines[i].to].push(_data.lines[i].from);
        }
        for (var j in _data.nodes)
        {
            var _node = _data.nodes[j];
            var _flag = false;
            switch (_node.type)
            {
                case "startround":
                    _startroundFlag++;
                    if (_fromlines[_node.id] == undefined) {
                        dialogTop("开始节点无法流转到下一个节点", "error");
                        return -1;
                    }
                    break;
                case "endround":
                    _endroundFlag++;
                    if ( _tolines[_node.id] == undefined) {
                        dialogTop("无法流转到结束节点", "error");
                        return -1;
                    }
                    break;
                case "stepnode":
                    _flag = true;
                    break;
                case "shuntnode":
                    _flag = true;
                    _fnodes.push(_node.id);
                    break;
                case "confluencenode":
                    _hnodes.push(_node.id);
                    _flag = true;
                    break;
                default:
                    dialogTop("节点数据异常,请重新登录下系统！", "error");
                    return -1;
                    break;
            }
            if (_flag)
            {
                if (_tolines[_node.id] == undefined) {
                    labellingRedNode(_node.id);
                    dialogTop("标注红色的节点没有【进来】的连接线段", "error");
                    return -1;
                }
                if (_fromlines[_node.id] == undefined) {
                    labellingRedNode(_node.id);
                    dialogTop("标注红色的节点没有【出去】的连接线段", "error");
                    return -1;
                }
            }
            _nodes[_node.id] = _node;
        }
        if (_startroundFlag == 0) {
            dialogTop("必须有开始节点", "error");
            return -1;
        }

        if (_endroundFlag == 0)
        {
            dialogTop("必须有结束节点", "error");
            return -1;
        }

        if (_fnodes.length != _hnodes.length)
        {
            dialogTop("分流节点必须等于合流节点", "error");
            return -1;
        }
        for (var a in _fnodes) {
            var aNondeid = _fnodes[a];
            if (_fromlines[aNondeid].length == 1) {
                labellingRedNode(aNondeid);
                dialogTop("标注红色的分流节点不允许只有一条【出去】的线段", "error");
                return -1;
            }
            var _hhnodeid = {};
            for (var b in _fromlines[aNondeid])
            {
                btoNode = _fromlines[aNondeid][b];
                if (_nodes[btoNode].type == "stepnode") {
                    var _nextLine = _fromlines[_nodes[btoNode].id];
                    
                    var _nextNode = _nodes[_nextLine[0]];
                    if (_nextNode.type != "confluencenode") {
                        labellingRedNode(_nodes[btoNode].id);
                        dialogTop("标注红色的普通节点下一个节点必须是合流节点", "error");
                        return -1;
                    }
                    else {
                        _hhnodeid[_nextLine[0]] = 0;
                        if (_hhnodeid.length > 1) {
                            labellingRedNode(aNondeid);
                            dialogTop("标注红色的分流节点与之对应的合流节点只能有一个", "error");
                            return -1;
                        }
                        if (_tolines[_nextLine[0]].length != _fromlines[aNondeid].length) {
                            labellingRedNode(_nextLine[0]);
                            dialogTop("标注红色的合流节点与之对应的分流节点只能有一个", "error");
                            return -1;
                        }
                    }
                    if (_nextLine.length > 1) {
                        labellingRedNode(_nodes[btoNode].id);
                        dialogTop("标注红色的节点只能有一条出去的线条【分流合流之间】", "error");
                        return -1;
                    }
                    else if (_tolines[_nodes[btoNode].id],length > 1) {
                        labellingRedNode(_nodes[btoNode].id);
                        dialogTop("标注红色的节点只能有一条进来的线条【分流合流之间】", "error");
                        return -1;
                    }
                }
                else {
                    labellingRedNode(aNondeid);
                    dialogTop("标注红色的分流节点必须经过一个普通节点到合流节点", "error");
                    return -1;
                }
            }
            
        }
        return _data;
    }
    FlowPanel.SetNodeEx = function (id,data) {
        FlowPanel.setName(id, data.NodeName, "node", data);
    }
    FlowPanel.SetLineEx = function (id, data) {
        FlowPanel.setName(id, data.LineName, "line", data);
    }
    if (options.isprocessing)//如果是显示进程状态
    {
        var tipHtml = '<div style="position:absolute;left:10px;margin-top: 10px;padding:10px;border-radius:5px;background:rgba(0,0,0,0.05);z-index:1000;display:inline-block;">';
        tipHtml += '<div style="display: inline-block;"><i style="padding-right:5px;color:#5cb85c;" class="fa fa-flag"></i><span>已处理</span></div>';
        tipHtml += '<div style="display: inline-block;margin-left: 10px;"><i style="padding-right:5px;color:#5bc0de;" class="fa fa-flag"></i><span>正在处理</span></div>';
        tipHtml += '<div style="display: inline-block;margin-left: 10px;"><i style="padding-right:5px;color:#d9534f;" class="fa fa-flag"></i><span>不通过</span></div>';
        tipHtml += '<div style="display: inline-block;margin-left: 10px;"><i style="padding-right:5px;color:#f0ad4e;" class="fa fa-flag"></i><span>驳回</span></div>';
        tipHtml += '<div style="display: inline-block;margin-left: 10px;"><i style="padding-right:5px;color:#999;" class="fa fa-flag"></i><span>未处理</span></div></div>';

        $frmpreview.find('.GooFlow_work .GooFlow_work_inner').css('background-image', 'none');
        $frmpreview.find('td').css('color', '#fff');
        $frmpreview.css('background', '#fff');
        $frmpreview.find('.ico').remove();
        $frmpreview.find('.GooFlow_item').css('border', '0px');
        $frmpreview.append(tipHtml);
        $.each(options.nodeData, function (i, item) {
            $frmpreview.find("#" + item.id).css("background", "#999");
            if (item.type == "startround") {
                $frmpreview.find("#" + item.id).css("background", "#5cb85c");
            }
            else {
                if (item.id == options.activityId) {
                    $frmpreview.find("#" + item.id).css("background", "#5bc0de");//正在处理
                }
                if (item.setInfo != undefined && item.setInfo.Taged != undefined) {
                    if (item.setInfo.Taged == -1) {
                        $frmpreview.find("#" + item.id).css("background", "#d9534f");//不通过
                    }
                    else if (item.setInfo.Taged == 1) {
                        $frmpreview.find("#" + item.id).css("background", "#5cb85c");//通过
                    }
                    else {
                        $frmpreview.find("#" + item.id).css("background", "#f0ad4e");//驳回
                    }
                }
            }
            if (item.setInfo != undefined && item.setInfo.Taged != undefined)
            {
                var _one = top.clientuserData[item.setInfo.UserId];
                var _row = '<div style="text-align:left">';
                var tagname = { "-1": "不通过", "1": "通过", "0": "驳回" };
                _row += "<p>处理人：" + (_one == undefined ? item.setInfo.UserId : _one.RealName)+"</p>";
                _row += "<p>结果：" + tagname[item.setInfo.Taged] + "</p>";
                _row += "<p>处理时间：" + item.setInfo.TagedTime + "</p>";
                _row += "<p>备注：" + item.setInfo.description + "</p></div>";

                $frmpreview.find('#' + item.id).attr('data-toggle', 'tooltip');
                $frmpreview.find('#' + item.id).attr('data-placement', 'bottom');
                $frmpreview.find('#' + item.id).attr('title', _row);
            }
        });
        $('[data-toggle="tooltip"]').tooltip({"html":true});
    }
    if (options.preview == 1)
    {
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
        $.ajax({
            url: "../../SystemManage/DataBaseLink/GetListJson",
            type: "get",
            dataType: "json",
            async: false,
            success: function (data) {
                for (var i in data) {
                    DataBaseLinkData[data[i].DatabaseLinkId] = data[i].DBAlias;
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                dialogMsg(errorThrown, -1);
            }
        });

        var _NodeRejectType = { "0": "前一步", "1": "第一步", "2": "某一步", "3": "用户指定", "4": "不处理" };
        var _NodeIsOver = { "0": "不允许", "1": "允许" };
        var _NodeDesignate = { "NodeDesignateType1": "所有成员", "NodeDesignateType2": "指定成员", "NodeDesignateType3": "发起者领导", "NodeDesignateType4": "前一步骤领导", "NodeDesignateType5": "发起者部门领导", "NodeDesignateType6": "发起者公司领导" };
        var _NodeConfluenceType = { "0": "所有步骤通过", "1": "一个步骤通过即可", "2": "按百分比计算" };
        $.each(options.flowcontent.nodes, function (i, item) {
            if (item.setInfo != undefined) {
                var _popoverhtml = "";
                _popoverhtml += '<div class="flow-portal-panel-title"><i class="fa fa-navicon"></i>&nbsp;&nbsp;基本信息</div>';
                _popoverhtml += '<ul>';
                _popoverhtml += '<li>节点标识:' + item.setInfo.NodeCode + '</li>';
                _popoverhtml += '<li>驳回类型:' + _NodeRejectType[item.setInfo.NodeRejectType] + '</li>';
                _popoverhtml += '<li>终止流程:' + _NodeIsOver[item.setInfo.NodeIsOver] + '</li>';
                if (item.setInfo.Description != "") { _popoverhtml += '<li>备注:' + item.setInfo.Description + '</li>'; }
                if (item.setInfo.NodeConfluenceType != "") {
                    _popoverhtml += '<li>会签策略:' + _NodeConfluenceType[item.setInfo.NodeConfluenceType] + '</li>';
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

                _popoverhtml += '<div class="flow-portal-panel-title"><i class="fa fa-navicon"></i>&nbsp;&nbsp;审核者</div>';
                _popoverhtml += '<ul>';
                _popoverhtml += '<li>类型:' + _NodeDesignate[item.setInfo.NodeDesignate] + '</li>';
                if (item.setInfo.NodeDesignateData != undefined) {
                    var _rowstr = "";
                    for (var i in item.setInfo.NodeDesignateData.role) {
                        var _postitem = item.setInfo.NodeDesignateData.role[i];
                        var _one = top.clientroleData[_postitem];
                        _rowstr += ' <span class="label label-success">' + (_one == undefined ? _postitem : _one.FullName) + '</span>';
                        if (i == item.setInfo.NodeDesignateData.role.length - 1) {
                            _popoverhtml += '<li>角色:' + _rowstr + '</li>';
                        }
                    }

                    _rowstr = "";
                    for (var i in item.setInfo.NodeDesignateData.post) {
                        var _postitem = item.setInfo.NodeDesignateData.post[i];
                        var _one = top.clientpostData[_postitem];
                        _rowstr += ' <span class="label label-info">' + (_one == undefined ? _postitem : _one.FullName) + '</span>';
                        if (i == item.setInfo.NodeDesignateData.post.length - 1) {
                            _popoverhtml += '<li>岗位:' + _rowstr + '</li>';
                        }
                    }

                    _rowstr = "";
                    for (var i in item.setInfo.NodeDesignateData.usergroup) {
                        var _postitem = item.setInfo.NodeDesignateData.usergroup[i];
                        var _one = top.clientuserGroup[_postitem];
                        _rowstr += ' <span class="label label-warning">' + (_one == undefined ? _postitem : _one.FullName) + '</span>';
                        if (i == item.setInfo.NodeDesignateData.usergroup.length - 1) {
                            _popoverhtml += '<li>用户组:' + _rowstr + '</li>';
                        }
                    }

                    _rowstr = "";
                    for (var i in item.setInfo.NodeDesignateData.user) {
                        var _postitem = item.setInfo.NodeDesignateData.user[i];
                        var _one = top.clientuserData[_postitem];
                        _rowstr += ' <span class="label label-danger">' + (_one == undefined ? _postitem : _one.RealName) + '</span>';
                        if (i == item.setInfo.NodeDesignateData.user.length - 1) {
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
                    }
                    else if (_item.down != undefined) {
                        _downtext = ' | 不可下载';
                    }
                    _row += '<li>' + _frmitems[_item.fieldid] + ': ' + (_item.look ? '可查看' : '不可查看') + _downtext + '</li>';
                    if (i == item.setInfo.frmPermissionInfo.length - 1) {
                        _popoverhtml += '<div class="flow-portal-panel-title"><i class="fa fa-navicon"></i>&nbsp;&nbsp;权限分配</div>';
                        _popoverhtml += '<ul>';
                        _popoverhtml += _row;
                        _popoverhtml += '</ul>';
                    }
                }

                if (item.setInfo.NodeDataBaseToSQL != "" || item.setInfo.NodeSQL != "") {
                    _popoverhtml += '<div class="flow-portal-panel-title"><i class="fa fa-navicon"></i>&nbsp;&nbsp;执行SQL</div>';
                    _popoverhtml += '<ul>';
                    _popoverhtml += '<li>数据库:' + DataBaseLinkData[item.setInfo.NodeDataBaseToSQL] + '</li>';
                    _popoverhtml += '<li>SQL语句:' + item.setInfo.NodeSQL + '</li>';
                    _popoverhtml += '</ul>';
                }

                $frmpreview.find('#' + item.id).attr('title', item.name);
                $frmpreview.find('#' + item.id).attr('data-toggle', 'popover');
                $frmpreview.find('#' + item.id).attr('data-placement', 'bottom');
                $frmpreview.find('#' + item.id).attr('data-content', _popoverhtml);
            }
            else {
                $frmpreview.find('#' + item.id).attr('title', item.name);
                $frmpreview.find('#' + item.id).attr('data-toggle', 'popover');
                $frmpreview.find('#' + item.id).attr('data-placement', 'bottom');
                $frmpreview.find('#' + item.id).attr('data-content', "该节点未被设置");
            }
        });
        $frmpreview.find('.GooFlow_item').popover({ html: true });
    }

    function labellingRedNode(id)
    {
        $frmpreview.find('.flow-labellingnode-red').removeClass('flow-labellingnode-red');
        $frmpreview.find('#' + id).addClass('flow-labellingnode-red');
    }

    return FlowPanel;
}


