$(function () {
    $.getclientdata();
})
var clientdataItem = [];
var clientorganizeData = [];
var clientdepartmentData = [];
var clientpostData = [];
var clientroleData = [];
var clientuserGroup = [];
var clientuserData = [];
var authorizeMenuData = [];
var authorizeButtonData = [];
var authorizeColumnData = [];
$.getclientdata = function () {
    $.ajax({
        url: contentPath + "/ClientData/GetClientDataJson",
        type: "post",
        dataType: "json",
        async: false,
        success: function (data) {
            clientdataItem = data.dataItem;
            clientorganizeData = data.organize;
            clientdepartmentData = data.department;
            clientpostData = data.post;
            clientroleData = data.role;
            clientuserGroup = data.userGroup;
            clientuserData = data.user;
            authorizeMenuData = data.authorizeMenu;
            authorizeButtonData = data.authorizeButton;
            authorizeColumnData = data.authorizeColumn;
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            dialogMsg(errorThrown, -1);
        }
    });
}