// ***********************************************************************
// Assembly         : OpenAuth.Mvc
// Author           : yubaolee
// Created          : 04-19-2016
//
// Last Modified By : yubaolee
// Last Modified On : 05-26-2016
// Contact : www.cnblogs.com/yubaolee
// File: assignModuleElement.js
//Description: 分配模块菜单（按钮）
// ***********************************************************************

function renderLayui() {
    layui.use(['layer', 'form'], function () {
        var form = layui.form();

        form.on('checkbox', function (data) {
            if (data.elem.checked) {
                $.post('/RelevanceManager/Assign', {
                    type: $("#moduleType").val(),
                    firstId: $('#firstId').val(),
                    secIds: data.value
                }, function (json) {
                    json = $.parseJSON(json);

                });
            }
            else {
                $.post('/RelevanceManager/UnAssign', {
                    type: $("#moduleType").val(),
                    firstId: $('#firstId').val(),
                    secIds: data.value
                }, function (json) {
                    json = $.parseJSON(json);

                });
            }
        });

        form.render();
    });
}

var list = function () {
    var selectedId = '00000000-0000-0000-0000-000000000000';  //选中的ID
    var url = '/ModuleElementManager/LoadWithAccess?firstId=' + $("#firstId").val() + "&key=" + $("#moduleType").val() + "&tId=";
    return {
        reload: function (id) {
            if (id != undefined) selectedId = id;
            $.getJSON(url + selectedId,
                function (data) {
                    var str = '';
                    if (data.length > 0) {
                        $.each(data,
                        function () {
                            str += "<input type=\"checkbox\" name=\"\" value=\""+this.Id+"\" title=\"" + this.Name + "\"";
                            if (this.Checked) {
                                str += " checked ";
                            }
                            str += ">\r\n";
                        });
                    }
                    $("#moduleElements").html(str);
                    renderLayui();
                });
        }
    };
}();
//左边导航
var ztree = function() {
    var url;
    var type = $("#moduleType");
    if (type.val() == "UserElement") {
        url = '/ModuleManager/LoadForUser';
    } else {
        url = '/ModuleManager/LoadForRole';
    }

    var setting = {
        view: { selectedMulti: false },
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
            onClick: function(event, treeId, treeNode) {
                list.reload(treeNode.Id);
            }
        }
    };
    var load = function() {
        $.getJSON(url,
            { firstId: $("#firstId").val() },
            function(json) {
                var zTreeObj = $.fn.zTree.init($("#orgtree"), setting, json);
                list.reload();
                zTreeObj.expandAll(true);
            });
    };
    load();

    return {
        reload: load
    }
}();

