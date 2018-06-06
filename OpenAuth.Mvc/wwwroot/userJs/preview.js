layui.config({
    base: "/js/"
}).use(['form','vue', 'layer', 'jquery', 'table','droptree','utils'], function () {
    var form = layui.form,
        element = layui.element,
		layer = (top == undefined || top.layer === undefined )? layui.layer : top.layer,
        $ = layui.jquery;
    var id = $.getUrlParam("id");
    $.getJSON("/forms/get?id=" + id, function (data) {
        $("#content").html(data.Result.Html);
    });

})