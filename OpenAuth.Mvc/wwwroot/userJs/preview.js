layui.config({
    base: "/js/"
}).use(['form','vue', 'layer', 'jquery', 'table','droptree','utils'], function () {
    var form = layui.form,
        element = layui.element,
		layer = (top == undefined || top.layer === undefined )? layui.layer : top.layer,
        $ = layui.jquery;
    var id = $.getUrlParam("id");
    $.getJSON("/forms/get?id=" + id, function (data) {
	    if (data.Result.FrmType == 0) {
		    $("#content").html(data.Result.Html);
	    } else {
            $("#content").html("复杂表单暂时只能在<a href='http://demo.openauth.me:1803'>企业版</a>查看，开源版预计会在以后的开源版本中发布");
	    }
    });

})