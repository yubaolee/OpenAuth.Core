$(function() {
    $.getclientdata();
});

var clientuserData = [];
$.getclientdata = function () {
    $.ajax({
        url: "/UserManager/GetAccessedUsers",
        type: "get",
        dataType: "json",
        async: false,
        success: function (data) {
            clientuserData = data;
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            console.log("加载可访问的用户列表失败！");
        }
    });
}