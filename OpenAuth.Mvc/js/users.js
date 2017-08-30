layui.config({
	base : "/js/"
}).use(['form','layer','jquery','laypage', 'table'],function(){
	var form = layui.form,
		layer = parent.layer === undefined ? layui.layer : parent.layer,
		laypage = layui.laypage,
		$ = layui.jquery;
    var table = layui.table;
    //监听表格复选框选择
    table.on('checkbox(demo)', function (obj) {
        console.log(obj)
    });
    //监听工具条
    table.on('tool(demo)', function (obj) {
        var data = obj.data;
        if (obj.event === 'detail') {
            layer.msg('ID：' + data.id + ' 的查看操作');
        } else if (obj.event === 'del') {
            layer.confirm('真的删除行么', function (index) {
                obj.del();
                layer.close(index);
            });
        } else if (obj.event === 'edit') {
            layer.alert('编辑行：<br>' + JSON.stringify(data))
        }
    });

    var  active = {
                         getCheckData: function () { //获取选中数据
                             var checkStatus = table.checkStatus('idTest')
                                 , data = checkStatus.data;
                             layer.alert(JSON.stringify(data));
                         }
                         , getCheckLength: function () { //获取选中数目
                             var checkStatus = table.checkStatus('idTest')
                                 , data = checkStatus.data;
                             layer.msg('选中了：' + data.length + ' 个');
                         }
                         , isAll: function () { //验证是否全选
                             var checkStatus = table.checkStatus('idTest');
                             layer.msg(checkStatus.isAll ? '全选' : '未全选')
                         }
                     };

    $('.demoTable .layui-btn').on('click', function () {
        var type = $(this).data('type');
        active[type] ? active[type].call(this) : '';
    });

	////加载页面数据
	//var usersData = '';
	//$.get("/json/usersList.json", function(data){
	//	usersData = data;
	//	if(window.sessionStorage.getItem("addUser")){
	//		var addUser = window.sessionStorage.getItem("addUser");
	//		usersData = JSON.parse(addUser).concat(usersData);
	//	}
	//	//执行加载数据的方法
	//	usersList();
	//})

	////查询
	//$(".search_btn").click(function(){
	//	var userArray = [];
	//	if($(".search_input").val() != ''){
	//		var index = layer.msg('查询中，请稍候',{icon: 16,time:false,shade:0.8});
    //        setTimeout(function(){
    //        	$.ajax({
	//				url : "../../json/usersList.json",
	//				type : "get",
	//				dataType : "json",
	//				success : function(data){
	//					if(window.sessionStorage.getItem("addUser")){
	//						var addUser = window.sessionStorage.getItem("addUser");
	//						usersData = JSON.parse(addUser).concat(data);
	//					}else{
	//						usersData = data;
	//					}
	//					for(var i=0;i<usersData.length;i++){
	//						var usersStr = usersData[i];
	//						var selectStr = $(".search_input").val();
	//	            		function changeStr(data){
	//	            			var dataStr = '';
	//	            			var showNum = data.split(eval("/"+selectStr+"/ig")).length - 1;
	//	            			if(showNum > 1){
	//								for (var j=0;j<showNum;j++) {
	//	            					dataStr += data.split(eval("/"+selectStr+"/ig"))[j] + "<i style='color:#03c339;font-weight:bold;'>" + selectStr + "</i>";
	//	            				}
	//	            				dataStr += data.split(eval("/"+selectStr+"/ig"))[showNum];
	//	            				return dataStr;
	//	            			}else{
	//	            				dataStr = data.split(eval("/"+selectStr+"/ig"))[0] + "<i style='color:#03c339;font-weight:bold;'>" + selectStr + "</i>" + data.split(eval("/"+selectStr+"/ig"))[1];
	//	            				return dataStr;
	//	            			}
	//	            		}
	//	            		//用户名
	//	            		if(usersStr.userName.indexOf(selectStr) > -1){
	//		            		usersStr["userName"] = changeStr(usersStr.userName);
	//	            		}
	//	            		//用户邮箱
	//	            		if(usersStr.userEmail.indexOf(selectStr) > -1){
	//		            		usersStr["userEmail"] = changeStr(usersStr.userEmail);
	//	            		}
	//	            		//性别
	//	            		if(usersStr.userSex.indexOf(selectStr) > -1){
	//		            		usersStr["userSex"] = changeStr(usersStr.userSex);
	//	            		}
	//	            		//会员等级
	//	            		if(usersStr.userGrade.indexOf(selectStr) > -1){
	//		            		usersStr["userGrade"] = changeStr(usersStr.userGrade);
	//	            		}
	//	            		if(usersStr.userName.indexOf(selectStr)>-1 || usersStr.userEmail.indexOf(selectStr)>-1 || usersStr.userSex.indexOf(selectStr)>-1 || usersStr.userGrade.indexOf(selectStr)>-1){
	//	            			userArray.push(usersStr);
	//	            		}
	//	            	}
	//	            	usersData = userArray;
	//	            	usersList(usersData);
	//				}
	//			})
            	
    //            layer.close(index);
    //        },2000);
	//	}else{
	//		layer.msg("请输入需要查询的内容");
	//	}
	//})

	////添加会员
	//$(".usersAdd_btn").click(function(){
	//	var index = layui.layer.open({
	//		title : "添加会员",
	//		type : 2,
	//		content : "addUser.html",
	//		success : function(layero, index){
	//			setTimeout(function(){
	//				layui.layer.tips('点击此处返回会员列表', '.layui-layer-setwin .layui-layer-close', {
	//					tips: 3
	//				});
	//			},500)
	//		}
	//	})
	//	//改变窗口大小时，重置弹窗的高度，防止超出可视区域（如F12调出debug的操作）
	//	$(window).resize(function(){
	//		layui.layer.full(index);
	//	})
	//	layui.layer.full(index);
	//})

	////批量删除
	//$(".batchDel").click(function(){
	//	var $checkbox = $('.users_list tbody input[type="checkbox"][name="checked"]');
	//	var $checked = $('.users_list tbody input[type="checkbox"][name="checked"]:checked');
	//	if($checkbox.is(":checked")){
	//		layer.confirm('确定删除选中的信息？',{icon:3, title:'提示信息'},function(index){
	//			var index = layer.msg('删除中，请稍候',{icon: 16,time:false,shade:0.8});
	//            setTimeout(function(){
	//            	//删除数据
	//            	for(var j=0;j<$checked.length;j++){
	//            		for(var i=0;i<usersData.length;i++){
	//						if(usersData[i].newsId == $checked.eq(j).parents("tr").find(".news_del").attr("data-id")){
	//							usersData.splice(i,1);
	//							usersList(usersData);
	//						}
	//					}
	//            	}
	//            	$('.users_list thead input[type="checkbox"]').prop("checked",false);
	//            	form.render();
	//                layer.close(index);
	//				layer.msg("删除成功");
	//            },2000);
	//        })
	//	}else{
	//		layer.msg("请选择需要删除的文章");
	//	}
	//})

    ////全选
	//form.on('checkbox(allChoose)', function(data){
	//	var child = $(data.elem).parents('table').find('tbody input[type="checkbox"]:not([name="show"])');
	//	child.each(function(index, item){
	//		item.checked = data.elem.checked;
	//	});
	//	form.render('checkbox');
	//});

	////通过判断文章是否全部选中来确定全选按钮是否选中
	//form.on("checkbox(choose)",function(data){
	//	var child = $(data.elem).parents('table').find('tbody input[type="checkbox"]:not([name="show"])');
	//	var childChecked = $(data.elem).parents('table').find('tbody input[type="checkbox"]:not([name="show"]):checked')
	//	if(childChecked.length == child.length){
	//		$(data.elem).parents('table').find('thead input#allChoose').get(0).checked = true;
	//	}else{
	//		$(data.elem).parents('table').find('thead input#allChoose').get(0).checked = false;
	//	}
	//	form.render('checkbox');
	//})

	////操作
	//$("body").on("click",".users_edit",function(){  //编辑
	//	layer.alert('您点击了会员编辑按钮，由于是纯静态页面，所以暂时不存在编辑内容，后期会添加，敬请谅解。。。',{icon:6, title:'文章编辑'});
	//})

	//$("body").on("click",".users_del",function(){  //删除
	//	var _this = $(this);
	//	layer.confirm('确定删除此用户？',{icon:3, title:'提示信息'},function(index){
	//		//_this.parents("tr").remove();
	//		for(var i=0;i<usersData.length;i++){
	//			if(usersData[i].usersId == _this.attr("data-id")){
	//				usersData.splice(i,1);
	//				usersList(usersData);
	//			}
	//		}
	//		layer.close(index);
	//	});
	//})

	//function usersList(){
	//	//渲染数据
	//	function renderDate(data,curr){
	//		var dataHtml = '';
	//		currData = usersData.concat().splice(curr*nums-nums, nums);
	//		if(currData.length != 0){
	//			for(var i=0;i<currData.length;i++){
	//				dataHtml += '<tr>'
	//		    	+  '<td><input type="checkbox" name="checked" lay-skin="primary" lay-filter="choose"></td>'
	//		    	+  '<td>'+currData[i].userName+'</td>'
	//		    	+  '<td>'+currData[i].userEmail+'</td>'
	//		    	+  '<td>'+currData[i].userSex+'</td>'
	//		    	+  '<td>'+currData[i].userGrade+'</td>'
	//		    	+  '<td>'+currData[i].userStatus+'</td>'
	//		    	+  '<td>'+currData[i].userEndTime+'</td>'
	//		    	+  '<td>'
	//				+    '<a class="layui-btn layui-btn-mini users_edit"><i class="iconfont icon-edit"></i> 编辑</a>'
	//				+    '<a class="layui-btn layui-btn-danger layui-btn-mini users_del" data-id="'+data[i].usersId+'"><i class="layui-icon">&#xe640;</i> 删除</a>'
	//		        +  '</td>'
	//		    	+'</tr>';
	//			}
	//		}else{
	//			dataHtml = '<tr><td colspan="8">暂无数据</td></tr>';
	//		}
	//	    return dataHtml;
	//	}

	//	//分页
	//	var nums = 13; //每页出现的数据量
	//	laypage.render({
	//		cont : "page",
	//		pages : Math.ceil(usersData.length/nums),
	//		jump : function(obj){
	//			$(".users_content").html(renderDate(usersData,obj.curr));
	//			$('.users_list thead input[type="checkbox"]').prop("checked",false);
	//	    	form.render();
	//		}
	//	})
	//}
        
})