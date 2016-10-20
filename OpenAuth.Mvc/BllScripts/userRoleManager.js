// ***********************************************************************
// Assembly         : OpenAuth.Mvc
// Author           : yubaolee
// Created          : 04-13-2016
//
// Last Modified By : yubaolee
// Last Modified On : 04-13-2016
// ***********************************************************************
// <copyright file="userRoleManager.js" company="www.cnblogs.com/yubaolee">
//     版权所有(C) 2015
// </copyright>
// <summary>用户分配角色模块</summary>
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
    var url = '/RoleManager/LoadForOrgAndUser?userId=' + $("#firstId").val()
        + "&key=" + $("#moduleType").val() + "&orgId=";
    return {
        reload: function (id) {
            if (id != undefined) selectedId = id;
            $.getJSON(url + selectedId,
                function (data) {
                    var str = '';
                    if (data.length > 0) {
                        $.each(data,
                        function () {
                            str += "<input type=\"checkbox\" name=\"\" value=\"" + this.Id + "\" title=\"" + this.Name + "\"";
                            if (this.Checked) {
                                str += " checked ";
                            }
                            str += ">\r\n";
                        });
                    }
                    $("#roles").html(str);
                    renderLayui();
                });
        }
    };
}();
//左边导航
var ztree = function () {
    var url = "/OrgManager/LoadOrg";

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
            onClick: function (event, treeId, treeNode) {
                list.reload(treeNode.Id);
            }
        }
    };
    var load = function () {
        $.getJSON(url,
            function (json) {
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

