layui.config({
	base : "/js/"
}).use(['form','element','layer','jquery'],function(){
	var form = layui.form,
		layer = parent.layer === undefined ? layui.layer : parent.layer,
		element = layui.element,
		$ = layui.jquery;

	$(".panel a").on("click",function(){
		window.parent.addTab($(this));
	})


	//用户数
	$.getJSON("/UserManager/Load?limit=1&page=1",
		function(data){
			$(".userAll span").text(data.count);
		}
	)

    //机构
	$.getJSON("/UserSession/GetOrgs",
        function (data) {
            $(".orgs span").text(data.Result.length);
        }
    )

    //角色
    $.getJSON("/RoleManager/Load",
        function (data) {
            $(".roles span").text(data.Result.length);
        }
    )

    //我的流程
    $.getJSON("/Flowinstances/Load?limit=1&page=1",
        function (data) {
            $(".flows span").text(data.count);
        }
    )

    //流程模板
    $.getJSON("/flowschemes/Load?limit=1&page=1",
        function (data) {
            $(".flowschemes span").text(data.count);
        }
    )

    //表单
    $.getJSON("/Forms/Load?limit=1&page=1",
        function (data) {
            $(".forms span").text(data.count);
        }
    )

	//数字格式化
	$(".panel span").each(function(){
		$(this).html($(this).text()>9999 ? ($(this).text()/10000).toFixed(2) + "<em>万</em>" : $(this).text());	
	})

	//系统基本参数
    $(".version").text("v2.0");      //当前版本
    $(".author").text("yubaolee");        //开发作者
    $(".homePage").text("/Home/Index");    //网站首页
    $(".server").text("centos docker");        //服务器环境
    $(".dataBase").text("mysql 5.7");    //数据库版本
    $(".maxUpload").text("100M");    //最大上传限制
    $(".userRights").text("管理员");//当前用户权限

})
