layui.config({
    base: "/js/"
}).use(['form', 'vue', 'ztree', 'layer', 'element', 'jquery', 'utils'], function () {
    var layer = layui.layer,
        $ = layui.jquery;
    var form = layui.form;
    var users = [];   //节点的执行人
    var roles = [];   //节点执行角色

    var index = layer.getFrameIndex(window.name); //获取窗口索引
    //从flowschemes.js进入的节点信息
    var node = parent.FlowDesignObject;
    console.log(JSON.stringify(node));

    var vm = new Vue({
        el: "#formEdit",
        data: {
            NodeName: node.name
            , NodeCode: node.name   //默认的code
            , NodeRejectType:'0'
            , NodeDesignate:"ALL_USER"
        }
    });

    //初始化节点设置信息
    if (node.setInfo != null) {
        vm.$set('$data', node.setInfo);
        users = node.setInfo.NodeDesignateData.users;
        roles = node.setInfo.NodeDesignateData.roles;
        //layui与vue不兼容，要重新赋值select radio(lll￢ω￢)
        $("#NodeRejectType").val(node.setInfo.NodeRejectType);
        $(":radio[name='NodeDesignate'][value='" + node.setInfo.NodeDesignate + "']").prop("checked", true);
        form.render();
    }

    form.on('select',
        function (data) {
            vm.NodeRejectType = data.value;
        });

   

    //菜单列表
    var menucon = {};  //table的参数，如搜索key，点击tree的id
    //用户列表，等lay table没问题了，可以换成table
    var userstree = function () {
        var url = '/UserManager/Load';
        var menuTree;
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
                onCheck: function (event, treeId, treeNode) {
                    users.push(treeNode.Id);
                }
            }
        };
        var load = function (options) {
            if (options != undefined) {
                $.extend(menucon, options);
            }

            $.getJSON(url, menucon, function (json) {
                menuTree = $.fn.zTree.init($("#userstree"), setting);
                menuTree.addNodes(null, json.data);
                //如果已经分配了用户，则设置相应的状态

                $.each(users,
                    function (i) {
                        var that = this;
                        var node = menuTree.getNodeByParam("Id", that, null);
                        menuTree.checkNode(node, true, false);
                    });
                menuTree.expandAll(true);
            });
        };
        return {
            load: load
        }
    }();

    var rolestree = function () {
        var url = '/RoleManager/Load';
        var rolestree;
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
                onCheck: function (event, treeId, treeNode) {
                    roles.push(treeNode.Id);
                }
            }
        };
        var load = function (options) {
            if (options != undefined) {
                $.extend(menucon, options);
            }

            $.getJSON(url, menucon, function (json) {
                rolestree = $.fn.zTree.init($("#rolestree"), setting);
                rolestree.addNodes(null, json.data);
                //如果已经分配了用户，则设置相应的状态

                $.each(roles,
                    function (i) {
                        var that = this;
                        var node = rolestree.getNodeByParam("Id", that, null);
                        rolestree.checkNode(node, true, false);
                    });
                rolestree.expandAll(true);
            });
        };
        return {
            load: load
        }
    }();

    //左边树状机构列表
    var ztree = function () {
        var url = '/UserSession/GetOrgs';
        var zTreeObj;
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
                    if (vm.NodeDesignate === "SPECIAL_USER") {
                        userstree.load({ orgId: treeNode.Id });
                    } else {
                        rolestree.load({ orgId: treeNode.Id });
                    }
                }
            }
        };
        var load = function () {
            $.getJSON(url, function (json) {
                if (vm.NodeDesignate === "ALL_USER") return;
                zTreeObj = $.fn.zTree.init($("#tree"), setting);
                var newNode = { Name: "全部", Id: null, ParentId: "" };
                json.push(newNode);
                zTreeObj.addNodes(null, json);
                if (vm.NodeDesignate === "SPECIAL_USER") {
                    userstree.load({ orgId: '' });
                } else if (vm.NodeDesignate === "SPECIAL_ROLE") {
                    rolestree.load({ orgId: '' });
                }
                zTreeObj.expandAll(true);
            });
        };
        load();
        return {
            reload: load
        }
    }();


    form.on('radio(NodeDesignate)',
        function (data) {
            vm.NodeDesignate = data.value;
            if (data.value === "SPECIAL_USER") {
                userstree.load();
                ztree.reload();
            }
            else if (data.value === "SPECIAL_ROLE") {
                rolestree.load();
                ztree.reload();
            }
        });

    //提供给上父页面调用
    getVal = function () {
        var result = {
            NodeDesignateData: {  //节点指定操作人
                users: users,
                roles: roles,
                orgs: []
            }
        };
        $.extend(result, vm.$data);
        return result;
    }

    //让层自适应iframe
    layer.iframeAuto(index);
})