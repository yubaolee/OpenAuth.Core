// ***********************************************************************
// Assembly         : OpenAuth.Mvc
// Author           : yubaolee
// Created          : 10-16-2016
//
// Last Modified By : yubaolee
// Last Modified On : 04-02-2019
//                    修改ztree为基于layui的dtree
// ***********************************************************************
// <copyright file="droptree.js" company="www.cnblogs.com/yubaolee">
//     版权所有 玉宝(C) 2017
// </copyright>
//单击文本框弹出的选择列表,可以多选。调用： 
//var droptree = layui.droptree("/UserSession/GetOrgs", "#Organizations", "#OrganizationIds");
// droptree.render();
// ***********************************************************************

layui.config({
    base: "/js/"
}).define(['jquery', 'layer','dtree'], function (exports) {
    var $ = layui.jquery;
    var layer = layui.layer;
    var dtree = layui.dtree;
    var inst;   //droptree实体

    //构造器
    var  DropTree = function (options) {
        var that = this;
        that.config = $.extend({}, that.config, options);

        var nameObj = $(that.config.nameDOM);
        if (nameObj[0]) {
	        var $events = $._data(nameObj[0], 'events');
	        if ($events && $events["click"]) {
		        console.log("already bind click");
		        return;
	        }
        }
        
        //上级机构选择框
        $(that.config.nameDOM).on("click", function () {
            layer.open({
                type: 1, //type:0 也行
                title: "选择",
                area: ["400px", "80%"],
                content: '<ul id="dropTreeSel" class="dtree" data-id="null"></ul>',
                btn: ['确认选择'],
                success: function(layero, index){
                  var DTree = dtree.render({
                    obj: $(layero).find("#dropTreeSel"), 
                    url: that.config.url,
                    method:'GET',
                    dataFormat:'list',
                      dataStyle: 'layuiStyle',
                    initLevel: "4",
                    response:{
                        statusName: "Code", //返回标识（必填）
                        statusCode: 200, //返回码（必填）
                        message: "Message", //返回信息（必填）
                        rootName: "Result", //根节点名称（必填）
                        treeId: that.config.key, //节点ID（必填）
                        parentId: that.config.parentKey, //父节点ID（必填）
                        title: that.config.text, //节点名称（必填）
                    },
                    checkbar: that.config.selectedMulti, // 开启复选框
                    checkbarType:'p-casc',
                    success: function(data, obj){  //使用异步加载回调
                        $.each(data.Result,
                            function (i, item) {
                                item.checkArr=[{  //复选框的数据必须加上这个，😰
                                    type:0,
                                    isChecked:0
                                }]
                            })
                       },
                    done: function(data, obj){  //使用异步加载回调
                        var checkedIds = $(that.config.idDOM).val();
                        if (that.config.selectedMulti) {
	                        dtree.chooseDataInit("dropTreeSel", checkedIds); // 初始化复选框的值
                        } else {
                            dtree.dataInit("dropTreeSel", checkedIds);
                        }
                    }
                  });

                   // 绑定节点的双击
                   dtree.on("nodedblclick('dropTreeSel')", function(obj){
                        $(that.config.idDOM).val(obj.param.nodeId);
                        $(that.config.nameDOM).val(obj.param.context);
                        $(that.config.idDOM).change(); 

                        layer.close(index);
                    });
                },
                yes: function(index, layero) {
                  var flag = true;
                  var ids=[];
                  var names=[];
                  if(that.config.selectedMulti){  //多选
                    var multi = dtree.getCheckbarNodesParam("dropTreeSel"); // 获取选中值
                      if (multi.length == 0){
                      layer.msg("请至少选择一个节点",{icon:2});
                      flag = false;
                    }
                    
                      for (var key in multi){
                          var param = multi[key];
	                      ids.push(param.nodeId);
	                      names.push(param.context);
                    }
                  }
                  else{ //单选
                    var single = dtree.getNowParam("dropTreeSel"); // 获取当前选中节点
                      if (single == null){
                        layer.msg("请至少选择一个节点",{icon:2});
                        flag = false;
                    }
                      ids.push(single.nodeId);
                      names.push(single.context);
                  }
                  
                  $(that.config.idDOM).val(ids.join(","));
                  $(that.config.nameDOM).val(names.join(","));
                  $(that.config.idDOM).change(); 
                  if(flag){
                    layer.close(index);
                  }
                }
              });
        });
     };
     
    //默认配置
    DropTree.prototype.config = {
        text: 'Name',
        key: 'Id',
        parentKey: 'ParentId',
        selectedMulti: true    //默认是多选
    };

    exports('droptree', function (url, name, id, selectedMulti) {
      var options = {
            nameDOM: name,   //显示的文本框ID，如："#catetoryName"
            idDOM: id,   //隐藏的文本框，如："#categoryId"
            url: url,
            selectedMulti: selectedMulti  //是否为多选
        }
        inst = new DropTree(options);
        return inst;
    });
});