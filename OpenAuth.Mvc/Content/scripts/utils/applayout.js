//表单设计
$.fn.frmDesign = function (options) {
    var $frmdesigh = $(this);
    if (!$frmdesigh.attr('id')) {
        return false;
    }
    var defaults = {
        controlDataJson: [],
        tablefiledJsonData: "",
        frmContent: "",
        Height: 572,
        url: "",
        param: "",
        isSystemTable: 0,//默认是不绑定数据表的
        getData: function (isTest) {
            var postData = [];
            var j = 0;
            var _controlfieldHistory = {};
            for (var i in options.controlDataJson) {
                var rowJson = options.controlDataJson[i];
                if (rowJson.control_field == "" && isTest != true) {
                    dialogTop("请输入字段Id", "error");
                    $("#app_layout_list").find('[data-value=' + i + ']').addClass('activeerror');
                    return false;
                }
                if (rowJson.control_label == "" && isTest != true) {
                    dialogTop("请输入字段名称", "error");
                    $("#app_layout_list").find('[data-value=' + i + ']').addClass('activeerror');
                    return false;
                }
                if (isTest != true)
                {
                    if (_controlfieldHistory[rowJson.control_field] != undefined)
                    {
                        dialogTop("字段Id有重复", "error");
                        return false;
                    }
                    _controlfieldHistory[rowJson.control_field] = "1";
                }

                if (rowJson.control_item != undefined) {
                    var controlitem = [];
                    for (var j in rowJson.control_item) {
                        controlitem.push(rowJson.control_item[j]);
                    }
                    rowJson.control_item = controlitem;
                }
                j++;
                postData.push(rowJson);
            }
            if (j == 0 && isTest != true)
            {
                dialogTop("不能是空表单", "error");
                return false;
            }
            return postData;
        }
    };
    var options = $.extend(defaults, options);

    var divhtml = '<div class="app_body"><div id="move_item_list" class="app_field">';
    divhtml += '<div class="item_row"><i id="text" class="fa fa-italic"></i>文本框</div>';
    divhtml += '<div class="item_row"><i id="textarea" class="fa fa-align-justify"></i>文本区</div>';
    divhtml += '<div class="item_row"><i id="texteditor" class="fa fa-edit"></i>编辑器</div>';

    divhtml += '<div class="item_row"><i id="radio" class="fa fa-circle-thin"></i>单选框</div>';
    divhtml += '<div class="item_row"><i id="checkbox" class="fa fa-square-o"></i>多选框</div>';
    divhtml += '<div class="item_row"><i id="select" class="fa fa-caret-square-o-right"></i>下拉框</div>';
    divhtml += '<div class="item_row"><i id="datetime" class="fa fa-calendar"></i>日期框</div>';

    divhtml += '<div class="item_row"><i id="image" class="fa fa-photo"></i>图片</div>';
    divhtml += '<div class="item_row"><i id="upload" class="fa fa-paperclip"></i>附件</div>';
   // divhtml += '<div class="item_row"><i id="departmentlist" class="fa fa-sitemap"></i>单位组织</div>';
   // divhtml += '<div class="item_row"><i id="dataitemlist" class="fa fa-book"></i>数据字典</div>';
    divhtml += '</div>';

    divhtml += '<div class="app_layout">';
    divhtml += '    <div id="app_layout_list" class="item_table notclose connectedSortable">';
    divhtml += '        <div class="guideareas"></div>';
    divhtml += '    </div>';

    divhtml += '</div>';
    divhtml += '    <div id="app_layout_option" class="field_option notclose">';
    divhtml += '    </div>';
    divhtml += '</div>';
    $frmdesigh.html(divhtml);
    
    
    $frmdesigh.find(".app_body").height(options.Height);
    $frmdesigh.find(".field_option").height(options.Height - 14).css("right", -240);
    $frmdesigh.find(".guideareas").height(options.Height - 33);
    var item_field_value_width = $(window).width() - 558;
    //表单控件拖动
    function formdesigner_move() {
        $("#move_item_list .item_row").draggable({
            connectToSortable: "#app_layout_list",
            helper: "clone",
            revert: "invalid"
        });
        $("#app_layout_list").sortable({
            opacity: 0.4,
            delay: 300,
            cursor: 'move',
            placeholder: "ui-state-highlight",
            stop: function (event, ui) {
                var random_id = String(Math.random()).substr(2);
                var $item_control = null;
                var $this_place = $(ui.item[0]);
                var controltype = $this_place.find('i').attr('id');
                var controlrowJson = {};
                controlrowJson["control_type"] = controltype;
                if (!!controltype) {
                    switch (controltype) {
                        case "text":
                            $item_control = $('<div class="item_field_label"><span>文本框</span></div><div class="item_field_value">文本框</div><div class="item_field_remove"><i  title="移除控件" class="del fa fa-close"></i></div>');
                            controlrowJson["control_label"] = "文本框";
                            controlrowJson["control_field"] = "";
                            controlrowJson["control_verify"] = "";
                            controlrowJson["control_default"] = "";
                            controlrowJson["control_required"] = "0";
                            //controlrowJson["control_only"] = "0";
                            options.controlDataJson[random_id] = controlrowJson;
                            break;
                        case "textarea":
                            $item_control = $('<div class="item_field_label"><span>文本区</span></div><div class="item_field_value">文本区</div><div class="item_field_remove"><i  title="移除控件" class="del fa fa-close"></i></div>');
                            controlrowJson["control_label"] = "文本区";
                            controlrowJson["control_field"] = "";
                            controlrowJson["control_verify"] = "";
                            controlrowJson["control_height"] = "100px";
                            controlrowJson["control_default"] = "";
                            controlrowJson["control_required"] = "0";
                            options.controlDataJson[random_id] = controlrowJson;
                            break;
                        case "texteditor":
                            $item_control = $('<div class="item_field_label"><span>编辑器</span></div><div class="item_field_value">编辑器</div><div class="item_field_remove"><i  title="移除控件" class="del fa fa-close"></i></div>');
                            controlrowJson["control_label"] = "编辑器";
                            controlrowJson["control_field"] = "";
                            controlrowJson["control_verify"] = "";
                            controlrowJson["control_height"] = "200px";
                            controlrowJson["control_default"] = "";
                            controlrowJson["control_required"] = "0";
                            options.controlDataJson[random_id] = controlrowJson;
                            break;
                        case "radio":
                            $item_control = $('<div class="item_field_label"><span>单选项</span></div><div class="item_field_value">单选项/未添加选项</div><div class="item_field_remove"><i  title="移除控件" class="del fa fa-close"></i></div>');
                            controlrowJson["control_label"] = "单选项";
                            controlrowJson["control_field"] = "";
                            controlrowJson["control_item"] = [];
                            controlrowJson["control_required"] = "0";
                            options.controlDataJson[random_id] = controlrowJson;
                            break;
                        case "checkbox":
                            $item_control = $('<div class="item_field_label"><span>多选项</span></div><div class="item_field_value">多选项/未添加选项</div><div class="item_field_remove"><i  title="移除控件" class="del fa fa-close"></i></div>');
                            controlrowJson["control_label"] = "多选项";
                            controlrowJson["control_field"] = "";
                            controlrowJson["control_item"] = [];
                            controlrowJson["control_required"] = "0";
                            options.controlDataJson[random_id] = controlrowJson;
                            break;
                        case "select":
                            $item_control = $('<div class="item_field_label"><span>下拉框</span></div><div class="item_field_value">下拉框/未添加选项</div><div class="item_field_remove"><i  title="移除控件" class="del fa fa-close"></i></div>');
                            controlrowJson["control_label"] = "下拉框";
                            controlrowJson["control_field"] = "";
                            controlrowJson["control_item"] = [];
                            controlrowJson["control_required"] = "0";
                            options.controlDataJson[random_id] = controlrowJson;
                            break;
                        case "datetime":
                            $item_control = $('<div class="item_field_label"><span>日期框</span></div><div class="item_field_value">年-月-日</div><div class="item_field_remove"><i  title="移除控件" class="del fa fa-close"></i></div>');
                            controlrowJson["control_label"] = "日期框";
                            controlrowJson["control_field"] = "";
                            controlrowJson["control_dateformat"] = "date";
                            controlrowJson["control_default"] = "";
                            controlrowJson["control_required"] = "0";
                            options.controlDataJson[random_id] = controlrowJson;
                            break;
                        case "image":
                            $item_control = $('<div class="item_field_label"><span>上传图片</span></div><div class="item_field_value">上传图片/jpg,gif,png,bmp</div><div class="item_field_remove"><i  title="移除控件" class="del fa fa-close"></i></div>');
                            controlrowJson["control_label"] = "上传图片";
                            controlrowJson["control_field"] = "";
                            controlrowJson["control_fileformat"] = "jpg,gif,png,bmp";
                            controlrowJson["control_required"] = "0";
                            options.controlDataJson[random_id] = controlrowJson;
                            break;
                        case "upload":
                            $item_control = $('<div class="item_field_label"><span>上传文件</span></div><div class="item_field_value">上传文件/doc,xls,ppt,pdf</div><div class="item_field_remove"><i  title="移除控件" class="del fa fa-close"></i></div>');
                            controlrowJson["control_label"] = "上传文件";
                            controlrowJson["control_field"] = "";
                            controlrowJson["control_fileformat"] = "doc,xls,ppt,pdf";
                            controlrowJson["control_required"] = "0";
                            options.controlDataJson[random_id] = controlrowJson;
                            break;
                        case "departmentlist":
                            break;
                        case "dataitemlist":
                            break;
                        default:
                            break;
                    }
                    if ($item_control) {
                        $this_place.html($item_control);
                        $this_place.find('.item_field_value').width(item_field_value_width);
                        $this_place.attr('data-value', random_id)
                        item_rowclick();
                        $this_place.trigger("click");
                    }
                } else {
                    $this_place.trigger("click");
                }
            },
            start: function (event, ui) {
                $(".guideareas").hide()
                $(".ui-state-highlight").html('拖放控件到这里');
                $(".field_option").hide();
                $("#app_layout_list .item_row").removeClass('active')
            },
            out: function (event, ui) {
                if (ui.helper != null) {
                    var falg = true;
                    for (item in options.controlDataJson) {
                        falg = false;
                        break;
                    }
                    if (falg) {
                        $(".guideareas").show();
                    }
                }
            }
        });
        item_rowclick();
        function item_rowclick() {
            $("#app_layout_list .item_row").find('.item_field_remove i').click(function () {
                var $item_row = $(this).parents('.item_row');
                delete options.controlDataJson[$item_row.attr('data-value')];
                $item_row.remove();
                $(".field_option").animate({ right: -240, speed: 2000 });
                var falg = true;
                for (item in options.controlDataJson) {
                    falg = false;
                    break;
                }
                if (falg) {
                    $(".guideareas").show();
                }
            });//移除空件
            $("#app_layout_list .item_row").unbind('click');
            $("#app_layout_list .item_row").click(function () {
                var $this = $(this);
                var $field_option = $(".field_option");
                $("#app_layout_list .item_row").removeClass('active').removeClass('activeerror');
                $this.addClass('active');
                $('.field_option').animate({ right: 0, speed: 2000 }).show();
                initControlProperty($this);
            });
            document.onclick = function (event) {
                try
                {
                    var _event = event ? event : window.event;
                    var _target = _event.target ? _event.target : _event.srcElement;
                    var className = "";
                    while (className != "app_body") {
                        className = _target.className;
                        if (className == undefined || className.indexOf("notclose") > 0) {
                            break;
                        }
                        _target = _target.parentNode;
                        if (_target == null) {
                            break;
                        }
                    }
                    if (className != undefined && className.indexOf("notclose") < 0 && _target != null) {
                        $(".field_option").animate({ right: -240, speed: 2000 });
                        $("#app_layout_list .item_row").removeClass('active').removeClass('activeerror');
                    }
                }
                catch(e)
                {
                    
                }
            };
        }
        //初始化控件属性
        function initControlProperty(e) {
            var rowJson = options.controlDataJson[e.attr('data-value')];
            if (rowJson) {
                switch (rowJson.control_type) {
                    case "text":
                        textProperty(e);
                        break;
                    case "textarea":
                        textareaProperty(e);
                        break;
                    case "texteditor":
                        texteditorProperty(e);
                        break;
                        break;
                    case "radio":
                        radioProperty(e);
                        break;
                    case "checkbox":
                        checkboxProperty(e);
                        break;
                    case "select":
                        selectProperty(e);
                        break;
                    case "datetime":
                        datetimeProperty(e);
                        break;
                    case "image":
                        imageProperty(e);
                        break;
                    case "upload":
                        uploadProperty(e);
                        break;
                    case "departmentlist":
                        break;
                    case "dataitemlist":
                        break;
                    default:
                        break;
                }
            } else {
                //$(".field_option").html("");
            }
        }
        //获取表单
        if (options.frmContent != "" && options.frmContent != null)
        {
            frmToHtml(options.frmContent);
        }
        else if (options.url != "") {
            $.ajax({
                url: options.url,
                data: options.param,
                type: "GET",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.FrmContent != null)
                    {
                        frmToHtml(data.FrmContent);
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    dialogMsg(errorThrown, -1);
                }
            });
        }
        //json=>html
        function frmToHtml(frmContent) {
            var frmContentJson = eval('(' + frmContent + ')');
            var num = 0;
            $app_layout_list = $('#app_layout_list');
            $.each(frmContentJson, function (id, item) {
                $(".guideareas").hide();
                var random_id = String(Math.random()).substr(2);
                options.controlDataJson[random_id] = item;
                var controlitemstr = "";
                if (item.control_item != undefined) {
                    var controlitem = [];
                    $.each(item.control_item, function (i, n) {
                        controlitem[n.identify] = n;
                        if (controlitemstr != "") {
                            controlitemstr += "、";
                        }
                        controlitemstr += n.name;
                    });
                    options.controlDataJson[random_id].control_item = controlitem;
                }
                var controlrequired = item.control_required == '1' ? '<font face="宋体">*</font>' : '';
                var _item_field_value = "";
                switch (item.control_type) {
                    case "text":
                        _item_field_value = "文本框";
                        break;
                    case "textarea":
                        _item_field_value = "文本区";
                        break;
                    case "texteditor":
                        _item_field_value = "编辑器";
                        break;
                    case "radio":
                        _item_field_value = "单选项/";
                        break;
                    case "checkbox":
                        _item_field_value = "多选项/";
                        break;
                    case "select":
                        _item_field_value = "下拉框/";
                        break;
                    case "datetime":
                        _item_field_value = "年-月-日";
                        break;
                    case "image":
                        _item_field_value = "上传图片/" + item.control_fileformat;
                        break;
                    case "upload":
                        _item_field_value = "上传文件/"+  item.control_fileformat;
                        break;
                    case "departmentlist":
                        break;
                    case "dataitemlist":
                        break;
                    default:
                        break;
                }
                var $item_control = $('<div class="item_row ui-draggable" ><div class="item_field_label"><span>' + item.control_label + '</span>' + controlrequired + '</div><div class="item_field_value">' + _item_field_value + controlitemstr + '</div><div class="item_field_remove"><i  title="移除控件" class="del fa fa-close"></i></div></div>');
                if ($item_control) {
                    $item_control.attr('data-value', random_id);
                    $app_layout_list.append($item_control);
                    item_rowclick();
                    if (num == 0) {
                        $item_control.trigger("click");
                    }
                    num++;
                }
            });
            $app_layout_list.find('.item_field_value').width(item_field_value_width);
        }
    }
    formdesigner_move();
   

    function textProperty(e_row) {
        var _html = '';
        _html += '<div class="field_tips"><i class="fa fa-info-circle"></i><span>无样式的单行文本框</span></div>';
        _html += '<div class="field_title">字段标识</div>';
        _html += '<div class="field_control"><div id="control_field" type="select" class="ui-select"></div></div>';//<input id="control_field" type="text" class="form-control" placeholder="必填项"/>
        _html += '<div class="field_title">字段说明</div>';
        _html += '<div class="field_control"><input id="control_label" type="text" class="form-control" placeholder="必填项"/></div>';
        _html += '<div class="field_title">字段验证</div>';
        _html += '<div class="field_control"><select id="control_verify" class="form-control"><option value="">==请选择==</option><option value="Num">数字</option><option value="Double">小数</option><option value="Phone">必须电话格式</option><option value="Mobile">手机格式</option><option value="Email">电子邮件格式</option><option value="IDCard">身份证格式</option></select></div>';
        _html += '<div class="field_title">默认值<i title="仅在添加数据时默认填入" class="help fa fa-question-circle"></i></div>';
        _html += '<div class="field_control"><input id="control_default" type="text" class="form-control" placeholder="无则不填"/></div>';
        _html += '<div class="field_title">设置</div>';
        _html += '<div class="field_control"><div class="checkbox notclose" style="padding-left: 3px;"><label><input id="control_required" type="checkbox" />必填</label></div></div>';//<label><input id="control_only" type="checkbox" />唯一<i title="字段中填入的值不可重复" class="help fa fa-question-circle"></i></label>
        var $html = $(_html);
        $(".field_option").html($html);
        var rowJson = options.controlDataJson[e_row.attr('data-value')];
        if (rowJson == null) {
            return false;
        }
        setControlField(rowJson, e_row, $html);
        $html.find('#control_label').val(rowJson.control_label);
        $html.find('#control_verify').val(rowJson.control_verify);
        $html.find('#control_default').val(rowJson.control_default);
        if (rowJson.control_required == 1) {
            $html.find('#control_required').attr("checked", 'checked');
        } else {
            $html.find('#control_required').removeAttr("checked");
        }
        $html.find('#control_label').keyup(function (e) {
            var value = $(this).val();
            e_row.find('.item_field_label').find('span').html(value);
            rowJson[$(this).attr('id')] = value;
            options.controlDataJson[e_row.attr('data-value')] = rowJson;
        });
        $html.find('#control_verify').change(function (e) {
            var value = $(this).val();
            rowJson[$(this).attr('id')] = value;
            options.controlDataJson[e_row.attr('data-value')] = rowJson;
        });
        $html.find('#control_default').keyup(function (e) {
            var value = $(this).val();
            rowJson[$(this).attr('id')] = value;
            options.controlDataJson[e_row.attr('data-value')] = rowJson;
        });
        $html.find('#control_required').click(function (e) {
            var value = 0;
            if ($(this).attr("checked")) {
                value = 0;
                $(this).attr("checked", false);
                e_row.find('.item_field_label').find('font').remove();
            } else {
                value = 1;
                $(this).attr("checked", true);
                e_row.find('.item_field_label').append('<font face="宋体">*</font>');
            }
            rowJson[$(this).attr('id')] = value;
            options.controlDataJson[e_row.attr('data-value')] = rowJson;
        });
        //$html.find('#control_only').click(function (e) {
        //    var value = 0;
        //    if ($(this).attr("checked")) {
        //        $(this).attr("checked", false);
        //        value = 0;
        //    } else {
        //        $(this).attr("checked", true);
        //        value = 1;
        //    }
        //    rowJson[$(this).attr('id')] = value;
        //    controlDataJson[e_row.attr('data-value')] = rowJson;
        //});
    }
    function textareaProperty(e_row) {
        var _html = '';
        _html += '<div class="field_tips"><i class="fa fa-info-circle"></i><span>无样式的多行文本框</span></div>';
        _html += '<div class="field_title">字段标识</div>';
        _html += '<div class="field_control"><div id="control_field" type="select" class="ui-select"></div></div>';
        _html += '<div class="field_title">字段说明</div>';
        _html += '<div class="field_control"><input id="control_label" type="text" class="form-control" placeholder="必填项"></div>';
        _html += '<div class="field_title">字段高度</div>';
        _html += '<div class="field_control"><input id="control_height" type="text" class="form-control" value="100px"></div>';
        _html += '<div class="field_title">默认值<i title="仅在添加数据时默认填入" class="help fa fa-question-circle"></i></div>';
        _html += '<div class="field_control"><input id="control_default" type="text" class="form-control" placeholder="无则不填"></div>';
        _html += '<div class="field_title">设置</div>';
        _html += '<div class="field_control"><div class="checkbox notclose" style="padding-left: 3px;"><label><input id="control_required" type="checkbox">必填</label></div></div>';
        var $html = $(_html);
        $(".field_option").html($html);
        var rowJson = options.controlDataJson[e_row.attr('data-value')];
        if (rowJson == null) {
            return false;
        }
        setControlField(rowJson, e_row, $html);
        $html.find('#control_label').val(rowJson.control_label);
        $html.find('#control_verify').val(rowJson.control_verify);
        $html.find('#control_height').val(rowJson.control_height);
        $html.find('#control_default').val(rowJson.control_default);
        if (rowJson.control_required == 1) {
            $html.find('#control_required').attr("checked", 'checked');
        } else {
            $html.find('#control_required').removeAttr("checked");
        }
        $html.find('#control_label').keyup(function (e) {
            var value = $(this).val();
            e_row.find('.item_field_label').find('span').html(value);
            rowJson[$(this).attr('id')] = value;
            options.controlDataJson[e_row.attr('data-value')] = rowJson;
        });
        $html.find('#control_verify').change(function (e) {
            var value = $(this).val();
            rowJson[$(this).attr('id')] = value;
            options.controlDataJson[e_row.attr('data-value')] = rowJson;
        });
        $html.find('#control_height').change(function (e) {
            var value = $(this).val();
            rowJson[$(this).attr('id')] = value;
            options.controlDataJson[e_row.attr('data-value')] = rowJson;
        });
        $html.find('#control_default').keyup(function (e) {
            var value = $(this).val();
            rowJson[$(this).attr('id')] = value;
            options.controlDataJson[e_row.attr('data-value')] = rowJson;
        });
        $html.find('#control_required').click(function (e) {
            var value = 0;
            if ($(this).attr("checked")) {
                value = 0;
                $(this).attr("checked", false);
                e_row.find('.item_field_label').find('font').remove();
            } else {
                value = 1;
                $(this).attr("checked", true);
                e_row.find('.item_field_label').append('<font face="宋体">*</font>');
            }
            rowJson[$(this).attr('id')] = value;
            options.controlDataJson[e_row.attr('data-value')] = rowJson;
        });
    }
    function texteditorProperty(e_row) {
        var _html = '';
        _html += '<div class="field_tips"><i class="fa fa-info-circle"></i><span>类似word，可设置丰富文字样式的多行文本编辑区</span></div>';
        _html += '<div class="field_title">字段标识</div>';
        _html += '<div class="field_control"><div id="control_field" type="select" class="ui-select"></div></div>';
        _html += '<div class="field_title">字段说明</div>';
        _html += '<div class="field_control"><input id="control_label" type="text" class="form-control" placeholder="必填项"></div>';
        _html += '<div class="field_title">字段高度</div>';
        _html += '<div class="field_control"><input id="control_height" type="text" class="form-control" value="200px"></div>';
        _html += '<div class="field_title">默认值<i title="仅在添加数据时默认填入" class="help fa fa-question-circle"></i></div>';
        _html += '<div class="field_control"><input id="control_default" type="text" class="form-control" placeholder="无则不填"></div>';
        _html += '<div class="field_title">设置</div>';
        _html += '<div class="field_control"><div class="checkbox notclose" style="padding-left: 3px;"><label><input id="control_required" type="checkbox">必填</label></div></div>';
        var $html = $(_html);
        $(".field_option").html($html);
        var rowJson = options.controlDataJson[e_row.attr('data-value')];
        if (rowJson == null) {
            return false;
        }
        setControlField(rowJson, e_row, $html);
        $html.find('#control_label').val(rowJson.control_label);
        $html.find('#control_verify').val(rowJson.control_verify);
        $html.find('#control_height').val(rowJson.control_height);
        $html.find('#control_default').val(rowJson.control_default);
        if (rowJson.control_required == 1) {
            $html.find('#control_required').attr("checked", 'checked');
        } else {
            $html.find('#control_required').removeAttr("checked");
        }

        $html.find('#control_label').keyup(function (e) {
            var value = $(this).val();
            e_row.find('.item_field_label').find('span').html(value);
            rowJson[$(this).attr('id')] = value;
            options.controlDataJson[e_row.attr('data-value')] = rowJson;
        });
        $html.find('#control_verify').change(function (e) {
            var value = $(this).val();
            rowJson[$(this).attr('id')] = value;
            options.controlDataJson[e_row.attr('data-value')] = rowJson;
        });
        $html.find('#control_height').change(function (e) {
            var value = $(this).val();
            rowJson[$(this).attr('id')] = value;
            options.controlDataJson[e_row.attr('data-value')] = rowJson;
        });
        $html.find('#control_default').keyup(function (e) {
            var value = $(this).val();
            rowJson[$(this).attr('id')] = value;
            options.controlDataJson[e_row.attr('data-value')] = rowJson;
        });
        $html.find('#control_required').click(function (e) {
            var value = 0;
            if ($(this).attr("checked")) {
                value = 0;
                $(this).attr("checked", false);
                e_row.find('.item_field_label').find('font').remove();
            } else {
                value = 1;
                $(this).attr("checked", true);
                e_row.find('.item_field_label').append('<font face="宋体">*</font>');
            }
            rowJson[$(this).attr('id')] = value;
            options.controlDataJson[e_row.attr('data-value')] = rowJson;
        });
    }
    function radioProperty(e_row) {
        var _html = '';
        _html += '<div class="field_tips"><i class="fa fa-info-circle"></i><span>显示所有备选项，从中只可选择一项</span></div>';
        _html += '<div class="field_title">字段标识</div>';
        _html += '<div class="field_control"><div id="control_field" type="select" class="ui-select"></div></div>';
        _html += '<div class="field_title">字段说明</div>';
        _html += '<div class="field_control"><input id="control_label" type="text" class="form-control" placeholder="必填项"></div>';
        _html += '<div class="field_title">备选项<div class="addclassify"><a><i class="fa fa-plus"></i>添加</a></div></div>';
        _html += '<div class="field_control"><ul class="classify"></ul></div>';
        _html += '<div class="field_title">设置</div>';
        _html += '<div class="field_control"><div class="checkbox notclose" style="padding-left: 3px;"><label><input id="control_required" type="checkbox">必填</label></div></div>';
        var $html = $(_html);
        $(".field_option").html($html);
        var getRowJson = options.controlDataJson[e_row.attr('data-value')];
        if (getRowJson == null) {
            return false;
        }
        setControlField(getRowJson, e_row, $html);
        $html.find('#control_label').val(getRowJson.control_label);
        if (getRowJson.control_required == 1) {
            $html.find('#control_required').attr("checked", 'checked');
        } else {
            $html.find('#control_required').removeAttr("checked");
        }
        $html.find('#control_label').keyup(function (e) {
            var value = $(this).val();
            e_row.find('.item_field_label').find('span').html(value);
            getRowJson[$(this).attr('id')] = value;
            options.controlDataJson[e_row.attr('data-value')] = getRowJson;
        });
        $html.find('#control_required').click(function (e) {
            var value = 0;
            if ($(this).attr("checked")) {
                value = 0;
                $(this).attr("checked", false);
                e_row.find('.item_field_label').find('font').remove();
            } else {
                value = 1;
                $(this).attr("checked", true);
                e_row.find('.item_field_label').append('<font face="宋体">*</font>');
            }
            getRowJson[$(this).attr('id')] = value;
            options.controlDataJson[e_row.attr('data-value')] = getRowJson;
        });
        //处理备选项
        var $classify = $(".field_control .classify");
        $classify.sortable({
            handle: '.dragitem',
            stop: function (event, ui) {
                var tempitemjson = controlItemListJson;
                controlItemListJson = {};
                $classify.find('li').each(function (i) {
                    var id = $(this).attr('data-value');
                    controlItemListJson[id] = tempitemjson[id];
                });
                options.controlDataJson[e_row.attr('data-value')]["control_item"] = controlItemListJson;
                var _name = [];
                for (var i in controlItemListJson) {
                    if (controlItemListJson[i].name) {
                        _name.push(controlItemListJson[i].name)
                    };
                }
                e_row.find('.item_field_value').html('单选项/' + String(_name).replace(/,/g, '、'));
            }
        });
        //选项列表Json
        var controlItemListJson = options.controlDataJson[e_row.attr('data-value')]["control_item"];
        for (var i in controlItemListJson) {
            additem(i);
            var $thisObjectRow = $classify.find('[data-value=' + i + ']');
            $thisObjectRow.find('input[name=name]').val(controlItemListJson[i].name);
            $thisObjectRow.find('em').attr('class', controlItemListJson[i].color);
            $thisObjectRow.find('input[name=defaults]').attr("checked", controlItemListJson[i].defaults == 1 ? true : false);
        }
        //添加一项li
        $('.addclassify').find('a').click(function () {
            var random_id = String(Math.random()).substr(2);
            controlItemListJson[random_id] = {
                identify: random_id,
                color: "color_a",
                name: "",
                defaults: "0",
            }
            additem(random_id);
        })
        function additem(random_id) {
            var $li = $('<li><span><em title="色彩" class="color_a"></em><i title="移除" class="fa fa-close"></i></span><i class="dragitem fa fa-arrows"></i><input name="defaults" type="radio" title="设置默认值"><input name="name" type="text" placeholder="请填写备选项"></li>');
            $li.attr('data-value', random_id)
            $classify.append($li);
            //移除一项li
            $li.find('i.fa-close').click(function () {
                var id = $(this).parents('li').attr('data-value');
                delete controlItemListJson[id];
                $(this).parents('li').remove();
                options.controlDataJson[e_row.attr('data-value')]["control_item"] = controlItemListJson;
                var _name = [];
                for (var i in controlItemListJson) {
                    if (controlItemListJson[i].name) {
                        _name.push(controlItemListJson[i].name)
                    };
                }
                e_row.find('.item_field_value').html('单选项/' + String(_name).replace(/,/g, '、'));
            });
            //点击切换色彩
            var clickindex = 1;
            $li.find('em').click(function () {
                var color = ['color_a', 'color_b', 'color_c', 'color_d', 'color_e', 'color_f', 'color_g', 'color_h', 'color_i'];
                $(this).attr('class', color[clickindex]);
                controlItemListJson[$(this).parents('li').attr('data-value')].color = color[clickindex];
                options.controlDataJson[e_row.attr('data-value')]["control_item"] = controlItemListJson;
                clickindex++;
                if (clickindex == 9) {
                    clickindex = 0
                }
            });
            //默认值事件
            $li.find('input[name=defaults]').click(function () {
                for (var i in controlItemListJson) {
                    controlItemListJson[i].defaults = 0;
                }
                controlItemListJson[$(this).parents('li').attr('data-value')].defaults = 1;
                options.controlDataJson[e_row.attr('data-value')]["control_item"] = controlItemListJson;
            });
            //输入事件
            $li.find('input[name=name]').change(function () {
                var value = $(this).val();
                controlItemListJson[$(this).parents('li').attr('data-value')].name = value;
                options.controlDataJson[e_row.attr('data-value')]["control_item"] = controlItemListJson;
                var _name = [];
                for (var i in controlItemListJson) {
                    if (controlItemListJson[i].name) {
                        _name.push(controlItemListJson[i].name);
                    }
                }
                e_row.find('.item_field_value').html('单选项/' + String(_name).replace(/,/g, '、'));
            })
        }
        if ($classify.find('li').length == 0) {
            $('.addclassify').find('a').trigger("click");
        }
    }
    function checkboxProperty(e_row) {
        var _html = '';
        _html += '<div class="field_tips"><i class="fa fa-info-circle"></i><span>显示所有备选项，从中可以选择多项</span></div>';
        _html += '<div class="field_title">字段标识</div>';
        _html += '<div class="field_control"><div id="control_field" type="select" class="ui-select"></div></div>';
        _html += '<div class="field_title">字段说明</div>';
        _html += '<div class="field_control"><input id="control_label" type="text" class="form-control" placeholder="必填项"></div>';
        _html += '<div class="field_title">备选项<div class="addclassify"><a><i class="fa fa-plus"></i>添加</a></div></div>';
        _html += '<div class="field_control"><ul class="classify"></ul></div>';
        _html += '<div class="field_title">设置</div>';
        _html += '<div class="field_control"><div class="checkbox notclose" style="padding-left: 3px;"><label><input id="control_required" type="checkbox">必填</label></div></div>';
        var $html = $(_html);
        $(".field_option").html($html);
        var getRowJson = options.controlDataJson[e_row.attr('data-value')];
        if (getRowJson == null) {
            return false;
        }
        setControlField(getRowJson, e_row, $html);
        $html.find('#control_label').val(getRowJson.control_label);
        if (getRowJson.control_required == 1) {
            $html.find('#control_required').attr("checked", 'checked');
        } else {
            $html.find('#control_required').removeAttr("checked");
        }
        $html.find('#control_label').keyup(function (e) {
            var value = $(this).val();
            e_row.find('.item_field_label').find('span').html(value);
            getRowJson[$(this).attr('id')] = value;
            options.controlDataJson[e_row.attr('data-value')] = getRowJson;
        });
        $html.find('#control_required').click(function (e) {
            var value = 0;
            if ($(this).attr("checked")) {
                value = 0;
                $(this).attr("checked", false);
                e_row.find('.item_field_label').find('font').remove();
            } else {
                value = 1;
                $(this).attr("checked", true);
                e_row.find('.item_field_label').append('<font face="宋体">*</font>');
            }
            getRowJson[$(this).attr('id')] = value;
            options.controlDataJson[e_row.attr('data-value')] = getRowJson;
        });


        //处理备选项
        var $classify = $(".field_control .classify");
        $classify.sortable({
            handle: '.dragitem',
            stop: function (event, ui) {
                var tempitemjson = controlItemListJson;
                controlItemListJson = {};
                $classify.find('li').each(function (i) {
                    var id = $(this).attr('data-value');
                    controlItemListJson[id] = tempitemjson[id];
                });
                options.controlDataJson[e_row.attr('data-value')]["control_item"] = controlItemListJson;
                var _name = [];
                for (var i in controlItemListJson) {
                    if (controlItemListJson[i].name) {
                        _name.push(controlItemListJson[i].name)
                    };
                }
                e_row.find('.item_field_value').html('多选项/' + String(_name).replace(/,/g, '、'));
            }
        });
        //选项列表Json
        var controlItemListJson = options.controlDataJson[e_row.attr('data-value')]["control_item"];
        for (var i in controlItemListJson) {
            additem(i);
            var $thisObjectRow = $classify.find('[data-value=' + i + ']');
            $thisObjectRow.find('input[name=name]').val(controlItemListJson[i].name);
            $thisObjectRow.find('em').attr('class', controlItemListJson[i].color);
            $thisObjectRow.find('input[name=defaults]').attr("checked", controlItemListJson[i].defaults == 1 ? true : false);
        }
        //添加一项li
        $('.addclassify').find('a').click(function () {
            var random_id = String(Math.random()).substr(2);
            controlItemListJson[random_id] = {
                identify: random_id,
                color: "color_a",
                name: "",
                defaults: "0",
            }
            additem(random_id);
        })
        function additem(random_id) {
            var $li = $('<li><span><em title="色彩" class="color_a"></em><i title="移除" class="fa fa-close"></i></span><i class="dragitem fa fa-arrows"></i><input name="defaults" type="checkbox" title="设置默认值"><input name="name" type="text" placeholder="请填写备选项"></li>');
            $li.attr('data-value', random_id)
            $classify.append($li);
            //移除一项li
            $li.find('i.fa-close').click(function () {
                var id = $(this).parents('li').attr('data-value');
                delete controlItemListJson[id];
                $(this).parents('li').remove();
                options.controlDataJson[e_row.attr('data-value')]["control_item"] = controlItemListJson;
                var _name = [];
                for (var i in controlItemListJson) {
                    if (controlItemListJson[i].name) {
                        _name.push(controlItemListJson[i].name)
                    };
                }
                e_row.find('.item_field_value').html('多选项/' + String(_name).replace(/,/g, '、'));
            });
            //点击切换色彩
            var clickindex = 1;
            $li.find('em').click(function () {
                var color = ['color_a', 'color_b', 'color_c', 'color_d', 'color_e', 'color_f', 'color_g', 'color_h', 'color_i'];
                $(this).attr('class', color[clickindex]);
                controlItemListJson[$(this).parents('li').attr('data-value')].color = color[clickindex];
                options.controlDataJson[e_row.attr('data-value')]["control_item"] = controlItemListJson;
                clickindex++;
                if (clickindex == 9) {
                    clickindex = 0
                }
            });
            //复选框事件
            $li.find('input[name=defaults]').click(function () {
                controlItemListJson[$(this).parents('li').attr('data-value')].defaults = 1;
                options.controlDataJson[e_row.attr('data-value')]["control_item"] = controlItemListJson;
            });
            //输入事件
            $li.find('input[name=name]').keyup(function () {
                var value = $(this).val();
                controlItemListJson[$(this).parents('li').attr('data-value')].name = value;
                options.controlDataJson[e_row.attr('data-value')]["control_item"] = controlItemListJson;
                var _name = [];
                for (var i in controlItemListJson) {
                    if (controlItemListJson[i].name) {
                        _name.push(controlItemListJson[i].name);
                    }
                }
                e_row.find('.item_field_value').html('多选项/' + String(_name).replace(/,/g, '、'));
            })
        }
        if ($classify.find('li').length == 0) {
            $('.addclassify').find('a').trigger("click");
        }
    }
    function selectProperty(e_row) {
        var _html = '';
        _html += '<div class="field_tips"><i class="fa fa-info-circle"></i><span>显示所有备选项，从中只可选择一项</span></div>';
        _html += '<div class="field_title">字段标识</div>';
        _html += '<div class="field_control"><div id="control_field" type="select" class="ui-select"></div></div>';
        _html += '<div class="field_title">字段说明</div>';
        _html += '<div class="field_control"><input id="control_label" type="text" class="form-control" placeholder="必填项"></div>';
        _html += '<div class="field_title">备选项<div class="addclassify"><a><i class="fa fa-plus"></i>添加</a></div></div>';
        _html += '<div class="field_control"><ul class="classify"></ul></div>';
        _html += '<div class="field_title">设置</div>';
        _html += '<div class="field_control"><div class="checkbox notclose" style="padding-left: 3px;"><label><input id="control_required" type="checkbox">必填</label></div></div>';
        var $html = $(_html);
        $(".field_option").html($html);
        var getRowJson = options.controlDataJson[e_row.attr('data-value')];
        if (getRowJson == null) {
            return false;
        }
        setControlField(getRowJson, e_row, $html);
        $html.find('#control_label').val(getRowJson.control_label);
        if (getRowJson.control_required == 1) {
            $html.find('#control_required').attr("checked", 'checked');
        } else {
            $html.find('#control_required').removeAttr("checked");
        }
        $html.find('#control_label').keyup(function (e) {
            var value = $(this).val();
            e_row.find('.item_field_label').find('span').html(value);
            getRowJson[$(this).attr('id')] = value;
            options.controlDataJson[e_row.attr('data-value')] = getRowJson;
        });
        $html.find('#control_required').click(function (e) {
            var value = 0;
            if ($(this).attr("checked")) {
                value = 0;
                $(this).attr("checked", false);
                e_row.find('.item_field_label').find('font').remove();
            } else {
                value = 1;
                $(this).attr("checked", true);
                e_row.find('.item_field_label').append('<font face="宋体">*</font>');
            }
            getRowJson[$(this).attr('id')] = value;
            options.controlDataJson[e_row.attr('data-value')] = getRowJson;
        });


        //处理备选项
        var $classify = $(".field_control .classify");
        $classify.sortable({
            handle: '.dragitem',
            stop: function (event, ui) {
                var tempitemjson = controlItemListJson;
                controlItemListJson = {};
                $classify.find('li').each(function (i) {
                    var id = $(this).attr('data-value');
                    controlItemListJson[id] = tempitemjson[id];
                });
                options.controlDataJson[e_row.attr('data-value')]["control_item"] = controlItemListJson;
                var _name = [];
                for (var i in controlItemListJson) {
                    if (controlItemListJson[i].name) {
                        _name.push(controlItemListJson[i].name)
                    };
                }
                e_row.find('.item_field_value').html('下拉框/' + String(_name).replace(/,/g, '、'));
            }
        });
        //选项列表Json
        var controlItemListJson = options.controlDataJson[e_row.attr('data-value')]["control_item"];
        for (var i in controlItemListJson) {
            additem(i);
            var $thisObjectRow = $classify.find('[data-value=' + i + ']');
            $thisObjectRow.find('input[name=name]').val(controlItemListJson[i].name);
            $thisObjectRow.find('em').attr('class', controlItemListJson[i].color);
            $thisObjectRow.find('input[name=defaults]').attr("checked", controlItemListJson[i].defaults == 1 ? true : false);
        }
        //添加一项li
        $('.addclassify').find('a').click(function () {
            var random_id = String(Math.random()).substr(2);
            controlItemListJson[random_id] = {
                identify: random_id,
                color: "color_a",
                name: "",
                defaults: "0",
            }
            additem(random_id);
        })
        function additem(random_id) {
            var $li = $('<li><span><em title="色彩" class="color_a"></em><i title="移除" class="fa fa-close"></i></span><i class="dragitem fa fa-arrows"></i><input name="defaults" type="radio" title="设置默认值"><input name="name" type="text" placeholder="请填写备选项"></li>');
            $li.attr('data-value', random_id)
            $classify.append($li);
            //移除一项li
            $li.find('i.fa-close').click(function () {
                var id = $(this).parents('li').attr('data-value');
                delete controlItemListJson[id];
                $(this).parents('li').remove();
                options.controlDataJson[e_row.attr('data-value')]["control_item"] = controlItemListJson;
                var _name = [];
                for (var i in controlItemListJson) {
                    if (controlItemListJson[i].name) {
                        _name.push(controlItemListJson[i].name)
                    };
                }
                e_row.find('.item_field_value').html('下拉框/' + String(_name).replace(/,/g, '、'));
            });
            //点击切换色彩
            var clickindex = 1;
            $li.find('em').click(function () {
                var color = ['color_a', 'color_b', 'color_c', 'color_d', 'color_e', 'color_f', 'color_g', 'color_h', 'color_i'];
                $(this).attr('class', color[clickindex]);
                controlItemListJson[$(this).parents('li').attr('data-value')].color = color[clickindex];
                options.controlDataJson[e_row.attr('data-value')]["control_item"] = controlItemListJson;
                clickindex++;
                if (clickindex == 9) {
                    clickindex = 0
                }
            });
            //默认值事件
            $li.find('input[name=defaults]').click(function () {
                for (var i in controlItemListJson) {
                    controlItemListJson[i].defaults = 0;
                }
                controlItemListJson[$(this).parents('li').attr('data-value')].defaults = 1;
                options.controlDataJson[e_row.attr('data-value')]["control_item"] = controlItemListJson;
            });
            //输入事件
            $li.find('input[name=name]').keyup(function () {
                var value = $(this).val();
                controlItemListJson[$(this).parents('li').attr('data-value')].name = value;
                options.controlDataJson[e_row.attr('data-value')]["control_item"] = controlItemListJson;
                var _name = [];
                for (var i in controlItemListJson) {
                    if (controlItemListJson[i].name) {
                        _name.push(controlItemListJson[i].name);
                    }
                }
                e_row.find('.item_field_value').html('下拉框/' + String(_name).replace(/,/g, '、'));
            })
        }
        if ($classify.find('li').length == 0) {
            $('.addclassify').find('a').trigger("click");
        }
    }
    function datetimeProperty(e_row) {
        var _html = '';
        _html += '<div class="field_tips"><i class="fa fa-info-circle"></i><span>选择日期、时间控件</span></div>';
        _html += '<div class="field_title">字段标识</div>';
        _html += '<div class="field_control"><div id="control_field" type="select" class="ui-select"></div></div>';
        _html += '<div class="field_title">字段说明</div>';
        _html += '<div class="field_control"><input id="control_label" type="text" class="form-control" placeholder="必填项"></div>';
        _html += '<div class="field_title">日期格式</div>';
        _html += '<div class="field_control"><select id="control_dateformat" class="form-control"><option value="date">仅日期</option><option value="datetime">日期和时间</option></select></div>';
        _html += '<div class="field_title">默认值<i title="仅在添加数据时默认填入" class="help fa fa-question-circle"></i></div>';
        _html += '<div class="field_control"><select id="control_default" class="form-control"><option value="">请选择</option><option value="Yesterday">昨天</option><option value="Today">今天</option><option value="Tomorrow">明天</option></select></div>';
        _html += '<div class="field_title">设置</div>';
        _html += '<div class="field_control"><div class="checkbox notclose" style="padding-left: 3px;"><label><input id="control_required" type="checkbox">必填</label></div></div>';
        var $html = $(_html);
        $(".field_option").html($html);
        var rowJson = options.controlDataJson[e_row.attr('data-value')];
        if (rowJson == null) {
            return false;
        }
        setControlField(rowJson, e_row, $html);
        $html.find('#control_label').val(rowJson.control_label);
        $html.find('#control_dateformat').val(rowJson.control_dateformat);
        $html.find('#control_default').val(rowJson.control_default);
        if (rowJson.control_required == 1) {
            $html.find('#control_required').attr("checked", 'checked');
        } else {
            $html.find('#control_required').removeAttr("checked");
        }
        $html.find('#control_label').keyup(function (e) {
            var value = $(this).val();
            e_row.find('.item_field_label').find('span').html(value);
            rowJson[$(this).attr('id')] = value;
            options.controlDataJson[e_row.attr('data-value')] = rowJson;
        });
        $html.find('#control_dateformat').change(function (e) {
            var value = $(this).val();
            if (value == 'date') {
                e_row.find('.item_field_value').html('年-月-日');
            } else if (value == 'datetime') {
                e_row.find('.item_field_value').html('年-月-日 时:分');
            }

            rowJson[$(this).attr('id')] = value;
            options.controlDataJson[e_row.attr('data-value')] = rowJson;
        });
        $html.find('#control_default').change(function (e) {
            var value = $(this).val();
            rowJson[$(this).attr('id')] = value;
            options.controlDataJson[e_row.attr('data-value')] = rowJson;
        });
        $html.find('#control_required').click(function (e) {
            var value = 0;
            if ($(this).attr("checked")) {
                value = 0;
                $(this).attr("checked", false);
                e_row.find('.item_field_label').find('font').remove();
            } else {
                value = 1;
                $(this).attr("checked", true);
                e_row.find('.item_field_label').append('<font face="宋体">*</font>');
            }
            rowJson[$(this).attr('id')] = value;
            options.controlDataJson[e_row.attr('data-value')] = rowJson;
        });
    }

    function imageProperty(e_row) {
        var _html = '';
        _html += '<div class="field_title">字段标识</div>';
        _html += '<div class="field_control"><div id="control_field" type="select" class="ui-select"></div></div>';
        _html += '<div class="field_title">字段说明</div>';
        _html += '<div class="field_control"><input id="control_label" type="text" class="form-control" placeholder="必填项"></div>';
        _html += '<div class="field_title">图片格式<i title=".jpg .gif .png .bmp" class="help fa fa-question-circle"></i></div>';
        _html += '<div class="field_control"><input id="control_fileformat" type="text" class="form-control" placeholder="如：jpg,gif,png,bmp"></div>';
        _html += '<div class="field_title">设置</div>';
        _html += '<div class="field_control"><div class="checkbox notclose" style="padding-left: 3px;"><label><input id="control_required" type="checkbox">必填</label></div></div>';
        var $html = $(_html);
        $(".field_option").html($html);
        var rowJson = options.controlDataJson[e_row.attr('data-value')];
        if (rowJson == null) {
            return false;
        }
        setControlField(rowJson, e_row, $html);
        $html.find('#control_label').val(rowJson.control_label);
        $html.find('#control_fileformat').val(rowJson.control_fileformat);
        if (rowJson.control_required == 1) {
            $html.find('#control_required').attr("checked", 'checked');
        } else {
            $html.find('#control_required').removeAttr("checked");
        }
        $html.find('#control_label').keyup(function (e) {
            var value = $(this).val();
            e_row.find('.item_field_label').find('span').html(value);
            rowJson[$(this).attr('id')] = value;
            options.controlDataJson[e_row.attr('data-value')] = rowJson;
        });
        $html.find('#control_fileformat').keyup(function (e) {
            var value = $(this).val();
            e_row.find('.item_field_value').html('上传图片/' + value);
            rowJson[$(this).attr('id')] = value;
            options.controlDataJson[e_row.attr('data-value')] = rowJson;
        });
        $html.find('#control_required').click(function (e) {
            var value = 0;
            if ($(this).attr("checked")) {
                value = 0;
                $(this).attr("checked", false);
                e_row.find('.item_field_label').find('font').remove();
            } else {
                value = 1;
                $(this).attr("checked", true);
                e_row.find('.item_field_label').append('<font face="宋体">*</font>');
            }
            rowJson[$(this).attr('id')] = value;
            options.controlDataJson[e_row.attr('data-value')] = rowJson;
        });
    }
    function uploadProperty(e_row) {
        var _html = '';
        _html += '<div class="field_title">字段标识</div>';
        _html += '<div class="field_control"><div id="control_field" type="select" class="ui-select"></div></div>';
        _html += '<div class="field_title">字段说明</div>';
        _html += '<div class="field_control"><input id="control_label" type="text" class="form-control" placeholder="必填项"></div>';
        _html += '<div class="field_title">文件格式<i title=".doc .xls .ppt .pdf " class="help fa fa-question-circle"></i></div>';
        _html += '<div class="field_control"><input id="control_fileformat" type="text" class="form-control" placeholder="如：doc,xls,ppt,pdf"></div>';
        _html += '<div class="field_title">设置</div>';
        _html += '<div class="field_control"><div class="checkbox notclose" style="padding-left: 3px;"><label><input id="control_required" type="checkbox">必填</label></div></div>';
        var $html = $(_html);
        $(".field_option").html($html);
        var rowJson = options.controlDataJson[e_row.attr('data-value')];
        if (rowJson == null) {
            return false;
        }
        setControlField(rowJson, e_row, $html);
        $html.find('#control_label').val(rowJson.control_label);
        $html.find('#control_fileformat').val(rowJson.control_fileformat);
        if (rowJson.control_required == 1) {
            $html.find('#control_required').attr("checked", 'checked');
        } else {
            $html.find('#control_required').removeAttr("checked");
        }
        $html.find('#control_label').keyup(function (e) {
            var value = $(this).val();
            e_row.find('.item_field_label').find('span').html(value);
            rowJson[$(this).attr('id')] = value;
            options.controlDataJson[e_row.attr('data-value')] = rowJson;
        });
        $html.find('#control_fileformat').keyup(function (e) {
            var value = $(this).val();
            e_row.find('.item_field_value').html('上传文件/' + value);
            rowJson[$(this).attr('id')] = value;
            options.controlDataJson[e_row.attr('data-value')] = rowJson;
        });
        $html.find('#control_required').click(function (e) {
            var value = 0;
            if ($(this).attr("checked")) {
                value = 0;
                $(this).attr("checked", false);
                e_row.find('.item_field_label').find('font').remove();
            } else {
                value = 1;
                $(this).attr("checked", true);
                e_row.find('.item_field_label').append('<font face="宋体">*</font>');
            }
            rowJson[$(this).attr('id')] = value;
            options.controlDataJson[e_row.attr('data-value')] = rowJson;
        });
    }

    function dataitemlistProperty(e_row) {

    }

    //绑定数据表字段
    function setControlField(rowJson, e_row, $html) {
       
        var _value = (rowJson.control_field == "" ? newGuid() : rowJson.control_field);
        if (options.isSystemTable == 0) {
            $html.find("#control_field").parents('.field_control').html('<input id="control_field" type="text" class="form-control" disabled data-text="' + _value + '" value="' + _value + '" />');
            rowJson.control_field = _value;
            options.controlDataJson[e_row.attr('data-value')] = rowJson;
        }
        else {
            $html.find("#control_field").parents('.field_control').html('<div class="field_control"><div id="control_field" type="select" class="ui-select"></div></div>');
            $html.find("#control_field").ComboBox({
                data: options.tablefiledJsonData,
                id: "f_column",
                text: "f_remark",
                description: "==请选择==",
                height: "230px",
                allowSearch: true
            });
            $html.find("#control_field").ComboBoxSetValue(rowJson.control_field);

            $html.find('#control_field').change(function (e) {
                var value = $(this).attr('data-value');
                rowJson[$(this).attr('id')] = value;
                options.controlDataJson[e_row.attr('data-value')] = rowJson;
            });
        }
    }
    
    return options;
}
//表单预览
$.fn.frmPreview = function (options)
{
    var $frmpreview= $(this);
    if (!$frmpreview.attr('id')) {
        return false;
    }
    $frmpreview.html("");
    var defaults = {
        tablecotent: [],
        width:0,
        datetime:new Date()
    };
    var options = $.extend(defaults, options);
    if (options.tablecotent == "")
    {
        return false;
    }
    var frmContentJson = eval('(' + options.tablecotent + ')');
   
    $.each(frmContentJson, function (id, item) {
        var $item_control = $('<div class="item_row"></div>');
        var controlrequired = item.control_required == '1' ? '<font face="宋体">*</font>' : '';
        var controlrequired1 = item.control_required == '1' ? 'isvalid="yes" checkexpession="NotNull"' : '';
        item.control_field = 'frm_' + item.control_field;
        $item_control.html('<div class="item_field_label"><span>' + item.control_label + '</span>' + controlrequired + '</div>');
        switch (item.control_type) {
            case "text":
                $item_control.append('<div class="item_field_value"><input id="' + item.control_field + '" type="text" class="form-control"  ' + controlrequired1 + ' /></div>');
                break;
            case "textarea":
                $item_control.append('<div class="item_field_value"><textarea id="' + item.control_field + '" style=height:' + item.control_height + '; class="form-control" ' + controlrequired1 + ' /></div>');
                break;
            case "texteditor":
                $item_control.append('<div class="item_field_value"><textarea id="' + item.control_field + '" style=height:' + item.control_height + '; class="form-control"   ' + controlrequired1 + ' /></div>');
                $frmpreview.append($item_control);
                new Simditor({
                    textarea: $('#' + item.control_field),
                    placeholder: '这里输入内容...',
                    toolbar: ['color', 'title', 'bold', 'underline', 'strikethrough', '|', 'ol', 'ul', 'blockquote', 'table', '|', 'link', 'image']
                });
                $item_control = null;
                break;
            case "radio":
                var radiohtml = "";
                $.each(item.control_item, function (id, childitem) {
                    radiohtml += '<div class="rdio rdio-' + childitem.color + '" ><input name="' + item.control_field + '" id = "' + item.control_field + childitem.identify + '" type="radio" data-value="' + childitem.identify + '" value="' + childitem.name + '"   /><label for="' + item.control_field + childitem.identify + '">' + childitem.name + '</label></div>';
                });
                $item_control.append('<div class="item_field_value">' + radiohtml + '</div>');
                break;
            case "checkbox":
                var ckboxhtml = "";
                $.each(item.control_item, function (id, childitem) {
                    ckboxhtml += '<div class="ckbox ckbox-' + childitem.color + '" ><input id = "' + item.control_field + childitem.identify + '" type="checkbox" data-value="' + childitem.identify + '" value="' + childitem.name + '" /><label for="' + item.control_field + childitem.identify + '">' + childitem.name + '</label></div>';
                });
                $item_control.append('<div class="item_field_value">' + ckboxhtml + '</div>');
                break;
            case "select":
                $item_control.append('<div class="item_field_value"><div id="' + item.control_field + '" type="select" class="ui-select" isvalid="yes" ' + controlrequired1 + '></div></div>');
                $frmpreview.append($item_control);
                $("#" + item.control_field).ComboBox({
                    data: item.control_item,
                    id: "name",
                    text: "name",
                    description: "==请选择==",
                    height: "200px",
                    allowSearch: true
                });
                $item_control = null;
                break;
            case "datetime":
                var dateformat = item.control_dateformat == 'date' ? 'yyyy-MM-dd' : 'yyyy-MM-dd HH:mm';
                var datedefault = "";
                switch (item.control_default)
                {
                    case "Yesterday":
                        datedefault = options.datetime.DateAdd('d',-1);
                        break;
                    case "Today":
                        datedefault = options.datetime.DateAdd('d', 0);
                        break;
                    case "Tomorrow":
                        datedefault = options.datetime.DateAdd('d', 1);;
                        break;
                }
                datedefault = formatDate(datedefault, dateformat.replace(/H/g,'h'));
                $item_control.append('<div class="item_field_value"><input value="' + datedefault + '" onClick="WdatePicker({dateFmt:\'' + dateformat + '\',qsEnabled:false,isShowClear:false,isShowOK:false,isShowToday:false})" id="' + item.control_field + '" readonly type="text" class="form-control input-datepicker"  ' + controlrequired1 + '/></div>');
                break;
            case "image":
                $item_control.append('<div class="item_field_value"><input id="' + item.control_field + '" type="file"  /></div>');
                $frmpreview.append($item_control);
                fuploadify(item.control_field, "添加图片");
                $item_control = null;
                break;
            case "upload":
                $item_control.append('<div class="item_field_value"><input id="' + item.control_field + '" type="file"  /></div>');
                $frmpreview.append($item_control);
                fuploadify(item.control_field, "添加附件");
                $item_control = null;
                break;
            case "departmentlist":
                break;
            case "dataitemlist":
                break;
            default:
                break;
        }
        if ($item_control != null)
        {
            $frmpreview.append($item_control);
        }
    });
    var _field_value_width = options.width - 132;
    if (options.width == 0) {
        _field_value_width = $frmpreview[0].scrollWidth - 132;
    }
    $frmpreview.find('.item_field_value').width(_field_value_width);
    function fuploadify(control_field,btnName) {
        $("#" + control_field).uploadify({
            method: 'post',
            uploader: '/FlowManage/File/Add',
            swf:  '/Content/scripts/plugins/uploadify/uploadify.swf',
            buttonText: btnName,
            height: 30,
            width: 90,
            fileTypeExts: '*.avi;*.mp3;*.mp4;*.bmp;*.ico;*.gif;*.jpeg;*.jpg;*.png;*.psd; *.rar;*.zip;*.swf;*.log;*.pdf;*.doc;*.docx;*.ppt;*.pptx;*.txt; *.xls; *.xlsx;',
            removeCompleted: false,
            onSelect: function (file) {
                $("#" + file.id).prepend('<div style="float:left;width:50px;margin-right:2px;"><img src="/Content/images/filetype/' + file.type.replace('.', '') + '.png" style="width:40px;height:40px;" /></div>');

                $(".uploadify-queue-item").find('.cancel').find('a').html('<i class="fa fa-trash-o "></i>');
                $(".uploadify-queue-item").find('.cancel').find('a').attr('title','删除');
                $(".uploadify-queue-item").hover(function () {
                    $(this).find('.cancel').find('a').show();
                }, function () {
                    $(this).find('.cancel').find('a').hide();
                });
            },
            onUploadSuccess: function (file, data) {
                var response = JSON.parse(data);
                $("#" + file.id).attr('filePath', response.Result);
                $("#" + file.id).attr('fileName', file.name);
                $("#" + file.id).find('.uploadify-progress').remove();
                $("#" + file.id).find('.data').html(' 恭喜您，上传成功！');
                $("#" + file.id).prepend('<a class="succeed" title="成功"><i class="fa fa-check-circle"></i></a>');
                Loading(false);

            },
            onUploadError: function (file) {
                $("#" + file.id).removeClass('uploadify-error');
                $("#" + file.id).find('.uploadify-progress').remove();
                $("#" + file.id).find('.data').html(' 很抱歉，上传失败！');
                $("#" + file.id).prepend('<span class="error" title="失败"><i class="fa fa-exclamation-circle"></i></span>');
            },
            onUploadStart: function () {
                $('#' + control_field + '-queue').show();
            },
            onCancel: function (file) {
            }
        });
        $("#" + control_field + "-button").prepend('<i style="opacity: 0.6;" class="fa fa-cloud-upload"></i>&nbsp;');
        $('#' + control_field + '-queue').attr('type','upload'); 
        $('#' + control_field + '-queue').hide(); 
    }
}
//获取表单数据
$.fn.frmGetData = function () {
    var reVal = ""; var checkboxValue = {};
    var uploadVal = new Array();
    $(this).find('input,select,textarea,.ui-select,.uploadify-queue').each(function (r) {
        var id = $(this).attr('id');
        if (id != undefined)
        {
            var filedid = id.replace('frm_', '');
            var type = $(this).attr('type');

            switch (type) {
                case "upload":  //文件上传
                    $(this).find('.uploadify-queue-item').each(function (u) {
                        uploadVal.push({
                            fileName: $(this).attr('fileName'),
                            filePath: $(this).attr('filePath')
                        });
                    });

                    reVal += '"' + filedid + '"' + ':' + JSON.stringify(uploadVal) + ','
                    break;
                case "checkbox":
                    var datavalue = $("#" + id).attr('data-value');
                    var value = $("#" + id).val();
                    if ($("#" + id).is(":checked")) {
                        //reVal += '"' + filedid.replace(datavalue, '') + '"' + ':' + '"' + $.trim(value) + '",'
                        if (checkboxValue[filedid.replace(datavalue, '')] == undefined) {
                            checkboxValue[filedid.replace(datavalue, '')] = "";
                        }
                        else {
                            checkboxValue[filedid.replace(datavalue, '')] += '|';
                        }
                        checkboxValue[filedid.replace(datavalue, '')] += $.trim(value);
                    }
                    break;
                case "radio":
                    var datavalue = $("#" + id).attr('data-value');
                    var value = $("#" + id).val();
                    if ($("#" + id).is(":checked")) {
                        reVal += '"' + filedid.replace(datavalue, '') + '"' + ':' + '"' + $.trim(value) + '",'
                    }
                    break;
                case "select":
                    var value = $("#" + id).attr('data-value');
                    if (value == "") {
                        value = "&nbsp;";
                    }
                    reVal += '"' + filedid + '"' + ':' + '"' + $.trim(value) + '",'
                    break;
                case "selectTree":
                    var value = $("#" + id).attr('data-value');
                    if (value == "") {
                        value = "&nbsp;";
                    }
                    reVal += '"' + filedid + '"' + ':' + '"' + $.trim(value) + '",'
                    break;
                default:
                    var value = $("#" + id).val();
                    if (value == "") {
                        value = "&nbsp;";
                    }
                    reVal += '"' + filedid + '"' + ':' + '"' + $.trim(value) + '",'
                    break;
            }
        }
    });
    for (var i in checkboxValue)
    {
        reVal += '"' + i + '"' + ':' + '"' + checkboxValue[i] + '",'
    }

    reVal = reVal.substr(0, reVal.length - 1);
    reVal = reVal.replace(/\\/g, '\\\\');
    reVal = reVal.replace(/\n/g, '\\n');
    var postdata = jQuery.parseJSON('{' + reVal + '}');
    //阻止伪造请求
    //if ($('[name=__RequestVerificationToken]').length > 0) {
    //    postdata["__RequestVerificationToken"] = $('[name=__RequestVerificationToken]').val();
    //}
    return postdata;
}
//设置表单数据
$.fn.frmSetData = function (data) {
    console.log("设置表单:"+JSON.stringify(data));
    var $id = $(this)
    for (var key in data) {
        var id = $id.find('#frm_' + key);
        var value = $.trim(data[key]).replace(/&nbsp;/g, '');
        if (id.attr('id')) {
            var type = id.attr('type');
            switch (type) {
                case "radio":
                    break;
                case "checkbox":
                    if (value == 1) {
                        id.attr("checked", 'checked');
                    } else {
                        id.removeAttr("checked");
                    }
                    break;
                case "select":
                    id.ComboBoxSetValue(value);
                    break;
                case "selectTree":
                    id.ComboBoxTreeSetValue(value);
                    break;
                case "upload":
                    $.each(data[key], function (e) {
                        var $this = this;
                        id.after("<a href='/FlowManage/File/upload/" + $this.filePath + "'>" + $this.fileName + "</a>");
                        });
                    break;
                default:
                    id.val(value);
                    break;
            }
        }
        else {
            $(this).find('input').each(function (r) {
                var checkid = $(this).attr('id');
                if (!checkid) return true;

                var checkfiledid = checkid.replace('frm_', '');
                var checktype = $(this).attr('type');
                var checkValue = $(this).val();
                switch (checktype) {
                    case "checkbox":
                        var datavalue = $(this).attr('data-value');
                        if ((key + datavalue) == checkfiledid )
                        {
                            var vlist = value.split('|');
                            for (var i in vlist)
                            {
                                if (vlist[i] == checkValue)
                                {
                                    $(this).attr("checked", 'checked');
                                    break;
                                }
                            }
                        }
                        break;
                    case "radio":
                        var datavalue = $(this).attr('data-value');
                        if ((key + datavalue) == checkfiledid && checkValue == value) {
                            $(this).attr("checked", 'checked');
                        }
                        break;
                    default:
                        break;
                }
            });
        }
    }
}
