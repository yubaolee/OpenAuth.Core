layui.config({
    base: "/js/"
}).use(['form','vue', 'ztree', 'layer', 'jquery', 'table','droptree','openauth','utils','cookie'], function () {
    var form = layui.form,
        layer = layui.layer,
        $ = layui.jquery;
    var table = layui.table;
    var openauth = layui.openauth;
    var toplayer = (top == undefined || top.layer === undefined) ? layer : top.layer;  //顶层的LAYER

    //左边树状机构列表
    var ztree = function () {
        var url = '/UserSession/GetOrgs';
        var zTreeObj;
        var setting = {
            view: { 
                selectedMulti: false ,
                nameIsHTML: true
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
                    rootPId: ""
                }
            },
            callback: {
                onClick: function (event, treeId, treeNode) {
                    $.cookie('defaultorgid', treeNode.Id, {path: '/'});
                    load();
                }
            }
        };
        var load = function () {
            $.getJSON(url, function (json) {
                zTreeObj = $.fn.zTree.init($("#tree"), setting);
                var defaultorgid = $.cookie('defaultorgid');
                if(defaultorgid != undefined) {
                    $.each(json.Result, function () {
                        var element = this;
                        if (element.Id == defaultorgid) {
                            element.Name = "<font color='red'>"+element.Name + "(当前默认)"+"</font>"
                        }
                    });
                }
                zTreeObj.addNodes(null, json.Result);
                zTreeObj.expandAll(true);
            });
        };
        load();
        return {
            reload: load
        }
    }();

    $("#tree").height( $("div.layui-table-view").height());


    //模块列表
    var ztreeModule = function () {
        var url = '/UserSession/GetModules';
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
                    rootPId: ""
                }
            },
            callback: {
                onClick: function (event, treeId, treeNode) {
                    //mainList({ orgId: treeNode.Id });
                }
            }
        };
        var load = function () {
            $.getJSON(url, function (json) {
                zTreeObj = $.fn.zTree.init($("#treeModule"), setting);
                zTreeObj.addNodes(null, json.Result);
                zTreeObj.expandAll(true);
            });
        };
        load();
        return {
            reload: load
        }
    }();

    var  vm = new Vue({
        el: "#formEdit",
        data() {
            return {
                tmp: {
                    Account: '',
                    Name: '',
                    Sex: '',
                }  
            }
        },
        watch:{
            tmp(val){
                this.$nextTick(function () {
                    form.render();  //刷新select等
                })
            }
        },
        mounted() {
            var _this = this;
            $.get('/UserSession/GetUserProfile',
                function (data) {
                    var obj = JSON.parse(data);
                    _this.tmp = obj.Result;
                });
        }
    });

    var url = "/UserManager/ChangeProfile";
    //提交数据
    form.on('submit(formSubmit)',
        function (data) {
            $.post(url,
                data.field,
                function (data) {
                    layer.msg(data.Message);
                },
                "json");
            return false;
        });
    //监听页面主按钮操作 end
})