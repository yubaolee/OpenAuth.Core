$.IMSignalR = function (options) {
    var defaults = {
        url: "http://localhost:8081/signalr",//服务地址
        userId: "",//用户登录Id
        updateUserList: function (userAllList, onLineUserList) { },//刷新用户列表
        updateLastUser: function (userLasrList) { },//刷新最新联系人
        updateUserStatus: function (userId, isOnLine) { },//刷用户在线状态0离线。1在线
        revMessage: function (formUser, message, dateTime) { },//接收消息
        revGroupMessage: function (userId, toGroup, message, dateTime) { },//接收群组消息
        afterLinkSuccess: function () { },//连接服务成功后
        disconnected: function () { }//断开连接后
    };
    var imMethod = {
        //组的操作
        IMCreateGroup: function (groupName, userIdList) { },//创建一个组
        IMUpdateGroupName: function (groupId, groupName) { },//更改组的名字
        IMAddGroupUserId: function (groupId, userId) { },//增加一个用户到组里
        IMRemoveGroupUserId: function (userGroupId) { },//从一个组里面移除
        //消息的操作
        IMSendToOne: function (toUser, message) { },//发送消息
        IMSendGroup: function (toUser, message) { },//发送消息群组
        IMUpdateMessageStatus: function (sendId) { },//更新消息状态
        IMGetMsgList: function (page, rownum, sendId, callback) { },//获取消息列表
        IMGetUnReadMsgNumList: function () { },//获取未读消息的条数
        //联系人操作
        IMUpdateLastUserByClient: function () { },//主动发起更新最近联系人列表
        //获取所有用户列表
        userAllList: {},
    };
    var options = $.extend(defaults, options);
    //Set the hubs URL for the connection
    $.connection.hub.url = options.url;
    $.connection.hub.qs = { "userId": options.userId };
    // Declare a proxy to reference the hub.
    var chat = $.connection.ChatsHub;
    //更新联系人列表
    chat.client.IMUpdateUserList = function (userAllList, onLineUserList) {
        var userDepartmentList = {};
        imMethod.userAllList = userAllList;
        $.each(userAllList, function (Id, item) {
            if (Id != options.userId) {
                if (userDepartmentList[item.DepartmentId] == undefined) {
                    userDepartmentList[item.DepartmentId] = {};
                    userDepartmentList[item.DepartmentId].DepartmentName = item.DepartmentId;
                    if (item.UserOnLine == 1) {
                        userDepartmentList[item.DepartmentId].onLineNum = 1;
                    }
                    else {
                        userDepartmentList[item.DepartmentId].onLineNum = 0;
                    }
                    userDepartmentList[item.DepartmentId].UserList = [];
                    userDepartmentList[item.DepartmentId].UserList.push(item);
                }
                else {
                    if (item.UserOnLine == 1) {
                        userDepartmentList[item.DepartmentId].onLineNum++;
                    }
                    userDepartmentList[item.DepartmentId].UserList.push(item);
                }
            }
        });
        options.updateUserList(userDepartmentList, onLineUserList);
    }
    //刷新最近的联系人
    chat.client.IMUpdateLastUser = function (lastUserList) {
        options.updateLastUser(lastUserList);
    }
    //刷新用户在线状态
    chat.client.IMUpdateUserStatus = function (userId, isOnLine) {
        imMethod.userAllList[userId].UserOnLine = isOnLine;
        options.updateUserStatus(userId, isOnLine);
    }
    //接收消息
    chat.client.RevMessage = function (formUser, message, dateTime) {
        options.revMessage(formUser, message, dateTime);
    }
    //接收群消息
    chat.client.RevGroupMessage = function (userId, toGroup, message, dateTime) {
        options.revGroupMessage(userId, toGroup, message, dateTime);
    }
    // 连接成功后注册服务器方法
    $.connection.hub.start().done(function () {
        imMethod.IMCreateGroup = function (groupName, userIdList) {
            return chat.server.createGroup(groupName, userIdList);
        };
        imMethod.IMUpdateGroupName = function (groupId, groupName) {
            return chat.server.updateGroupName(groupId, groupName);
        };
        imMethod.IMAddGroupUserId = function (groupId, userId) {
            return chat.server.addGroupUserId(groupId, userId);
        };
        imMethod.IMRemoveGroupUserId = function (userGroupId) {
            return chat.server.removeGroupUserId(userGroupId);
        };

        imMethod.IMSendToOne = function (toUser, message) {
            chat.server.imSendToOne(toUser, message);
        };
        imMethod.IMSendGroup = function (toUser, message) {
            chat.server.imSendToGroup(toUser, message);
        };
        imMethod.IMUpdateMessageStatus = function (sendId) {
            return chat.server.updateMessageStatus(sendId);
        };
        //获取与某用户的消息列表
        imMethod.IMGetMsgList = function (page, rownum, sendId, callback) {
            var pagination = { rows: rownum, page: page, sidx: 'CreateDate', sord: 'desc' }
            chat.server.getMsgList(pagination, sendId).done(function (resdata) {
                var data = [];
                for (i = resdata.length, i >= 0; i--;) {
                    resdata[i].CreateDate = formatDate(resdata[i].CreateDate, 'yyyy-MM-dd hh:mm');
                    data.push(resdata[i]);
                }
                callback(data);
            });

        };
        //获取未读消息的条数
        imMethod.IMGetUnReadMsgNumList = function (callback) {
            chat.server.getMsgNumList("0").done(function (resdata) {
                callback(resdata);
            });
        };

        imMethod.IMUpdateLastUserByClient = function () {
            chat.server.imSendLastUser();
        }

        options.afterLinkSuccess();
    });
    //断开连接后
    $.connection.hub.disconnected(function () {
        options.disconnected();
    });
    //返回可供客户端调用的方法
    return imMethod;
}
//即使通信
IMInit = function (options) {
    var $message_wrap = $(".message-wrap");
    var $message_window = $(".message-window");
    var imMethod;
    var defaults = {
        userId: "77653de4-d8e7-4903-9f2a-ee47ba3111da",//当前登录Id
        userName: "",                                   //当前用户名,
        toUserId: "",                                   //发送人Id
        toUserName: "",                                 //发送人
        windowId: "",   //当前窗口Id
        revMessage: GetMessage,
        afterLinkSuccess: function () { //连接成功后
            //显示消息未读条数
            imMethod.IMGetUnReadMsgNumList(function (num) {
                $message_wrap.find('.message-count').html(num);
                if (parseInt(num) > 0)
                {
                    IMIconflash(1);
                }
            });
        },
        disconnected: function () {
            IMRemove();
        },
        //初始化联系人列表
        updateUserList: function (userAllList, onLineUserList) {
            var $ul = $(".message-group #message-contact-list"); 
            var html = "";
            for (var i in userAllList)
            {
                var item = userAllList[i];
                console.log(item);
                html += '<li><a><i class="fa fa-caret-right"></i><span>' + item.DepartmentName + '</span><em> ' + item.onLineNum + '/' + item.UserList.length + ' </em></a>'
                var userJson = userAllList[i].UserList.sort(function (a, b) { return a.UserOnLine < b.UserOnLine ? 1 : -1 });
                if (userJson.length > 0) {
                    html += '<ul class="message-chatlist">';
                    $.each(userJson, function (j) {
                        var src = "/Content/images/off-line.png";
                        if (userJson[j].UserOnLine == 1) {
                            src = "/Content/images/on-line.png";
                        }
                        html += '<li>';
                        html += '<div class="message-oneface"><img src="' + top.contentPath + src + '" /></div>';
                        html += '<div data-value="' + userJson[j].UserId + '" class="message-onename">' + userJson[j].RealName + ' <span>[' + userAllList[i].DepartmentName + ']</span></div>';
                        html += '</li>';
                    });
                    html += '</ul>';
                }
                html += '</li>';
            }
            $ul.html(html);
            //点击部门名称展开
            $message_wrap.find('.message-group a').click(function () {
                if (!$(this).hasClass("active")) {
                    $(this).addClass("active")
                    $(this).next('.message-chatlist').slideDown(200);
                    $(this).find('i').removeClass('fa-caret-right').addClass('fa-caret-down');
                } else {
                    $(this).removeClass("active")
                    $(this).next('.message-chatlist').slideUp(200);
                    $(this).find('i').removeClass('fa-caret-down').addClass('fa-caret-right');
                }
            });
            //打开聊天窗口
            OpenChatWindow();
            //关闭聊天窗口
            CloseChatWindow();
        },
        //更新最近联系人列表
        updateLastUser: UpDateLastUser,
        //刷新用户在线状态
        updateUserStatus: function (userId, isOnline) {
            var node = $message_wrap.find('.message-chatlist li').find('[data-value=' + userId + ']')[0];
            var emnode = $(node.parentNode.parentNode.parentNode).find('em');
            var usernumlist = emnode.html().split('/');
            var OnlineNum = parseInt(usernumlist[0].replace(/ /g, ''));//刷新列表人数
            var src = "off-line.png"
            if (isOnline == 1) {
                var linode = $(node.parentNode).clone();
                var ulnode = $(node.parentNode.parentNode);
                ulnode.prepend(linode);
                $(node.parentNode).remove();

                src = "on-line.png";
                OnlineNum++;
            }
            else {
                OnlineNum--;
            }
            $message_wrap.find('.message-chatlist li').find('[data-value=' + userId + ']').prev('.message-oneface').find('img').attr('src', top.contentPath + '/Content/images/' + src + '');
            emnode.html(" " + OnlineNum + '/' + usernumlist[1]);

        }
    };
    var options = $.extend(defaults, options);

    
    try
    {
        imMethod = $.IMSignalR(options);
    }
    catch(e)
    {
        IMRemove();
        return false;
    }
   

    //打开即时聊天
    $("#btn_message").click(function () {
        $(this).hide()
        $message_wrap.show();
    })
    //关闭即时聊天
    $message_wrap.find('.message-close').click(function () {
        IMIconflash(0);
        $message_wrap.hide();
        $message_window.hide();
        $("#btn_message").show();
    })
    //导航切换（联系人、讨论组、最近回话）
    $message_wrap.find('.message-nav li').click(function () {
        var tab_Id = $(this).attr('id');
        switch (tab_Id) {
            case "nav-contact-tab":
                $message_wrap.find("#message-contact-list").show();
                $message_wrap.find("#message-group-list").hide();
                $message_wrap.find("#message-last-list").hide();
                $(this).find('span').hide();
                break;
            case "nav-group-tab":
                $message_wrap.find("#message-group-list").show();
                $message_wrap.find("#message-contact-list").hide();
                $message_wrap.find("#message-last-list").hide();
                break;
            case "nav-last-tab":
                $message_wrap.find("#message-last-list").show();
                $message_wrap.find("#message-contact-list").hide();
                $message_wrap.find("#message-group-list").hide();
                $(this).find('span').show();
                break;
            default:
                break;

        }
        $(this).parents('ul').find('li').removeClass("active");
        $(this).addClass("active");
    });
    //搜索（同事、讨论组、最近回话）
    $message_wrap.find('.message-body-search').find('.search-text').keyup(function () {
        var $chatlist = $("#message-contact-list").find('.message-chatlist');
        var value = $(this).val();
        if (value != "") {
            $chatlist.show();
            $chatlist.prev('a').hide();
            window.setTimeout(function () {
                $chatlist.find('li')
                 .hide()
                 .filter(":contains('" + (value) + "')")
                 .show();
            }, 200);
            $chatlist.find('li').hover(function () {
                $(this).find('span').show();
            }, function () {
                $(this).find('span').hide();
            })
        } else {
            $chatlist.hide();
            $chatlist.find('li').show();
            $chatlist.prev('a').show();
            if ($chatlist.prev('a').hasClass('active')) {
                $chatlist.prev('a.active').next('ul').show();
            }
            $chatlist.find('li').find('span').hide();
        }
    }).keyup();


    //刷新最近联系人列表
    function UpDateLastUser(userLasrList) {
        var $ul = $(".message-group #message-last-list");
        var html = "";
        //显示消息未读条数
        imMethod.IMGetUnReadMsgNumList(function (num) {
            $message_wrap.find('.message-count').html(num);
        });
        $ul.html(html);
        $.each(userLasrList, function (i, item) {

            var model = imMethod.userAllList[item.OtherId];
            var src = "off-line.png"
            if (model.UserOnLine == 1) {
                src = "on-line.png"
            }
            html += '<li>';
            html += '<div class="message-oneface"><img src="' + top.contentPath + '/Content/images/' + src + '" /></div>';
            html += '<div data-value="' + model.UserId + '" class="message-onename">' + model.RealName + ' <span>[' + model.DepartmentId + ']</span></div>';
            if (item.UnReadNum > 0) {
                html += '<span class="message-count">' + item.UnReadNum + '</span>';
            }
            html += '</li>';
        });
        $ul.append(html);
        $ul.find('li').hover(function () {
            $(this).find('span').show();
        }, function () {
            $(this).find('span').hide();
        })
        //打开聊天窗口
        OpenChatWindow();
        //关闭聊天窗口
        CloseChatWindow();
    }
    //打开聊天窗口
    function OpenChatWindow() {
        $message_wrap.find('.message-chatlist li').click(function () {
            $message_window.show();
            var id = $(this).find('.message-onename').attr('data-value');
            var name = $(this).find('.message-onename').text();

            defaults.toUserId = id;
            defaults.toUserName = name;
            defaults.windowId = id;
            $message_window.find('.message-window-header .text').html('与 ' + name + ' 聊天中')
            $message_window.find('.message-window-chat').scrollTop($message_window.find('.message-window-chat')[0].scrollHeight);
            $message_window.find('.message-window-chat').find('.message-window-content').html('');

            //IMIconflash(0);
            imMethod.IMGetMsgList(1, 5, id, function (data) {
                imMethod.IMUpdateMessageStatus(id);
                $.each(data, function (i) {
                    GetMessage(data[i].SendId, data[i].Content, data[i].CreateDate, true);
                });
                //显示消息未读条数
                imMethod.IMGetUnReadMsgNumList(function (num) {
                    $message_wrap.find('.message-count').html(num);
                });
                $(this).find('.message-count').html("");
            });
        });
    }
    //关闭聊天窗口
    function CloseChatWindow() {
        $message_window.find('.message-window-header .close').click(function () {
            $message_window.hide();
            defaults.windowId = "";
        })
    }
    SendMessage();
    //发消息
    function SendMessage() {
        var $textarea = $message_window.find('.message-window-send').find('textarea');
        $textarea.bind('keypress', function (event) {
            if (event.keyCode == "13") {
                var sendText = $(this).val();
                if (sendText) {
                    imMethod.IMSendToOne(options.toUserId, sendText);
                    $message_window.find('.message-window-send').html('<textarea autofocus placeholder="按回车发送消息,shift+回车换行"></textarea>');
                    SendMessage();
                }
            }
        });
    }
    //收消息
    function GetMessage(fromUer, content, dateTime,flag) {
        if (fromUer != options.userId) {
            if (options.windowId == fromUer)
            {
                var html = '<div class="left"><div class="author-name">';
                html += '<img src="/Content/images/on-line.png" />';
                html += '<small class="chat-text">' + options.toUserName + '</small>';
                html += '<small class="chat-date">' + dateTime + '</small>';
                html += '</div><div class="chat-message"><em></em>' + content + '</div></div>';
                $message_window.find('.message-window-content').append(html)
                $message_window.find('.message-window-chat').scrollTop($message_window.find('.message-window-chat')[0].scrollHeight);
            }
            if (flag == undefined) {
                //统计未读消息总数量
                if (options.windowId != fromUer) {
                    var num = parseInt($message_wrap.find('.message-count').html());
                    num += 1;
                    if (num > 99) {
                        num = 99;
                    }
                    $message_wrap.find('.message-count').html(num);
                    IMIconflash(1);
                }
                else {//如果窗口是打开的就判定为已读
                    imMethod.IMUpdateMessageStatus(fromUer);
                }
            }
        } else {
            var html = '<div class="right"><div class="author-name">';
            html += '<small class="chat-date">2015-11-25 11:24</small>';
            html += '<small class="chat-text">' + options.userName + '</small>';
            html += '<img src="/Content/images/on-line.png" />';
            html += '</div>';
            html += '<div class="chat-message"><em></em>' + content + '</div></div>';
            $message_window.find('.message-window-content').append(html)
            $message_window.find('.message-window-chat').scrollTop($message_window.find('.message-window-chat')[0].scrollHeight);
        }
    }
}
//图标闪乐
var IMinterval;
IMIconflash = function (state) {
    var $obj = $("#icon_message");
    if (state == 1) {
        if ($('body').find('embed').length == 0) {
            $('body').append('<embed src="' + top.contentPath + '/Content/images/video/5103.wav">');
        }
        else {
            $('embed').remove();
            $('body').append('<embed src="' + top.contentPath + '/Content/images/video/5103.wav">');
        }
        IMinterval = setInterval(function () {
            if (!$obj.hasClass('_ok')) {
                $obj.addClass('_ok');
                $obj.hide();
            } else {
                $obj.removeClass('_ok');
                $obj.show();
            }
        }, 400);
    } else {
        $obj.removeClass('_ok');
        $obj.show();
        clearInterval(IMinterval);
    }
}
//服务端断开，移除消息窗体
IMRemove = function () {
    var $obj = $('#btn_message');
    var $messagewrap = $('.message-wrap');
    $obj.remove();
    $messagewrap.remove();
    top.dialogTop("消息服务器连接不上", "error");
}