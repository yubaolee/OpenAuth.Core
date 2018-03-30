layui.config({
    base: "/js/"
}).use(['form', 'vue', 'ztree', 'layer', 'element', 'jquery', 'utils'], function () {
    var //layer = (parent == undefined || parent.layer === undefined )? layui.layer : parent.layer,
        layer = layui.layer,
        $ = layui.jquery;
    var users = [];   //节点的执行人

    var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
    //从flowschemes.js进入的节点信息
    var node = parent.FlowDesignObject;
    console.log(JSON.stringify(node));

    var vm = new Vue({
        el: "#formEdit"
    });

    //初始化节点设置信息
    if (node.setInfo != null) {
        vm.$set('$data', node.setInfo);
        users = node.setInfo.NodeDesignateData.users;
    }

    //菜单列表
    var menucon = {};  //table的参数，如搜索key，点击tree的id
    //副树状结构，等lay table没问题了，可以换成table
    var subtree = function () {
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
                menuTree = $.fn.zTree.init($("#menutree"), setting);
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
                    subtree.load({ orgId: treeNode.Id });
                }
            }
        };
        var load = function () {
            $.getJSON(url, function (json) {
                zTreeObj = $.fn.zTree.init($("#tree"), setting);
                var newNode = { Name: "全部", Id: null, ParentId: "" };
                json.push(newNode);
                zTreeObj.addNodes(null, json);
                subtree.load({ orgId: '' });
                zTreeObj.expandAll(true);
            });
        };
        load();
        return {
            reload: load
        }
    }();

    //提供给上父页面调用
    getVal = function () {
        var result = {
             NodeDesignateData: {  //节点指定操作人
                users: users,
                role: [],
                org: []
            }
        };
        $.extend(result, vm.$data);
        return result;
    }

    //让层自适应iframe
    parent.layer.iframeAuto(index);
})