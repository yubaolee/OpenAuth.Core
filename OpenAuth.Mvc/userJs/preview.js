layui.config({
    base: "/js/"
}).use(['form','vue', 'layer', 'jquery', 'table','droptree','utils'], function () {
    var form = layui.form,
        element = layui.element,
		//layer = (parent == undefined || parent.layer === undefined )? layui.layer : parent.layer,
        layer = layui.layer,
        $ = layui.jquery;
    var id = $.getUrlParam("id");
    $.getJSON("/forms/get?id=" + id, function (data) {
        $("#content").html(data.Result.Html);
    });

})