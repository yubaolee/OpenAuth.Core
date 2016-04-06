/*!
 * B-JUI  v1.3 beta2 (http://b-jui.com)
 * Git@OSC (http://git.oschina.net/xknaan/B-JUI)
 * Copyright 2014 K'naan.
 * Licensed under Apache (http://www.apache.org/licenses/LICENSE-2.0)
 */

/* ========================================================================
 * B-JUI: bjui-core.js  v1.3 beta2
 * @author K'naan
 * -- Modified from dwz.core.js (author:ZhangHuihua@msn.com)
 * http://git.oschina.net/xknaan/B-JUI/blob/master/BJUI/js/bjui-core.js
 * ========================================================================
 * Copyright 2014 K'naan.
 * Licensed under Apache (http://www.apache.org/licenses/LICENSE-2.0)
 * ======================================================================== */

+function ($) {
    'use strict';
    
    var BJUI = {
        JSPATH     : 'BJUI/',
        PLUGINPATH : 'BJUI/plugins/',
        IS_DEBUG   : false,
        KeyPressed : { //key press state
            ctrl  : false,
            shift : false
        },
        keyCode: {
            ENTER : 13, ESC  : 27, END : 35, HOME : 36,
            SHIFT : 16, CTRL : 17, TAB : 9,
            LEFT  : 37, RIGHT: 39, UP  : 38, DOWN : 40,
            DELETE: 46, BACKSPACE: 8
        },
        eventType: {
            initUI         : 'bjui.initUI',         // When document load completed or ajax load completed, B-JUI && Plugins init 
            beforeInitUI   : 'bjui.beforeInitUI',   // If your DOM do not init [add to DOM attribute 'data-noinit="true"']
            afterInitUI    : 'bjui.afterInitUI',    // 
            ajaxStatus     : 'bjui.ajaxStatus',     // When performing ajax request, display or hidden progress bar
            resizeGrid     : 'bjui.resizeGrid',     // When the window or dialog resize completed
            beforeAjaxLoad : 'bjui.beforeAjaxLoad', // When perform '$.fn.ajaxUrl', to do something...
            
            beforeLoadNavtab  : 'bjui.beforeLoadNavtab',
            beforeLoadDialog  : 'bjui.beforeLoadDialog',
            afterLoadNavtab   : 'bjui.afterLoadNavtab',
            afterLoadDialog   : 'bjui.afterLoadDialog',
            beforeCloseNavtab : 'bjui.beforeCloseNavtab',
            beforeCloseDialog : 'bjui.beforeCloseDialog',
            afterCloseNavtab  : 'bjui.afterCloseNavtab',
            afterCloseDialog  : 'bjui.afterCloseDialog'
        },
        pageInfo: {pageCurrent:'pageCurrent', pageSize:'pageSize', orderField:'orderField', orderDirection:'orderDirection'},
        alertMsg: {displayPosition:'topcenter', alertTimeout: 6000}, //alertmsg display position && close timeout
        ajaxTimeout: 30000,
        statusCode: {ok:200, error:300, timeout:301},
        keys: {statusCode:'statusCode', message:'message'},
        ui: {
            windowWidth      : 0,
            showSlidebar     : true,      // After the B-JUI initialization, display slidebar
            clientPaging     : true,      // Response paging and sorting information on the client
            overwriteHomeTab : false      // When open an undefined id of navtab, whether overwrite the home navtab
        },
        debug: function(msg) {
            if (this.IS_DEBUG) {
                if (typeof(console) != 'undefined') console.log(msg)
                else alert(msg)
            }
        },
        loginInfo: {
            url    : 'login.html',
            title  : 'Login',
            width  : 420,
            height : 260,
            mask   : true
        },
        loadLogin: function() {
            var login = this.loginInfo
            
            BJUI.dialog({id:'bjui-login', url:login.url, title:login.title, width:login.width, height:login.height, mask:login.mask})
        },
        init: function(options) {
            var op = $.extend({}, options)
            
            $.extend(BJUI.statusCode, op.statusCode)
            $.extend(BJUI.pageInfo, op.pageInfo)
            $.extend(BJUI.alertMsg, op.alertMsg)
            $.extend(BJUI.loginInfo, op.loginInfo)
            $.extend(BJUI.ui, op.ui)
            
            if (op.JSPATH) this.JSPATH = op.JSPATH
            if (op.PLUGINPATH) this.PLUGINPATH = op.PLUGINPATH
            if (op.ajaxTimeout) this.ajaxTimeout = op.ajaxTimeout
            
            this.IS_DEBUG = op.debug || false
            this.initEnv()
            
            if ((!$.cookie || !$.cookie('bjui_theme')) && op.theme) $(this).theme('setTheme', op.theme)
        },
        initEnv: function() {
            $(window).resize(function() {
                var ww = $(this).width()
                
                if (BJUI.ui.windowWidth) {
                    if (BJUI.ui.windowWidth > 600 && BJUI.ui.windowWidth < ww)
                        ww = BJUI.ui.windowWidth
                }
                
                BJUI.initLayout(ww)
                setTimeout(function() {$(this).trigger(BJUI.eventType.resizeGrid)}, 30)
            })
            
            setTimeout(function() {
                var ww = $(window).width()
                
                if (BJUI.ui.windowWidth) {
                    if (BJUI.ui.windowWidth > 600 && BJUI.ui.windowWidth < ww)
                        ww = BJUI.ui.windowWidth
                }
                
                BJUI.initLayout(ww)
                $(document).initui()
            }, 10)
        },
        initLayout: function(ww) {
            var iContentW = ww - (BJUI.ui.showSlidebar ? $('#bjui-sidebar').width() + 6 : 6),
                iContentH = $(window).height() - $('#bjui-header').height() - $('#bjui-footer').outerHeight(), 
                navtabH   = $('#bjui-navtab').find('.tabsPageHeader').height()
            
            if (BJUI.ui.windowWidth) $('#bjui-window').width(ww)
            BJUI.windowWidth = ww
            
            $('#bjui-container').height(iContentH)
            $('#bjui-navtab').width(iContentW)
            $('#bjui-leftside, #bjui-sidebar, #bjui-sidebar-s, #bjui-splitBar, #bjui-splitBarProxy').css({height:'100%'})
            $('#bjui-navtab .tabsPageContent').height(iContentH - navtabH)
            
            /* fixed pageFooter */
            setTimeout(function() {
                $('#bjui-navtab > .tabsPageContent > .navtabPage').resizePageH()
                $('#bjui-navtab > .tabsPageContent > .navtabPage').find('.bjui-layout').resizePageH()
            }, 10)
            
            /* header navbar */
            var navbarWidth = $('body').data('bjui.navbar.width'),
                $header = $('#bjui-header'), $toggle = $header.find('.bjui-navbar-toggle'), $logo = $header.find('.bjui-navbar-logo'), $navbar = $('#bjui-navbar-collapse'), $nav = $navbar.find('.bjui-navbar-right')
            
            if (!navbarWidth) {
                navbarWidth = {logoW:$logo.outerWidth(), navW:$nav.outerWidth()}
                $('body').data('bjui.navbar.width', navbarWidth)
            }
            if (navbarWidth) {
                if (ww - navbarWidth.logoW < navbarWidth.navW) {
                    $toggle.show()
                    $navbar.addClass('collapse menu')
                } else {
                    $toggle.hide()
                    $navbar.removeClass('collapse menu in')
                }
            }
            /* horizontal navbar */
            var $hnavbox  = $('#bjui-hnav-navbar-box'),
                $hnavbar  = $hnavbox.find('> #bjui-hnav-navbar'),
                $hmoreL   = $hnavbox.prev(),
                $hmoreR   = $hnavbox.next(),
                hboxWidth = $hnavbox.width(),
                liW       = 0
            
            $hnavbar.find('> li').each(function(i) {
                var $li = $(this)
                
                liW += $li.outerWidth()
                
                if (liW > hboxWidth) {
                    $hmoreR.show()
                    $hnavbox.data('hnav.move', true).data('hnav.liw', liW)
                } else {
                    $hmoreL.hide()
                    $hmoreR.hide()
                    $hnavbox.removeData('hnav.move')
                }
            })
        },
        regional: {},
        setRegional: function(key, value) {
            BJUI.regional[key] = value
        },
        getRegional : function(key) {
            if (String(key).indexOf('.') >= 0) {
                var msg, arr = String(key).split('.')
                
                for (var i = 0; i < arr.length; i++) {
                    if (!msg) msg = BJUI.regional[arr[i]]
                    else msg = msg[arr[i]]
                }
                
                return msg
            } else {
                return BJUI.regional[key]
            }
        },
        doRegional: function(frag, regional) {
            $.each(regional, function(k, v) {
                frag = frag.replaceAll('#'+ k +'#', v)
            })
            
            return frag
        },
        // is ie browser
        isIE: function(ver) {
            var b = document.createElement('b')
            
            b.innerHTML = '<!--[if IE '+ ver +']><i></i><![endif]-->'
            
            return b.getElementsByTagName('i').length === 1
        },
        StrBuilder: function() {
            return new StrBuilder()
        }
    }
    
    function StrBuilder() {
        this.datas = new Array()
    }
    
    StrBuilder.prototype.add = function(str) {
        if (typeof str !== 'undefined') this.datas.push(str)
        return this
    }
    
    StrBuilder.prototype.toString = function(str) {
        var string = this.datas.join(str || '')
        
        this.clear()
        
        return string
    }
    
    StrBuilder.prototype.isEmpty = function(){
        return this.datas.length == 0
    }
    
    StrBuilder.prototype.clear = function(){
        this.datas = []
        this.datas.length = 0
    }
    
    window.BJUI = BJUI
    
}(jQuery);
/*!
 * B-JUI  v1.3 beta2 (http://b-jui.com)
 * Git@OSC (http://git.oschina.net/xknaan/B-JUI)
 * Copyright 2014 K'naan.
 * Licensed under Apache (http://www.apache.org/licenses/LICENSE-2.0)
 */

/* ========================================================================
 * B-JUI: bjui-regional.zh-CN.js  v1.3 beta2
 * @author K'naan
 * http://git.oschina.net/xknaan/B-JUI/blob/master/BJUI/js/bjui-regional.zh-CN.js
 * ========================================================================
 * Copyright 2014 K'naan.
 * Licensed under Apache (http://www.apache.org/licenses/LICENSE-2.0)
 * ======================================================================== */

+function ($) {
    'use strict';
    
    $(function() {
        
        /* 消息提示框 */
        BJUI.setRegional('alertmsg', {
            title  : {error : '错误提示', info : '信息提示', warn : '警告信息', correct : '成功信息', confirm : '确认信息'},
            btnMsg : {ok    : '确定', yes  : '是',   no   : '否',   cancel  : '取消'}
        })
        
        /* dialog */
        BJUI.setRegional('dialog', {
            close    : '关闭',
            maximize : '最大化',
            restore  : '还原',
            minimize : '最小化',
            title    : '弹出窗口'
        })
        
        /* order by */
        BJUI.setRegional('orderby', {
            asc  : '升序',
            desc : '降序'
        })
        
        /* 分页 */
        BJUI.setRegional('pagination', {
            total   : '总记录数/总页数',
            first   : '首页',
            last    : '末页',
            prev    : '上一页',
            next    : '下一页',
            jumpto  : '输入跳转页码，回车确认',
            jump    : '跳转',
            page    : '页',
            refresh : '刷新'
        })
        
        BJUI.setRegional('datagrid', {
            asc       : '升序',
            desc      : '降序',
            showhide  : '显示/隐藏 列',
            filter    : '过滤',
            clear     : '清除',
            lock      : '锁定列',
            unlock    : '解除锁定',
            add       : '添加',
            edit      : '编辑',
            save      : '保存',
            update    : '更新',
            cancel    : '取消',
            del       : '删除',
            prev      : '上一条',
            next      : '下一条',
            refresh   : '刷新',
            query     : '查询',
            'import'  : '导入',
            'export'  : '导出',
            all       : '全部',
            'true'    : '是',
            'false'   : '否',
            noData    : '没有数据！',
            expandMsg : '点我展开行！',
            shrinkMsg : '点我收缩行！',
            selectMsg : '未选中任何行！',
            editMsg   : '请先保存编辑行！',
            saveMsg   : '没有需要保存的行！',
            delMsg    : '确定要删除该行吗？',
            delMsgM   : '确定要删除选中行？'
        })
        
        BJUI.setRegional('findgrid', {
            choose : '选择选中项',
            append : '追加选择',
            empty  : '清空现有值'
        })
        
        /* ajax加载提示 */
        BJUI.setRegional('progressmsg', '正在努力加载数据，请稍等...')
        
        /* 日期选择器 */
        BJUI.setRegional('datepicker', {
            close      : '关闭',
            prev       : '上月',
            next       : '下月',
            clear      : '清空',
            ok         : '确定',
            dayNames   : ['日', '一', '二', '三', '四', '五', '六'],
            monthNames : ['一月', '二月', '三月', '四月', '五月', '六月', '七月', '八月', '九月', '十月', '十一月', '十二月']
        })
        
        /* navtab右键菜单  */
        BJUI.setRegional('navtabCM', {
            refresh    : '刷新本标签',
            close      : '关闭本标签',
            closeother : '关闭其他标签',
            closeall   : '关闭所有标签'
        })
        
        /* dialog右键菜单 */
        BJUI.setRegional('dialogCM', {
            refresh    : '刷新本窗口',
            close      : '关闭本窗口',
            closeother : '关闭其他窗口',
            closeall   : '关闭所有窗口'
        })
        
        /* upload按钮提示 */
        BJUI.setRegional('upload', {
            upConfirm    : '开始上传',
            upPause      : '暂停上传',
            upCancel     : '取消上传'
        })
    
        /* 503错误提示 */
        BJUI.setRegional('statusCode_503', '服务器当前负载过大或者正在维护！')
        
        /* AJAX 状态返回 0 提示 */
        BJUI.setRegional('ajaxnosend', '与服务器的通信中断，请检查URL链接或服务器状态！')
        
        /* timeout提示 */
        BJUI.setRegional('sessiontimeout', '会话超时，请重新登陆！')
        
        /* 占位符对应选择器无有效值提示 */
        BJUI.setRegional('plhmsg', '占位符对应的选择器无有效值！')
        
        /* 未定义复选框组名提示 */
        BJUI.setRegional('nocheckgroup', '未定义选中项的组名[复选框的"data-group"]！')
        
        /* 未选中复选框提示 */
        BJUI.setRegional('notchecked', '未选中任何一项！')
        
        /* 未选中下拉菜单提示 */
        BJUI.setRegional('selectmsg', '请选择一个选项！')
        
        /* 表单验证错误提示信息 */
        BJUI.setRegional('validatemsg', '提交的表单中 [{0}] 个字段有错误，请更正后再提交！')
        
        /* ID检查 */
        BJUI.setRegional('idChecked', '不规范，ID需以字母开头，组成部分包括（0-9，字母，中横线，下划线）')
        
        /* 框架名称 */
        BJUI.setRegional('uititle', 'B-JUI')
        
        /* 主navtab标题 */
        BJUI.setRegional('maintab', '我的主页')
        
        /**
         * 
         *  Plugins regional setting
         * 
         */
        /* nice validate - Global configuration */
        $.validator && $.validator.config({
            //stopOnError: false,
            //theme: 'yellow_right',
            defaultMsg: "{0}格式不正确",
            loadingMsg: "正在验证...",
            
            // Custom rules
            rules: {
                digits: [/^\d+$/, '请输入整数']
                ,number: [/^[\-\+]?((([0-9]{1,3})([,][0-9]{3})*)|([0-9]+))?([\.]([0-9]+))?$/, '请输入有效的数字']
                ,letters: [/^[a-z]+$/i, '{0}只能输入字母']
                ,tel: [/^(?:(?:0\d{2,3}[\- ]?[1-9]\d{6,7})|(?:[48]00[\- ]?[1-9]\d{6}))$/, '电话格式不正确']
                ,mobile: [/^1[3-9]\d{9}$/, '手机号格式不正确']
                ,email: [/^[\w\+\-]+(\.[\w\+\-]+)*@[a-z\d\-]+(\.[a-z\d\-]+)*\.([a-z]{2,4})$/i, '邮箱格式不正确']
                ,qq: [/^[1-9]\d{4,}$/, 'QQ号格式不正确']
                //,date: [/^\d{4}-\d{1,2}-\d{1,2}$/, '请输入正确的日期,例:yyyy-mm-dd']
                ,date:[/^\d{4}[\/\-](0?[1-9]|1[012])[\/\-](0?[1-9]|[12][0-9]|3[01])$/, '请输入正确的日期，例：yyyy-MM-dd']
                //,time: [/^([01]\d|2[0-3])(:[0-5]\d){1,2}$/, '请输入正确的时间,例:14:30或14:30:00']
                ,time: [/^(2[0123]|(1|0?)[0-9]){1}:([0-5][0-9]){1}:([0-5][0-9]){1}$/, '请输入正确的时间，例：HH:mm:ss']
                ,datetime: [/^\d{4}[\/\-](0?[1-9]|1[012])[\/\-](0?[1-9]|[12][0-9]|3[01])\s+(2[0123]|(1|0?)[0-9]){1}:([0-5][0-9]){1}:([0-5][0-9]){1}$/,
                            '请输入正确的日期时间，例：yyyy-MM-dd HH:mm:ss']
                ,ID_card: [/^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])((\d{4})|\d{3}[A-Z])$/, '请输入正确的身份证号码']
                ,url: [/^(https?|ftp):\/\/[^\s]+$/i, '网址格式不正确']
                ,postcode: [/^[1-9]\d{5}$/, '邮政编码格式不正确']
                ,chinese: [/^[\u0391-\uFFE5]+$/, '请输入中文']
                ,username: [/^\w{3,12}$/, '请输入3-12位数字、字母、下划线']
                ,password: [/^[0-9a-zA-Z]{6,16}$/, '密码由6-16位数字、字母组成']
                ,pattern:function(element, params) {
                    if (!params) return true
                    
                    var date = element.value.parseDate(params)
                    
                    return (!date ? this.renderMsg('错误的日期时间格式！', params) : true)
                }
                ,accept: function(element, params) {
                    if (!params) return true
                    
                    var ext = params[0]
                    
                    return (ext === '*') ||
                           (new RegExp('.(?:' + (ext || 'png|jpg|jpeg|gif') + ')$', 'i')).test(element.value) ||
                           this.renderMsg('只接受{1}后缀', ext.replace('|', ','))
                }
                
            }
        })

        /* nice validate - Default error messages */
        $.validator && $.validator.config({
            messages: {
                required: '{0}不能为空',
                remote: '{0}已被使用',
                integer: {
                    '*': '请输入整数',
                    '+': '请输入正整数',
                    '+0': '请输入正整数或0',
                    '-': '请输入负整数',
                    '-0': '请输入负整数或0'
                },
                match: {
                    eq: '{0}与{1}不一致',
                    neq: '{0}与{1}不能相同',
                    lt: '{0}必须小于{1}',
                    gt: '{0}必须大于{1}',
                    lte: '{0}必须小于或等于{1}',
                    gte: '{0}必须大于或等于{1}'
                },
                range: {
                    rg: '请输入{1}到{2}的数',
                    gte: '请输入大于或等于{1}的数',
                    lte: '请输入小于或等于{1}的数'
                },
                checked: {
                    eq: '请选择{1}项',
                    rg: '请选择{1}到{2}项',
                    gte: '请至少选择{1}项',
                    lte: '请最多选择{1}项'
                },
                length: {
                    eq: '请输入{1}个字符',
                    rg: '请输入{1}到{2}个字符',
                    gte: '请至少输入{1}个字符',
                    lte: '请最多输入{1}个字符',
                    eq_2: '',
                    rg_2: '',
                    gte_2: '',
                    lte_2: ''
                }
            }
        })
    })
    
}(jQuery);
/*!
 * B-JUI  v1.3 beta2 (http://b-jui.com)
 * Git@OSC (http://git.oschina.net/xknaan/B-JUI)
 * Copyright 2014 K'naan.
 * Licensed under Apache (http://www.apache.org/licenses/LICENSE-2.0)
 */

/* ========================================================================
 * B-JUI: bjui-frag.js  v1.3 beta2
 * @author K'naan
 * http://git.oschina.net/xknaan/B-JUI/blob/master/BJUI/js/bjui-frag.js
 * ========================================================================
 * Copyright 2014 K'naan.
 * Licensed under Apache (http://www.apache.org/licenses/LICENSE-2.0)
 * ======================================================================== */

+function ($) {
    'use strict';

    BJUI.setRegional('alertmsg', {
        title  : {error : 'Error', info : 'Info', warn : 'Warning', correct : 'Correct', confirm : 'Confirm'},
        btnMsg : {ok    : 'OK',    yes  : 'YES',  no   : 'NO',      cancel  : 'Cancel'}
    })
    
    BJUI.setRegional('dialog', {
        close    : 'Close',
        maximize : 'Maximize',
        restore  : 'Restore',
        minimize : 'Minimize',
        title    : 'Popup window'
    })
    
    BJUI.setRegional('orderby', {
        asc  : 'Asc',
        desc : 'Desc'
    })
    
    BJUI.setRegional('pagination', {
        first  : 'First page',
        last   : 'Last page',
        prev   : 'Prev page',
        next   : 'Next page',
        jumpto : 'Jump page number',
        jump   : 'Jump'
    })
    
    BJUI.setRegional('datagrid', {
        asc       : 'ASC',
        desc      : 'DESC',
        showhide  : 'Show/Hide columns',
        filter    : 'Filter',
        clear     : 'Clear',
        lock      : 'Lock',
        unlock    : 'Unlock',
        add       : 'Add',
        edit      : 'Edit',
        save      : 'Save',
        update    : 'Update',
        cancel    : 'Cancel',
        del       : 'Delete',
        prev      : 'Prev',
        next      : 'Next',
        refresh   : 'Refresh',
        query     : 'Query',
        'import'  : 'Import',
        'export'  : 'Export',
        all       : 'All',
        'true'    : 'True',
        'false'   : 'False',
        noData    : 'No data!',
        expandMsg : 'Click here to expand the tr!',
        shrinkMsg : 'Click here to shrink the tr!',
        selectMsg : 'Not selected any rows!',
        saveMsg   : 'No rows need to save!',
        editMsg   : 'Please save the edited row!',
        delMsg    : 'Sure you want to delete this row?',
        delMsgM   : 'Sure you want to delete selected rows?'
    })
    
    BJUI.setRegional('findgrid', {
        choose : 'Choose the selected item',
        append : 'Append choose the selected item',
        empty  : 'Empty existing values'
    })
    
    BJUI.setRegional('progressmsg', 'Data loading, please waiting...')
    
    BJUI.setRegional('datepicker', {
        close      : 'Close',
        prev       : 'Prev month',
        next       : 'Next month',
        clear      : 'Clear',
        ok         : 'OK',
        dayNames   : ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],
        monthNames : ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
    })
    
    BJUI.setRegional('navtabCM', {
        refresh    : 'Refresh navtab',
        close      : 'Close navtab',
        closeother : 'Close other navtab',
        closeall   : 'Close all navtab'
    })
    
    BJUI.setRegional('dialogCM', {
        refresh    : 'Refresh dialog',
        close      : 'Close dialog',
        closeother : 'Close other dialog',
        closeall   : 'Close all dialog'
    })
    
    BJUI.setRegional('upload', {
        upConfirm    : 'Start upload',
        upPause      : 'Pause upload',
        upCancel     : 'Cancel upload'
    })
    
    BJUI.setRegional('statusCode_503', 'HTTP status 503, the current server load is too large or is down for maintenance!')
    
    BJUI.setRegional('ajaxnosend', 'Communication with the server is interrupted, please check the URL link or server status!')
    
    BJUI.setRegional('sessiontimout', 'Session timeout, please login!')
    
    BJUI.setRegional('plhmsg', 'Placeholder corresponding selector None Valid!')
    
    BJUI.setRegional('nocheckgroup', 'Undefined group name selected item [check box "data-group"]!')
    
    BJUI.setRegional('notchecked', 'Unchecked any one!')
    
    BJUI.setRegional('selectmsg', 'Please select one option!')
    
    BJUI.setRegional('validatemsg', 'Submitted form data has [{0}] field an error, please after modified submitting!')
    
    BJUI.setRegional('idChecked', 'is not standardized, ID need to start with a letter, components include (0-9, letters, hyphens, underscore)')
    
    BJUI.setRegional('uititle', 'B-JUI')
    
    BJUI.setRegional('maintab', 'My home')
    
    
    window.FRAG = {
        dialog: '<div class="bjui-dialog bjui-dialog-container" style="top:150px; left:300px;">' +
                '    <div class="dialogHeader" onselectstart="return false;" oncopy="return false;" onpaste="return false;" oncut="return false;">' +
                '        <a class="close" href="javascript:;" title="#close#"><i class="fa fa-times-circle"></i></a>' +
                '        <a class="maximize" href="javascript:;" title="#maximize#"><i class="fa fa-plus-circle"></i></a>' +
                '        <a class="restore" href="javascript:;" title="#restore#"><i class="fa fa-history"></i></a>' +
                '        <a class="minimize" href="javascript:;" title="#minimize#"><i class="fa fa-minus-circle"></i></a>' +
                '        <h1><span><i class="fa fa-th-large"></i></span> <span class="title">#title#</span></h1>' +
                '    </div>' +
                '    <div class="dialogContent unitBox"></div>' +
                '    <div class="resizable_h_l" tar="nw"></div>' +
                '    <div class="resizable_h_r" tar="ne"></div>' +
                '    <div class="resizable_h_c" tar="n"></div>' +
                '    <div class="resizable_c_l" tar="w" style="height:100%;"></div>' +
                '    <div class="resizable_c_r" tar="e" style="height:100%;"></div>' +
                '    <div class="resizable_f_l" tar="sw"></div>' +
                '    <div class="resizable_f_r" tar="se"></div>' +
                '    <div class="resizable_f_c" tar="s"></div>' +
                '</div>'
        ,
        taskbar: '<div id="bjui-taskbar" style="left:0px; display:none;">' +
                 '    <div class="taskbarContent">' +
                 '        <ul></ul>' +
                 '    </div>' +
                 '    <div class="taskbarLeft taskbarLeftDisabled"><i class="fa fa-angle-double-left"></i></div>' +
                 '    <div class="taskbarRight"><i class="fa fa-angle-double-right"></i></div>' +
                 '</div>'
        ,
        splitBar: '<div id="bjui-splitBar"></div>',
        splitBarProxy: '<div id="bjui-splitBarProxy"></div>',
        resizable: '<div id="bjui-resizable" class="bjui-resizable"></div>',
        alertBackground: '<div class="bjui-alertBackground"></div>',
        maskBackground: '<div class="bjui-maskBackground bjui-ajax-mask"></div>',
        maskProgress: '<div class="bjui-maskProgress bjui-ajax-mask"><i class="fa fa-cog fa-spin"></i>&nbsp;&nbsp;#progressmsg#<div class="progressBg"><div class="progress"></div></div></div>',
        progressBar_custom: '<div id="bjui-progressBar-custom" class="progressBar"><i class="fa fa-cog fa-spin"></i> <span></span></div>',
        dialogMask: '<div class="bjui-dialogBackground"></div>',
        orderby: '<a href="javascript:;" class="order asc" data-order-direction="asc" title="#asc#"><i class="fa fa-angle-up"></i></a>' +
                 '<a href="javascript:;" class="order desc" data-order-direction="desc" title="#desc#"><i class="fa fa-angle-down"></i></a>'
        ,
        slidePanel: '<div class="panel panel-default">' +
                    '    <div class="panel-heading">' +
                    '        <h4 class="panel-title"><a data-toggle="collapse" data-parent="#bjui-accordionmenu" href="##id#" class="#class#">#icon#&nbsp;#title#<b>#righticon#</b></a></h4>' +
                    '    </div>' +
                    '    <div id="#id#" class="panel-collapse collapse#bodyclass#">' +
                    '        <div class="panel-body">' +
                    '        </div>' +
                    '    </div>' +
                    '</div>'
        ,                    
        pagination: '<ul class="pagination">' +
                    '    <li class="j-first">' +
                    '        <a class="first" href="javascript:;"><i class="fa fa-step-backward"></i> #first#</a>' +
                    '        <span class="first"><i class="fa fa-step-backward"></i> #first#</span>' +
                    '    </li>' +
                    '    <li class="j-prev">' +
                    '        <a class="previous" href="javascript:;"><i class="fa fa-backward"></i> #prev#</a>' +
                    '        <span class="previous"><i class="fa fa-backward"></i> #prev#</span>' +
                    '    </li>' +
                    '    #pageNumFrag#' +
                    '    <li class="j-next">' +
                    '        <a class="next" href="javascript:;">#next# <i class="fa fa-forward"></i></a>' +
                    '        <span class="next">#next# <i class="fa fa-forward"></i></span>' +
                    '    </li>' +
                    '    <li class="j-last">' +
                    '        <a class="last" href="javascript:;">#last# <i class="fa fa-step-forward"></i></a>' +
                    '        <span class="last">#last# <i class="fa fa-step-forward"></i></span>' +
                    '    </li>' +
                    '    <li class="jumpto"><span class="p-input"><input class="form-control input-sm-pages" type="text" size="2.6" value="#pageCurrent#" title="#jumpto#"></span><a class="goto" href="javascript:;" title="#jump#"><i class="fa fa-chevron-right"></i></a></li>' +
                    '</ul>'
        ,
        gridPaging: '<ul class="pagination">' +
                    '    <li class="page-total">' +
                    '        <span title="#total#">#count#</span>' +
                    '    </li>' +
                    '    <li class="page-jumpto"><span class="page-input"><input class="form-control input-sm-pages" type="text" size="3.2" value="#pageCurrent#" title="#jumpto#"></span></li>' +
                    '    <li class="page-first btn-nav">' +
                    '        <a href="javascript:;" title="#first#"><i class="fa fa-step-backward"></i></a>' +
                    '    </li>' +
                    '    <li class="page-prev btn-nav">' +
                    '        <a href="javascript:;" title="#prev#"><i class="fa fa-backward"></i></a>' +
                    '    </li>' +
                    '    #pageNumFrag#' +
                    '    <li class="page-next btn-nav">' +
                    '        <a href="javascript:;" title="#next#"><i class="fa fa-forward"></i></a>' +
                    '    </li>' +
                    '    <li class="page-last btn-nav">' +
                    '        <a href="javascript:;" title="#last#"><i class="fa fa-step-forward"></i></a>' +
                    '    </li>' +
                    '</ul>'
        ,
        gridPageNum : '<li class="page-num#active#"><a href="javascript:;">#num#</a></li>',
        gridMenu : '<div class="datagrid-menu-box">'
                 + '    <ul>'
                 + '        <li class="datagrid-li-asc"><a href="javascript:;"><span class="icon"><i class="fa fa-sort-amount-asc"></i></span><span class="title">#asc#</span></a></li>'
                 + '        <li class="datagrid-li-desc"><a href="javascript:;"><span class="icon"><i class="fa fa-sort-amount-desc"></i></span><span class="title">#desc#</span></a></li>'
                 + '        <li class="datagrid-li-filter"><a href="javascript:;"><span class="icon"><i class="fa fa-filter"></i></span><span class="title">#filter#</span><span class="arrow"></span></a></li>'
                 + '        <li class="datagrid-li-showhide"><a href="javascript:;"><span class="icon"><i class="fa fa-check-square-o"></i></span><span class="title">#showhide#</span><span class="arrow"></span></a></li>'
                 + '        <li class="datagrid-li-lock"><a href="javascript:;"><span class="icon"><i class="fa fa-lock"></i></span><span class="title">#lock#</span></a></li>'
                 + '        <li class="datagrid-li-unlock disable"><a href="javascript:;"><span class="icon"><i class="fa fa-unlock"></i></span><span class="title">#unlock#</span></a></li>'
                 + '    </ul>'
                 + '</div>'
        ,
        gridFilter: '<div class="datagrid-filter-box">'
                  + '<fieldset>'
                  + '<legend>#label#</legend>'
                  + '<span class="filter-a"></span>'
                  + '<span class="filter-and"><select data-toggle="selectpicker" data-container="true" data-width="100%"><option value="and">AND</option><option value="or">OR</option></select></span>'
                  + '<span class="filter-b"></span>'
                  + '<span class="filter-ok"><button type="button" class="btn-green ok" data-icon="check">#filter#</button><button type="button" class="btn-orange clear" data-icon="remove">#clear#</button></span>'
                  + '</fieldset>'
                  + '</div>'
        ,
        gridShowhide: '<li data-index="#index#" class="datagrid-col-check"><a href="javascript:;"><i class="fa fa-check-square-o"></i>#label#</a></li>',
        gridEditBtn : '<button type="button" class="btn btn-green edit"><i class="fa fa-edit"></i> #edit#</button>'
                    + '<button type="button" class="btn btn-green update"><i class="fa fa-edit"></i> #update#</button>'
                    + '<button type="button" class="btn btn-green save"><i class="fa fa-check"></i> #save#</button>'
                    + '<button type="button" class="btn btn-orange cancel"><i class="fa fa-undo"></i> #cancel#</button>'
                    + '<button type="button" class="btn btn-red delete"><i class="fa fa-remove"></i> #del#</button>'
        ,
        gridDialogEditBtns: '<ul>'
                          + '    <li class="pull-left"><button type="button" class="btn btn-orange prev" data-icon="arrow-up">#prev#</button></li>'
                          + '    <li class="pull-left"><button type="button" class="btn btn-orange next" data-icon="arrow-down">#next#</button></li>'
                          + '    <li><button type="button" class="btn btn-red cancel" data-icon="remove">#cancel#</button></li>'
                          + '    <li><button type="button" class="btn btn-default save" data-icon="save">#save#</button></li>'
                          + '</ul>'
        ,
        gridExpandBtn: '<span title="#expandMsg#"><i class="fa fa-plus"></i></span>',
        gridShrinkBtn: '<span title="#shrinkMsg#"><i class="fa fa-minus"></i></span>',
        alertBoxFrag: '<div id="bjui-alertMsgBox" class="bjui-alert"><div class="alertContent"><div class="#type#"><div class="alertInner"><h1><i class="fa #fa#"></i>#title#</h1><div class="msg">#message#</div></div><div class="toolBar"><ul>#btnFragment#</ul></div></div></div></div>',
        alertBtnFrag: '<li><button class="btn btn-#class#" rel="#callback#" type="button">#btnMsg#</button></li>',
        calendarFrag: '<div id="bjui-calendar">' +
                      '    <div class="main">' +
                      '        <a class="close" href="javascript:;" title="#close#"><i class="fa fa-times-circle"></i></a>' +
                      '        <div class="head">' +
                      '            <table width="100%" border="0" cellpadding="0" cellspacing="2">' +
                      '                <tr>' +
                      '                    <td width="20"><a class="prev" href="javascript:;" title="#prev#"><i class="fa fa-arrow-left"></i></a></td>' +
                      '                    <td><select name="year"></select></td>' +
                      '                    <td><select name="month"></select></td>' +
                      '                    <td width="20"><a class="next" href="javascript:;" title="#next#"><i class="fa fa-arrow-right"></i></a></td>' +
                      '                </tr>' +
                      '            </table>' +
                      '        </div>' +
                      '        <div class="body">' +
                      '            <dl class="dayNames"><dt>7</dt><dt>1</dt><dt>2</dt><dt>3</dt><dt>4</dt><dt>5</dt><dt>6</dt></dl>' +
                      '            <dl class="days"><!-- date list --></dl>' +
                      '            <div style="clear:both;height:0;line-height:0"></div>' +
                      '        </div>' +
                      '        <div class="foot">' +
                      '            <table class="time">' +
                      '                <tr>' +
                      '                    <td>' +
                      '                        <input type="text" class="hh" maxlength="2" data-type="hh" data-start="0" data-end="23">:<input' +
                      '                         type="text" class="mm" maxlength="2" data-type="mm" data-start="0" data-end="59">:<input' +
                      '                         type="text" class="ss" maxlength="2" data-type="ss" data-start="0" data-end="59">' +
                      '                    </td>' +
                      '                    <td><ul><li class="up" data-add="1">&and;</li><li class="down">&or;</li></ul></td>' +
                      '                </tr>' +
                      '            </table>' +
                      '            <button type="button" class="clearBtn btn btn-orange">#clear#</button>' +
                      '            <button type="button" class="okBtn btn btn-default">#ok#</button>' +
                      '        </div>' +
                      '        <div class="tm">' +
                      '            <ul class="hh">' +
                      '                <li>0</li>' +
                      '                <li>1</li>' +
                      '                <li>2</li>' +
                      '                <li>3</li>' +
                      '                <li>4</li>' +
                      '                <li>5</li>' +
                      '                <li>6</li>' +
                      '                <li>7</li>' +
                      '                <li>8</li>' +
                      '                <li>9</li>' +
                      '                <li>10</li>' +
                      '                <li>11</li>' +
                      '                <li>12</li>' +
                      '                <li>13</li>' +
                      '                <li>14</li>' +
                      '                <li>15</li>' +
                      '                <li>16</li>' +
                      '                <li>17</li>' +
                      '                <li>18</li>' +
                      '                <li>19</li>' +
                      '                <li>20</li>' +
                      '                <li>21</li>' +
                      '                <li>22</li>' +
                      '                <li>23</li>' +
                      '            </ul>' +
                      '            <ul class="mm">' +
                      '                <li>0</li>' +
                      '                <li>5</li>' +
                      '                <li>10</li>' +
                      '                <li>15</li>' +
                      '                <li>20</li>' +
                      '                <li>25</li>' +
                      '                <li>30</li>' +
                      '                <li>35</li>' +
                      '                <li>40</li>' +
                      '                <li>45</li>' +
                      '                <li>50</li>' +
                      '                <li>55</li>' +
                      '            </ul>' +
                      '            <ul class="ss">' +
                      '                <li>0</li>' +
                      '                <li>10</li>' +
                      '                <li>20</li>' +
                      '                <li>30</li>' +
                      '                <li>40</li>' +
                      '                <li>50</li>' +
                      '            </ul>' +
                      '        </div>' +
                      '    </div>' +
                      '</div>'
        ,
        spinnerBtn:  '<ul class="bjui-spinner"><li class="up" data-add="1">&and;</li><li class="down">&or;</li></ul>',
        lookupBtn:   '<a class="bjui-lookup" href="javascript:;" data-toggle="lookupbtn"><i class="fa fa-search"></i></a>',
        findgridBtn: '<a class="bjui-lookup" href="javascript:;" data-toggle="findgridbtn"><i class="fa fa-search"></i></a>',
        dateBtn:     '<a class="bjui-lookup" href="javascript:;" data-toggle="datepickerbtn"><i class="fa fa-calendar"></i></a>',
        navtabCM: '<ul id="bjui-navtabCM">' +
                  '    <li rel="reload"><span class="icon"><i class="fa fa-refresh"></i></span><span class="title">#refresh#</span></li>' +
                  '    <li rel="closeCurrent"><span class="icon"><i class="fa fa-remove"></i></span><span class="title">#close#</li>' +
                  '    <li rel="closeOther"><span class="icon"><i class="fa fa-remove"></i></span><span class="title">#closeother#</li>' +
                  '    <li rel="closeAll"><span class="icon"><i class="fa fa-remove"></i></span><span class="title">#closeall#</li>' +
                  '</ul>'
        ,
        dialogCM: '<ul id="bjui-dialogCM">' +
                  '    <li rel="reload"><span class="icon"><i class="fa fa-refresh"></i></span><span class="title">#refresh#</span></li>' +          
                  '    <li rel="closeCurrent"><span class="icon"><i class="fa fa-remove"></i></span><span class="title">#close#</span></li>' +
                  '    <li rel="closeOther"><span class="icon"><i class="fa fa-remove"></i></span><span class="title">#closeother#</span></li>' +
                  '    <li rel="closeAll"><span class="icon"><i class="fa fa-remove"></i></span><span class="title">#closeall#</span></li>' +
                  '</ul>'
        ,
        externalFrag: '<iframe src="{url}" style="width:100%;height:{height};" frameborder="no" border="0" marginwidth="0" marginheight="0"></iframe>',
        uploadTemp: '<div id="{fileId}" class="item">' +
                    '    <div class="info">' + 
                    '        <span class="up_filename">{fileName}</span><span class="up_confirm" title="#upConfirm#"><i class="fa fa-play-circle-o"></i></span><span class="up_pause" title="#upPause#"><span class="glyphicon glyphicon-pause"></span></span><span class="up_cancel" title="#upCancel#"><i class="fa fa-times-circle-o"></i></span>' +
                    '    </div>' +
                    '    <div class="preview"><span class="img"></span></div>' +
                    '    <div class="progress"><div class="bar"></div></div>' +
                    '    <span class="percent">{percent}</span>' +
                    '    <span class="filesize"><span class="uploadedsize">{uploadedSize}</span>/<span class="totalsize">{fileSize}</span></span>' +
                    '</div>'
        ,
        uploadFrag: '<input class="bjui-upload-select-file" style="display:none;" type="file" name="fileselect[]" #multi# accept="#accept#">'+
                    '<a href="javascript:void(0)" class="btn btn-default bjui-upload-select">#btnTxt#</a>' +
                    '<div class="queue"></div>'
    }
    
}(jQuery);
/*!
 * B-JUI  v1.3 beta2 (http://b-jui.com)
 * Git@OSC (http://git.oschina.net/xknaan/B-JUI)
 * Copyright 2014 K'naan.
 * Licensed under Apache (http://www.apache.org/licenses/LICENSE-2.0)
 */

/* ========================================================================
 * B-JUI: bjui-extends.js  v1.3 beta2
 * @author K'naan
 * http://git.oschina.net/xknaan/B-JUI/blob/master/BJUI/js/bjui-extends.js
 * ========================================================================
 * Copyright 2014 K'naan.
 * Licensed under Apache (http://www.apache.org/licenses/LICENSE-2.0)
 * ======================================================================== */

+function ($) {
    'use strict';
    
    $.fn.extend({
        /**
         * @param {Object} op: {type:GET/POST, url:ajax请求地址, data:ajax请求参数列表, callback:回调函数 }
         */
        ajaxUrl: function(op) {
            var $this = $(this)
            
            $this.trigger(BJUI.eventType.beforeAjaxLoad)
            
            if (op.loadingmask) {
                $this.trigger(BJUI.eventType.ajaxStatus)
            }
            
            $.ajax({
                type     : op.type || 'GET',
                url      : op.url,
                data     : op.data || {},
                cache    : false,
                dataType : 'html',
                timeout  : BJUI.ajaxTimeout,
                success  : function(response) {
                    var json = response.toJson(), $ajaxMask = $this.find('> .bjui-ajax-mask')
                    
                    if (!json[BJUI.keys.statusCode]) {
                        $this.empty().html(response).append($ajaxMask).initui()
                    } else {
                        if (json[BJUI.keys.statusCode] == BJUI.statusCode.error) {
                            if (json[BJUI.keys.message]) $this.alertmsg('error', json[BJUI.keys.message])
                            if (!$this.closest('.bjui-layout').length) {
                                if ($this.closest('.navtab-panel').length) $this.navtab('closeCurrentTab')
                                else $this.dialog('closeCurrent')
                            }
                        } else if (json[BJUI.keys.statusCode] == BJUI.statusCode.timeout) {
                            if ($this.closest('.bjui-dialog').length) $this.dialog('closeCurrent')
                            if ($this.closest('.navtab-panel').length) $this.navtab('closeCurrentTab')
                            
                            BJUI.alertmsg('info', (json[BJUI.keys.message] || BJUI.regional.sessiontimeout))
                            BJUI.loadLogin()
                        }
                        $ajaxMask.fadeOut('normal', function() {
                            $(this).remove()
                        })
                    }
                    
                    if ($.isFunction(op.callback)) op.callback(response)
                },
                error      : function(xhr, ajaxOptions, thrownError) {
                    $this.bjuiajax('ajaxError', xhr, ajaxOptions, thrownError)
                    if (!$this.closest('.bjui-layout').length) {
                        if ($this.closest('.navtab-panel').length) $this.navtab('closeCurrentTab')
                        else $this.dialog('closeCurrent')
                    }
                    $this.trigger('bjui.ajaxError')
                },
                statusCode : {
                    0  : function(xhr, ajaxOptions, thrownError) {
                        BJUI.alertmsg('error', BJUI.regional.ajaxnosend)
                    },
                    503: function(xhr, ajaxOptions, thrownError) {
                        BJUI.alertmsg('error', BJUI.regional.statusCode_503)
                    }
                }
            })
        },
        loadUrl: function(url,data,callback) {
            $(this).ajaxUrl({url:url, data:data, callback:callback})
        },
        doAjax: function(op) {
            var $this = $(this), $target, $ajaxMask
            
            if (!op.url) {
                BJUI.debug('The ajax url is undefined!')
                return
            }
            if (!op.callback) {
                BJUI.debug('The ajax callback is undefined!')
                return
            } else {
                op.callback = op.callback.toFunc()
            }
            if (op.loadingmask) {
                $target = $this.getPageTarget()
                $target.trigger(BJUI.eventType.ajaxStatus)
                $ajaxMask = $target.find('> .bjui-ajax-mask')
            }
            if (!op.type) op.type = 'POST'
            if (!op.dataType) op.dataType = 'json'
            if (!op.cache) op.cache = false
            op.timeout = op.ajaxTimeout || BJUI.ajaxTimeout
            op.success = function(response) {
                if ($ajaxMask) {
                    if (op.callback) {
                        $.when(op.callback(response)).done(function() {
                            $target.trigger('bjui.ajaxStop')
                        })
                    } else {
                        $target.trigger('bjui.ajaxStop')
                    }
                } else {
                    op.callback(response)
                }
            }
            op.error = op.error || function(xhr, ajaxOptions, thrownError) {
                BJUI.ajax('ajaxError', xhr, ajaxOptions, thrownError)
                if ($ajaxMask) {
                    $target.trigger('bjui.ajaxError')
                }
            }
            op.statusCode = {
                0  : function(xhr, ajaxOptions, thrownError) {
                    BJUI.alertmsg('error', BJUI.regional.ajaxnosend)
                },
                503: function(xhr, ajaxOptions, thrownError) {
                    BJUI.alertmsg('error', BJUI.regional.statusCode_503)
                }
            }
            
            $.ajax(op)
        },
        getPageTarget: function() {
            var $target
            
            if (this.closest('.bjui-layout').length) $target = this.closest('.bjui-layout')
            else if (this.closest('.navtab-panel').length) $target = $.CurrentNavtab
            else $target = $.CurrentDialog
            
            return $target
        },
        resizePageH: function() {
            return this.each(function() {
                if ($(this).closest('.tab-content').length) return
                
                var $box         = $(this),
                    $pageHeader  = $box.find('> .bjui-pageHeader'),
                    $pageContent = $box.find('> .bjui-pageContent'),
                    $pageFooter  = $box.find('> .bjui-pageFooter'),
                    headH        = $pageHeader.outerHeight() || 0,
                    footH        = $pageFooter.outerHeight() || 0
                
                if ($pageFooter.css('bottom')) footH += parseInt($pageFooter.css('bottom')) || 0
                if (!footH && $box.hasClass('dialogContent')) footH = 5
                $pageContent.css({top:headH, bottom:footH})
            })
        },
        getMaxIndexObj: function($elements) {
            var zIndex = 0, index = 0
            
            $elements.each(function(i) {
                var newZIndex = parseInt($(this).css('zIndex')) || 1
                
                if (zIndex < newZIndex) {
                    zIndex = newZIndex
                    index  = i
                }
            })
            
            return $elements.eq(index)
        },
        /**
         * 将表单数据转成JSON对象 用法：$(form).serializeJson() Author: K'naan
         */
        serializeJson: function () {
            var o = {}
            var a = this.serializeArray()
            
            $.each(a, function () {
                if (o[this.name] !== undefined) {
                    if (!o[this.name].push) {
                        o[this.name] = [o[this.name]]
                    }
                    o[this.name].push(this.value || '')
                } else {
                   o[this.name] = this.value || ''
                }
            })
            
            return o
        },
        isTag: function(tn) {
            if (!tn) return false
            if (!$(this).prop('tagName')) return false
            return $(this)[0].tagName.toLowerCase() == tn ? true : false
        },
        /**
         * 判断当前元素是否已经绑定某个事件
         * @param {Object} type
         */
        isBind: function(type) {
            var _events = $(this).data('events')
            return _events && type && _events[type]
        },
        /**
         * 输出firebug日志
         * @param {Object} msg
         */
        log: function(msg) {
            return this.each(function() {
                if (console) console.log('%s: %o', msg, this)
            })
        }
    })
    
    /**
     * 扩展String方法
     */
    $.extend(String.prototype, {
        isPositiveInteger: function() {
            return (new RegExp(/^[1-9]\d*$/).test(this))
        },
        isInteger: function() {
            return (new RegExp(/^\d+$/).test(this))
        },
        isNumber: function() {
            return (new RegExp(/^([-]{0,1}(\d+)[\.]+(\d+))|([-]{0,1}(\d+))$/).test(this))
        },
        isNormalID: function() {
            return (new RegExp(/^[a-zA-Z][0-9a-zA-Z_-]*$/).test(this))
        },
        includeChinese: function() {
        	return (new RegExp(/[\u4E00-\u9FA5]/).test(this))
        },
        trim: function() {
            return this.replace(/(^\s*)|(\s*$)|\r|\n/g, '')
        },
        startsWith: function (pattern) {
            return this.indexOf(pattern) === 0
        },
        endsWith: function(pattern) {
            var d = this.length - pattern.length
            return d >= 0 && this.lastIndexOf(pattern) === d
        },
        replaceSuffix: function(index) {
            return this.replace(/\[[0-9]+\]/,'['+index+']').replace('#index#',index)
        },
        replaceSuffix2: function(index) {
            return this.replace(/\-(i)([0-9]+)$/, '-i'+ index).replace('#index#', index)
        },
        trans: function() {
            return this.replace(/&lt;/g, '<').replace(/&gt;/g,'>').replace(/&quot;/g, '"')
        },
        encodeTXT: function() {
            return (this).replaceAll('&', '&amp;').replaceAll('<','&lt;').replaceAll('>', '&gt;').replaceAll(' ', '&nbsp;')
        },
        replaceAll: function(os, ns) {
            return this.replace(new RegExp(os, 'gm'), ns)
        },
        /*替换占位符为对应选择器的值*/ //{^(.|\#)[A-Za-z0-9_-\s]*}
        replacePlh: function($box) {
            $box = $box || $(document)
            return this.replace(/{\/?[^}]*}/g, function($1) {
                var $input = $box.find($1.replace(/[{}]+/g, ''))
                
                return $input && $input.val() ? $input.val() : $1
            })
        },
        replaceMsg: function(holder) {
            return this.replace(new RegExp('({.*})', 'g'), holder)
        },
        replaceTm: function($data) {
            if (!$data) return this
            
            return this.replace(RegExp('({[A-Za-z_]+[A-Za-z0-9_-]*})','g'), function($1) {
                return $data[$1.replace(/[{}]+/g, '')]
            })
        },
        replaceTmById: function(_box) {
            var $parent = _box || $(document)
            
            return this.replace(RegExp('({[A-Za-z_]+[A-Za-z0-9_-]*})','g'), function($1) {
                var $input = $parent.find('#'+ $1.replace(/[{}]+/g, ''))
                return $input.val() ? $input.val() : $1
            })
        },
        isFinishedTm: function() {
            return !(new RegExp('{\/?[^}]*}').test(this))
        },
        skipChar: function(ch) {
            if (!this || this.length===0) return ''
            if (this.charAt(0)===ch) return this.substring(1).skipChar(ch)
            return this
        },
        isValidPwd: function() {
            return (new RegExp(/^([_]|[a-zA-Z0-9]){6,32}$/).test(this))
        },
        isValidMail: function() {
            return(new RegExp(/^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/).test(this.trim()))
        },
        isSpaces: function() {
            for (var i = 0; i < this.length; i += 1) {
                var ch = this.charAt(i)
                
                if (ch!=' '&& ch!='\n' && ch!='\t' && ch!='\r') return false
            }
            return true
        },
        isPhone:function() {
            return (new RegExp(/(^([0-9]{3,4}[-])?\d{3,8}(-\d{1,6})?$)|(^\([0-9]{3,4}\)\d{3,8}(\(\d{1,6}\))?$)|(^\d{3,8}$)/).test(this))
        },
        isUrl:function() {
            return (new RegExp(/^[a-zA-z]+:\/\/([a-zA-Z0-9\-\.]+)([-\w .\/?%&=:]*)$/).test(this))
        },
        isExternalUrl:function() {
            return this.isUrl() && this.indexOf('://'+ document.domain) == -1
        },
        toBool: function() {
            return (this.toLowerCase() === 'true') ? true : false
        },
        toJson: function() {
            var json = this
            
            try {
                if (typeof json === 'object') json = json.toString()
                if (!json.trim().match("^\{(.+:.+,*){1,}\}$")) return this
                else return JSON.parse(this)
            } catch (e) {
                return this
            }
        },
        toObj: function() {
            var obj = null
            
            try {
                obj = (new Function('return '+ this))()
            } catch (e) {
                obj = this
                BJUI.debug('String toObj：Parse "String" to "Object" error! Your str is: '+ this)
            }
            return obj
        },
        /**
         * String to Function
         * 参数(方法字符串或方法名)： 'function(){...}' 或 'getName' 或 'USER.getName' 均可
         * Author: K'naan
         */
        toFunc: function() {
            if (!this || !this.length) return undefined
            
            if (this.startsWith('function')) {
                return (new Function('return '+ this))()
            }
            
            try {
                var m_arr = this.split('.'), fn = window
                
                for (var i = 0; i < m_arr.length; i++) {
                    fn = fn[m_arr[i]]
                }
                
                if (typeof fn === 'function') {
                    return fn
                }
            } catch (e) {
                return undefined
            }
        }
    })
    
    /* Function */
    $.extend(Function.prototype, {
        //to fixed String.prototype -> toFunc
        toFunc: function() {
            return this
        }
    })
    
    /* Array */
    $.extend(Array.prototype, {
        remove: function(index) {
            if (index < 0) return this
            else return this.slice(0, index).concat(this.slice(index + 1, this.length))
        },
        unique: function() {
            var temp = new Array()
            
            this.sort()
            for (var i = 0; i < this.length; i++) {
                if (this[i] == this[i + 1]) continue
                temp[temp.length] = this[i]
            }
            
            return temp
        },
        myIndexOf: function(e) {
            if (!this || !this.length) return -1
            
            for (var i = 0, j; j = this[i]; i++) {
                if (j == e) return i
            }
            
            return -1
        },
        /* serializeArray to json */
        toJson: function() {
            var o = {}
            var a = this
            
            $.each(a, function () {
                if (o[this.name] !== undefined) {
                    if (!o[this.name].push) {
                        o[this.name] = [o[this.name]]
                    }
                    o[this.name].push(this.value || '')
                } else {
                   o[this.name] = this.value || ''
                }
            })
            
            return o
        }
    })
    
    /* Global */
    $.isJson = function(obj) {
        var flag = true
        
        try {
            flag = $.parseJSON(obj)
        } catch (e) {
            return false
        }
        return flag ? true : false
    }
    
}(jQuery);
/*!
 * B-JUI  v1.3 beta2 (http://b-jui.com)
 * Git@OSC (http://git.oschina.net/xknaan/B-JUI)
 * Copyright 2014 K'naan.
 * Licensed under Apache (http://www.apache.org/licenses/LICENSE-2.0)
 */

/* ========================================================================
 * B-JUI: bjui-basedrag.js  v1.3 beta2
 * @author K'naan
 * http://git.oschina.net/xknaan/B-JUI/blob/master/BJUI/js/bjui-basedrag.js
 * ========================================================================
 * Copyright 2014 K'naan.
 * Licensed under Apache (http://www.apache.org/licenses/LICENSE-2.0)
 * ======================================================================== */

+function ($) {
    'use strict';

    // BASEDRAG CLASS DEFINITION
    // ======================
    
    var Basedrag = function(element, options) {
        this.$element = $(element)
        this.options  = options
    }
    
    Basedrag.prototype.init = function() {
        var that = this
        
        this.options.$obj = this.$element
        if (this.options.obj) this.options.$obj = this.options.obj
        if (this.options.event)
            this.start(this.options.event)
        else {
            if (this.options.selector)
                this.$element.find(this.options.selector).on('mousedown', function(e) { that.start.apply(that, [e]) })
            else
                this.$element.on('mousedown', function(e) { that.start.apply(that, [e]) })
        }
    }
    
    Basedrag.prototype.start = function(e) {
        document.onselectstart = function(e) { return false } //禁止选择
        var that = this
        
        if (!this.options.oleft) this.options.oleft = parseInt(this.$element.css('left')) || 0
        if (!this.options.otop)  this.options.otop  = parseInt(this.$element.css('top')) || 0
        
        $(document).on('mouseup.bjui.basedrag', function(e) { that.stop.apply(that, [e]) })
            .on('mousemove.bjui.basedrag', function(e) { that.drag.apply(that, [e]) })
    }
    
    Basedrag.prototype.drag = function(e) {
        if (!e) e = window.event
        var options = this.options,
            left    = (options.oleft + (e.pageX || e.clientX) - options.event.pageX),
            top     = (options.otop + (e.pageY || e.clientY) - options.event.pageY)
        
        if (top < 1) top = 0
        if (options.move == 'horizontal') {
            if ((options.minW && left >= parseInt(this.options.$obj.css('left')) + options.minW) && (options.maxW && left <= parseInt(this.options.$obj.css('left')) + options.maxW)) {
                this.$element.css('left', left)
            } else if (options.scop) {
                if (options.relObj) {
                    if ((left - parseInt(options.relObj.css('left'))) > options.cellMinW)
                        this.$element.css('left', left)
                    else
                        this.$element.css('left', left)
                }
            }
        } else if (options.move == 'vertical') {
            this.$element.css('top', top)
        } else {
            var $selector = options.selector ? this.options.$obj.find(options.selector) : this.options.$obj
            
            if (left >= -$selector.outerWidth() * 2 / 3 && top >= 0 && (left + $selector.outerWidth() / 3 < $(window).width()) && (top + $selector.outerHeight() < $(window).height())) {
                this.$element.css({left:left, top:top})
            }
        }
        if (options.drag)
            options.drag.apply(this.$element, [this.$element, e, left, top])
        
        return this.preventEvent(e)
    }
    
    Basedrag.prototype.stop = function(e) {
        $(document).off('mousemove.bjui.basedrag').off('mouseup.bjui.basedrag')
        if (this.options.stop)
            this.options.stop.apply(this.$element, [this.$element, e])
        if (this.options.event)
            this.destroy()
        document.onselectstart = function(e) { return true } //启用选择
        return this.preventEvent(e)
    }
    
    Basedrag.prototype.preventEvent = function(e) {
        if (e.stopPropagation) e.stopPropagation()
        if (e.preventDefault) e.preventDefault()
        return false
    }
    
    Basedrag.prototype.destroy = function() {
        this.$element.removeData('bjui.basedrag')
        if (!this.options.nounbind) this.$element.off('mousedown')
    }
    
    // BASEDRAG PLUGIN DEFINITION
    // =======================
    
    function Plugin(option) {
        var args     = arguments
        var property = option
        
        return this.each(function () {
            var $this   = $(this)
            var options = $.extend({}, $this.data(), typeof option === 'object' && option)
            var data    = $this.data('bjui.basedrag')
            
            if (!data) $this.data('bjui.basedrag', (data = new Basedrag(this, options)))
            if (typeof property === 'string' && $.isFunction(data[property])) {
                [].shift.apply(args)
                if (!args) data[property]()
                else data[property].apply(data, args)
            } else {
                data.init()
            }
        })
    }

    var old = $.fn.basedrag

    $.fn.basedrag             = Plugin
    $.fn.basedrag.Constructor = Basedrag
    
    // BASEDRAG NO CONFLICT
    // =================
    
    $.fn.basedrag.noConflict = function () {
        $.fn.basedrag = old
        return this
    }
    
}(jQuery);
/*!
 * B-JUI  v1.3 beta2 (http://b-jui.com)
 * Git@OSC (http://git.oschina.net/xknaan/B-JUI)
 * Copyright 2014 K'naan.
 * Licensed under Apache (http://www.apache.org/licenses/LICENSE-2.0)
 */

/* ========================================================================
 * B-JUI: bjui-slidebar.js  v1.3 beta2
 * @author K'naan
 * http://git.oschina.net/xknaan/B-JUI/blob/master/BJUI/js/bjui-slidebar.js
 * ========================================================================
 * Copyright 2014 K'naan.
 * Licensed under Apache (http://www.apache.org/licenses/LICENSE-2.0)
 * ======================================================================== */

+function ($) {
    'use strict';
    
    // SLIDEBAR CLASS INSTANCE
    // ======================
    $(function() {
        $('#bjui-leftside').after('<!-- Adjust the width of Left slide -->').after(FRAG.splitBar).after(FRAG.splitBarProxy)
    })
    
    // SLIDEBAR CLASS DEFINITION
    // ======================
    
    var Slidebar = function(element, options) {
        this.$element   = $(element)
        this.$bar       = this.$element.find('#bjui-sidebar')
        this.$sbar      = this.$element.find('#bjui-sidebar-s')
        this.$lock      = this.$bar.find('> .toggleCollapse > .lock')
        this.$navtab    = $('#bjui-navtab')
        this.$collapse  = this.$sbar.find('.collapse')
        this.$split     = $('#bjui-splitBar')
        this.$split2    = $('#bjui-splitBarProxy')
        
        this.isfloat    = false
        this.options    = options
    }
    
    Slidebar.prototype.lock = function() {
        var that   = this
        var cleft  = that.$bar.outerWidth() + 4
        var cwidth = BJUI.windowWidth - $('#bjui-sidebar').width() - 6
        
        that.faLock()
        that.hoverLock()
        that.$sbar.animate({left: -10}, 20)
        that.$bar.removeClass('shadown')
        that.isfloat = false
        that.$navtab.animate({left:cleft, width:cwidth}, 500, function() {
            $(window).trigger(BJUI.eventType.resizeGrid)
        })
        that.$split.show()
    }
    
    Slidebar.prototype.unlock = function() {
        var that    = this
        var barleft = 0 - that.$bar.outerWidth() - 0
        var cwidth  = BJUI.windowWidth - 6
        
        that.faUnLock()
        that.hoverUnLock()
        that.$navtab.animate({left:6, width:cwidth}, 400)
        that.$bar.animate({left: barleft}, 500, function() {
            that.$sbar.animate({left:0}, 200)
            that.$split.hide()
            $(window).trigger(BJUI.eventType.resizeGrid)
        })
        that.isfloat = false
    }
    
    Slidebar.prototype.float = function() {
        var that  = this
        
        that.$sbar.animate({left:-10}, 200)
        that.$bar.addClass('shadown').animate({left: 0}, 500)
        that.isfloat = true
    }
    
    Slidebar.prototype.hideFloat = function() {
        var that    = this
        var barleft = 0 - that.$bar.outerWidth() - 0
        
        that.$bar.animate({left: barleft - 10}, 500, function() {
            that.$sbar.animate({left:0}, 100)
        })
        that.isfloat = false
    }
    
    Slidebar.prototype.hoverLock = function() {
        var that = this
        
        that.$lock
            .hover(function() {
                that.tipUnLock()
                that.faUnLock()
            }, function() {
                that.tipLock()
                that.faLock()
            })
    }
    
    Slidebar.prototype.hoverUnLock = function() {
        var that = this
        
        that.$lock
            .hover(function() {
                that.tipLock()
                that.faLock()
            }, function() {
                that.tipUnLock()
                that.faUnLock()
            })
    }
    
    Slidebar.prototype.tipLock = function() {
        this.$lock.tooltip('destroy').tooltip({ title:'保持锁定，始终显示导航栏', container:'body' })
    }
    
    Slidebar.prototype.tipUnLock = function() {
        this.$lock.tooltip('destroy').tooltip({ title:'解除锁定，自动隐藏导航栏', container:'body' })
    }
    
    Slidebar.prototype.faLock = function() {
        this.$lock.find('> i').attr('class', 'fa fa-lock')
    }
    
    Slidebar.prototype.faUnLock = function() {
        this.$lock.find('> i').attr('class', 'fa fa-unlock-alt')
    }
    
    Slidebar.prototype.init = function() {
        var that = this
        
        if (!BJUI.ui.showSlidebar) {
            that.unlock()
        } else {
            that.hoverLock()
        } 
        
        this.$lock.off('click.bjui.slidebar').on('click.bjui.slidebar', function() {
            if (that.isfloat) {
                that.lock()
            } else {
                that.unlock()
            }
            BJUI.ui.showSlidebar = !BJUI.ui.showSlidebar
        })
        
        this.$collapse.hover(function() {
            that.float()
            that.$navtab.click(function() {
                if (that.isfloat) that.hideFloat()
            })
        })
        
        this.$split.mousedown(function(e) {
            that.$split2.each(function() {
                var $spbar2 = $(this)
                
                setTimeout(function() { $spbar2.show() }, 100)
                $spbar2
                    .css({visibility:'visible', left: that.$split.css('left')})
                    .basedrag($.extend(that.options, {obj:that.$bar, move:'horizontal', event:e, stop: function() {
                        $(this).css('visibility', 'hidden')
                        var move      = parseInt($(this).css('left')) - parseInt(that.$split.css('left'))
                        var sbarwidth = that.$bar.outerWidth() + move
                        var cleft     = parseInt(that.$navtab.css('left')) + move
                        var cwidth    = that.$navtab.outerWidth() - move
                        
                        that.$bar.css('width', sbarwidth)
                        that.$split.css('left', $(this).css('left'))
                        that.$navtab.css({left:cleft, width:cwidth})
                    }}))
                
                return false
            })
        })
        
        // move hnav
        if ($('#bjui-hnav-navbar-box').length) {
            that.moveHnav()
        }
    }
    
    Slidebar.prototype.moveHnav = function() {
        var $hnavbox  = $('#bjui-hnav-navbar-box'),
            $hnavbar  = $hnavbox.find('> #bjui-hnav-navbar'),
            $hmoreL   = $hnavbox.prev(),
            $hmoreR   = $hnavbox.next()
        
        $hmoreL.hover(function() {
            $hnavbar.stop().animate({left:0}, 2000, function() {
                $hmoreL.hide()
            })
        }, function() {
            $hnavbar.stop()
            if ($hnavbox.data('hnav.move')) {
                $hmoreR.show()
            }
        }).on('click', function() {
            $hnavbar.stop().animate({left:0}, 'fast', function() {
                $hmoreL.hide()
            })
            return false
        })
        
        $hmoreR.hover(function() {
            $hnavbar.stop().animate({left:($hnavbox.width() - $hnavbox.data('hnav.liw') - 10)}, 2000, function() {
                $hmoreR.hide()
            })
        }, function() {
            $hnavbar.stop()
            if ($hnavbar.css('left') != '0px') {
                $hmoreL.show()
            }
        }).on('click', function() {
            $hnavbar.stop().animate({left:($hnavbox.width() - $hnavbox.data('hnav.liw') - 10)}, 'fast', function() {
                $hmoreR.hide()
            })
            return false
        })
    }
    
    Slidebar.prototype.initHnav = function() {
        var that   = this,
            title  = that.$element.text().trim(),
            $li    = that.$element.parent(),
            $box   = $('#bjui-accordionmenu'),
            $trees, $items, $panel, $array
        
        $trees = $li.find('> .items > ul.ztree')
        $items = $li.find('> .items > ul.menu-items')
        if (!($trees.length || $items.length)) return
        if ($trees.length) $array = $trees
        if ($items.length) {
            if (!$array) $array = $items
            else $array = $array.add($items)
            
            $items.find('a').each(function() {
                var $a = $(this), options = $a.data('options')
                
                if (!$a.data('icon.init') && options && typeof options === 'string') {
                    options = options.toObj()
                    if (options && options.faicon) {
                        options.faicon = options.faicon.trim()
                        if (options.faicon.startsWith('fa-')) options.faicon = options.faicon.substr(3)
                        $a.prepend('<i class="fa fa-'+ options.faicon +'"></i>').data('icon.init', true).attr('title', $a.text())
                    }
                }
            })
        }
        
        $box.empty()
        $array.each(function(i) {
            var $t = $(this), panel, cls, bodycls, faicon = $t.data('faicon'), faiconClose = $t.data('faiconClose'), icon = faicon ? faicon : 'dot-circle-o'
            
            if ($t.data('tit')) title = $t.data('tit')
            
            cls     = i ? 'collapsed' : ''
            bodycls = i ? '' : ' in'
            panel   = FRAG.slidePanel
                          .replaceAll('#id#', 'bjui-collapse'+ i)
                          .replaceAll('#title#', title)
                          .replaceAll('#righticon#', '<i class="fa fa-angle-down"></i>')
                          .replaceAll('#class#', cls)
                          .replaceAll('#bodyclass#', bodycls)
            
            if (icon) panel = panel.replaceAll('#icon#', '<i class="fa fa-'+ icon +'"></i>')
            else panel = panel.replaceAll('#icon#', '')
            
            $panel = $(panel)
            $panel.find('> .panel-collapse > .panel-body').append($t.removeAttr('data-noinit'))
            $box.append($panel)
            
            if (!i) $panel.collapse('show')
        })
        
        $('#bjui-sidebar').initui()
        
        $li
            .addClass('active')
            .data('bjui.slidebar.hnav.panels', $box.find('> .panel'))
            .siblings().removeClass('active')
    }
    
    // SLIDEBAR PLUGIN DEFINITION
    // =======================
    
    function Plugin(option) {
        var args     = arguments
        var property = option
        
        return this.each(function () {
            var $this   = $(this)
            var options = $.extend({}, $this.data(), typeof option === 'object' && option)
            var data    = $this.data('bjui.slidebar')
            
            if (!data) $this.data('bjui.slidebar', (data = new Slidebar(this, options)))
            
            if (typeof property === 'string' && $.isFunction(data[property])) {
                [].shift.apply(args)
                if (!args) data[property]()
                else data[property].apply(data, args)
            } else {
                data.init()
            }
        })
    }

    var old = $.fn.slidebar

    $.fn.slidebar             = Plugin
    $.fn.slidebar.Constructor = Slidebar
    
    // SLIDEBAR NO CONFLICT
    // =================
    
    $.fn.basedrag.noConflict = function () {
        $.fn.slidebar = old
        return this
    }
    
    // SLIDEBAR DATA-API
    // ==============
    $(document).one(BJUI.eventType.afterInitUI, function(e) {
        $('#bjui-leftside').slidebar({minW:150, maxW:700})
    })
    
    $(document).on('click.bjui.slidebar.data-api', '[data-toggle="slidebar"]', function(e) {
        var $li = $(this).parent(), $box = $('#bjui-accordionmenu'), $panels = $li.data('bjui.slidebar.hnav.panels')
        
        $box.find('> .panel').detach()
        
        if ($panels && $panels.length) {
            $box.append($panels)
            $li.addClass('active').siblings().removeClass('active')
        } else {
            Plugin.call($(this), 'initHnav')
        }
        
        e.preventDefault()
    })
    
}(jQuery);
/*!
 * B-JUI  v1.3 beta2 (http://b-jui.com)
 * Git@OSC (http://git.oschina.net/xknaan/B-JUI)
 * Copyright 2014 K'naan.
 * Licensed under Apache (http://www.apache.org/licenses/LICENSE-2.0)
 */

/* ========================================================================
 * B-JUI: bjui-contextmenu.js  v1.3 beta2
 * @author K'naan
 * http://git.oschina.net/xknaan/B-JUI/blob/master/BJUI/js/bjui-contextmenu.js
 * ========================================================================
 * Copyright 2014 K'naan.
 * Licensed under Apache (http://www.apache.org/licenses/LICENSE-2.0)
 * ======================================================================== */

+function ($) {
    'use strict';
    
    // CONTEXTMENU GLOBAL ELEMENTS
    // ======================
    
    var $menu, $shadow, hash
    
    $(function() {
        var INIT_CONTEXTMENU = function() {
            $menu   = $('<div id="bjui-contextmenu"></div>').hide()
            $shadow = $('<div id="bjui-contextmenuShadow"></div>').hide()
            hash    = []
            
            $('body').append('<!-- contextmenu -->').append($menu).append($shadow)
        }
        
        INIT_CONTEXTMENU()
    })
    
    // CONTEXTMENU CLASS DEFINITION
    // ======================
    var Contextmenu = function(element, options) {
        this.$element = $(element)
        this.options  = options
    }
    
    Contextmenu.DEFAULTS = {
        id       : undefined,
        shadow   : true,
        bindings : {},
        ctrSub   : null
    }
    
    Contextmenu.prototype.init = function() {
        var that  = this
        var op    = this.options
        
        if (!op.id) return
        hash.push({
            id       : op.id,
            shadow   : op.shadow,
            bindings : op.bindings || {},
            ctrSub   : op.ctrSub
        })
        
        var index = hash.length - 1
        
        this.$element.on('contextmenu', function(e) {
            that.display(index, this, e, op)
            return false
        })
    }
    
    Contextmenu.prototype.display = function(index, trigger, e, options) {
        var that    = this
        var cur     = hash[index]
        var cp      = BJUI.regional[cur.id]
        var content = FRAG[cur.id]
        
        $.each(cp, function(i, n) {
            content = content.replace('#'+ i +'#', cp[i])
        })
        
        // Send the content to the menu
        $menu.html(content)
        $.each(cur.bindings, function(id, func) {
            $('[rel="'+ id +'"]', $menu).on('click', function(e) {
                that.hide()
                func($(trigger), $('#bjui-'+ cur.id))
            })
        })
        
        var posX = e.pageX
        var posY = e.pageY
        
        if ($(window).width() < posX + $menu.width())   posX -= $menu.width()
        if ($(window).height() < posY + $menu.height()) posY -= $menu.height()
        
        $menu.css({'left':posX, 'top':posY}).show()
        if (cur.shadow)
            $shadow.css({width:$menu.width(), height:$menu.height(), left:posX + 3, top:posY + 3}).show()
        $(document).one('click', that.hide)
        
        if ($.isFunction(cur.ctrSub))
            cur.ctrSub($(trigger), $('#bjui-'+ cur.id))
    }
    
    Contextmenu.prototype.hide = function() {
        $menu.hide()
        $shadow.hide()
    }
    
    /* Custom contextmenu */
    Contextmenu.prototype.show = function(options) {
        var that = this
        
        if (options.items && options.items.length) {
            that.$element.on('contextmenu', function(e) {
                var isShow = true
                
                /*exclude*/
                if (options.exclude) {
                    that.$element.find(options.exclude).each(function() {
                        if (this == e.target || $(this).find(e.target).length) {
                            isShow = false
                            return
                        }
                    })
                }
                
                if (!isShow) {
                    e.stopPropagation()
                    return !isShow
                } else {
                    that.custom(options.items, e)
                }
                
                return false
            })
        }
    }
    
    Contextmenu.prototype.custom = function(items, e) {
        $menu.empty().html('<ul></ul>')
        
        var that    = this
        var options = that.options
        var $ul     = $menu.find('> ul'), $li
        
        $.each(items, function(i, n) {
            var icon = ''
            
            if (n.icon) icon = '<i class="fa fa-'+ n.icon +'"></i>'
            if (n.title == 'diver') {
                $li = $('<li class="diver"></li>')
            } else {
                $li = $('<li><span class="icon">'+ icon +'</span><span class="title">'+ n.title +'</span></li>')
                if (n.func && typeof n.func === 'string') n.func = n.func.toFunc()
                if (n.func) {
                    $li.on('click', function(evt) {
                        that.hide()
                        n.func(that.$element, $li)
                    })
                }
            }
            $li.appendTo($ul)
        })
        
        var posX = e.pageX
        var posY = e.pageY
        
        if ($(window).width() < posX + $menu.width())   posX -= $menu.width()
        if ($(window).height() < posY + $menu.height()) posY -= $menu.height()
        
        $menu.css({'left':posX, 'top':posY}).show()
        
        if (options.shadow)
            $shadow.css({width:$menu.width(), height:$menu.height(), left:posX + 3, top:posY + 3}).show()
        
        $(document).one('click', that.hide)
    }
    
    // CONTEXTMENU PLUGIN DEFINITION
    // =======================
    
    function Plugin(option) {
        var args     = arguments
        var property = option
        
        return this.each(function () {
            var $this   = $(this)
            var options = $.extend({}, Contextmenu.DEFAULTS, $this.data(), typeof option === 'object' && option)
            var data    = $this.data('bjui.contextmenu')
            
            if (!data) $this.data('bjui.contextmenu', (data = new Contextmenu(this, options)))
            if (typeof property === 'string' && $.isFunction(data[property])) {
                [].shift.apply(args)
                if (!args) data[property]()
                else data[property].apply(data, args)
            } else {
                data.init()
            }
        })
    }

    var old = $.fn.contextmenu

    $.fn.contextmenu             = Plugin
    $.fn.contextmenu.Constructor = Contextmenu
    
    // CONTEXTMENU NO CONFLICT
    // =================
    
    $.fn.contextmenu.noConflict = function () {
        $.fn.contextmenu = old
        return this
    }
    
}(jQuery);
/*!
 * B-JUI  v1.3 beta2 (http://b-jui.com)
 * Git@OSC (http://git.oschina.net/xknaan/B-JUI)
 * Copyright 2014 K'naan.
 * Licensed under Apache (http://www.apache.org/licenses/LICENSE-2.0)
 */

/* ========================================================================
 * B-JUI: bjui-navtab.js  v1.3 beta2
 * @author K'naan
 * http://git.oschina.net/xknaan/B-JUI/blob/master/BJUI/js/bjui-navtab.js
 * ========================================================================
 * Copyright 2014 K'naan.
 * Licensed under Apache (http://www.apache.org/licenses/LICENSE-2.0)
 * ======================================================================== */

+function ($) {
    'use strict';
    
    // NAVTAB GLOBAL ELEMENTS
    // ======================
    
    var currentIndex, $currentTab, $currentPanel, $box, $tabs, $panels, $prevBtn, $nextBtn, $moreBtn, $moreBox, $main, $mainLi,
        autorefreshTimer
    
    $(function() {
        var INIT_NAVTAB = function() {
            currentIndex = 0
            $box         = $('#bjui-navtab')
            $tabs        = $box.find('.navtab-tab')
            $panels      = $box.find('.navtab-panel')
            $prevBtn     = $box.find('.tabsLeft')
            $nextBtn     = $box.find('.tabsRight')
            $moreBtn     = $box.find('.tabsMore')
            $moreBox     = $box.find('.tabsMoreList')
            $main        = $tabs.find('li:first')
            $mainLi      = $moreBox.find('li:first')
            
            $prevBtn.click(function() { $(this).navtab('scrollPrev') })
            $nextBtn.click(function() { $(this).navtab('scrollNext') })
            $moreBtn.click(function() { $moreBox.show() })
            
            $(document).on('click.bjui.navtab.switchtab', function(e) {
                var $target = e.target.tagName == 'I' ? $(e.target).parent() : $(e.target)
                
                if ($moreBtn[0] != $target[0]) $moreBox.hide()
            })
            
            var mainTit, options
            
            $main
                .navtab('contextmenu', $main)
                .click(function() { if (!$(this).hasClass('active')) $(this).navtab('switchTab', 'main') })
                .find('> a > span').html(function(n, c) { return (mainTit = c.replace('#maintab#', BJUI.regional.maintab)) })
            
            options = $.extend({}, Navtab.DEFAULTS, $main.data(), {id:'main', title:mainTit})
            
            $main.data('options', $.extend({}, options))
            
            if ($main.attr('data-url')) {
                $(document).one(BJUI.eventType.initUI, function(e) {
                    $main.removeAttr('data-url').navtab('reload', options)
                })
            }
            
            setTimeout(function() {
                $mainLi.trigger('click')
            }, 100)
            
            $mainLi
                .click(function() {
                    if ($(this).hasClass('active')) $moreBox.hide()
                    else $(this).navtab('switchTab', 'main')
                })
                .find('> a').html(function(n, c) { return c.replace('#maintab#', BJUI.regional.maintab) })
        }
        
        INIT_NAVTAB()
    })
    
    // NAVTAB CLASS DEFINITION
    // ======================
    
    var Navtab = function(options) {
        this.options  = options
        this.tools    = this.TOOLS()
    }
    
    Navtab.DEFAULTS = {
        id          : null,
        title       : 'New tab',
        url         : null,
        type        : 'GET',
        data        : {},
        loadingmask : true,
        fresh       : false,
        autorefresh : false,
        onLoad      : null,
        beforeClose : null,
        onClose     : null
    }
    
    Navtab.prototype.TOOLS = function() {
        var that = this
        var tools = {
            getDefaults: function() {
                return Navtab.DEFAULTS
            },
            getTabs: function() {
                return $tabs.find('> li')
            },
            getPanels: function() {
                return $panels.find('> div')
            },
            getMoreLi: function() {
                return $moreBox.find('> li')
            },
            getTab: function(tabid) {
                var index = this.indexTabId(tabid)
                
                if (index >= 0) return this.getTabs().eq(index)
            },
            getPanel: function(tabid) {
                var index = this.indexTabId(tabid)
                
                if (index >= 0) return this.getPanels().eq(index)
            },
            getTabsW: function(iStart, iEnd) {
                return this.tabsW(this.getTabs().slice(iStart, iEnd))
            },
            tabsW: function($tabs) {
                var iW = 0
                
                $tabs.each(function() {
                    iW += $(this).outerWidth(true)
                })
                
                return iW
            },
            indexTabId: function(tabid) {
                var iOpenIndex = -1
                
                if (!tabid) return iOpenIndex
                
                this.getTabs().each(function(index) {
                    if ($(this).data('options').id == tabid) {
                        iOpenIndex = index
                        return false
                    }
                })
                
                return iOpenIndex
            },
            getLeft: function() {
                return $tabs.position().left
            },
            getScrollBarW: function() {
                return $box.width() - 55
            },
            visibleStart: function() {
                var $tabs = this.getTabs(), iLeft = this.getLeft(), iW = 0, index = 0
                
                $tabs.each(function(i) {
                    if (iW + iLeft >= 0) {
                        index = i
                        return false
                    }
                    iW += $(this).outerWidth(true)
                })
                
                return index
            },
            visibleEnd: function() {
                var tools = this, $tabs = this.getTabs(), iLeft = this.getLeft(), iW = 0, index = $tabs.length
                
                $tabs.each(function(i) {
                    iW += $(this).outerWidth(true)
                    if (iW + iLeft > tools.getScrollBarW()) {
                        index = i
                        return false
                    }
                })
                
                return index
            },
            scrollPrev: function() {
                var iStart = this.visibleStart()
                
                if (iStart > 0)
                    this.scrollTab(- this.getTabsW(0, iStart - 1))
            },
            scrollNext: function() {
                var iEnd = this.visibleEnd()
                
                if (iEnd < this.getTabs().size())
                    this.scrollTab(- this.getTabsW(0, iEnd + 1) + this.getScrollBarW())
            },
            scrollTab: function(iLeft, isNext) {
                $tabs.animate({ left: iLeft }, 150, function() { that.tools.ctrlScrollBtn() })
            },
            scrollCurrent: function() { // auto scroll current tab
                var iW = this.tabsW(this.getTabs()), scrollW = this.getScrollBarW()
                
                if (iW <= scrollW)
                    this.scrollTab(0)
                else if (this.getLeft() < scrollW - iW)
                    this.scrollTab(scrollW-iW)
                else if (currentIndex < this.visibleStart())
                    this.scrollTab(- this.getTabsW(0, currentIndex))
                else if (currentIndex >= this.visibleEnd())
                    this.scrollTab(scrollW - this.getTabs().eq(currentIndex).outerWidth(true) - this.getTabsW(0, currentIndex))
            },
            ctrlScrollBtn: function() {
                var iW = this.tabsW(this.getTabs())
                
                if (this.getScrollBarW() > iW) {
                    $prevBtn.hide()
                    $nextBtn.hide()
                    $tabs.parent().removeClass('tabsPageHeaderMargin')
                } else {
                    $prevBtn.show().removeClass('tabsLeftDisabled')
                    $nextBtn.show().removeClass('tabsRightDisabled')
                    $tabs.parent().addClass('tabsPageHeaderMargin')
                    if (this.getLeft() >= 0)
                        $prevBtn.addClass('tabsLeftDisabled')
                    else if (this.getLeft() <= this.getScrollBarW() - iW)
                        $nextBtn.addClass('tabsRightDisabled')
                }
            },
            switchTab: function(iTabIndex) {
                var $tab = this.getTabs().removeClass('active').eq(iTabIndex).addClass('active'), $panels = this.getPanels(), $panel = $panels.eq(iTabIndex), onSwitch = that.options.onSwitch ? that.options.onSwitch.toFunc() : null
                var $ajaxBackground = $(FRAG.maskBackground)
                
                $panels.css({top:'-10000000px'})
                
                if ($tab.data('reloadFlag')) {
                    $panel.animate({top:0})
                    that.refresh($tab.data('options').id)
                } else {
                    if ($panel.find('.bjui-ajax-mask').length) {
                        $panel.css({top:0})
                    } else {
                        $panel
                            .css({top:0})
                            .append($ajaxBackground)
                        
                        $ajaxBackground.fadeOut('normal', function() {
                            $(this).remove()
                        })
                    }
                }
                
                this.getMoreLi().removeClass('active').eq(iTabIndex).addClass('active')
                currentIndex = iTabIndex
                this.scrollCurrent()
                $currentTab     = $tab
                $.CurrentNavtab = $currentPanel = $panel
                
                if (onSwitch) onSwitch.apply(that)
                
                // set current to body data
                var datas = $('body').data('bjui.navtab')
                
                if (!that.options.id) $.extend(that.options, $tab.data('options')) // for main
                datas.current = that
                
                // events
                $panel.trigger('bjui.navtab.switch')
            },
            closeTab: function(index, openTabid) {
                var $tab        = this.getTabs().eq(index),
                    $more       = this.getMoreLi().eq(index),
                    $panel      = this.getPanels().eq(index),
                    options     = $tab.data('options'),
                    beforeClose = options.beforeClose ? options.beforeClose.toFunc() : null,
                    onClose     = options.onClose ? options.onClose.toFunc() : null,
                    canClose    = true
                
                if (beforeClose) canClose = beforeClose.apply(that, [$panel])
                if (!canClose) {
                    that.tools.switchTab(index)
                    return
                }
                $tab.remove()
                $more.remove()
                $panel.trigger(BJUI.eventType.beforeCloseNavtab).remove()
                
                if (autorefreshTimer) clearInterval(autorefreshTimer)
                if (onClose) onClose.apply(that)
                if (currentIndex >= index) currentIndex--
                if (openTabid) {
                    var openIndex = this.indexTabId(openTabid)
                    
                    if (openIndex > 0) currentIndex = openIndex
                }
                
                // remove from body
                var datas = $('body').data('bjui.navtab')
                
                if (datas[options.id])
                    delete datas[options.id]
                
                this.scrollCurrent()
                this.switchTab(currentIndex)
            },
            closeOtherTab: function(index) {
                index = index || currentIndex
                
                this.getTabs().each(function(i) {
                    if (i > 0 && index != i) $(this).find('> .close').trigger('click')
                })
            },
            loadUrlCallback: function($panel) {
                $panel.find(':button.btn-close').click(function() { that.closeCurrentTab() })
            },
            updateTit: function(index, title) {
                this.getTabs().eq(index).find('> a').attr('title', title).find('> span').html(title)
                this.getMoreLi().eq(index).find('> a').attr('title', title).html(title)
            },
            reload: function($tab, flag) {
                flag = flag || $tab.data('reloadFlag')
                
                var options = $tab.data('options')
                
                if (flag) {
                    $tab.data('reloadFlag', false)
                    var $panel = that.tools.getPanel(options.id)
                    
                    if ($tab.hasClass('external')) {
                        that.openExternal(options.url, $panel, options.data)
                    } else {
                        that.tools.reloadTab($panel, options)
                    }
                }
            },
            reloadTab: function($panel, options) {
                var onLoad = options.onLoad ? options.onLoad.toFunc() : null,
                    arefre = options.autorefresh && (isNaN(String(options.autorefresh)) ? 15 : options.autorefresh)
                
                $panel
                    .trigger(BJUI.eventType.beforeLoadNavtab)
                    .ajaxUrl({
                        type:(options.type || 'GET'), url:options.url, data:options.data || {}, loadingmask:options.loadingmask, callback:function(response) {
                            that.tools.loadUrlCallback($panel)
                            if (onLoad) onLoad.apply(that, [$panel])
                            if (autorefreshTimer) clearInterval(autorefreshTimer)
                            if (arefre) autorefreshTimer = setInterval(function() { $panel.navtab('refresh') }, arefre * 1000)
                            if (BJUI.ui.clientPaging && $panel.data('bjui.clientPaging')) $panel.pagination('setPagingAndOrderby', $panel)
                        }
                    })
            }
        }
        
        return tools
    }
    
    Navtab.prototype.contextmenu = function($obj) {
        var that = this
        
        $obj.contextmenu({
            id: 'navtabCM',
            bindings: {
                reload: function(t, m) {
                    if (t.data('options').url)
                        that.refresh(t.data('options').id)
                },
                closeCurrent: function(t, m) {
                    var tabId = t.data('options').id
                    
                    if (tabId) that.closeTab(tabId)
                    else that.closeCurrentTab()
                },
                closeOther: function(t, m) {
                    if (!t.index()) {
                        that.closeAllTab()
                    } else {
                        var index = that.tools.indexTabId(t.data('options').id)
                        
                        that.tools.closeOtherTab(index > 0 ? index : currentIndex)
                    }
                },
                closeAll: function(t, m) {
                    that.closeAllTab()
                }
            },
            ctrSub: function(t, m) {
                var mReload = m.find('[rel="reload"]'),
                    mCur    = m.find('[rel="closeCurrent"]'),
                    mOther  = m.find('[rel="closeOther"]'),
                    mAll    = m.find('[rel="closeAll"]'),
                    $tabLi  = that.tools.getTabs()
                
                if (!t.index()) {
                    mCur.addClass('disabled')
                    if (!t.data('options').url) mReload.addClass('disabled')
                }
            }
        })
    }
    
    // if found tabid replace tab, else create a new tab.
    Navtab.prototype.openTab = function() {
        var that = this, options = this.options, tools = this.tools, iOpenIndex
        
        if (!options.url && options.href) options.url = options.href
        
        if (!options.url) {
            BJUI.debug('Navtab Plugin: Error trying to open a navtab, url is undefined!')
            return
        } else {
            options.url = decodeURI(options.url).replacePlh()
            
            if (!options.url.isFinishedTm()) {
                $('body').alertmsg('error', (options.warn || BJUI.regional.plhmsg))
                BJUI.debug('Navtab Plugin: The new navtab\'s url is incorrect, url: '+ options.url)
                return
            }
            
            options.url = encodeURI(options.url)
        }
        
        iOpenIndex = options.id ? tools.indexTabId(options.id) : currentIndex
        
        if (iOpenIndex >= 0) {
            var $tab   = tools.getTabs().eq(iOpenIndex),
                $panel = tools.getPanels().eq(iOpenIndex),
                op     = $tab.data('options')
            
            if (options.fresh || options.url != op.url)
                that.reload(options)
            else if (options.title != op.title) {
                op.title = options.title
                tools.updateTit(iOpenIndex, options.title)
            }
            
            currentIndex = iOpenIndex
            
            if (options.id == 'main') {
                this.contextmenu($tab)
            }
        } else {
            var tabFrag = '<li><a href="javascript:" title="#title#"><span>#title#</span></a><span class="close">&times;</span></li>',
                $tab = $(tabFrag.replaceAll('#title#', options.title)),
                $panel = $('<div class="navtabPage unitBox"></div>'),
                $more  = $('<li><a href="javascript:" title="#title#">#title#</a></li>'.replaceAll('#title#', options.title))
            
            $tab.appendTo($tabs)
            $panel.appendTo($panels)
            $more.appendTo($moreBox)
            
            $tab.data('options', $.extend({}, options))
            
            if (options.external || (options.url && options.url.isExternalUrl())) {
                $tab.addClass('external')
                this.openExternal(options.url, $panel, options.data)
            } else {
                $tab.removeClass('external')
                tools.reloadTab($panel, options)
            }
            
            currentIndex = tools.getTabs().length - 1
            this.contextmenu($tab)
            
            //events
            $tab.on('click', function(e) {
                if (!$(this).hasClass('active'))
                    that.switchTab(options.id)
            }).on('click.bjui.navtab.close', '.close', function(e) {
                that.closeTab(options.id)
            }).on('mousedown.bjui.navtab.drag', 'a', function(e) {
                $tab.data('bjui.navtab.drag', true)
                
                setTimeout($.proxy(function () {
                    if ($tab.data('bjui.navtab.drag')) that.drag(e, $tab, $panel, $more)
                }, that), 150)
                
                e.preventDefault()
            }).on('mouseup.bjui.navtab.drag', 'a', function(e) {
                $tab.data('bjui.navtab.drag', false)
            })
            
            $more.on('click', function() {
                that.switchTab(options.id)
            })
        }
        
        tools.switchTab(currentIndex)
        tools.scrollCurrent()
    }
    
    Navtab.prototype.closeTab = function(tabid) {
        var index = this.tools.indexTabId(tabid)
        
        if (index > 0)
            this.tools.closeTab(index)
    }
    
    Navtab.prototype.closeCurrentTab = function(openTabid) { //openTabid can be empty. close current tab by default, and open the last tab
        if (currentIndex > 0)
            this.tools.closeTab(currentIndex, openTabid)
    }
    
    Navtab.prototype.closeAllTab = function() {
        this.tools.getTabs().find('> .close').trigger('click')
    }
    
    Navtab.prototype.reloadFlag = function(tabids) {
        var arr = tabids.split(',')
        
        for (var i = 0; i < arr.length; i++) {
            var $tab = this.tools.getTab(arr[i].trim())
            
            if ($tab) {
                if (this.tools.indexTabId(arr[i]) == currentIndex) this.tools.reload($tab, true)
                else $tab.data('reloadFlag', true)
            }
        }
    }
    
    Navtab.prototype.switchTab = function(tabid) {
        var index = this.tools.indexTabId(tabid)
        
        this.tools.switchTab(index)
    }
    
    Navtab.prototype.scrollPrev = function() {
        this.tools.scrollPrev()
    }
    
    Navtab.prototype.scrollNext = function() {
        this.tools.scrollNext()
    }
    
    Navtab.prototype.refresh = function(tabid) {
        var $tab, $panel
        
        if (!tabid) {
            $tab = $currentTab
        } else if (typeof tabid === 'string') {
            $tab = this.tools.getTab(tabid)
        } else {
            $tab = tabid
        }
        
        if ($tab && $tab.length) {
            $panel = this.tools.getPanel($tab.data('options').id)
            $panel.removeData('bjui.clientPaging')
            
            this.reload($tab.data('options'))
        }
    }
    
    Navtab.prototype.reload = function(option) {
        var that    = this,
            options = $.extend({}, typeof option === 'object' && option),
            $tab    = options.id ? this.tools.getTab(options.id) : this.tools.getTabs().eq(currentIndex)
        
        if ($tab) {
            var op      = $tab.data('options')
            var _reload = function() {
                if (options.title && options.title != op.title) {
                    that.tools.updateTit($tab.index(), options.title)
                }
                $tab.data('options', $.extend({}, op, options))
                that.tools.reload($tab, true)
            }
            
            if (op.reloadWarn) {
                $('body').alertmsg('confirm', op.reloadWarn, {
                    okCall: function() {
                        _reload()
                    }
                })
            } else {
                _reload()
            }
        }
    }
    
    Navtab.prototype.reloadForm = function(clearQuery, option) {
        var options = $.extend({}, typeof option === 'object' && option),
            $tab    = options.id ? this.tools.getTab(options.id) : $currentTab,
            $panel  = options.id ? this.tools.getPanel(options.id) : $currentPanel
        
        if ($tab && $panel) {
            var op         = $tab.data('options'),
                data       = {},
                pageData   = {},
                $pagerForm = options.form || $panel.find('#pagerForm')
            
            if ($pagerForm && $pagerForm.length) {
                options.type = options.type || $pagerForm.attr('method') || 'POST'
                options.url  = options.url || $pagerForm.attr('action')
                
                pageData = $pagerForm.serializeJson()
                
                if (clearQuery) {
                    var pageInfo = BJUI.pageInfo
                    
                    for (var key in pageInfo) {
                        data[pageInfo[key]] = pageData[pageInfo[key]]
                    }
                } else {
                    data = pageData
                }
            }
            
            options.data = $.extend({}, options.data || {}, data)
            
            if (!$tab.hasClass('external')) {
                this.tools.reloadTab($panel, options)
            } else {
                this.openExternal(options.url, $panel, options.data)
            }
        }
    }
    
    Navtab.prototype.getCurrentPanel = function() {
        return this.tools.getPanels().eq(currentIndex)
    }
    
    Navtab.prototype.checkTimeout = function() {
        var json = JSON.parse($currentPanel.html())
        
        if (json && json[BJUI.keys.statusCode] == BJUI.statusCode.timeout) this.closeCurrentTab()
    }
    
    Navtab.prototype.openExternal = function(url, $panel, data) {
        var ih = $panel.closest('.navtab-panel').height()
        
        if (data && !$.isEmptyObject(data)) {
            url.indexOf('?') ? url += '&' : '?'
            url += $.param(data)
        }
        
        $panel.html(FRAG.externalFrag.replaceAll('{url}', url).replaceAll('{height}', ih +'px'))
    }
    
    Navtab.prototype.drag = function(e, $tab, $panel, $more) {
        var that  = this,
            $lis  = that.tools.getTabs(), $panels = that.tools.getPanels(), $mores = that.tools.getMoreLi(),
            $drag = $tabs.next('.bjui-navtab-drag'),
            $prev = $tab.prev(), $next  = $tab.next(),
            index = $tab.index(), width = $tab.width(),
            oleft = $tab.position().left,
            leftarr = [], newArr = [], newIndex
        
        if ($lis.length <= 2) return
        
        if (!$drag.length) {
            $drag = $('<div class="bjui-navtab-drag" style="position:absolute; top:0; left:1px; width:2px; height:25px; background:#ff6600; display:none;"></div>')
            $drag.insertAfter($tabs)
        }
        
        $drag.css('left', oleft - 2)
        
        $tabs.find('> li').each(function() {
            leftarr.push($(this).position().left)
        })
        
        $tab.find('> a').basedrag({
            move:'horizontal',
            oleft    : oleft,
            drag     : function($target, e, left, top) {
                $tab.addClass('navtab-drag')
                
                newArr = [left]
                $.merge(newArr, leftarr)
                newArr.sort(function(a, b) { return a - b })
                
                newIndex = $.inArray(left, newArr)
                if (!newIndex) newIndex = 1
                if (newIndex == $lis.length)
                    $drag.css('left', leftarr[newIndex - 1] - 2 + $lis.last().width())
                else
                    $drag.css('left', leftarr[newIndex] - 2)
                    
                $drag.show()
            },
            stop     : function() {
                $tab.removeClass('navtab-drag')
                $drag.hide()
                
                if (index != newIndex) {
                    if (newIndex == $lis.length) {
                        if (index != $lis.length - 1) {
                            $tab.insertAfter($lis.eq(newIndex - 1))
                            $panel.insertAfter($panels.eq(newIndex - 1))
                            $more.insertAfter($mores.eq(newIndex - 1))
                        }
                    } else {
                        $tab.insertBefore($lis.eq(newIndex))
                        $panel.insertBefore($panels.eq(newIndex))
                        $more.insertBefore($mores.eq(newIndex))
                    }
                }
            },
            event    : e,
            nounbind : true
        })
    }
    
    // NAVTAB PLUGIN DEFINITION
    // =======================
    
    function Plugin(option) {
        var args     = arguments,
            property = option,
            navtab   = 'bjui.navtab',
            $body    = $('body'),
            datas    = $body.data(navtab) || {}
        
        return this.each(function () {
            var $this   = $(this),
                options = $.extend({}, Navtab.DEFAULTS, typeof option === 'object' && option),
                id      = options && options.id,
                data
            
            if (!id) {
                if (datas.current) {
                    id = datas.current.options.id
                } else {
                    id = BJUI.ui.overwriteHomeTab ? 'main' : 'navtab' 
                }
            } else {
                // if (!id.isNormalID()) {
                //     BJUI.debug('Navtab Plugin: ID ['+ id +'] '+ BJUI.regional.idChecked)
                    
                //     return
                // }
            }
            
            options.id = id
            data = datas && datas[id]
            
            if (!data) {
                datas[id] = (data = new Navtab(options))
            } else {
                if (typeof option === 'object' && option)
                    $.extend(data.options, option)
            }
            
            $body.data(navtab, datas)
            
            if (typeof property === 'string' && $.isFunction(data[property])) {
                [].shift.apply(args)
                if (!args) data[property]()
                else data[property].apply(data, args)
            } else {
                data.openTab()
            }
        })
    }
    
    var old = $.fn.navtab
    
    $.fn.navtab             = Plugin
    $.fn.navtab.Constructor = Navtab
    
    // NAVTAB NO CONFLICT
    // =================
    
    $.fn.navtab.noConflict = function () {
        $.fn.navtab = old
        return this
    }
    
    // NOT SELECTOR
    // ==============
    
    BJUI.navtab = function() {
        Plugin.apply($('body'), arguments)
    }
    
    // NAVTAB DATA-API
    // ==============
    
    $(document).on('click.bjui.navtab.data-api', '[data-toggle="navtab"]', function(e) {
        var $this = $(this), href = $this.attr('href'), data = $this.data(), options = data.options
        
        if (options) {
            if (typeof options === 'string') options = options.toObj()
            if (typeof options === 'object')
                $.extend(data, options)
        }
        
        if (!data.title) data.title = $this.text()
        if (href && !data.url) data.url = href
        
        Plugin.call($this, data)
        
        e.preventDefault()
    })
    
}(jQuery);
/*!
 * B-JUI  v1.3 beta2 (http://b-jui.com)
 * Git@OSC (http://git.oschina.net/xknaan/B-JUI)
 * Copyright 2014 K'naan.
 * Licensed under Apache (http://www.apache.org/licenses/LICENSE-2.0)
 */

/* ========================================================================
 * B-JUI: bjui-dialog.js  v1.3 beta2
 * @author K'naan
 * http://git.oschina.net/xknaan/B-JUI/blob/master/BJUI/js/bjui-dialog.js
 * ========================================================================
 * Copyright 2014 K'naan.
 * Licensed under Apache (http://www.apache.org/licenses/LICENSE-2.0)
 * ======================================================================== */

+function ($) {
    'use strict';
    
    // DIALOG GLOBAL ELEMENTS
    // ======================
    
    var $resizable
    var $current, shadow, zindex
    
    $(function() {
        var INIT_DIALOG = function() {
            $resizable = $('#bjui-resizable')
            shadow     = 'dialogShadow'
            zindex     = Dialog.ZINDEX
            
            $('body').append('<!-- dialog resizable -->').append(FRAG.resizable)
        }
        
        INIT_DIALOG()
    })
    
    // DIALOG CLASS DEFINITION
    // ======================
    var Dialog = function(options) {
        this.$element = $('body')
        this.options  = options
        this.tools    = this.TOOLS()
    }
    
    Dialog.DEFAULTS = {
        id          : null,
        title       : 'New Dialog',
        url         : null,
        type        : 'GET',
        data        : {},
        loadingmask : true,
        width       : 500,
        height      : 300,
        minW        : 65,
        minH        : 40,
        max         : false,
        mask        : false,
        resizable   : true,
        drawable    : true,
        maxable     : true,
        minable     : true,
        fresh       : false,
        onLoad      : null,
        beforeClose : null,
        onClose     : null
    }
    
    Dialog.ZINDEX = 30
    
    Dialog.prototype.TOOLS = function() {
        var that  = this
        var tools = {
            getDefaults: function() {
                return Dialog.DEFAULTS
            },
            init: function($dialog) {
                var width  = that.options.width > that.options.minW ? that.options.width : that.options.minW
                var height = that.options.height > that.options.minH ? that.options.height : that.options.minH
                var wW     = $(window).width(),
                    wH     = $(window).height(),
                    iTop   = that.options.max ? 0 : ((wH - height) / 3)
                
                if (width > wW)  width  = wW
                if (height > wH) height = wH
                
                $dialog
                    .height(height)
                    .width(width)
                    .show()
                    .css({left:(wW - width) / 2, top:0, opacity:0.1})
                    .animate({top:iTop > 0 ? iTop : 0, opacity:1})
                    .addClass(shadow)
                    .find('> .dialogContent').height(height - $('> .dialogHeader', $dialog).outerHeight() - 6)
                
                $('body').find('> .bjui-dialog-container').not($dialog).removeClass(shadow)
            },
            reload: function($dialog, options) {
                var $dialogContent = $dialog.find('> .dialogContent'), onLoad, data = options && options.data, html
                
                options = options || $dialog.data('options')
                onLoad  = options.onLoad ? options.onLoad.toFunc() : null
                
                $dialog.trigger(BJUI.eventType.beforeLoadDialog)
                
                if (options.url) {
                    if (data) {
                        if (typeof data === 'string') {
                            if (data.trim().startsWith('{')) {
                                data = data.toObj()
                            } else {
                                data = data.toFunc()
                            }
                        }
                        if (typeof data === 'function') {
                            data = data.apply()
                        }
                    }
                    $dialogContent.ajaxUrl({
                        type:options.type || 'GET', url:options.url, data:data || {}, loadingmask:options.loadingmask, callback:function(response) {
                            if (onLoad) onLoad.apply(that, [$dialog])
                            if (BJUI.ui.clientPaging && $dialog.data('bjui.clientPaging')) $dialog.pagination('setPagingAndOrderby', $dialog)
                        }
                    })
                } else {
                    if (options.html) {
                        html = options.html
                        if ($.isFunction(html.toFunc()))
                            html = html.toFunc()
                    } else if (options.target) {
                        html = $(options.target).html() || $dialog.data('bjui.dialog.target')
                        $(options.target).empty()
                        $dialog.data('bjui.dialog.target', html)
                    }
                    
                    $dialogContent.trigger(BJUI.eventType.beforeAjaxLoad).html(html).initui()
                    
                    if (onLoad) onLoad.apply(that, [$dialog])
                }
            },
            resizeContent:function($dialog, width, height) {
                var $dialogContent = $dialog.find('> .dialogContent')
                
                $dialogContent
                    .css({width:(width - 12), height:(height - $dialog.find('> .dialogHeader').outerHeight() - 6)})
                    .resizePageH()
                
                $(window).trigger(BJUI.eventType.resizeGrid)
            }
        }
        
        return tools
    }
    
    Dialog.prototype.open = function() {
        var that    = this,
            options = that.options,
            $body   = $('body'),
            datas   = $body.data('bjui.dialog'),
            data    = datas[options.id],
            $dialog = data && data.dialog
            
        if (!(options.target || $(options.target).length) && !options.html) {
            if (!options.url && options.href) options.url = options.href
            if (!options.url) {
                BJUI.debug('Dialog Plugin: Error trying to open a dialog, url is undefined!')
                return
            } else {
                options.url = decodeURI(options.url).replacePlh()
                
                if (!options.url.isFinishedTm()) {
                    BJUI.alertmsg('error', (options.warn || BJUI.regional.plhmsg))
                    BJUI.debug('Dialog Plugin: The new dialog\'s url is incorrect, url: '+ options.url)
                    return
                }
                
                options.url = encodeURI(options.url)
            }
        } else {
            options.url = undefined
        }
        if ($dialog) { //if the dialog id already exists
            var op = $dialog.data('options')
            
            this.switchDialog($dialog)
            
            if ($dialog.is(':hidden')) $dialog.show()
            if (options.fresh || options.url != op.url) {
                that.reload(options)
            }
        } else { //open a new dialog
            var dr     = BJUI.regional.dialog,
                dialog = FRAG.dialog
                    .replace('#close#', dr.close)
                    .replace('#maximize#', dr.maximize)
                    .replace('#restore#', dr.restore)
                    .replace('#minimize#', dr.minimize)
                    .replace('#title#', dr.title)
            
            $dialog = $(dialog)
                .data('options', $.extend({}, options))
                .css('z-index', (++ zindex))
                .hide()
                .appendTo($body)
            
            $dialog.find('> .dialogHeader > h1 > span.title').html(options.title)
            
            this.tools.init($dialog)
            
            if (options.maxable) $dialog.find('a.maximize').show()
            else $dialog.find('a.maximize').hide()
            if (options.minable) $dialog.find('a.minimize').show()
            else $dialog.find('a.minimize').hide()
            if (options.max) that.maxsize($dialog)
            if (options.mask) this.addMask($dialog)
            else if (options.minable && $.fn.taskbar) this.$element.taskbar({id:options.id, title:options.title})
            
            $dialog.on('click', function(e) {
                if (!$(e.target).data('bjui.dialog'))
                    if ($current && $current[0] != $dialog[0]) that.switchDialog($dialog)
            }).on('click', '.btn-close', function(e) {
                that.close($dialog)
                
                e.preventDefault()
            }).on('click', '.dialogHeader > a', function(e) {
                var $a = $(this)
                
                if ($a.hasClass('close')) that.close($dialog)
                if ($a.hasClass('minimize')) {
                    that.minimize($dialog)
                }
                if ($a.hasClass('maximize')) {
                    that.switchDialog($dialog)
                    that.maxsize($dialog)
                }
                if ($a.hasClass('restore')) that.restore($dialog)
                
                e.preventDefault()
                e.stopPropagation()
            }).on('dblclick', '.dialogHeader > h1', function(e) {
                if (options.maxable) {
                    if ($dialog.find('> .dialogHeader > a.restore').is(':hidden')) $dialog.find('a.maximize').trigger('click')
                    else $dialog.find('> .dialogHeader > a.restore').trigger('click')
                }
            }).on('mousedown.bjui.dialog.drag', '.dialogHeader > h1', function(e) {
                that.switchDialog($dialog)
                
                if (!options.drawable || $dialog.data('max')) return
                
                $dialog.data('bjui.dialog.task', true)
                setTimeout($.proxy(function () {
                    if ($dialog.data('bjui.dialog.task')) that.drag(e, $dialog)
                }, that), 150)
                
                e.preventDefault()
            }).on('mouseup.bjui.dialog.drag', '.dialogHeader > h1', function(e) {
                $dialog.data('bjui.dialog.task', false)
            }).on('mousedown.bjui.dialog.resize', 'div[class^="resizable"]', function(e) {
                if (!options.drawable || $dialog.data('max')) return false
                if (!options.resizable) return false
                
                var $bar = $(this)
                
                that.switchDialog($dialog)
                that.resizeInit(e, $('#bjui-resizable'), $dialog, $bar)
                $bar.show()
                
                e.preventDefault()
            }).on('mouseup.bjui.dialog.resize', 'div[class^="resizable"]', function(e) {
                e.preventDefault()
            })
            
            data.dialog = $dialog
            this.tools.reload($dialog, options)
        }
        
        $.CurrentDialog = $current = $dialog
        
        // set current to body data
        datas.current = this
    }
    
    Dialog.prototype.addMask = function($dialog) {
        var $mask = $dialog.data('bjui.dialog.mask')
        
        $dialog.wrap('<div style="z-index:'+ zindex +'" class="bjui-dialog-wrap"></div>')
        $dialog.find('> .dialogHeader > a.minimize').hide()
        if (!$mask || !$mask.length) {
            $mask = $(FRAG.dialogMask)
            $mask.css('z-index', 1).show().insertBefore($dialog)
            $dialog.data('bjui.dialog.mask', $mask)
        }
    }
    
    Dialog.prototype.refresh = function(id) {
        if (id && typeof id === 'string') {
            var arr = id.split(','), datas = $('body').data('bjui.dialog')
            
            for (var i = 0; i < arr.length; i++) {
                var $dialog = datas[arr[i].trim()].dialog
                
                if ($dialog) {
                    $dialog.removeData('bjui.clientPaging')
                    this.tools.reload($dialog)
                }
            }
        } else {
            if ($current) {
                $current.removeData('bjui.clientPaging')
                this.tools.reload($current)
            }
        }
    }
    
    Dialog.prototype.reload = function(option) {
        var that     = this,
            options  = $.extend({}, typeof option === 'object' && option),
            datas    = $('body').data('bjui.dialog'),
            $dialog  = (options.id && datas[options.id] && datas[options.id].dialog) || that.getCurrent()
        
        if ($dialog && $dialog.length) {
            var op = $dialog.data('options')
            
            options = $.extend({}, op, options)
            
            var _reload = function() {
                var $dialogContent = $dialog.find('> .dialogContent')
                
                if (options.width != op.width) {
                    if (options.max) {
                        $dialog.animate({ width:options.width}, 'normal', function() { $dialogContent.width(options.width) })
                    } else {
                        $dialog.width(options.width)
                        $dialogContent.width(options.width)
                    }
                }
                if (options.height != op.height) {
                    if (options.max) {
                        $dialog.animate({ height:options.height }, 'normal', function() {
                            $dialogContent.height(options.height - $dialog.find('> .dialogHeader').outerHeight() - 6).resizePageH()
                        })
                    } else {
                        $dialog.height(options.height)
                        $dialogContent.height(options.height - $dialog.find('> .dialogHeader').outerHeight() - 6)
                    }
                }
                if (options.maxable != op.maxable) {
                    if (options.maxable) $dialog.find('a.maximize').show()
                    else $dialog.find('a.maximize').hide()
                } 
                if (options.minable != op.minable) {
                    if (options.minable) $dialog.find('a.minimize').show()
                    else $dialog.find('a.minimize').hide()
                }
                if (options.max != op.max)
                    if (options.max)
                        setTimeout(that.maxsize($dialog), 10)
                if (options.mask != op.mask) {
                    if (options.mask) {
                        that.addMask($dialog)
                        if ($.fn.taskbar) that.$element.taskbar('closeDialog', options.id)
                    } else if (options.minable && $.fn.taskbar) {
                        that.$element.taskbar({id:options.id, title:options.title})
                    }
                }
                if (options.title != op.title) {
                    $dialog.find('> .dialogHeader > h1 > span.title').html(options.title)
                    $dialog.taskbar('changeTitle', options.id, options.title)
                }
                
                $dialog.data('options', $.extend({}, options))
                
                that.tools.reload($dialog, op)
            }
            
            if (op.reloadWarn) {
                $dialog.alertmsg('confirm', op.reloadWarn, {
                    okCall: function() {
                        _reload()
                    }
                })
            } else {
                _reload()
            }
        }
    }
    
    Dialog.prototype.reloadForm = function(clearQuery, option) {
        var options = $.extend({}, typeof option === 'object' && option),
            datas   = $('body').data('bjui.dialog'),
            $dialog
        
        if (options.id) {
            if (datas && datas[options.id])
                $dialog = datas[options.id].dialog
        } else {
            $dialog = $current
        }
        
        if ($dialog) {
            var op         = $dialog.data('options'),
                data       = {},
                pageData   = {},
                $pagerForm = options.form || $dialog.find('#pagerForm')
            
            if ($pagerForm && $pagerForm.length) {
                options.type = options.type || $pagerForm.attr('method') || 'POST'
                options.url  = options.url || $pagerForm.attr('action')
                
                pageData = $pagerForm.serializeJson()
                
                if (clearQuery) {
                    var pageInfo = BJUI.pageInfo
                    
                    for (var key in pageInfo) {
                        data[pageInfo[key]] = pageData[pageInfo[key]]
                    }
                } else {
                    data = pageData
                }
            }
            
            options.data = $.extend({}, options.data || {}, data)
            
            this.tools.reload($dialog, options)
        }
    }
    
    Dialog.prototype.getCurrent = function() {
        return $current
    }
    
    Dialog.prototype.switchDialog = function($dialog) {
        var index = $dialog.css('z-index')
        
        if ($current && $current != $dialog) {
            if ($current.data('options').mask)
                return
            
            var cindex = $current.css('z-index'),
                datas  = $('body').data('bjui.dialog')
            
            $current.css('z-index', index)
            $dialog.css('z-index', cindex)
            $.CurrentDialog = $current = $dialog
            
            // set current to body data
            datas.current = this
            
            if ($.fn.taskbar) this.$element.taskbar('switchTask', $dialog.data('options').id)
        }
        
        $dialog.addClass(shadow)
        $('body').find('> .bjui-dialog-container').not($dialog).removeClass(shadow)
    }
    
    Dialog.prototype.close = function(dialog) {
        var that        = this,
            datas       = $('body').data('bjui.dialog'),
            $dialog     = (typeof dialog === 'string') ? datas[dialog].dialog : dialog,
            $mask       = $dialog.data('bjui.dialog.mask'),
            options     = $dialog.data('options'),
            target      = $dialog.data('bjui.dialog.target'),
            beforeClose = options.beforeClose ? options.beforeClose.toFunc() : null,
            onClose     = options.onClose ? options.onClose.toFunc() : null,
            canClose    = true
        
        if (!$dialog || !options) return
        if (beforeClose) canClose = beforeClose.apply(that, [$dialog])
        if (!canClose) {
            that.switchDialog($dialog)
            return
        }
        if (options.target && target) $(options.target).html(target) 
        if ($mask && $mask.length) {
            $mask.remove()
            $dialog.unwrap()
        } else if ($.fn.taskbar) {
            this.$element.taskbar('closeDialog', options.id)
        }
        
        $dialog.animate({top:- $dialog.outerHeight(), opacity:0.1}, 'normal', function() {
            delete datas[options.id]
            
            $dialog.trigger(BJUI.eventType.beforeCloseDialog).remove()
            if (onClose) onClose.apply(that)
            
            $.CurrentDialog = $current = null
            
            var $dialogs  = $('body').find('.bjui-dialog-container'),
                $_current = null
            
            if ($dialogs.length) {
                $_current = that.$element.getMaxIndexObj($dialogs)
            } else {
                zindex = Dialog.ZINDEX
            }
            if ($_current && $_current.is(':visible')) {
                $.CurrentDialog = $current = $_current
                that.switchDialog($_current)
            }
        })
    }
    
    Dialog.prototype.closeCurrent = function() {
        this.close($current)
    }
    
    Dialog.prototype.checkTimeout = function() {
        var $dialogConetnt = $current.find('> .dialogContent'),
            json = JSON.parse($dialogConetnt.html())
        
        if (json && json[BJUI.keys.statusCode] == BJUI.statusCode.timeout) this.closeCurrent()
    }
    
    Dialog.prototype.maxsize = function($dialog) {
        $dialog.data('original', {
            top   : $dialog.css('top'),
            left  : $dialog.css('left'),
            width : $dialog.css('width'),
            height: $dialog.css('height')
        }).data('max', true)
        
        $dialog.find('> .dialogHeader > a.maximize').hide()
        $dialog.find('> .dialogHeader > a.restore').show()
        
        var iContentW = $(window).width(),
            iContentH = $(window).height() - $('#bjui-taskbar').height() - 1
        
        $dialog.css({ top:0, left:0, width:iContentW, height:iContentH })
        
        this.tools.resizeContent($dialog, iContentW, iContentH)
    }
    
    Dialog.prototype.restore = function($dialog) {
        var original = $dialog.data('original'),
            dwidth   = parseInt(original.width),
            dheight  = parseInt(original.height)
        
        $dialog.css({
            top: original.top,
            left: original.left,
            width: dwidth,
            height: dheight
        })
        
        this.tools.resizeContent($dialog, dwidth, dheight)
        
        $dialog.find('> .dialogHeader > a.maximize').show()
        $dialog.find('> .dialogHeader > a.restore').hide()
        $dialog.data('max', false)
    }
    
    Dialog.prototype.minimize = function($dialog) {
        $dialog.hide()
        if ($.fn.taskbar) this.$element.taskbar('minimize', $dialog)
        
        var $dialogs  = $('body').find('.bjui-dialog-container:visible'),
            $_current = null
        
        if ($dialogs.length) {
            $_current = this.$element.getMaxIndexObj($dialogs)
        }
        if ($_current) this.switchDialog($_current)
    }
    
    Dialog.prototype.drag = function(e, $dialog) {
        var $shadow = $('#bjui-dialogProxy')
        
        $dialog.find('> .dialogContent').css('opacity', '.3')
        $dialog.basedrag({
            selector : '> .dialogHeader',
            stop     : function() {
                $dialog
                    .css({left:$dialog.css('left'), top:$dialog.css('top')})
                    .find('> .dialogContent').css('opacity', 1)
            },
            event    : e,
            nounbind : true
        })
    }
    
    Dialog.prototype.resizeDialog = function($resizable, $dialog, target) {
        var tmove,
            oleft  = parseInt($resizable.css('left')),
            otop   = parseInt($resizable.css('top')),
            height = parseInt($resizable.css('height')),
            width  = parseInt($resizable.css('width'))
        
        if (target == 'n' || target == 'nw') tmove = parseInt($dialog.css('top')) - otop
        else tmove = height - parseInt($dialog.css('height'))
        
        if (otop < 0) otop = 0
        
        $dialog
            .css({top:otop, left:oleft, width:width + 2, height:height + 1})
            .find('> .dialogContent').css('width', (width - 10))
        
        if (target != 'w' && target != 'e') {
            var $dialogContent = $dialog.find('> .dialogContent')
            
            $dialogContent
                .css({height:height - $dialog.find('> .dialogHeader').outerHeight() - 6})
                .resizePageH()
        }
        $(window).trigger(BJUI.eventType.resizeGrid)
    }
    
    Dialog.prototype.resizeInit = function(e, $resizable, $dialog, $bar) {
        var that = this, target = $bar.attr('tar')
        
        $('body').css('cursor', target +'-resize')
        $resizable
            .css({
                top    : $dialog.css('top'),
                left   : $dialog.css('left'),
                height : $dialog.outerHeight(),
                width  : $dialog.css('width')
            })
            .show()
        
        if (!this.options.dragCurrent) {
            this.options.dragCurrent = {
                $resizable : $resizable,
                $dialog    : $dialog,
                target     : target,
                oleft      : parseInt($resizable.css('left'))   || 0,
                owidth     : parseInt($resizable.css('width'))  || 0,
                otop       : parseInt($resizable.css('top'))    || 0,
                oheight    : parseInt($resizable.css('height')) || 0,
                ox         : e.pageX || e.screenX,
                oy         : e.pageY || e.clientY
            }
            $(document).on('mouseup.bjui.dialog.resize', $.proxy(that.resizeStop, that))
            $(document).on('mousemove.bjui.dialog.resize', $.proxy(that.resizeStart, that))
        }
    }
    
    Dialog.prototype.resizeStart = function(e) {
        var current = this.options.dragCurrent
        
        if (!current) return
        if (!e) var e = window.event
        
        var lmove     = (e.pageX || e.screenX) - current.ox,
            tmove     = (e.pageY || e.clientY) - current.oy,
            $mask = current.$dialog.data('bjui.dialog.mask')
        
        if (!$mask || !$mask.length)
            if ((e.pageY || e.clientY) <= 0 || (e.pageY || e.clientY) >= ($(window).height() - current.$dialog.find('> .dialogHeader').outerHeight())) return
        
        var target = current.target,
            width  = current.owidth,
            height = current.oheight
        
        if (target != 'n' && target != 's')
            width += (target.indexOf('w') >= 0) ? -lmove : lmove
        if (width >= this.options.minW) {
            if (target.indexOf('w') >= 0)
                current.$resizable.css('left', (current.oleft + lmove))
            if (target != 'n' && target != 's')
                current.$resizable.css('width', width)
        }
        if (target != 'w' && target != 'e')
            height += (target.indexOf('n') >= 0) ? -tmove : tmove
        if (height >= this.options.minH) {
            if (target.indexOf('n') >= 0)
                current.$resizable.css('top', (current.otop + tmove))
            if (target != 'w' && target != 'e')
                current.$resizable.css('height', height)
        }
    }
    
    Dialog.prototype.resizeStop = function(e) {
        var current = this.options.dragCurrent
        
        if (!current) return false
        
        $(document).off('mouseup.bjui.dialog.resize').off('mousemove.bjui.dialog.resize')
        
        this.options.dragCurrent = null
        this.resizeDialog(current.$resizable, current.$dialog, current.target)
        
        $('body').css('cursor', '')
        current.$resizable.hide()
    }
    
    // DIALOG PLUGIN DEFINITION
    // =======================
    
    function Plugin(option) {
        var args     = arguments,
            property = option,
            dialog   = 'bjui.dialog',
            $body    = $('body'),
            datas    = $body.data(dialog) || {}
        
        return this.each(function () {
            var $this   = $(this),
                options = $.extend({}, Dialog.DEFAULTS, typeof option === 'object' && option),
                id      = options && options.id,
                data
            
            if (!id) {
                if (datas.current) id = datas.current.options.id
                else id = 'dialog'
            } else {
                if (!id.isNormalID()) {
                    BJUI.debug('Dialog Plugin: ID ['+ id +'] '+ BJUI.regional.idChecked)
                    
                    return
                }
            }
            
            options.id = id
            data = datas && datas[id]
            
            if (!data) {
                datas[id] = (data = new Dialog(options))
            } else {
                if (typeof option === 'object' && option)
                    $.extend(data.options, option)
            }
            
            $body.data(dialog, datas)
            
            if (typeof property === 'string' && $.isFunction(data[property])) {
                [].shift.apply(args)
                if (!args) data[property]()
                else data[property].apply(data, args)
            } else {
                //data = new Dialog(this, options)
                data.open()
            }
        })
    }
    
    var old = $.fn.dialog
    
    $.fn.dialog             = Plugin
    $.fn.dialog.Constructor = Dialog
    
    // DIALOG NO CONFLICT
    // =================
    
    $.fn.dialog.noConflict = function () {
        $.fn.dialog = old
        return this
    }
    
    // NOT SELECTOR
    // ==============
    
    BJUI.dialog = function() {
        Plugin.apply($('body'), arguments)
    }
    
    // DIALOG DATA-API
    // ==============
    
    $(document).on('click.bjui.dialog.data-api', '[data-toggle="dialog"]', function(e) {
        var $this   = $(this), href = $this.attr('href'), data = $this.data(), options = data.options
        
        if (options) {
            if (typeof options === 'string') options = options.toObj()
            if (typeof options === 'object')
                $.extend(data, options)
        }
        
        if (!data.title) data.title = $this.text()
        if (href && !data.url) data.url = href
        
        Plugin.call($this, data)
        
        e.preventDefault()
    })
    
}(jQuery);
/*!
 * B-JUI  v1.3 beta2 (http://b-jui.com)
 * Git@OSC (http://git.oschina.net/xknaan/B-JUI)
 * Copyright 2014 K'naan.
 * Licensed under Apache (http://www.apache.org/licenses/LICENSE-2.0)
 */

/* ========================================================================
 * B-JUI: bjui-taskbar.js  v1.3 beta2
 * reference: bjui-dialog.js
 * @author K'naan
 * http://git.oschina.net/xknaan/B-JUI/blob/master/BJUI/js/bjui-taskbar.js
 * ========================================================================
 * Copyright 2014 K'naan.
 * Licensed under Apache (http://www.apache.org/licenses/LICENSE-2.0)
 * ======================================================================== */

+function ($) {
    'use strict';
    
    // TASKBAR GLOBAL ELEMENTS
    // ======================
    
    var $resizable
    var $taskBar, $taskBox, $taskList, $prevBtn, $nextBtn, taskDisabled, taskSelected, taskMargin
    
    $(function() {
        var INIT_TASKBAR = function() {
            $resizable   = $('#bjui-resizable')
            $taskBar     = $(FRAG.taskbar)
            $taskBox     = $taskBar.find('.taskbarContent')
            $taskList    = $taskBox.find('> ul')
            $prevBtn     = $taskBar.find('.taskbarLeft')
            $nextBtn     = $taskBar.find('.taskbarRight')
            taskDisabled = 'disabled'
            taskSelected = 'selected'
            taskMargin   = 'taskbarMargin'
            
            $('body').append('<!-- dialog task bar -->').append($taskBar)
            
            //events
            $prevBtn.click(function(e) { $(this).taskbar('scrollLeft') })
            $nextBtn.click(function(e) { $(this).taskbar('scrollRight') })
        }
        INIT_TASKBAR()
    })
    
    // TASKBAR CLASS DEFINITION
    // ======================
    
    var Taskbar = function(element, options) {
        this.$element = $(element)
        this.$task    = null
        this.options  = options
        this.tools    = this.TOOLS()
    }
    
    Taskbar.DEFAULTS = {
        id: undefined,
        title: undefined
    }
    
    Taskbar.prototype.init = function() {
        var that = this
        var $task = $taskList.find('#task-'+ this.options.id)
        
        this.show()
        if (!$task.length) {
            var taskFrag = '<li id="#taskid#"><div class="taskbutton"><span><i class="fa fa-th-large"></i></span> <span class="title">#title#</span></div><div class="close"><i class="fa fa-times-circle"></i></div></li>';
            
            $task = $(taskFrag.replace('#taskid#', 'task-'+ this.options.id).replace('#title#', this.options.title))
            $task.appendTo($taskList)
        } else {
            $task.find('> div > span.title').html(this.options.title)
        }
        this.contextmenu($task)
        this.switchTask($task)
        this.tools.scrollTask($task)
        
        //events
        $task.click(function(e) {
            if ($(e.target).closest('div').hasClass('close') || $(e.target).hasClass('close')) {
                $task.dialog('close', that.options.id)
            } else {
                var datas   = $('body').data('bjui.dialog'),
                    $dialog = datas[that.options.id].dialog
                
                if ($task.hasClass('selected')) {
                    $dialog.find('.dialogHeader a.minimize').trigger('click')
                } else {
                    if ($dialog.is(':hidden')) {
                        that.restoreDialog($dialog)
                    } else {
                        $dialog.trigger('click')
                        $task.addClass(taskSelected)
                    }   
                }
                that.scrollCurrent($task)
            }
            
            return false
        })
    }
    
    Taskbar.prototype.TOOLS = function() {
        var that  = this
        var tools = {
            scrollCurrent: function() {
                var iW = this.tasksW(this.getTasks())
                
                if (iW > this.getTaskBarW()) {
                    var $tools = this
                    var lTask  = $taskList.find('> li:last-child')
                    var left   = this.getTaskBarW() - lTask.position().left - lTask.outerWidth(true)
                    
                    $taskList.animate({left: left}, 200, function() {
                        $tools.ctrlScrollBtn()
                    })
                } else {
                    this.ctrlScrollBtn()
                }
            },
            getTaskBarW: function() {
                return $taskBox.width()- ($prevBtn.is(':hidden') ? $prevBtn.width() + 2 : 0) - ($nextBtn.is(':hidden') ? $nextBtn.width() + 2 : 0)
            },
            scrollTask: function($task) {
                var $tools = this
                
                if ($task.position().left + this.getLeft() + $task.outerWidth() > this.getBarWidth()) {
                    var left = this.getTaskBarW() - $task.position().left  - $task.outerWidth(true) - 2
                    
                    $taskList.animate({left:left}, 200, function() {
                        $tools.ctrlScrollBtn()
                    })
                } else if ($task.position().left + this.getLeft() < 0) {
                    var left = this.getLeft() - ($task.position().left + this.getLeft())
                    
                    $taskList.animate({left:left}, 200, function() {
                        $tools.ctrlScrollBtn()
                    })
                }
            },
            ctrlScrollBtn: function() {
                var iW = this.tasksW(this.getTasks())
                
                if (this.getTaskBarW() > iW) {
                    $taskBox.removeClass(taskMargin)
                    $nextBtn.hide()
                    $prevBtn.hide()
                    if (this.getTasks().eq(0).length) this.scrollTask(this.getTasks().eq(0))
                } else {
                    $taskBox.addClass(taskMargin)
                    $nextBtn.show().removeClass(taskDisabled)
                    $prevBtn.show().removeClass(taskDisabled)
                    if (this.getLeft() >= 0) $prevBtn.addClass(taskDisabled)
                    if (this.getLeft() <= this.getTaskBarW() - iW) $nextBtn.addClass(taskDisabled)
                }
            },
            getLeft: function(){
                return $taskList.position().left
            },
            visibleStart: function() {
                var iLeft = this.getLeft()
                var jTasks = this.getTasks()
                
                for (var i = 0; i < jTasks.size(); i++) {
                    if (jTasks.eq(i).position().left + jTasks.eq(i).outerWidth(true) + iLeft >= 0) return jTasks.eq(i)
                }
                
                return jTasks.eq(0)
            },
            visibleEnd: function() {
                var iLeft = this.getLeft()
                var jTasks = this.getTasks()
                
                for (var i = 0; i < jTasks.size(); i++) {
                    if (jTasks.eq(i).position().left + jTasks.eq(i).outerWidth(true) + iLeft > this.getBarWidth()) return jTasks.eq(i)
                }
                
                return jTasks.eq(jTasks.size() - 1)
            },
            getTasks: function() {
                return $taskList.find('> li')
            },
            tasksW: function(jTasks) {
                var iW = 0
                
                jTasks.each(function() {
                    iW += $(this).outerWidth(true)
                })
                
                return iW
            },
            getBarWidth: function() {
                return $taskBar.innerWidth()
            },
            getCurrent: function() {
                return $taskList.find('li.'+ taskSelected)
            }
        }
        
        return tools
    }
    
    Taskbar.prototype.contextmenu = function($obj) {
        var that = this
        
        $obj.contextmenu({
            id: 'dialogCM',
            bindings: {
                reload: function(t) {
                    t.dialog('refresh', that.options.id)
                },
                closeCurrent: function(t, m) {
                    var $obj = t.isTag('li') ? t : that.tools.getCurrent()
                    
                    $obj.find('.close').trigger('click')
                },
                closeOther: function(t, m){
                    var $tasks = $taskList.find('> li').not(t)
                    
                    $tasks.each(function(i) {
                        $(this).find('.close').trigger('click')
                    })
                },
                closeAll: function(t, m) {
                    var $tasks = that.tools.getTasks()
                    
                    $tasks.each(function(i) {
                        $(this).find('.close').trigger('click')
                    })
                }
            },
            ctrSub: function(t, m) {
                var mCur = m.find('[rel="closeCurrent"]')
                var mOther = m.find('[rel="closeOther"]')
                
                if (!that.tools.getCurrent().length) {
                    mCur.addClass(taskDisabled)
                    mOther.addClass(taskDisabled)
                } else {
                    if (that.tools.getTasks().size() == 1)
                        mOther.addClass(taskDisabled)
                }
            }
        })
    }
    
    Taskbar.prototype.closeDialog = function(task) {
        var $task = (typeof task === 'string') ? this.getTask(task) : task
        
        if (!$task || !$task.length) return
        
        $task.remove()
        if (!this.tools.getTasks().size()) {
            this.hide()
        }
        this.tools.scrollCurrent()
        this.$element.removeData('bjui.taskbar')
    }
    
    Taskbar.prototype.minimize = function(dialog) {
        var that    = this,
            datas   = $('body').data('bjui.dialog'),
            $dialog = (typeof dialog === 'string') ? datas[dialog].dialog : dialog,
            $task   = this.getTask($dialog.data('options').id)
        
        $resizable.css({
            top: $dialog.css('top'),
            left: $dialog.css('left'),
            height: $dialog.css('height'),
            width: $dialog.css('width')
        }).show().animate({top:$(window).height() - 60, left:$task.position().left, width:$task.outerWidth(), height:$task.outerHeight()}, 250, function() {
            $(this).hide()
            that.inactive($task)
        })
    }
    
    /**
     * @param {Object} id or dialog
     */
    Taskbar.prototype.restoreDialog = function($dialog) {
        var $task = this.getTask($dialog.data('options').id)
        
        $resizable.css({top:$(window).height() - 60, left:$task.position().left, height:$task.outerHeight(), width:$task.outerWidth()})
            .show()
            .animate({top:$dialog.css('top'), left:$dialog.css('left'), width:$dialog.css('width'), height:$dialog.css('height')}, 250, function() {
                $(this).hide()
                
                $dialog.show().trigger('click.bjui.taskbar.restore')
            })
        
        this.switchTask($task)
    }
    
    /**
     * @param {Object} id
     */
    Taskbar.prototype.inactive = function(task) {
        var $task = (typeof task === 'string') ? this.getTask(task) : task
        
        $task.removeClass(taskSelected)
    }
    
    Taskbar.prototype.scrollLeft = function() {
        var $task = this.tools.visibleStart()
        
        this.tools.scrollTask($task)
    }
    
    Taskbar.prototype.scrollRight = function() {
        var $task = this.tools.visibleEnd()
        
        this.tools.scrollTask($task)
    }
    
    Taskbar.prototype.scrollCurrent = function($task) {
        this.tools.scrollTask($task)
    }
    
    /**
     * @param {Object} id or $task
     */
    Taskbar.prototype.switchTask = function(task) {
        this.tools.getCurrent().removeClass(taskSelected)
        var $task = (typeof task === 'string') ? this.getTask(task) : task
        
        $task.addClass(taskSelected)
    }
    
    Taskbar.prototype.getTask = function(id) {
        return $taskList.find('#task-'+ id)
    }
    
    Taskbar.prototype.changeTitle = function(id, title) {
        var $task = this.getTask(id)
        
        if ($task && title) $task.find('.title').html(title)
    }
    
    Taskbar.prototype.show = function() {
        if ($taskBar.is(':hidden')) $taskBar.show().animate({bottom:0}, 500)
    }
    
    Taskbar.prototype.hide = function() {
        if ($taskBar.is(':visible')) $taskBar.animate({bottom:-50}, 500, function() { $taskBar.hide() })
    }
    
    // TASKBAR PLUGIN DEFINITION
    // =======================
    
    function Plugin(option) {
        var args = arguments
        var property = option
        
        return this.each(function () {
            var $this   = $(this)
            var options = $.extend({}, Taskbar.DEFAULTS, $this.data(), typeof option === 'object' && option)
            var data    = $this.data('bjui.taskbar')
            
            if (!data) $this.data('bjui.taskbar', (data = new Taskbar(this, options)))
            else if (data.options.id != options.id) $this.data('bjui.taskbar', (data = new Taskbar(this, options)))
            
            if (typeof property === 'string' && $.isFunction(data[property])) {
                [].shift.apply(args)
                if (!args) data[property]()
                else data[property].apply(data, args)
            } else {
                data.init()
            }
        })
    }

    var old = $.fn.taskbar

    $.fn.taskbar             = Plugin
    $.fn.taskbar.Constructor = Taskbar
    
    // TASKBAR NO CONFLICT
    // =================
    
    $.fn.taskbar.noConflict = function () {
        $.fn.taskbar = old
        return this
    }
    
}(jQuery);
/*!
 * B-JUI  v1.3 beta2 (http://b-jui.com)
 * Git@OSC (http://git.oschina.net/xknaan/B-JUI)
 * Copyright 2014 K'naan.
 * Licensed under Apache (http://www.apache.org/licenses/LICENSE-2.0)
 */

/* ========================================================================
 * B-JUI: bjui-ajax.js  v1.3 beta2
 * @author K'naan 
 * http://git.oschina.net/xknaan/B-JUI/blob/master/BJUI/js/bjui-ajax.js
 * ========================================================================
 * Copyright 2014 K'naan.
 * Licensed under Apache (http://www.apache.org/licenses/LICENSE-2.0)
 * ======================================================================== */

+function ($) {
    'use strict';
    
    // BJUIAJAX GLOBAL ELEMENTS
    // ======================
    
    var autorefreshTimer
    
    // BJUIAJAX CLASS DEFINITION
    // ======================
    
    var Bjuiajax = function(element, options) {
        var $this     = this
        
        this.$element = $(element)
        this.options  = options
        this.tools    = this.TOOLS()
    }
    
    Bjuiajax.DEFAULTS = {
        okalert     : true,
        reload      : true,
        loadingmask : true
    }
    
    Bjuiajax.NAVTAB = 'navtab'
    
    Bjuiajax.prototype.TOOLS = function() {
        var that  = this
        var tools = {
            getPagerForm: function($parent, args, form) {
                var pageInfo = $.extend({}, BJUI.pageInfo)
                
                if (!form)
                    form = $parent.find('#pagerForm:first')[0]
                
                if ($parent.data('bjui.clientPaging')) {
                    args = $.extend({}, $parent.data('bjui.clientPaging'), args)
                    $parent.data('bjui.clientPaging', args)
                }
                
                if (form) {
                    for (var key in pageInfo) {
                        var val = ''
                        
                        if (args && args[key]) val = args[key]
                        if (!form[pageInfo[key]]) $('<input type="hidden" name="'+ pageInfo[key] +'" value="'+ val +'">').appendTo($(form))
                        else if (val) form[pageInfo[key]].value = val
                    }
                }
                
                return form
            },
            getTarget: function() {
                if (that.$element.closest('.navtab-panel').length) return Bjuiajax.NAVTAB
                else return 'dialog'
            }
        }
        
        return tools
    }
    
    Bjuiajax.prototype.ajaxdone = function(json) {
        if (json[BJUI.keys.statusCode] == BJUI.statusCode.error) {
            if (json[BJUI.keys.message]) BJUI.alertmsg('error', json[BJUI.keys.message])
        } else if (json[BJUI.keys.statusCode] == BJUI.statusCode.timeout) {
            BJUI.alertmsg('info', (json[BJUI.keys.message] || BJUI.regional.sessiontimeout))
            BJUI.loadLogin()
        } else {
            if (json[BJUI.keys.message]) BJUI.alertmsg('correct', json[BJUI.keys.message])
        }
    }
    
    Bjuiajax.prototype.ajaxerror = function(xhr, ajaxOptions, thrownError) {
        var msg = xhr.responseText, that = this, options = that.options, failCallback = options.failCallback
        
        if (typeof msg === 'string' && msg.startsWith('{')) {
            this.ajaxdone(msg.toObj())
        } else {
            BJUI.alertmsg('error', '<div>Http status: ' + xhr.status + ' ' + xhr.statusText + '</div>' 
                + '<div>ajaxOptions: '+ ajaxOptions +' </div>'
                + '<div>thrownError: '+ thrownError +' </div>'
                + '<div>'+ msg +'</div>')
        }
        
        if (failCallback) {
            if (typeof failCallback === 'string')
                failCallback = failCallback.toFunc()
            if (typeof failCallback === 'function')
                failCallback.apply(that, [msg, options])
            else
                BJUI.debug('The callback function \'failCallback\' is incorrect: '+ failCallback)
        }
    }
    
    Bjuiajax.prototype.ajaxcallback = function(json) {
        var that = this, options = that.options,
            okCallback = options.okCallback, errCallback = options.errCallback, okAfterCallback = options.okAfterCallback,
            tabids = [], dialogids = [], divids = [], datagrids = []
        
        var okFunc = function() {
                if (typeof okCallback === 'string')
                    okCallback = okCallback.toFunc()
                if (typeof okCallback === 'function')
                    okCallback.apply(that, [json, options])
                else
                    BJUI.debug('The callback function \'okCallback\' is incorrect: '+ okCallback)
            },
            okAfterFunc = function() {
                if (typeof okAfterCallback === 'string')
                    okAfterCallback = okAfterCallback.toFunc()
                if (typeof okAfterCallback === 'function')
                    okAfterCallback.apply(that, [json, options])
                else
                    BJUI.debug('The callback function \'okAfterCallback\' is incorrect: '+ okAfterCallback)
            },
            errFunc = function() {
                if (typeof errCallback === 'string')
                    errCallback = errCallback.toFunc()
                if (typeof errCallback === 'function')
                    errCallback.apply(that, [json, options])
                else
                    BJUI.debug('The callback function \'errCallback\' is incorrect: '+ errCallback)
            }
        
        if (typeof json === 'string')
            json = json.toObj()
                
        if (options.okalert)
            that.ajaxdone(json)
        
        if (!json[BJUI.keys.statusCode]) {
            if (okCallback) {
                okFunc()
                return
            }
        }
        if (json[BJUI.keys.statusCode] == BJUI.statusCode.ok) {
            if (okCallback) {
                okFunc()
                return
            }
            
            if (json.tabid)
                $.merge(tabids, json.tabid.split(','))
            if (options.tabid)
                $.merge(tabids, options.tabid.split(','))
            
            if (json.dialogid)
                $.merge(dialogids, json.dialogid.split(','))
            if (options.dialogid)
                $.merge(dialogids, options.dialogid.split(','))
            
            if (json.divid)
                $.merge(divids, json.divid.split(','))
            if (options.divid)
                $.merge(divids, options.divid.split(','))
            
            if (json.datagrid)
                $.merge(datagrids, json.datagrid.split(','))
            if (options.datagrid)
                $.merge(datagrids, options.datagrid.split(','))
            
            // refresh
            if (tabids.length) {
                $.unique(tabids)
                setTimeout(function() { BJUI.navtab('reloadFlag', tabids.join(',')) }, 100)
            }
            if (dialogids.length) {
                $.unique(dialogids)
                setTimeout(function() { BJUI.dialog('refresh', dialogids.join(',')) }, 100)
            }
            if (divids.length) {
                $.unique(divids)
                setTimeout(function() { that.refreshdiv(divids.join(',')) }, 100)
            }
            if (datagrids.length) {
                setTimeout(function() {
                    $.each(datagrids, function(i, n) {
                        $('#'+ n.trim()).datagrid('refresh')
                    })
                }, 100)
            }
            
            if (that.$target == $.CurrentNavtab) {
                that.navtabcallback(json)
            } else if (that.$target == $.CurrentDialog) {
                that.dialogcallback(json)
            } else {
                that.divcallback(json)
            }
            
            if (okAfterCallback) {
                okAfterFunc()
            }
        } else {
            if (errCallback) {
                errFunc()
            }
        }
    }
    
    Bjuiajax.prototype.divcallback = function(json, $target, options) {
        var that = this, options = that.options,
            forward = json.forward || options.forward || null,
            forwardConfirm = json.forwardConfirm || options.forwardConfirm || null
        
        
        if (options.reload && !forward) {
            that.refreshlayout(options)
        }
        
        if (options.reloadNavtab)
            setTimeout(function() { BJUI.navtab('refresh') }, 100)
        
        if (forward) {
            var _forward = function() {
                $.extend(options, {url: forward})
                that.refreshlayout(options)
            }
            
            if (forwardConfirm) {
                BJUI.alertmsg('confirm', forwardConfirm, {
                    okCall: function() { _forward() }
                })
            } else {
                _forward()
            }
        }
    }
    
    Bjuiajax.prototype.navtabcallback = function(json) {
        var that = this, options = that.options,
            closeCurrent = json.closeCurrent || options.closeCurrent || false,
            forward = json.forward || options.forward || null,
            forwardConfirm = json.forwardConfirm || options.forwardConfirm || null
        
        if (closeCurrent && !forward)
            BJUI.navtab('closeCurrentTab')
        else if (options.reload && !forward)
            setTimeout(function() { BJUI.navtab('refresh') }, 100)
        
        if (forward) {
            var _forward = function() {
                BJUI.navtab('reload', {url:forward})
            }
            
            if (forwardConfirm) {
                BJUI.alertmsg('confirm', forwardConfirm, {
                    okCall: function() { _forward() },
                    cancelCall: function() { if (closeCurrent) { BJUI.navtab('closeCurrentTab') } }
                })
            } else {
                _forward()
            }
        }
    }
    
    Bjuiajax.prototype.dialogcallback = function(json) {
        var that = this, options = that.options,
            closeCurrent = json.closeCurrent || options.closeCurrent || false,
            forward = json.forward || options.forward || null,
            forwardConfirm = json.forwardConfirm || options.forwardConfirm || null
        
        if (closeCurrent && !forward)
            BJUI.dialog('closeCurrent')
        else if (options.reload && !forward)
            setTimeout(function() { BJUI.dialog('refresh') }, 100)
        
        if (options.reloadNavtab)
            setTimeout(function() { BJUI.navtab('refresh') }, 100)
        if (forward) {
            var _forward = function() {
                BJUI.dialog('reload', {url:forward})
            }
            
            if (forwardConfirm) {
                BJUI.alertmsg('confirm', json.forwardConfirm, {
                    okCall: function() { _forward() },
                    cancelCall: function() { if (closeCurrent) { BJUI.dialog('closeCurrent') } }
                })
            } else {
                _forward()
            }
        }
    }
    
    Bjuiajax.prototype.pagecallback = function(options, target) {
        var that    = this
        var op      = $.extend({}, Bjuiajax.DEFAULTS, options)
        var $target = target || null
        var form    = null
        
        if ($target && $target.length) {
            form = that.tools.getPagerForm($target, op)
            if (form) {
                $.extend(op, $(form).data())
                that.reloadlayout({target:$target[0], type:$(form).attr('method') || 'POST', url:$(form).attr('action'), data:$(form).serializeArray(), loadingmask:op.loadingmask})
            }
        } else {
            if (that.tools.getTarget() == Bjuiajax.NAVTAB) {
                $target = $.CurrentNavtab
                form    = that.tools.getPagerForm($target, op)
                if (form) $.extend(op, $(form).data())
                that.$element.navtab('reloadForm', false, op)
            } else {
                $target = $.CurrentDialog
                form    = that.tools.getPagerForm($target, op)
                if (form) $.extend(op, $(form).data())
                that.$element.dialog('reloadForm', false, op)
            }
        }
    }
    
    Bjuiajax.prototype.doajax = function(options) {
        var that = this, $target, $element = that.$element
        
        if (!options) options = {}
        if (!options.loadingmask) options.loadingmask = false
        
        options = $.extend({}, Bjuiajax.DEFAULTS, typeof options === 'object' && options)
        that.options = options
        
        if (options.target) {
            if (options.target instanceof jQuery)
                $target = options.target
            else
                $target = $(options.target)
        } else {
            if ($element[0] !== $('body')[0]) {
                $target = $element.closest('.bjui-layout')
            }
        }
        
        if (!$target || !$target.length)
            $target = $.CurrentDialog || $.CurrentNavtab
        
        that.$target = $target
        
        if (!options.url) {
            BJUI.debug('Bjuiajax Plugin: \'doajax\' method: the url is undefined!')
            return
        } else {
            options.url = decodeURI(options.url).replacePlh($target)
            
            if (!options.url.isFinishedTm()) {
                BJUI.alertmsg('error', (options.warn || BJUI.regional.plhmsg))
                BJUI.debug('Bjuiajax Plugin: \'doajax\' method: The url is incorrect: '+ options.url)
                return
            }
            
            options.url = encodeURI(options.url)
        }
        
        var callback = options.callback && options.callback.toFunc()
        var todo     = function() {
            if (!options.callback)
                options.callback = $.proxy(function(data) {that.ajaxcallback(data)}, that)
            
            $target.doAjax(options)
        }
        
        if (options.confirmMsg) {
            BJUI.alertmsg('confirm', options.confirmMsg,
                {
                    okCall : function() {
                        todo()
                    }
                }
            )
        } else {
            todo()
        }
    }
    
    Bjuiajax.prototype.ajaxform = function(option) {
        var that      = this,
            options   = $.extend({}, typeof option === 'object' && option),
            $element  = that.$element,
            $target   = null,
            $form     = null,
            callback  = options.callback,
            enctype
        
        // form
        if ($element[0] === $('body')[0]) {
            $form = options.form
            
            if (!($form instanceof jQuery))
                $form = $(options.form)
        } else {
            $form   = $element
            $target = $form.closest('.bjui-layout')
        }
        
        if (!$form || !$form.length || !($form.isTag('form'))) {
            BJUI.debug('Bjuiajax Plugin: \'ajaxform\' method: Not set the form!')
            return
        }
        
        enctype = $form.attr('enctype')
        
        // target
        if (options.target) {
            $target = options.target
            
            if (!($target instanceof jQuery))
                $target = $($target)
        }
        
        if (!$target || !$target.length)
            $target = $.CurrentDialog || $.CurrentNavtab
        
        that.$target = $target
        
        options.url  = options.url || $form.attr('action')
        // for ie8
        if (BJUI.isIE(8) && !options.type) {
            if (!$form[0].getAttributeNode('method').specified) options.type = 'POST'
        }
        options.type = options.type || $form.attr('method') || 'POST'
        
        $.extend(that.options, options)
        
        if (callback) callback = callback.toFunc()
        
        var successFn = function(data, textStatus, jqXHR) {
            callback ? callback.apply(that, [data, $form]) : $.proxy(that.ajaxcallback(data), that)
        }
        var _submitFn = function() {
            var op = {loadingmask:that.options.loadingmask, type:that.options.type, url:that.options.url, callback:successFn, error:$.proxy(that.ajaxerror, that)}
            
            if (enctype && enctype == 'multipart/form-data') {
                if (window.FormData) {
                    $.extend(op, {data:new FormData($form[0]), contentType:false, processData:false}) 
                } else {
                    $.extend(op, {data:$form.serializeArray(), files:$form.find(':file'), iframe:true, processData:false})
                }
            } else {
                $.extend(op, {data:$form.serializeArray()})
            }
            
            if (that.options.ajaxTimeout) op.ajaxTimeout = that.options.ajaxTimeout
            
            $form.doAjax(op)
        }
        
        if (that.options.confirmMsg) {
            BJUI.alertmsg('confirm', that.options.confirmMsg, {okCall: _submitFn})
        } else {
            _submitFn()
        }
    }
    
    Bjuiajax.prototype.ajaxsearch = function(option) {
        var that = this, options = $.extend({}, typeof option === 'object' && option), $element = that.$element, form = null, op = {pageCurrent:1}, $form, $target, isValid = options.isValid
        
        if (options.target) $target = $(options.target)
        if ($element[0] === $('body')[0]) {
            $form = options.form
            
            if (!($form instanceof jQuery)) {
                $form = $(options.form)
            }
            if (!$form || !$form.length || !($form.isTag('form'))) {
                BJUI.debug('Bjuiajax Plugin: \'ajaxsearch\' method: Not set the form!')
                return
            }
            if (options.target) {
                $target = options.target
                
                if (!($target instanceof jQuery))
                    $target = $($target)
            } else {
                $target = $form.closest('.bjui-layout')
            }
            
            if (!$target || !$target.length)
                $target = $.CurrentDialog || $.CurrentNavtab
        } else {
            $form   = $element
            $target = $form.closest('.bjui-layout')
            
            if (!($form.isTag('form'))) {
                BJUI.debug('Bjuiajax Plugin: \'ajaxsearch\' method: Not set the form!')
                return
            }
            if (!$target || !$target.length) {
                $target = $.CurrentDialog || $.CurrentNavtab
            }
            
            if (!options.url)
                options.url = $form.attr('action')
        }
        
        that.$target = $target
        
        if (!options.url)
            options.url = $form.attr('action')
        
        if (!options.url) {
            BJUI.debug('Bjuiajax Plugin: \'ajaxsearch\' method: The form\'s action or url is undefined!')
            return
        } else {
            options.url = decodeURI(options.url).replacePlh($form.closest('.unitBox'))
            
            if (!options.url.isFinishedTm()) {
                BJUI.alertmsg('error', (options.warn || BJUI.regional.plhmsg))
                BJUI.debug('Bjuiajax Plugin: \'ajaxsearch\' method: The form\'s action or url is incorrect: '+ options.url)
                return
            }
            
            options.url = encodeURI(options.url)
        }
        
        if (!options.type)
            options.type = $form.attr('method') || 'POST'
        
        that.tools.getPagerForm($target, op, $form[0])
        options.form = $form
        
        $.extend(that.options, options)
        
        var search = function() {
            if ($target.hasClass('bjui-layout')) {
                var data = $form.serializeJson(), _data = {}
                
                if (options.clearQuery) {
                    var pageInfo = BJUI.pageInfo
                    
                    for (var key in pageInfo) {
                        _data[pageInfo[key]] = data[pageInfo[key]]
                    }
                    
                    data = _data
                }
                
                that.reloadlayout({target:$target[0], type:that.options.type, url:that.options.url, data:data, loadingmask:that.options.loadingmask})
            } else {
                if ($target[0] === ($.CurrentNavtab)[0]) {
                    BJUI.navtab('reloadForm', that.options.clearQuery, options)
                } else {
                    BJUI.dialog('reloadForm', that.options.clearQuery, options)
                }
            }
        }
        
        if (!isValid) {
            if ($.fn.validator) {
                $form.isValid(function(v) {
                    if (v) search()
                })
            } else {
                search()
            }
        } else {
            search()
        }
    }
    
    Bjuiajax.prototype.doload = function(option) {
        var that = this, $target = null, options = $.extend({}, typeof option === 'object' && option)
        
        $.extend(that.options, options)
        
        if (options.target) {
            $target = options.target
            
            if (!($target instanceof jQuery))
                $target = $($target)
        }
        
        if (!$target || !$target.length) {
            BJUI.debug('Bjuiajax Plugin: \'doload\' method: Not set loaded container, like [data-target].')
            return
        }
        
        if (!options.url) {
            BJUI.debug('Bjuiajax Plugin: \'doload\' method: The url is undefined!')
            return
        } else {
            options.url = decodeURI(options.url).replacePlh()
            
            if (!options.url.isFinishedTm()) {
                BJUI.alertmsg('error', (options.warn || BJUI.regional.plhmsg))
                BJUI.debug('Bjuiajax Plugin: \'doload\' method: The url is incorrect: '+ options.url)
                return
            }
            
            options.url = encodeURI(options.url)
        }
        
        $target.removeData('bjui.clientPaging').data('options', options)
        that.reloadlayout(options)
    }
    
    Bjuiajax.prototype.refreshlayout = function(target) {
        var that = this, $target
        
        if (target) {
            $target = target
            
            if (!($target instanceof jQuery))
                $target = $($target)
        }
        
        if (!$target || !$target.length) {
            if (autorefreshTimer) clearInterval(autorefreshTimer)
            BJUI.debug('Bjuiajax Plugin: \'refreshlayout\' method: No argument, can not refresh DIV.(parameters:[selector/jQuery object/element])')
            return
        }
        if ($target && $target.length) {
            if (!$target.data('options')) {
                BJUI.debug('Bjuiajax Plugin: \'refreshlayout\' method: The target(DIV) is not a reload layout!')
                return
            }
            $target.removeData('bjui.clientPaging')
            that.reloadlayout($target.data('options'))
        }
    }
    
    Bjuiajax.prototype.reloadlayout = function(option) {
        var $target = null,
            options = $.extend({}, typeof option === 'object' && option),
            arefre  = options && options.autorefresh && (isNaN(String(options.autorefresh)) ? 15 : options.autorefresh)
        
        if (options.target) {
            $target = options.target
            
            if (!($target instanceof jQuery))
                $target = $($target)
        }
        
        if (!$target || !$target.length) {
            if (autorefreshTimer) clearInterval(autorefreshTimer)
            BJUI.debug('Bjuiajax Plugin: \'refreshlayout\' method: Not set loaded container, like [data-target].')
            return
        } else {
            if (!$target.data('options')) {
                BJUI.debug('Bjuiajax Plugin: \'refreshlayout\' method: This target(DIV) is not initialized!')
                return
            }
            options = $.extend({}, $target.data('options'), options)
        }
        
        $target
            .addClass('bjui-layout')
            .data('options', options)
            .ajaxUrl({ type:options.type, url:options.url, data:options.data, loadingmask:options.loadingmask, callback:function(html) {
                    if (BJUI.ui.clientPaging && $target.data('bjui.clientPaging'))
                        $target.pagination('setPagingAndOrderby', $target)
                    if (options.callback)
                        options.callback.apply(this, [$target, html])
                    if (autorefreshTimer)
                        clearInterval(autorefreshTimer)
                    if (arefre)
                        autorefreshTimer = setInterval(function() { $target.bjuiajax('refreshlayout', $target) }, arefre * 1000)
                }
            })
    }
    
    Bjuiajax.prototype.refreshdiv = function(divid) {
        if (divid && typeof divid === 'string') {
            var arr = divid.split(',')
            
            for (var i = 0; i < arr.length; i++) {
                this.refreshlayout('#'+ arr[i])
            }
        }
    }
    
    Bjuiajax.prototype.ajaxdownload = function(option) {
        var that = this, $target, options = $.extend({}, typeof option === 'object' && option)
        
        options.loadingmask = false
        
        $.extend(that.options, options)
        
        if (options.target) {
            $target = options.target
            
            if (!($target instanceof jQuery))
                $target = $($target)
        }
        
        if (!$target || !$target.length)
            $target = $.CurrentDialog || $.CurrentNavtab
        
        that.$target = $target
        
        if (!options.url) {
            BJUI.debug('Bjuiajax Plugin: \'ajaxdownload\' method: The url is undefined!')
            return
        } else {
            options.url = decodeURI(options.url).replacePlh($target)
            
            if (!options.url.isFinishedTm()) {
                BJUI.alertmsg('error', (options.warn || BJUI.regional.plhmsg))
                BJUI.debug('Bjuiajax Plugin: \'ajaxdownload\' method: The url is incorrect: '+ options.url)
                return
            }
        }
        
        var todo = function() {
            var downloadOptions = {}
            
            downloadOptions.failCallback = function(responseHtml, url) {
                if (responseHtml.trim().startsWith('{')) responseHtml = responseHtml.toObj()
                that.ajaxdone(responseHtml)
                $target.trigger('bjui.ajaxError')
            }
            downloadOptions.prepareCallback = function(url) {
                if (options.loadingmask) {
                    $target.trigger('bjui.ajaxStart')
                }
            }
            downloadOptions.successCallback = function(url) {
                $target.trigger('bjui.ajaxStop')
            }
            
            if (options.type && !options.httpMethod)
                options.httpMethod = options.type
            
            console.log(options)
            
            $.extend(downloadOptions, options)
            
            if (!downloadOptions.data) downloadOptions.data = {}
            if (typeof downloadOptions.data.ajaxrequest === 'undefined') downloadOptions.data.ajaxrequest = true
            
            $.fileDownload(options.url, downloadOptions)
        }
        
        if (options.confirmMsg) {
            BJUI.alertmsg('confirm', options.confirmMsg, {
                okCall: function() {
                    todo()
                }
            })
        } else {
            todo()
        }
    }
    
    // Deprecated
    Bjuiajax.prototype.doexport = function(options) {
        var that = this, $element = that.$element, $target = options.target ? $(options.target) : null, form
        
        if (!options.url) {
            BJUI.debug('Error trying to open a ajax link: url is undefined!')
            return
        } else {
            options.url = decodeURI(options.url).replacePlh($element.closest('.unitBox'))
            
            if (!options.url.isFinishedTm()) {
                BJUI.alertmsg('error', (options.warn || BJUI.regional.plhmsg))
                BJUI.debug('The ajax url is incorrect: '+ options.url)
                return
            }
        }
        
        var todo = function() {
            if (!$target || !$target.length) {
                if (that.tools.getTarget() == Bjuiajax.NAVTAB) {
                    $target = $.CurrentNavtab
                } else {
                    $target = $.CurrentDialog
                }
            }
            form = that.tools.getPagerForm($target)
            
            if (form) {
                if (!options.data) options.data = {}
                $.extend(options.data, $(form).serializeJson())
            }
            
            $.fileDownload(options.url, {
                failCallback: function(responseHtml, url) {
                    if (responseHtml.trim().startsWith('{')) responseHtml = responseHtml.toObj()
                    that.ajaxdone(responseHtml)
                },
                data: options.data || {}
            })
        }
        
        if (options.confirmMsg) {
            BJUI.alertmsg('confirm', options.confirmMsg, {
                okCall: function() {
                    todo()
                }
            })
        } else {
            todo()
        }
    }
    
    // Deprecated
    Bjuiajax.prototype.doexportchecked = function(options) {
        var that = this, $element = that.$element, $target = options.target ? $(options.target) : null, idname
        
        if (!options.url) {
            BJUI.debug('Error trying to open a export link: url is undefined!')
            return
        } else {
            options.url = decodeURI(options.url).replacePlh($element.closest('.unitBox'))
            
            if (!options.url.isFinishedTm()) {
                BJUI.alertmsg('error', (options.warn || BJUI.regional.plhmsg))
                BJUI.debug('The ajax url is incorrect: '+ options.url)
                return
            }
        }
        
        var todo = function() {
            if (!options.group) {
                BJUI.alertmsg('error', options.warn || BJUI.regional.nocheckgroup)
                return
            }
            if (!$target || !$target.length) {
                if (that.tools.getTarget() == Bjuiajax.NAVTAB) {
                    $target = $.CurrentNavtab
                } else {
                    $target = $.CurrentDialog
                }
            }
            
            var ids     = [],
                $checks = $target.find(':checkbox[name='+ options.group +']:checked')
            
            if (!$checks.length) {
                BJUI.alertmsg('error', BJUI.regional.notchecked)
                return
            }
            $checks.each(function() {
                ids.push($(this).val())
            })
            
            idname = options.idname || 'ids'
            options.data = options.data || {}
            options.data[idname] = ids.join(',')
            
            $.fileDownload(options.url, {
                failCallback: function(responseHtml, url) {
                    if (responseHtml.trim().startsWith('{')) responseHtml = responseHtml.toObj()
                    that.ajaxdone(responseHtml)
                },
                data: options.data
            })
        }
        
        if (options.confirmMsg) {
            BJUI.alertmsg('confirm', options.confirmMsg, {
                okCall: function() {
                    todo()
                }
            })
        } else {
            todo()
        }
    }
    
    // Deprecated
    Bjuiajax.prototype.doajaxchecked = function(options) {
        var that = this, $element = that.$element, $target = options.target ? $(options.target) : null, idname
        
        options = $.extend({}, Bjuiajax.DEFAULTS, typeof options === 'object' && options)
        if (!options.url) {
            BJUI.debug('Error trying to open a del link: url is undefined!')
            return
        } else {
            options.url = decodeURI(options.url).replacePlh($element.closest('.unitBox'))
            
            if (!options.url.isFinishedTm()) {
                BJUI.alertmsg('error', (options.warn || BJUI.regional.plhmsg))
                BJUI.debug('The ajax url is incorrect: '+ options.url)
                return
            }
        }
        
        var todo = function() {
            if (!options.group) {
                BJUI.alertmsg('error', options.warn || BJUI.regional.nocheckgroup)
                return
            }
            if (!$target || !$target.length) {
                if (that.tools.getTarget() == Bjuiajax.NAVTAB) {
                    $target = $.CurrentNavtab
                } else {
                    $target = $.CurrentDialog
                }
            }
            
            var ids      = [],
                $checks  = $target.find(':checkbox[name='+ options.group +']:checked'),
                callback = options.callback && options.callback.toFunc()
            
            if (!$checks.length) {
                BJUI.alertmsg('error', BJUI.regional.notchecked)
                return
            }
            $checks.each(function() {
                ids.push($(this).val())
            })
            
            idname = options.idname || 'ids'
            options.data = options.data || {}
            options.data[idname] = ids.join(',')
            
            $element.doAjax({type:options.type, url:options.url, data:options.data, callback:callback ? callback : $.proxy(function(data) {that.ajaxcallback(data)}, that)})
        }
        
        if (options.confirmMsg) {
            BJUI.alertmsg('confirm', options.confirmMsg, {
                okCall: function() {
                    todo()
                }
            })
        } else {
            todo()
        }
    }
    
    // BJUIAJAX PLUGIN DEFINITION
    // =======================
    
    function Plugin(option) {
        var args     = arguments,
            property = option,
            ajax     = 'bjui.ajax',
            $body    = $('body')
        
        return this.each(function () {
            var $this   = $(this),
                options = $.extend({}, Bjuiajax.DEFAULTS, typeof option === 'object' && option),
                data    = $this.data(ajax),
                func
            
            if (!data) {
                data = new Bjuiajax(this, options)
            } else {
                if (this === $body[0]) {
                    data = new Bjuiajax(this, options)
                } else {
                    $.extend(data.options, typeof option === 'object' && option)
                }
            }
            
            $this.data(ajax, data)
            
            if (typeof property === 'string') {
                func = data[property.toLowerCase()]
                if ($.isFunction(func)) {
                    [].shift.apply(args)
                    if (!args) func()
                    else func.apply(data, args)
                }
            }
        })
    }
    
    var old = $.fn.bjuiajax
    
    $.fn.bjuiajax             = Plugin
    $.fn.bjuiajax.Constructor = Bjuiajax
    
    // BJUIAJAX NO CONFLICT
    // =================
    
    $.fn.bjuiajax.noConflict = function () {
        $.fn.bjuiajax = old
        return this
    }
    
    // NOT SELECTOR
    // ==============
    
    BJUI.ajax = function() {
        Plugin.apply($('body'), arguments)
    }
    
    // BJUIAJAX DATA-API
    // ==============
    
    $(document).on('submit.bjui.bjuiajax.data-api', 'form[data-toggle="ajaxform"]', function(e) {
        var $this = $(this), options = $this.data()
        
        Plugin.call($this, 'ajaxform', options)
        
        e.preventDefault()
    })
    
    /* ajaxsearch */
    $(function() {
        if ($.fn.validator) {
            $(document).on(BJUI.eventType.initUI, function(e) {
                $(e.target).find('form[data-toggle="ajaxsearch"]').each(function() {
                    var $form = $(this), options = $form.data()
                    
                    options.isValid = true
                    $form.validator({
                        valid: function(form) {
                            Plugin.call($form, 'ajaxsearch', options)
                        }
                    })
                })
            })
        } else {
            $(document).on('submit.bjui.bjuiajax.data-api', 'form[data-toggle="ajaxsearch"]', function(e) {
                var $this   = $(this), options = $this.data()
                
                Plugin.call($this, 'ajaxsearch', options)
                
                e.preventDefault()
            })
        }
    })
    
    $(document).on('click.bjui.bjuiajax.data-api', '[data-toggle="reloadsearch"]', function(e) {
        var $this = $(this), options
        var $form = $this.closest('form')
        
        if (!$form || !$form.length) return
        
        options = $form.data()
        options.clearQuery = $this.data('clearQuery') || true
        
        Plugin.call($form, 'ajaxsearch', options)
        
        e.preventDefault()
    })
    
    $(document).on('click.bjui.bjuiajax.data-api', '[data-toggle="ajaxload"]', function(e) {
        var $this = $(this), data = $this.data(), options = data.options
        
        if (options) {
            if (typeof options === 'string') options = options.toObj()
            if (typeof options === 'object') {
                delete data.options
                $.extend(data, options)
            }
        }
        
        if (!data.url) data.url = $this.attr('href')
        
        Plugin.call($this, 'doload', data)
        
        e.preventDefault()
    })
    
    $(document).on(BJUI.eventType.initUI, function(e) {
        $(e.target).find('[data-toggle="autoajaxload"]').each(function() {
            var $element = $(this), options = $element.data()
            
            options.target = this
            Plugin.call($element, 'doload', options)
        })
    })
    
    $(document).on('click.bjui.bjuiajax.data-api', '[data-toggle="refreshlayout"]', function(e) {
        var $this = $(this), target = $this.data('target')
        
        Plugin.call($this, 'refreshlayout', target)
        
        e.preventDefault()
    })
    
    $(document).on('click.bjui.bjuiajax.data-api', '[data-toggle="reloadlayout"]', function(e) {
        var $this = $(this), data = $this.data()
        
        Plugin.call($this, 'reloadlayout', data)
        
        e.preventDefault()
    })
    
    $(document).on('click.bjui.bjuiajax.data-api', '[data-toggle="doajax"]', function(e) {
        var $this = $(this), data = $this.data(), options = data.options
        
        if (options) {
            if (typeof options === 'string') options = options.toObj()
            if (typeof options === 'object') {
                delete data.options
                $.extend(data, options)
            }
        }
        
        if (!data.url) data.url = $this.attr('href')
        
        Plugin.call($this, 'doajax', data)
        
        e.preventDefault()
    })
    
    $(document).on('click.bjui.bjuiajax.data-api', '[data-toggle="ajaxdownload"]', function(e) {
        var $this = $(this), data = $this.data(), options = data.options
        
        if (options) {
            if (typeof options === 'string') options = options.toObj()
            if (typeof options === 'object') {
                delete data.options
                $.extend(data, options)
            }
        }
        if (!data.url) data.url = $this.attr('href')
        
        Plugin.call($this, 'ajaxdownload', data)
        
        e.preventDefault()
    })
    
    $(document).on('click.bjui.bjuiajax.data-api', '[data-toggle="doexport"]', function(e) {
        var $this = $(this), options = $this.data()
        
        if (!options.url) options.url = $this.attr('href')
        
        Plugin.call($this, 'doexport', options)
        
        e.preventDefault()
    })
    
    $(document).on('click.bjui.bjuiajax.data-api', '[data-toggle="doexportchecked"]', function(e) {
        var $this = $(this), options = $this.data()
        
        if (!options.url) options.url = $this.attr('href')
        
        Plugin.call($this, 'doexportchecked', options)
        
        e.preventDefault()
    })
    
    $(document).on('click.bjui.bjuiajax.data-api', '[data-toggle="doajaxchecked"]', function(e) {
        var $this = $(this), options = $this.data()
        
        if (!options.url) options.url = $this.attr('href')
        
        Plugin.call($this, 'doajaxchecked', options)
        
        e.preventDefault()
    })
    
}(jQuery);
/*!
 * B-JUI  v1.3 beta2 (http://b-jui.com)
 * Git@OSC (http://git.oschina.net/xknaan/B-JUI)
 * Copyright 2014 K'naan.
 * Licensed under Apache (http://www.apache.org/licenses/LICENSE-2.0)
 */

/* ========================================================================
 * B-JUI: bjui-alertmsg.js  v1.3 beta2
 * @author K'naan
 * http://git.oschina.net/xknaan/B-JUI/blob/master/BJUI/js/bjui-alertmsg.js
 * ========================================================================
 * Copyright 2014 K'naan.
 * Licensed under Apache (http://www.apache.org/licenses/LICENSE-2.0)
 * ======================================================================== */

+function ($) {
    'use strict';
    
    // ALERTMSG GLOBAL ELEMENTS
    // ======================
    
    var $box, $alertbg, timer
    
    $(function() {
        var INIT_ALERTMSG = function() {
            $box     = $(FRAG.alertBoxFrag).hide().html('')
            $alertbg = $(FRAG.alertBackground).hide().html('')
            $('body').append('<!-- alert msg box -->').append($box).append('<!-- alert msg box mask bg -->').append($alertbg)
        }
        
        INIT_ALERTMSG()
    })
    
    // ALERTMSG CLASS DEFINITION
    // ======================
    var Alertmsg = function(options) {
        this.options   = options
        this.tools     = this.TOOLS()
        this.clearTime = null
    }
    
    Alertmsg.DEFAULTS = {
        displayPosition : 'topcenter', // Optional 'topleft, topcenter, topright, middleleft, middlecenter, middleright, bottomleft, bottomcenter, bottomright'
        displayMode     : 'slide',     // Optional 'none, fade, slide'
        autoClose       : null,
        alertTimeout    : 3000,
        mask            : null,
        types           : {error:'error', info:'info', warn:'warn', correct:'correct', confirm:'confirm'},
        fas             : {error:'fa-times-circle', info:'fa-info-circle', warn:'fa-exclamation-circle', correct:'fa-check-circle', confirm:'fa-question-circle'}
    }
    
    Alertmsg.prototype.TOOLS = function() {
        var that  = this
        var tools = {
            getTitle: function(key){
                return that.options.title || BJUI.regional.alertmsg.title[key]
            },
            keydownOk: function(event) {
                if (event.which == BJUI.keyCode.ENTER) {
                    event.data.target.trigger('click')
                    return false
                }
                return true
            },
            keydownEsc: function(event) {
                if (event.which == BJUI.keyCode.ESC) event.data.target.trigger('click')
            },
            openPosition: function() {
                var position = BJUI.alertMsg.displayPosition, mode = BJUI.alertMsg.displayMode, width = 460, height = $box.outerHeight(), startCss = {}, endCss = {}
                
                if (position) {
                    if (that.options.displayPosition && that.options.displayPosition != 'topcenter')
                        position = that.options.displayPosition
                } else {
                    position = that.options.displayPosition
                }
                
                if (mode) {
                    if (that.options.displayMode && that.options.displayMode != 'silde')
                        mode = that.options.displayMode
                } else {
                    mode = that.options.displayMode
                }
                
                switch (position) {
                case 'topleft':
                    startCss = {top:0 - height, left:0, 'margin-left':0}
                    endCss   = {top:0}
                    
                    break
                case 'topcenter':
                    startCss = {top:0 - height}
                    endCss   = {top:0}
                    
                    break
                case 'topright':
                    startCss = {top:0 - height, left:'auto', right:0, 'margin-left':0}
                    endCss   = {top:0}
                    
                    break
                case 'middleleft':
                    startCss = {top:'50%', left:0 - width, 'margin-left':0, 'margin-top':0 - height/2}
                    endCss   = {left:0}
                    
                    break
                case 'middlecenter':
                    startCss = {top:'0', 'margin-top':0 - height/2}
                    endCss   = {top:'50%'}
                    
                    break
                case 'middleright':
                    startCss = {top:'50%', left:'auto', right:0 - width, 'margin-top':0 - height/2}
                    endCss   = {right:0}
                    
                    break
                case 'bottomleft':
                    startCss = {top:'auto', left:0, bottom:0 - height, 'margin-left':0}
                    endCss   = {bottom:0}
                    
                    break
                case 'bottomcenter':
                    startCss = {top:'auto', bottom:0 - height}
                    endCss   = {bottom:0}
                    
                    break
                case 'bottomright':
                    startCss = {top:'auto', left:'auto', right:0, bottom:0 - height, 'margin-left':0}
                    endCss   = {bottom:0}
                    
                    break
                }
                
                if (mode == 'slide') {
                    $box.css(startCss).show().animate(endCss, 500)
                } else if (mode == 'fade') {
                    startCss.opacity = 0.1
                    $box.css(startCss).css(endCss).show().animate({opacity:1}, 500)
                } else {
                    $box.css(startCss).css(endCss).show()
                }
            },
            closePosition: function() {
                var position = BJUI.alertMsg.displayPosition, mode = BJUI.alertMsg.displayMode, width = 460, height = $box.outerHeight(), endCss = {}
                
                if (position) {
                    if (that.options.displayPosition && that.options.displayPosition != 'topcenter')
                        position = that.options.displayPosition
                } else {
                    position = that.options.displayPosition
                }
                
                if (mode) {
                    if (that.options.displayMode && that.options.displayMode != 'silde')
                        mode = that.options.displayMode
                } else {
                    mode = that.options.displayMode
                }
                
                switch (position) {
                case 'topleft':
                    endCss   = {top:0 - height}
                    
                    break
                case 'topcenter':
                    endCss   = {top:0 - height}
                    
                    break
                case 'topright':
                    endCss   = {top:0 - height}
                    
                    break
                case 'middleleft':
                    endCss   = {left:0 - width}
                    
                    break
                case 'middlecenter':
                    endCss   = {top:0 - height}
                    
                    break
                case 'middleright':
                    endCss   = {right:0 - width}
                    
                    break
                case 'bottomleft':
                    endCss   = {bottom:0 - height}
                    
                    break
                case 'bottomcenter':
                    endCss   = {bottom:0 - height}
                    
                    break
                case 'bottomright':
                    endCss   = {bottom:0 - height}
                    
                    break
                }
                
                if (mode == 'slide') {
                    $box.animate(endCss, 500, function() {
                        $alertbg.hide()
                        $(this).hide().empty()
                    })
                } else if (mode == 'fade') {
                    $box.animate({opacity:0}, 500, function() {
                        $alertbg.hide()
                        $(this).hide().empty()
                    })
                } else {
                    $box.hide().remove()
                    $alertbg.hide()
                }
            },
            open: function(type, msg, buttons) {
                var tools = this, btnsHtml = '', $newbox, $btns, alertTimeout = BJUI.alertMsg.alertTimeout
                
                if (buttons) {
                    for (var i = 0; i < buttons.length; i++) {
                        var sRel = buttons[i].call ? 'callback' : ''
                        var sCls = buttons[i].cls  ? buttons[i].cls : 'default'
                        var sIco = (buttons[i].cls && buttons[i].cls == 'green') ? 'check' : 'close'
                        
                        btnsHtml += FRAG.alertBtnFrag.replace('#btnMsg#', '<i class="fa fa-'+ sIco +'"></i> '+ buttons[i].name).replace('#callback#', sRel).replace('#class#', sCls)
                    }
                }
                $newbox = 
                    $(FRAG.alertBoxFrag.replace('#type#', type)
                    .replace('#fa#', that.options.fas[type])
                    .replace('#title#', this.getTitle(type))
                    .replace('#message#', msg)
                    .replace('#btnFragment#', btnsHtml))
                    .hide()
                    .appendTo('body')
                
                if ($box && $box.length) $box.remove()
                $box = $newbox
                
                tools.openPosition()
                
                if (timer) {
                    clearTimeout(timer)
                    timer = null
                }
                
                if (that.options.mask == null) {
                    if (!(that.options.types.info == type || that.options.types.correct == type))
                        $alertbg.show()
                }
                if (that.options.autoClose == null) {
                    if (that.options.types.info == type || that.options.types.correct == type) {
                        if (alertTimeout) { 
                            if (that.options.alertTimeout && that.options.alertTimeout != 3000)
                                alertTimeout = that.options.alertTimeout
                        } else {
                            alertTimeout = that.options.alertTimeout
                        }
                        timer = setTimeout(function() { tools.close() }, alertTimeout)
                    }
                }
                
                $btns = $box.find('.btn')
                
                $btns.each(function(i) {
                    $(this).on('click', $.proxy(function() {
                            that.tools.close()
                            
                            var call = buttons[i].call
                            
                            if (typeof call === 'string')   call = call.toFunc() 
                            if (typeof call === 'function') call.call()
                        }, that)
                    )
                    
                    if (buttons[i].keyCode === BJUI.keyCode.ENTER) {
                        $(document).on('keydown.bjui.alertmsg.ok', {target:$btns.eq(i)}, tools.keydownOk)
                    }
                    if (buttons[i].keyCode === BJUI.keyCode.ESC) {
                        $(document).on('keydown.bjui.alertmsg.esc', {target:$btns.eq(i)}, tools.keydownEsc)
                    }
                })
            },
            alert: function(type, msg, btnoptions) {
                $.extend(that.options, typeof btnoptions === 'object' && btnoptions)
                
                var op      = $.extend({}, {okName:BJUI.regional.alertmsg.btnMsg.ok, okCall:null}, that.options)
                var buttons = [
                    {name:op.okName, call:op.okCall, cls:'default', keyCode:BJUI.keyCode.ENTER}
                ]
                
                this.open(type, msg, buttons)
            },
            close: function() {
                $(document).off('keydown.bjui.alertmsg.ok').off('keydown.bjui.alertmsg.esc')
                
                this.closePosition()
            }
        }
        
        return tools
    }
    
    Alertmsg.prototype.error = function(msg, btnoptions) {
        this.tools.alert(this.options.types.error, msg, btnoptions)
    }
    
    Alertmsg.prototype.info = function(msg, btnoptions) {
        this.tools.alert(this.options.types.info, msg, btnoptions)
    }
    
    Alertmsg.prototype.warn = function(msg, btnoptions) {
        this.tools.alert(this.options.types.warn, msg, btnoptions)
    }
    
    Alertmsg.prototype.ok = function(msg, btnoptions) {
        this.tools.alert(this.options.types.correct, msg, btnoptions)
    }
    
    Alertmsg.prototype.correct = function(msg, btnoptions) {
        this.tools.alert(this.options.types.correct, msg, btnoptions)
    }
    
    Alertmsg.prototype.confirm = function(msg, btnoptions) {
        $.extend(this.options, typeof btnoptions === 'object' && btnoptions)
        
        var op      = $.extend({}, {okName:BJUI.regional.alertmsg.btnMsg.ok, okCall:null, cancelName:BJUI.regional.alertmsg.btnMsg.cancel, cancelCall:null}, this.options)
        var buttons = [
            {name:op.okName, call:op.okCall, cls:'green', keyCode:BJUI.keyCode.ENTER},
            {name:op.cancelName, call:op.cancelCall, cls:'red', keyCode:BJUI.keyCode.ESC}
        ]
        
        this.tools.open(this.options.types.confirm, msg, buttons)
    }
    
    // ALERTMSG PLUGIN DEFINITION
    // =======================
    
    function Plugin(option) {
        var args     = arguments,
            property = option,
            alertmsg = 'bjui.alertmsg',
            $body    = $('body'),
            data     = $body.data(alertmsg)
        
        return this.each(function () {
            var $this   = $(this),
                options = $.extend({}, Alertmsg.DEFAULTS, typeof option === 'object' && option)
            
            if (!data) {
                data = new Alertmsg(options)
            } else {
                data.options = options
            }
            
            $body.data(alertmsg, data)
            
            if (typeof property === 'string' && $.isFunction(data[property])) {
                [].shift.apply(args)
                if (!args) data[property]()
                else data[property].apply(data, args)
            }
        })
    }
    
    var old = $.fn.alertmsg
    
    $.fn.alertmsg             = Plugin
    $.fn.alertmsg.Constructor = Alertmsg
    
    // ALERTMSG NO CONFLICT
    // =================
    
    $.fn.alertmsg.noConflict = function () {
        $.fn.alertmsg = old
        return this
    }
    
    // NOT SELECTOR
    // ==============
    
    BJUI.alertmsg = function() {
        Plugin.apply($('body'), arguments)
    }
    
    // NAVTAB DATA-API
    // ==============
    
    $(document).on('click.bjui.alertmsg.data-api', '[data-toggle="alertmsg"]', function(e) {
        var $this = $(this), data = $this.data(), options = data.options, type
        
        if (options) {
            if (typeof options === 'string') options = options.toObj()
            if (typeof options === 'object') {
                $.extend(data, options)
            }
        }
        
        type = data.type
        if (!type) return false
        if (!data.msg) {
            if (options.msg) data.msg = options.msg
        }
        
        Plugin.call($this, type, data.msg || type, data)
        
        e.preventDefault()
    })
    
}(jQuery);
/*!
 * B-JUI  v1.3 beta2 (http://b-jui.com)
 * Git@OSC (http://git.oschina.net/xknaan/B-JUI)
 * Copyright 2014 K'naan.
 * Licensed under Apache (http://www.apache.org/licenses/LICENSE-2.0)
 */

/* ========================================================================
 * B-JUI: bjui-pagination.js  v1.3 beta2
 * @author K'naan
 * http://git.oschina.net/xknaan/B-JUI/blob/master/BJUI/js/bjui-pagination.js
 * ========================================================================
 * Copyright 2014 K'naan.
 * Licensed under Apache (http://www.apache.org/licenses/LICENSE-2.0)
 * ======================================================================== */

+function ($) {
    'use strict';
    
    // PAGINATION CLASS DEFINITION
    // ======================
    
    var Pagination = function(element, options) {
        this.$element = $(element)
        this.options  = options
        this.tools    = this.TOOLS()
    }
    
    Pagination.DEFAULTS = {
        first : 'li.j-first',
        prev  : 'li.j-prev',
        next  : 'li.j-next',
        last  : 'li.j-last',
        nums  : 'li.j-num > a',
        jump  : 'li.jumpto',
        pageNumFrag : '<li class="#liClass#"><a href="javascript:;">#pageNum#</a></li>',
        total       : 0,
        pageSize    : 10,
        pageNum     : 10,
        pageCurrent : 1,
        callback    : function() { return false }
    }
    
    Pagination.prototype.TOOLS = function() {
        var that    = this
        var options = this.options
        var tools   = {
            pageNums: function() {
                return Math.ceil(options.total / options.pageSize)
            },
            getInterval: function() {
                var ne_half     = Math.ceil(options.pageNum / 2)
                var pn          = this.pageNums()
                var upper_limit = pn - options.pageNum
                var start       = this.getCurrentPage() > ne_half ? Math.max(Math.min(this.getCurrentPage() - ne_half, upper_limit), 0) : 0
                var end         = this.getCurrentPage() > ne_half ? Math.min(this.getCurrentPage() + ne_half, pn) : Math.min(options.pageNum, pn)
                
                return {start: start + 1, end:end + 1}
            },
            getCurrentPage: function() {
                var pageCurrent = parseInt(options.pageCurrent)
                
                return (isNaN(pageCurrent)) ? 1 : pageCurrent
            },
            hasPrev: function() {
                return this.getCurrentPage() > 1
            },
            hasNext: function() {
                return this.getCurrentPage() < this.pageNums()
            }
        }
        return tools
    }
    
    Pagination.prototype.init = function() {
        if (BJUI.ui.clientPaging && !this.getClientPaging()) this.setClientPaging({pageCurrent:this.options.pageCurrent, pageSize:this.options.pageSize})
        
        var that        = this,
            options     = this.options,
            tools       = this.tools,
            interval    = tools.getInterval(),
            pageNumFrag = '',
            pagination  = FRAG.pagination,
            pr          = BJUI.regional.pagination
        
        for (var i = interval.start; i < interval.end; i++) {
            pageNumFrag += options.pageNumFrag.replaceAll('#pageNum#', i).replaceAll('#liClass#', i == tools.getCurrentPage() ? 'selected j-num' : 'j-num')
        }
        
        pagination = 
            pagination
                .replaceAll('#pageNumFrag#', pageNumFrag)
                .replaceAll('#pageCurrent#', tools.getCurrentPage())
                .replaceAll('#first#', pr.first)
                .replaceAll('#last#', pr.last)
                .replaceAll('#prev#', pr.prev)
                .replaceAll('#next#', pr.next)
                .replaceAll('#jumpto#', pr.jumpto)
                .replaceAll('#jump#', pr.jump)
            
        this.$element.html(pagination)
        
        var $first = this.$element.find(options.first),
            $prev  = this.$element.find(options.prev),
            $next  = this.$element.find(options.next),
            $last  = this.$element.find(options.last)
        
        if (tools.hasPrev()){
            $first.add($prev).find('> span').hide()
            _bindEvent($prev, tools.getCurrentPage() - 1)
            _bindEvent($first, 1)
        } else {
            $first.add($prev).addClass('disabled').find('> a').hide()
        }
        if (tools.hasNext()) {
            $next.add($last).find('> span').hide()
            _bindEvent($next, tools.getCurrentPage() + 1)
            _bindEvent($last, tools.pageNums())
        } else {
            $next.add($last).addClass('disabled').find('> a').hide()
        }

        this.$element.find(options.nums).each(function(i) {
            _bindEvent($(this), i + interval.start)
        })
        
        this.$element.find(options.jump).each(function() {
            var $inputBox = $(this).find(':text'),
                $button   = $(this).find('.goto')
            
            $button.on('click', function() {
                var pageCurrent = $inputBox.val(), pagingInfo = {pageCurrent:pageCurrent, pageSize:options.pageSize}
                
                if (pageCurrent && pageCurrent.isPositiveInteger()) {
                    that.setClientPaging(pagingInfo)
                    $(this).bjuiajax('pageCallback', pagingInfo, that.$element.closest('.bjui-layout'))
                }
            })
            
            $inputBox.keyup(function(e) {
                if (e.keyCode == BJUI.keyCode.ENTER) $button.trigger('click')
            })
        })
        
        function _bindEvent($target, pageCurrent) {
            $target.on('click', function(e) {
                var pagingInfo = {pageCurrent:pageCurrent, pageSize:that.options.pageSize}
                
                that.setClientPaging(pagingInfo)
                $(this).bjuiajax('pageCallback', pagingInfo, that.$element.closest('.bjui-layout'))
                
                e.preventDefault()
            })
        }
    }
    
    Pagination.prototype.changePagesize = function() {
        var that = this, pageSize = that.$element.val(), pagingInfo = {pageSize:pageSize}
        
        if (!isNaN(pageSize)) {
            that.setClientPaging(pagingInfo)
            that.$element.bjuiajax('pageCallback', pagingInfo, that.$element.closest('.bjui-layout'))
        }
    }
    
    Pagination.prototype.orderBy = function(options) {
        var that = this
        
        that.$element.css({cursor:'pointer'}).click(function() {
            var orderField     = $(this).data('orderField'),
                orderDirection = $(this).data('orderDirection'),
                orderInfo      = {orderField:orderField, orderDirection:orderDirection}
            
            that.setClientPaging(orderInfo)
            $(this).bjuiajax('pageCallback', orderInfo, that.$element.closest('.bjui-layout'))
        })
    }
    
    Pagination.prototype.destroy = function() {
        this.$element.removeData('bjui.pagination').empty()
    }
    
    Pagination.prototype.getTarget = function() {
        var that = this, $target
        
        if (that.$element.closest('.bjui-layout').length) $target = that.$element.closest('.bjui-layout')
        else if (that.$element.closest('.navtab-panel').length) $target = $.CurrentNavtab
        else $target = $.CurrentDialog
        
        return $target
    }
    
    Pagination.prototype.getClientPaging = function() {
        return this.getTarget().data('bjui.clientPaging')
    }
    
    Pagination.prototype.setClientPaging = function(clientPaging) {
        if (BJUI.ui.clientPaging) {
            var $target = this.getTarget()
            
            $target.data('bjui.clientPaging', $.extend({}, $target.data('bjui.clientPaging') || {}, clientPaging))
        }
    }
    
    Pagination.prototype.setClientOrder = function(clientOrder) {
        if (BJUI.ui.clientPaging) {
            var clientPaging = this.getClientPaging()
            
            if (!clientPaging || !clientPaging.orderField) this.setClientPaging(clientOrder)
        }
    }
    
    Pagination.prototype.setPagingAndOrderby = function($target) {
        var clientPaging = $target.data('bjui.clientPaging')
        
        $target.find('[data-toggle="pagination"]')
            .pagination('destroy')
            .pagination(clientPaging)
        
        if (clientPaging.pageSize)
            $target.find('select[data-toggle-change="changepagesize"]').selectpicker('val', clientPaging.pageSize)
        if (clientPaging.orderField)
            $target.find('th[data-order-field="'+ clientPaging.orderField +'"]').addClass(clientPaging.orderDirection).siblings().removeClass('asc desc')
    }
    
    // PAGINATION PLUGIN DEFINITION
    // =======================
    
    function Plugin(option) {
        var args     = arguments,
            property = option
        
        return this.each(function () {
            var $this   = $(this),
                options = $.extend({}, Pagination.DEFAULTS, $this.data(), typeof option === 'object' && option),
                data    = $this.data('bjui.pagination')
            
            if (!data) $this.data('bjui.pagination', (data = new Pagination(this, options)))
            if (typeof property === 'string' && $.isFunction(data[property])) {
                [].shift.apply(args)
                if (!args) data[property]()
                else data[property].apply(data, args)
            } else {
                data.init()
            }
        })
    }
    
    var old = $.fn.pagination

    $.fn.pagination             = Plugin
    $.fn.pagination.Constructor = Pagination
    
    // PAGINATION NO CONFLICT
    // =================
    
    $.fn.pagination.noConflict = function () {
        $.fn.pagination = old
        return this
    }
    
    // PAGINATION DATA-API
    // ==============

    $(document).on(BJUI.eventType.initUI, function(e) {
        var $this = $(e.target).find('[data-toggle="pagination"]')
        
        if (!$this.length) return
        
        Plugin.call($this)
    })
    
    $(document).on('change.bjui.pagination.data-api', 'select[data-toggle-change="changepagesize"]', function(e) {
        var $this   = $(this)
        var options = $this.data()
        
        Plugin.call($this, 'changePagesize')
        
        e.preventDefault()
    })
    
}(jQuery);
/*!
 * B-JUI  v1.3 beta2 (http://b-jui.com)
 * Git@OSC (http://git.oschina.net/xknaan/B-JUI)
 * Copyright 2014 K'naan.
 * Licensed under Apache (http://www.apache.org/licenses/LICENSE-2.0)
 */

/* ========================================================================
 * B-JUI: bjui-util.date.js  v1.3 beta2
 * @author K'naan
 * http://git.oschina.net/xknaan/B-JUI/blob/master/BJUI/js/bjui-util.date.js
 * ========================================================================
 * Copyright 2014 K'naan.
 * Licensed under Apache (http://www.apache.org/licenses/LICENSE-2.0)
 * ======================================================================== */

+function ($) {
    'use strict';
    
    var MONTH_NAMES = new Array('January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec')

    var DAY_NAMES   = new Array('Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat')

    function LZ(x) {
        return (x < 0 || x > 9 ? '' :'0') + x
    }

    /**
         * formatDate (date_object, format)
         * Returns a date in the output format specified.
         * The format string uses the same abbreviations as in parseDate()
         * @param {Object} date
         * @param {Object} format
         */
    function formatDate(date, format) {
        format       = format + ''
        var result   = ''
        var i_format = 0
        var c        = ''
        var token    = ''
        var y        = date.getYear() + ''
        var M        = date.getMonth() + 1
        var d        = date.getDate()
        var E        = date.getDay()
        var H        = date.getHours()
        var m        = date.getMinutes()
        var s        = date.getSeconds()
        var yyyy, yy, MMM, MM, dd, hh, h, mm, ss, ampm, HH, H, KK, K, kk, k
        // Convert real date parts into formatted versions
        var value = {}
        
        if (y.length < 4) {
            y = '' + (y - 0 + 1900)
        }
        value['y']    = '' + y
        value['yyyy'] = y
        value['yy']   = y.substring(2, 4)
        value['M']    = M
        value['MM']   = LZ(M)
        value['MMM']  = MONTH_NAMES[M - 1]
        value['NNN']  = MONTH_NAMES[M + 11]
        value['d']    = d
        value['dd']   = LZ(d)
        value['E']    = DAY_NAMES[E + 7]
        value['EE']   = DAY_NAMES[E]
        value['H']    = H
        value['HH']   = LZ(H)
        
        if (!H) {
            value['h'] = 12
        } else if (H > 12) {
            value['h'] = H - 12
        } else {
            value['h'] = H
        }
        value['hh'] = LZ(value['h'])
        
        if (H > 11) {
            value['K'] = H - 12
        } else {
            value['K'] = H
        }
        value['k']  = H + 1
        value['KK'] = LZ(value['K'])
        value['kk'] = LZ(value['k'])
        
        if (H > 11) {
            value['a'] = 'PM'
        } else {
            value['a'] = 'AM'
        }
        value['m']  = m
        value['mm'] = LZ(m)
        value['s']  = s
        value['ss'] = LZ(s)
        
        while (i_format < format.length) {
            c     = format.charAt(i_format)
            token = ''
            
            while (format.charAt(i_format) == c && i_format < format.length) {
                token += format.charAt(i_format++)
            }
            if (value[token] != null) {
                result += value[token]
            } else {
                result += token
            }
        }
        return result
    }

    function _isInteger(val) {
        return new RegExp(/^\d+$/).test(val)
    }

    function _getInt(str, i, minlength, maxlength) {
        for (var x = maxlength; x >= minlength; x--) {
            var token = str.substring(i, i + x)
            
            if (token.length < minlength) {
                return null
            }
            if (_isInteger(token)) {
                return token
            }
        }
        return null
    }

    /**
         * parseDate( date_string , format_string )
         * 
         * This function takes a date string and a format string. It matches
         * If the date string matches the format string, it returns the date. 
         * If it does not match, it returns 0.
         * @param {Object} val
         * @param {Object} format
         */
    function parseDate(val, format) {
        val          = val + ''
        format       = format + ''
        
        var i_val    = 0
        var i_format = 0
        var c        = ''
        var token    = ''
        var token2   = ''
        var x, y
        var now      = new Date(1900, 0, 1)
        var year     = now.getYear()
        var month    = now.getMonth() + 1
        var date     = 1
        var hh       = now.getHours()
        var mm       = now.getMinutes()
        var ss       = now.getSeconds()
        var ampm     = ''
        
        while (i_format < format.length) {
            // Get next token from format string
            c     = format.charAt(i_format)
            token = ''
            while (format.charAt(i_format) == c && i_format < format.length) {
                token += format.charAt(i_format++)
            }
            // Extract contents of value based on format token
            if (token == 'yyyy' || token == 'yy' || token == 'y') {
                if (token == 'yyyy') {
                    x = 4
                    y = 4
                }
                if (token == 'yy') {
                    x = 2
                    y = 2
                }
                if (token == 'y') {
                    x = 2
                    y = 4
                }
                year = _getInt(val, i_val, x, y)
                if (year == null) {
                    return 0
                }
                i_val += year.length
                if (year.length == 2) {
                    if (year > 70) {
                        year = 1900 + (year - 0)
                    } else {
                        year = 2e3 + (year - 0)
                    }
                }
            } else if (token == 'MMM' || token == 'NNN') {
                month = 0
                for (var i = 0; i < MONTH_NAMES.length; i++) {
                    var month_name = MONTH_NAMES[i]
                    
                    if (val.substring(i_val, i_val + month_name.length).toLowerCase() == month_name.toLowerCase()) {
                        if (token == 'MMM' || token == 'NNN' && i > 11) {
                            month = i + 1
                            if (month > 12) {
                                month -= 12
                            }
                            i_val += month_name.length
                            break
                        }
                    }
                }
                if (month < 1 || month > 12) {
                    return 0
                }
            } else if (token == 'EE' || token == 'E') {
                for (var i = 0; i < DAY_NAMES.length; i++) {
                    var day_name = DAY_NAMES[i]
                    
                    if (val.substring(i_val, i_val + day_name.length).toLowerCase() == day_name.toLowerCase()) {
                        i_val += day_name.length
                        break
                    }
                }
            } else if (token == 'MM' || token == 'M') {
                month = _getInt(val, i_val, token.length, 2)
                if (month == null || month < 1 || month > 12) {
                    return 0
                }
                i_val += month.length
            } else if (token == 'dd' || token == 'd') {
                date = _getInt(val, i_val, token.length, 2)
                if (date == null || date < 1 || date > 31) {
                    return 0
                }
                i_val += date.length
            } else if (token == 'hh' || token == 'h') {
                hh = _getInt(val, i_val, token.length, 2)
                if (hh == null || hh < 1 || hh > 12) {
                    return 0
                }
                i_val += hh.length
            } else if (token == 'HH' || token == 'H') {
                hh = _getInt(val, i_val, token.length, 2)
                if (hh == null || hh < 0 || hh > 23) {
                    return 0
                }
                i_val += hh.length
            } else if (token == 'KK' || token == 'K') {
                hh = _getInt(val, i_val, token.length, 2)
                if (hh == null || hh < 0 || hh > 11) {
                    return 0
                }
                i_val += hh.length
            } else if (token == 'kk' || token == 'k') {
                hh = _getInt(val, i_val, token.length, 2)
                if (hh == null || hh < 1 || hh > 24) {
                    return 0
                }
                i_val += hh.length
                hh--
            } else if (token == 'mm' || token == 'm') {
                mm = _getInt(val, i_val, token.length, 2)
                if (mm == null || mm < 0 || mm > 59) {
                    return 0
                }
                i_val += mm.length
            } else if (token == 'ss' || token == 's') {
                ss = _getInt(val, i_val, token.length, 2)
                if (ss == null || ss < 0 || ss > 59) {
                    return 0
                }
                i_val += ss.length
            } else if (token == 'a') {
                if (val.substring(i_val, i_val + 2).toLowerCase() == 'am') {
                    ampm = 'AM'
                } else if (val.substring(i_val, i_val + 2).toLowerCase() == 'pm') {
                    ampm = 'PM'
                } else {
                    return 0
                }
                i_val += 2
            } else {
                if (val.substring(i_val, i_val + token.length) != token) {
                    return 0
                } else {
                    i_val += token.length
                }
            }
        }
        // If there are any trailing characters left in the value, it doesn't match
        if (i_val != val.length) {
            return 0
        }
        // Is date valid for month?
        if (month == 2) {
            // Check for leap year
            if (year % 4 == 0 && year % 100 != 0 || year % 400 == 0) {
                // leap year
                if (date > 29) {
                    return 0
                }
            } else {
                if (date > 28) {
                    return 0
                }
            }
        }
        if (month == 4 || month == 6 || month == 9 || month == 11) {
            if (date > 30) {
                return 0
            }
        }
        // Correct hours value
        if (hh < 12 && ampm == 'PM') {
            hh = hh - 0 + 12
        } else if (hh > 11 && ampm == 'AM') {
            hh -= 12
        }
        
        return new Date(year, month - 1, date, hh, mm, ss)
    }

    Date.prototype.formatDate = function(dateFmt) {
        return formatDate(this, dateFmt)
    }

    String.prototype.parseDate = function(dateFmt) {
        if (this.length < dateFmt.length) {
            dateFmt = dateFmt.slice(0, this.length)
        }
        return parseDate(this, dateFmt)
    }

    /**
     * replaceTmEval('{1+2}-{2-1}')
     */
    function replaceTmEval(data) {
        return data.replace(RegExp('({[A-Za-z0-9_+-]*})', 'g'), function($1) {
            return eval('(' + $1.replace(/[{}]+/g, '') + ')')
        })
    }

    /**
     * dateFmt:%y-%M-%d
     * %y-%M-{%d+1}
     * ex: new Date().formatDateTm('%y-%M-{%d-1}')
     *     new Date().formatDateTm('2012-1')
     */
    Date.prototype.formatDateTm = function(dateFmt) {
        var y = this.getFullYear()
        var m = this.getMonth() + 1
        var d = this.getDate()
        var sDate = dateFmt.replaceAll('%y', y).replaceAll('%M', m).replaceAll('%d', d)
        
        sDate = replaceTmEval(sDate)
        
        var _y = 1900, _m = 0, _d = 1
        var aDate = sDate.split('-')
        
        if (aDate.length > 0) _y = aDate[0]
        if (aDate.length > 1) _m = aDate[1] - 1
        if (aDate.length > 2) _d = aDate[2]
        
        return new Date(_y, _m, _d).formatDate('yyyy-MM-dd')
    }
    
}(jQuery);
/*!
 * B-JUI  v1.3 beta2 (http://b-jui.com)
 * Git@OSC (http://git.oschina.net/xknaan/B-JUI)
 * Copyright 2014 K'naan.
 * Licensed under Apache (http://www.apache.org/licenses/LICENSE-2.0)
 */

/* ========================================================================
 * B-JUI: bjui-datepicker.js  v1.3 beta2
 * reference: util.date.js
 * @author K'naan
 * http://git.oschina.net/xknaan/B-JUI/blob/master/BJUI/js/bjui-datepicker.js
 * ========================================================================
 * Copyright 2014 K'naan.
 * Licensed under Apache (http://www.apache.org/licenses/LICENSE-2.0)
 * ======================================================================== */

+function ($) {
    'use strict';

    // DATEPICKER GLOBAL ELEMENTS
    // ======================
    
    var $box, $main, $prev, $next, $year, $month, $time, $timeinps, $spinner, $hh, $mm, $ss, $tm, $close, $days, $dayNames, $clearBtn, $okBtn
    
    $(function() {
        var INIT_DATEPICKER = function() {
            var cp       = BJUI.regional.datepicker
            var calendar = FRAG.calendarFrag
                .replace('#close#', cp.close)
                .replace('#prev#', cp.prev)
                .replace('#next#', cp.next)
                .replace('#clear#', cp.clear)
                .replace('#ok#', cp.ok)
            
            $box      = $(calendar).hide()
            $('body').append('<!-- datepicker -->').append($box)
            $main     = $box.find('> .main')
            $prev     = $box.find('a.prev')
            $next     = $box.find('a.next')
            $year     = $box.find('select[name=year]')
            $month    = $box.find('select[name=month]')
            $time     = $box.find('.time')
            $timeinps = $time.find(':text')
            $spinner  = $time.find('ul > li')
            $hh       = $time.find('.hh')
            $mm       = $time.find('.mm')
            $ss       = $time.find('.ss')
            $tm       = $main.find('> .tm')
            $close    = $box.find('.close')
            $days     = $main.find('> .body > .days')
            $dayNames = $main.find('> .body > .dayNames')
            $clearBtn = $box.find('.clearBtn')
            $okBtn    = $box.find('.okBtn')
            
            //regional
            var dayNames = '', dr = BJUI.regional.datepicker
            
            $.each(dr.dayNames, function(i, v) {
                dayNames += '<dt>'+ v +'</dt>'
            })
            $dayNames.html(dayNames)
            $.each(dr.monthNames, function(i, v) {
                var m = i + 1
                
                $month.append('<option value="'+ m +'">'+ v +'</option>')
            })
        
            $box.on('selectstart', function() { return false })
        }
        
        INIT_DATEPICKER()
    })
    
    // DATEPICKER CLASS DEFINITION
    // ======================
    var Datepicker = function(element, options) {
        this.$element = $(element)
        this.options  = options
        this.tools    = this.TOOLS()
        this.$dateBtn = null
                
        // minDate、maxDate
        var now = new Date()
        
        this.options.minDate = now.formatDateTm(this.options.minDate)
        this.options.maxDate = now.formatDateTm(this.options.maxDate)
        
        //events
        this.events = {
            focus_time    : 'focus.bjui.datepicker.time',
            click_prev    : 'click.bjui.datepicker.prev',
            click_next    : 'click.bjui.datepicker.next',
            click_ok      : 'click.bjui.datepicker.ok',
            click_days    : 'click.bjui.datepicker.days',
            click_clear   : 'click.bjui.datepicker.clear',
            click_close   : 'click.bjui.datepicker.close',
            click_tm      : 'click.bjui.datepicker.tm',
            click_spinner : 'click.bjui.datepicker.spinner',
            mousedown_sp  : 'mousedown.bjui.datepicker.spinner',
            mouseup_sp    : 'mouseup.bjui.datepicker.spinner',
            change_ym     : 'change.bjui.datepicker.ym',
            click_time    : 'click.bjui.datepicker.time',
            keydown_time  : 'keydown.bjui.datepicker.time',
            keyup_time    : 'keyup.bjui.datepicker.time'
        }
    }
    
    Datepicker.DEFAULTS = {
        pattern : 'yyyy-MM-dd',
        minDate : '1900-01-01',
        maxDate : '2099-12-31',
        mmStep  : 1,
        ssStep  : 1
    }
    
    Datepicker.EVENTS = {
        afterChange : 'afterchange.bjui.datepicker'
    }
    
    Datepicker.prototype.TOOLS = function() {
        var that  = this
        var tools = {
            changeTmMenu: function(sltClass) {
                $tm.removeClass('hh').removeClass('mm').removeClass('ss')
                if (sltClass) {
                    $tm.addClass(sltClass)
                    $timeinps.removeClass('slt').filter('.'+ sltClass).addClass('slt')
                }
            },
            clickTmMenu: function($input, type) {
                $tm
                    .find('> ul')
                    .hide()
                    .filter('.'+ type)
                    .show()
                    .find('> li')
                    .off(that.events.click_tm)
                    .on(that.events.click_tm, function() {
                        var $li = $(this)
                        var val = parseInt($li.text()) < 10 ? ('0'+ $li.text()) : $li.text()
                        
                        $input.val(val)
                    })
            },
            keydownInt: function(e) {
                if (!((e.keyCode >= 48 && e.keyCode <= 57) || (e.keyCode == BJUI.keyCode.DELETE || e.keyCode == BJUI.keyCode.BACKSPACE))) { return false }
            },
            changeTm: function($input, $btn) {
                var ivalue = parseInt($input.val()), istart = parseInt($input.data('start')) || 0, iend = parseInt($input.data('end'))
                var istep  = parseInt($input.data('step') || 1)
                var type   = $btn ? ($btn.data('add') ? $btn.data('add') : -1) : 0
                var newVal = ivalue
                
                if (type == 1) {
                    if (ivalue <= iend - istep) 
                        newVal = ivalue + istep
                } else if (type == -1) {
                    if (ivalue >= (istart + istep))
                        newVal = ivalue - istep
                } else if (ivalue > iend) {
                    newVal = iend
                } else if (ivalue < istart) {
                    newVal = istart
                }
                if (newVal < 10) newVal = '0'+ newVal
                $input.val(newVal)
            },
            closeCalendar: function(flag) {
                tools.changeTmMenu()
                if (flag) {
                    $(document).off(that.events.click_close)
                    $box.hide()
                }
            },
            get: function(name) {
                return that.options[name]
            },
            getDays: function (y, m) {
                return m == 2 ? (y % 4 || (!(y % 100) && y % 400) ? 28 : 29) : (/4|6|9|11/.test(m) ? 30 : 31)
            },
            minMaxDate: function(sDate) {
                var _count  = sDate.split('-').length - 1
                var _format = 'y-M-d'
                
                if (_count == 1) _format = 'y-M'
                else if (!_count) _format = 'y'
                
                return sDate.parseDate(_format)
            },
            getMinDate: function() {
                return this.minMaxDate(that.options.minDate)
            },
            getMaxDate: function() {
                var _sDate = that.options.maxDate
                var _count = _sDate.split('-').length - 1
                var _date  = this.minMaxDate(_sDate)
                
                if (_count < 2) { //format:y-M、y
                    var _day = this.getDays(_date.getFullYear(), _date.getMonth() + 1)
                    _date.setDate(_day)
                    if (!_count)//format:y
                        _date.setMonth(11)
                }
                
                return _date
            },
            getDateWrap: function(date) {
                if (!date) date = this.parseDate(that.sDate) || new Date()
                
                var y = date.getFullYear()
                var m = date.getMonth() + 1
                var days = this.getDays(y, m)
                
                return {
                    year: y, month: m, day: date.getDate(),
                    hour: date.getHours(), minute: date.getMinutes(), second: date.getSeconds(),
                    days: days, date: date
                }
            },
            changeDate: function(y, m, d) {
                var date    = new Date(y, m - 1, d || 1)
                
                that.sDate = this.formatDate(date)
                return date
            },
            changeDateTime: function(y, M, d, H, m, s) {
                var date    = new Date(y, M - 1, d, H, m, s)
                
                that.sDate = this.formatDate(date)
                return date
            },
            changeDay: function(day, chMonth) {
                if (!chMonth) chMonth = 0
                var dw = this.getDateWrap()
                
                return this.changeDate(dw.year, dw.month + parseInt(chMonth), day)
            },
            changeMonth: function(type) {
                var yearIndex = $year.get(0).selectedIndex
                var maxYear   = $year.find('option').length
                var month     = ($month.val() * 1) + type
                
                if (!month) {
                    if (!yearIndex) {
                        month = 1
                    } else {
                        month = 12
                        yearIndex--
                        $year.get(0).selectedIndex = yearIndex
                    }
                } else if (month == 13) {
                    if (yearIndex == (maxYear - 1)) {
                        month = 12
                    } else {
                        month = 1
                        yearIndex++
                        $year.get(0).selectedIndex = yearIndex
                    }
                }
                $month.val(month).change()
            },
            parseDate: function(sDate) {
                if (!sDate) return null
                return sDate.parseDate(that.options.pattern)
            },
            formatDate: function(date) {
                return date.formatDate(that.options.pattern)
            },
            hasHour: function() {
                return that.options.pattern.indexOf('H') != -1
            },
            hasMinute: function() {
                return that.options.pattern.indexOf('m') != -1
            },
            hasSecond: function() {
                return that.options.pattern.indexOf('s') != -1
            },
            hasTime: function() {
                return this.hasHour() || this.hasMinute() || this.hasSecond()
            },
            hasDate: function() {
                var _dateKeys = ['y','M','d','E']
                
                for (var i = 0; i < _dateKeys.length; i++) {
                    if (that.options.pattern.indexOf(_dateKeys[i]) != -1) return true
                }
                return false
            },
            afterChange: function(date) {
                var value = this.formatDate(date)
                
                that.$element.trigger(Datepicker.EVENTS.afterChange, {date:date, value:value})
            }
        }
        return tools
    }
    
    Datepicker.prototype.addBtn = function() {
        var that = this, $element = that.$element
        
        if (!this.$dateBtn && !this.options.addbtn && !$element.parent().hasClass('wrap_bjui_btn_box')) {
            this.$dateBtn = $(FRAG.dateBtn)
            this.$element.css({'paddingRight':'15px'}).wrap('<span class="wrap_bjui_btn_box"></span>')
            
            var $box   = this.$element.parent()
            var height = this.$element.addClass('form-control').innerHeight()
            
            $box.css({'position':'relative', 'display':'inline-block'})
            
            this.$dateBtn.css({'height':height, 'lineHeight':height +'px'}).appendTo($box)
            this.$dateBtn.on('selectstart', function() { return false })
        }
    }
    
    Datepicker.prototype.init = function() {
        if (this.$element.val()) this.sDate = this.$element.val().trim()
        
        var that      = this
        var options   = this.options
        var tools     = this.tools
        var dw        = tools.getDateWrap()
        var minDate   = tools.getMinDate(), maxDate = tools.getMaxDate()
        var yearstart = minDate.getFullYear(), yearend = maxDate.getFullYear()
        
        $year.empty()
        for (var y = yearstart; y <= yearend; y++) {
            $year.append('<option value="'+ y +'"'+ (dw.year == y ? ' selected' : '') +'>'+ y +'</option>')
        }
        
        $month.val(dw.month)
        $year.add($month).off(this.events.change_ym).on(this.events.change_ym, function() {
            if (tools.hasTime()) {
                var $day = $days.find('.slt')
                var date = tools.changeDateTime($year.val(), $month.val(), $day.data('day'), dw.hour, dw.minute, dw.second)
                
                that.create(tools.getDateWrap(date), minDate, maxDate)
            } else {
                var $day = $days.find('.slt')
                var date = tools.changeDate($year.val(), $month.val(), $day.data('day'))
                
                that.create(tools.getDateWrap(date), minDate, maxDate)
            }
        })
        $prev.off(this.events.click_prev).on(this.events.click_prev, function() {
            that.tools.changeMonth(-1)
        })
        $next.off(this.events.click_prev).on(this.events.click_prev, function() {
            that.tools.changeMonth(1)
        })
        $clearBtn.off(this.events.click_clear).on(this.events.click_clear, function() {
            that.$element.val('')
            tools.closeCalendar(true)
        })
        $okBtn.off(this.events.click_ok).on(this.events.click_ok, function() {
            var $dd = $days.find('dd.slt')
            
            if ($dd.hasClass('disabled')) return false
            
            var date = tools.changeDay($dd.data('day'), $dd.data('month'))
            
            if (tools.hasTime()) {
                date.setHours(parseInt($hh.val()))
                date.setMinutes(parseInt($mm.val()))
                date.setSeconds(parseInt($ss.val()))
            }
            tools.closeCalendar(true)
            that.$element.val(tools.formatDate(date)).focus()
            
            //changedEvent
            tools.afterChange(date)
        })
        $close.off(this.events.click_close).on(this.events.click_close, function() {
            tools.closeCalendar(true)
        })
        $(document).on(this.events.click_close, function(e) {
            var $target = $(e.target)
            
            if (e.target == that.$element.get(0)) return
            if ($target.closest('#calendar').length) return
            if ($target.data('toggle') == 'datepicker' || $target.parent().data('toggle') == 'datepickerbtn' || $target.data('toggle') == 'datepickerbtn')
                tools.closeCalendar(false)
            else
                tools.closeCalendar(true)
        })
        this.create(dw, minDate, maxDate)
    }
    
    Datepicker.prototype.create = function(dw, minDate, maxDate) {
        var that       = this
        var options    = this.options
        var tools      = this.tools
        var monthStart = new Date(dw.year, dw.month - 1, 1)
        var startDay   = monthStart.getDay()
        var dayStr     = ''
        
        if (startDay > 0) {
            monthStart.setMonth(monthStart.getMonth() - 1)
            var prevDateWrap = tools.getDateWrap(monthStart)
            
            for (var t = prevDateWrap.days - startDay + 1; t <= prevDateWrap.days; t++) {
                var _date     = new Date(dw.year, dw.month - 2, t)
                var _ctrClass = (_date >= minDate && _date <= maxDate) ? '' : ' disabled'
                
                dayStr += '<dd class="other'+ _ctrClass +'" data-month="-1" data-day="'+ t +'">'+ t +'</dd>'
            }
        }
        for (var t = 1; t <= dw.days; t++) {
            var _date     = new Date(dw.year, dw.month - 1, t)
            var _ctrClass = (_date >= minDate && _date <= maxDate) ? '' : 'disabled'
            
            if (t == dw.day)
                _ctrClass += ' slt'
            dayStr += '<dd class="'+ _ctrClass +'" data-day="'+ t +'">'+ t +'</dd>'
        }
        for (var t = 1; t <= 42 - startDay - dw.days; t++) {
            var _date     = new Date(dw.year, dw.month, t)
            var _ctrClass = (_date >= minDate && _date <= maxDate) ? '' : ' disabled'
            
            dayStr += '<dd class="other'+ _ctrClass +'" data-month="1" data-day="'+ t +'">'+ t +'</dd>'
        }
        
        var $alldays = $days.html(dayStr).find('dd')
        
        $alldays.not('.disabled').off(this.events.click_days).on(this.events.click_days, function() {
            var $day = $(this)
            
            if (!tools.hasTime()) {
                var date = tools.changeDay($day.data('day'), $day.data('month'))
                
                tools.closeCalendar(true)
                that.$element.val(tools.formatDate(date)).focus()
                
                //changedEvent
                tools.afterChange(date)
            } else {
                $alldays.removeClass('slt')
                $day.addClass('slt')
            }
        })
        
        if (!tools.hasDate()) {
            $main.addClass('nodate') // only time
        } else {
            $main.removeClass('nodate')
        }
        if (tools.hasTime()) {
            $time.show()
            $hh.val(dw.hour < 10 ? ('0'+ dw.hour) : dw.hour).off(this.events.focus_time).on(this.events.focus_time, function() {
                tools.changeTmMenu('hh')
            })
            
            var iMinute = parseInt(dw.minute / options.mmStep) * options.mmStep
            
            $mm.val(iMinute < 10 ? ('0'+ iMinute) : iMinute).data('step', options.mmStep).off(this.events.focus_time).on(this.events.focus_time, function() {
                tools.changeTmMenu('mm')
            })
            $ss.val(tools.hasSecond() ? (dw.second < 10 ? ('0'+ dw.second) : dw.second) : '00').data('step', options.ssStep).off(this.events.focus_time).on(this.events.focus_time, function() {
                tools.changeTmMenu('ss')
            })
            $box.off('click').on('click', function(e) {
                if ($(e.target).closest('.time').length) return
                $tm.find('> ul').hide()
                tools.changeTmMenu()
            })
            $timeinps.off(this.events.keydown_time).on(this.events.keydown_time, tools.keydownInt).each(function() {
                var $input = $(this)
                
                $input.off(that.events.keyup_time).on(that.events.keyup_time, function() {
                    tools.changeTm($input)
                })
            }).off(this.events.click_time).on(this.events.click_time, function() {
                tools.clickTmMenu($(this), $(this).data('type'))
            })
            
            var timer = null
            
            $spinner.off(this.events.click_spinner).on(this.events.click_spinner, function(e) {
                var $btn = $(this)
                
                $timeinps.filter('.slt').each(function() {
                    tools.changeTm($(this), $btn)
                })
                
                e.preventDefault()
            }).off(this.events.mousedown_sp).on(this.events.mousedown_sp, function(e) {
                var $btn = $(this)
                
                timer = setInterval(function() {
                    $timeinps.filter('.slt').each(function() {
                        tools.changeTm($(this), $btn)
                    })
                }, 150)
            }).off(this.events.mouseup_sp).on(this.events.mouseup_sp, function(e) {
                clearTimeout(timer)
            })
            
            if (!tools.hasHour())   $hh.attr('disabled', true)
            if (!tools.hasMinute()) $mm.attr('disabled', true)
            if (!tools.hasSecond()) $ss.attr('disabled', true)
        } else {
            $time.hide()
        }
        this.show()
    }
    
    Datepicker.prototype.show = function() {
        var offset = this.$element.offset()
        var iTop   = offset.top + this.$element.get(0).offsetHeight
        // fix top
        var iBoxH  = $box.outerHeight(true)
        
        if (iTop > iBoxH && iTop > $(window).height() - iBoxH)
            iTop = offset.top - iBoxH
        $box.css({
            left: offset.left,
            top: iTop
        }).show().click(function(e) {
            e.stopPropagation()
        })
    }
    
    // DATEPICKER PLUGIN DEFINITION
    // =======================
    
    function Plugin(option) {
        var args     = arguments
        var property = option
        
        return this.each(function () {
            var $this   = $(this)
            var options = $.extend({}, Datepicker.DEFAULTS, $this.data(), typeof option === 'object' && option)
            var data    = $this.data('bjui.datepicker')
            
            if (!data) $this.data('bjui.datepicker', (data = new Datepicker(this, options)))
            if (typeof property === 'string' && $.isFunction(data[property])) {
                [].shift.apply(args)
                if (!args) data[property]()
                else data[property].apply(data, args)
            } else {
                data.init()
            }
        })
    }

    var old = $.fn.datepicker
    
    $.fn.datepicker             = Plugin
    $.fn.datepicker.Constructor = Datepicker
    
    // DATEPICKER NO CONFLICT
    // =================
    
    $.fn.datepicker.noConflict = function () {
        $.fn.datepicker = old
        return this
    }
    
    // DATEPICKER DATA-API
    // ==============
    
    $(document).on(BJUI.eventType.initUI, function(e) {
        var $this = $(e.target).find('[data-toggle="datepicker"]')
        
        if (!$this.length) return
        if ($this.data('nobtn')) return
        
        Plugin.call($this, 'addBtn')
    })
    
    $(document).on('click.bjui.datepicker.data-api', '[data-toggle="datepickerbtn"]', function(e) {
        var $date = $(this).prevAll('[data-toggle="datepicker"]')
        
        if (!$date || !$date.is(':text')) return
        Plugin.call($date, $date.data())
        
        e.preventDefault()
    })
    
    $(document).on('click.bjui.datepicker.data-api', '[data-toggle="datepicker"]', function(e) {
        var $this = $(this)
        
        if ($this.data('onlybtn')) return
        if (!$this.is(':text')) return
        Plugin.call($this, $this.data())
        
        e.preventDefault()
    })

}(jQuery);
/*!
 * B-JUI  v1.3 beta2 (http://b-jui.com)
 * Git@OSC (http://git.oschina.net/xknaan/B-JUI)
 * Copyright 2014 K'naan.
 * Licensed under Apache (http://www.apache.org/licenses/LICENSE-2.0)
 */

/* ========================================================================
 * B-JUI: bjui-ajaxtab.js  v1.3 beta2
 * @author K'naan
 * http://git.oschina.net/xknaan/B-JUI/blob/master/BJUI/js/bjui-ajaxtab.js
 * ========================================================================
 * Copyright 2014 K'naan.
 * Licensed under Apache (http://www.apache.org/licenses/LICENSE-2.0)
 * ======================================================================== */

+function ($) {
    'use strict';
    
    // AJAXTAB CLASS DEFINITION
    // ======================
    
    var Ajaxtab = function(element, options) {
        this.$element = $(element)
        this.options  = options
    }
    
    Ajaxtab.DEFAULTS = {
        url    : undefined,
        target : undefined,
        reload : false
    }
    
    Ajaxtab.prototype.init = function() {
        var options = this.options
        
        if (!(options.url)) {
            BJUI.debug('Ajaxtab Plugin: Error trying to open a tab, url is undefined!')
            return
        } else {
            options.url = decodeURI(options.url).replacePlh(this.$element.closest('.unitBox'))
            
            if (!options.url.isFinishedTm()) {
                this.$element.alertmsg('error', (options.warn || BJUI.regional.plhmsg))
                BJUI.debug('Ajaxtab Plugin: The new ajaxtab\'s url is incorrect, url: '+ options.url)
                return
            }
            
            options.url = encodeURI(options.url)
        }
        if (!options.target) {
            BJUI.debug('Ajaxtab Plugin: Attribute \'target\' is not defined!')
            return
        }
        if (options.reload) {
            this.load()
        } else {
            var reload = this.$element.data('bjui.ajaxtab.reload')
            
            if (!reload) this.load()
            else this.$element.tab('show')
        }
    }
    
    Ajaxtab.prototype.load = function() {
        var $element = this.$element
        var options  = this.options
        
        $(options.target).ajaxUrl({
            url      : options.url,
            data     : {},
            callback : function() {
                $element.data('bjui.ajaxtab.reload', true).tab('show')
            }
        })
    }
    
    // AJAXTAB PLUGIN DEFINITION
    // =======================
    
    function Plugin(option) {
        var args     = arguments
        var property = option
        
        return this.each(function () {
            var $this   = $(this)
            var options = $.extend({}, Ajaxtab.DEFAULTS, $this.data(), typeof option === 'object' && option)
            var data    = $this.data('bjui.ajaxtab')
            
            if (!data) $this.data('bjui.ajaxtab', (data = new Ajaxtab(this, options)))
            if (typeof property === 'string' && $.isFunction(data[property])) {
                [].shift.apply(args)
                if (!args) data[property]()
                else data[property].apply(data, args)
            } else {
                data.init()
            }
        })
    }

    var old = $.fn.ajaxtab

    $.fn.ajaxtab             = Plugin
    $.fn.ajaxtab.Constructor = Ajaxtab
    
    // AJAXTAB NO CONFLICT
    // =================
    
    $.fn.ajaxtab.noConflict = function () {
        $.fn.ajaxtab = old
        return this
    }
    
    // AJAXTAB DATA-API
    // ==============

    $(document).on('click.bjui.ajaxtab.data-api', '[data-toggle="ajaxtab"]', function(e) {
        var $this   = $(this)
        var options = $this.data()
        
        if (!options.url) options.url = $this.attr('href')
        Plugin.call($this, options)
        
        e.preventDefault()
    })
    
}(jQuery);
/*!
 * B-JUI  v1.3 beta2 (http://b-jui.com)
 * Git@OSC (http://git.oschina.net/xknaan/B-JUI)
 * Copyright 2014 K'naan.
 * Licensed under Apache (http://www.apache.org/licenses/LICENSE-2.0)
 */

/* ========================================================================
 * B-JUI: bjui-datagrid.js  v1.3 beta2
 * @author K'naan
 * http://git.oschina.net/xknaan/B-JUI/blob/master/BJUI/js/bjui-datagrid.js
 * ========================================================================
 * Copyright 2014 K'naan.
 * Licensed under Apache (http://www.apache.org/licenses/LICENSE-2.0)
 * ======================================================================== */

+function ($) {
    'use strict';
    
    // DATAGRID CLASS DEFINITION
    // ======================
    
    var Datagrid = function(element, options) {
        this.$element = $(element)
        this.options  = options
        this.tools    = this.TOOLS()
        
        this.datanames = {
            tbody      : 'bjui.datagrid.tbody.dom',
            td_html    : 'bjui.datagrid.td.html',
            changeData : 'bjui.datagrid.tr.changeData'
        }
        
        this.classnames = {
            s_checkbox    : 'datagrid-checkbox',
            s_linenumber  : 'datagrid-linenumber',
            s_edit        : 'datagrid-column-edit',
            s_lock        : 'datagrid-lock',
            s_menu        : 'datagrid-menu-box',
            s_filter      : 'datagrid-filter-box',
            s_showhide    : 'datagrid-showhide-box',
            th_cell       : 'datagrid-cell',
            th_menu       : 'datagrid-column-menu',
            btn_menu      : 'datagrid-column-menu-btn',
            th_col        : 'datagrid-col',
            th_field      : 'datagrid-col-field',
            th_sort       : 'datagrid-sortable',
            th_resize     : 'datagrid-resize-head',
            th_resizemark : 'datagrid-column-resizemark',
            tr_child      : 'datagrid-child-tr',
            tr_edit       : 'datagrid-edit-tr',
            tr_add        : 'datagrid-add-tr',
            tr_selected   : 'datagrid-selected-tr',
            td_edit       : 'datagrid-edit-td',
            td_changed    : 'datagrid-changed',
            td_child      : 'datagrid-child-td',
            td_linenumber : 'datagrid-linenumber-td',
            td_checkbox   : 'datagrid-checkbox-td',
            li_asc        : 'datagrid-li-asc',
            li_desc       : 'datagrid-li-desc',
            li_filter     : 'datagrid-li-filter',
            li_showhide   : 'datagrid-li-showhide',
            li_lock       : 'datagrid-li-lock',
            li_unlock     : 'datagrid-li-unlock'
        }
    }
    
    Datagrid.DEFAULTS = {
        gridTitle       : '',
        columns         : null,     // Thead column module
        data            : null,     // Data source
        dataUrl         : null,     // Request data source URL, for processing (filtering / sorting / paging) results
        updateRowUrl    : null,     // Update row data URL, return JSON data
        postData        : null,     // Send other data to server
        loadType        : 'POST',   // Ajax load request type
        dataType        : 'json',   // Data type of data source
        local           : 'remote', // Optional 'local' | 'remote'
        fieldSortable   : true,     // Click the field to sort
        filterThead     : true,     // Filter in the thead
        sortAll         : false,    // Sort scope, false = this page, true = all
        filterAll       : false,    // Filter scope, false = this page, true = all
        filterMult      : true,     // Filter multiple fileds, false = single, true = multiple
        selectMult      : false,    // When clicked tr, multiple selected (Default need to press Ctrl or Shift or used checkbox)
        linenumberAll   : false,    // All data together numbers
        showLinenumber  : true,     // Display linenumber column, Optional 'true' | 'false' | 'lock', (Optional 'true, false' is a boolean)
        showCheckboxcol : false,    // Display checkbox column, Optional 'true' | 'false' | 'lock', (Optional 'true, false' is a boolean)
        showChildcol    : undefined,// Display child button column, Optional 'true' | 'false' | 'lock', (Optional 'true, false' is a boolean). If not set false and 'hasChild == true', showChildcol = true
        showEditbtnscol : false,    // Display edit buttons column, Optional 'true' | 'false' | 'edit', (Optional 'true, false' is a boolean, Optional 'edit' is custom column label)
        showTfoot       : false,    // Display the tfoot, Optional 'true' | 'false' | 'lock', (Optional 'true, false' is a boolean)
        showToolbar     : false,    // Display datagrid toolbar
        showNoDataTip   : true,     // Display 'no data' tips, Optional 'true' | 'false' | 'string', (Optional 'true, false' is a boolean, Optional 'string' is custom tips)
        toolbarItem     : '',       // Displayed on the toolbar elements, Optional 'all, add, edit, cancel, save, del, import, export, |'
        toolbarCustom   : '',       // Html code || function || jQuery dom object, custom elements, displayed on the toolbar
        columnResize    : true,     // Allow adjust the column width
        columnMenu      : true,     // Display the menu button on the column
        columnShowhide  : true,     // On the menu display (show / hide columns)
        columnFilter    : false,    // On the menu display (filter form)
        columnLock      : true,     // On the menu display (lock / unlock columns)
        paging          : true,     // Display pagination component
        pagingAlign     : 'center', // The pagination component alignment
        hasChild        : false,    // It contains child data, Optional (true | false)
        childOptions    : {         // Child grid options
            width         : '100%',
            height        : 'auto',
            paging        : false,
            columnMenu    : false,
            filterThead   : false,
            childUpdate   : false   // This options only for childOptions, when the child grid data changes, update the parent row(!! The parent grid neeed option 'updateRowUrl' !!), Optional (Boolean: true | false, true = 'all') OR (String: 'all, add, edit, del')
        },
        editUrl         : null,     // An action URL, for processing (update / save), return results (json)
        editCallback    : null,     // Callback for save
        editMode        : 'inline', // Editing mode, Optional 'false' | 'inline' | 'dialog', (Optional 'false' is a boolean)
        editDialogOp    : null,     // For dialog edit, the dialog init options
        editType        : 'POST',   // Ajax request method of edit, Optional 'POST' | 'GET' | 'raw', (Optional 'raw' is post raw data)
        inlineEditMult  : true,     // Can inline edit multiple rows
        saveAll         : true,     // For inline edit, true = save current row, false = save all editing rows
        addLocation     : 'first',  // Add rows to datagrid location, Optional 'first' | 'last' | 'prev' | 'next'
        delUrl          : null,     // The delete URL, return delete tr results (json)
        delType         : 'POST',   // Delete URL of ajax request method
        delPK           : null,     // Ajax delete request to send only the primary key
        delConfirm      : true,     // Delete confirmation message, Optional 'true' | 'false' | 'message', (Optional 'true, false' is a boolean)
        delCallback     : null,     // Callback for delete
        jsonPrefix      : '',       // JSON object key prefix, for post data
        contextMenuH    : true,     // Right-click on the thead, display the context menu
        contextMenuB    : false,    // Right-click on the tbody tr, display the context menu
        hScrollbar      : false,    // Allowed horizontal scroll bar
        fullGrid        : false,    // If the table width below gridbox width, stretching table width
        importOption    : null,     // Import btn options
        exportOption    : null,     // Export btn options
        beforeEdit      : null,     // Function - before edit method, return true execute edit method
        beforeDelete    : null,     // Function - before delete method, return true execute delete method
        beforeSave      : null,     // Function - before save method, arguments($trs, datas)
        afterSave       : null,     // Function - after save method, arguments($trs, datas)
        afterDelete     : null      // Function - after delete method
    }
    
    Datagrid.renderItem = function(value, data, items) {
        if (!items || !items.length) return ''
        var label = ''
        
        $.each(items, function(i, n) {
            if (typeof n[value] !== 'undefined') {
                label = n[value]
                return false
            }
        })
        
        return label
    }
    
    Datagrid.renderItemMulti = function(value, data, items) {
        if (!items || !items.length) return ''
        var label = [], val = $.type(value) === 'array' ? value : String(value).split(',')
        
        $.each(items, function(i, n) {
            $.each(val, function(k, v) {
                if (typeof n[v] !== 'undefined') {
                    label.push(n[v])
                    return false
                }
            })
        })
        
        return label.join(',')
    }
    
    Datagrid.prototype.TOOLS = function() {
        var that  = this, options = that.options
        var tools = {
            getPageCount: function(pageSize, total) {
                return Math.ceil(total / pageSize)
            },
            getPageInterval: function(count, pageCurrent, showPageNum) {
                var half  = Math.ceil(showPageNum / 2), limit = count - showPageNum,
                    start = pageCurrent > half ? Math.max(Math.min(pageCurrent - half, limit), 0) : 0,
                    end   = pageCurrent > half ? Math.min((pageCurrent + half), count) : Math.min(showPageNum, count)
                
                if (end - start == showPageNum) end = end + 1
                if (end < showPageNum) end = end + 1
                if (start + 1 == end) end = end + 1
                
                return {start:start + 1, end:end}
            },
            getRight: function($obj) {
                var width = 0, index = $obj.data('index'), $firstTds = that.$tbody.find('> tr:first > td:lt('+ (index + 1) +')')
                
                if (!$firstTds || !$firstTds.length) $firstTds = that.$colgroupH.find('> col:lt('+ (index + 1) +')')
                $firstTds.each(function() {
                    var $td = $(this), w = $td.is(':hidden') ? 0 : $td.outerWidth()
                    
                    width += w
                })
                
                return width
            },
            getRight4Lock: function(index) {
                var width = 0, $td = that.$lockTbody.find('> tr:first > td:eq('+ index +')'), $firstTds = $td && $td.prevAll().add($td)
                
                if (!$firstTds || !$firstTds.length) $firstTds = that.$lockColgroupH.filter(':lt('+ (index + 1) +')')
                $firstTds.each(function() {
                    var $td = $(this), w = $td.is(':hidden') ? 0 : $td.outerWidth()
                    
                    width += w
                })
                
                return width
            },
            beforeEdit: function($trs, datas) {
                var beforeEdit = options.beforeEdit
                
                if (beforeEdit) {
                    if (typeof beforeEdit === 'string') beforeEdit = beforeEdit.toFunc()
                    if (typeof beforeEdit === 'function') {
                        return beforeEdit.call(that, $trs, datas)
                    }
                }
                
                return true
            },
            beforeSave: function($trs, data) {
                var beforeSave = options.beforeSave
                
                if (beforeSave) {
                    if (typeof beforeSave === 'string') beforeSave = beforeSave.toFunc()
                    if (typeof beforeSave === 'function') {
                        return beforeSave.call(that, $trs, data)
                    }
                }
                
                return true
            },
            afterSave: function($trs, data) {
                var afterSave = options.afterSave, childUpdate = that.options.childUpdate, $parent = that.$element.data('bjui.datagrid.parent'),
                    updateParent = function($tr) {
                        $tr.closest('table').datagrid('updateRow', $tr)
                    }
                
                if (afterSave) {
                    if (typeof afterSave === 'string') afterSave = afterSave.toFunc()
                    if (typeof afterSave === 'function') {
                        afterSave.call(that, $trs, data)
                    }
                }
                
                // remove add data
                $trs.each(function() {
                    $(this).removeData('datagrid.addData')
                })
                
                // update child parent
                if ($parent && childUpdate) {
                    if (typeof childUpdate === 'string' && childUpdate.indexOf('all') === -1) {
                        if (data.addFlag && childUpdate.indexOf('add') !== -1)
                            updateParent($parent)
                        else if (childUpdate.indexOf('edit') !== -1)
                            updateParent($parent)
                    } else {
                        updateParent($parent)
                    }
                }
                
                // fixedColumnWidth
                if (that.fixedColumnWidth) {
                    var $tableB, $firstTr, $grid = $('<div class="bjui-datagrid"></div>'), $th, width
                    
                    $.each(that.columnModel, function(i, n) {
                        if (n.fixedWidth) {
                            if (!$tableB) {
                                $tableB = that.$element.clone().addClass('table table-bordered').appendTo($grid)
                                $tableB.prepend(that.$thead.clone())
                                $grid.appendTo($('body'))
                                $tableB.attr('style', 'width:auto !important;').initui()
                                $tableB.find('colgroup').remove()
                                $tableB.find('.datagrid-filter').remove()
                            }
                            
                            $firstTr = $tableB.find('> tbody > tr:first-child')
                            
                            if ($firstTr.hasClass("datagrid-nodata")) {
                                if (that.$trsH.length > 1)
                                    rowspan = that.$trsH.length - parseInt(n.th.attr('rowspan') || 1, 10)
                                else
                                    rowspan = 0
                                
                                $th = $tableB.find('> thead > tr:eq('+ rowspan +') > th:eq('+ n.th.index() +')').css('width', '')
                                
                                width = $th.outerWidth() + 5
                            } else {
                                $th = $tableB.find('> tbody > tr:first-child > td:eq('+ i +')').css({width:'', 'white-space':'nowrap'})
                                
                                width = $th.outerWidth() + 5
                            }
                            
                            that.$colgroupH.find('> col').eq(i).css('width', width)
                            that.$colgroupB.find('> col').eq(i).css('width', width)
                            that.$colgroupF && that.$colgroupF.find('> col').eq(i).css('width', width)
                        }
                    })
                    
                    if ($grid)
                        $grid.remove()
                    
                    that.fixedColumnWidth = null
                }
                
                // fixedH
                if (options.height === 'auto') {
                    that.$boxB.scrollTop(5)
                    if (that.$boxB.scrollTop)
                        that.fixedHeight()
                }
            },
            afterDelete: function() {
                var afterDelete = options.afterDelete
                
                if (afterDelete) {
                    if (typeof afterDelete === 'string') afterDelete = afterDelete.toFunc()
                    if (typeof afterDelete === 'function') {
                        afterDelete.call(that)
                    }
                }
            },
            // Correct colspan
            setColspan: function(column, colspanNum) {
                if (column.colspan) column.colspan = column.colspan + colspanNum - 1
                column.index = column.index + colspanNum - 1
                if (column.parent) this.setColspan(column.parent, colspanNum)
            },
            // set columns options
            setOp: function(op) {
                if (!op.name) {
                    op.menu = op.lock = op.edit = op.add = op.quickSort = op.quickfilter = false
                } else {
                    op.menu        = (typeof op.menu        === 'undefined') ? true  : op.menu
                    op.lock        = (typeof op.lock        === 'undefined') ? true  : op.lock
                    op.edit        = (typeof op.edit        === 'undefined') ? true  : op.edit
                    op.add         = (typeof op.add         === 'undefined') ? true  : op.add
                    op.quicksort   = (typeof op.quicksort   === 'undefined') ? true  : op.quicksort
                    op.quickfilter = (typeof op.quickfilter === 'undefined') ? true  : op.quickfilter
                }
                op.hide = (typeof op.hide === 'undefined') ? false : op.hide
                
                return op
            },
            // create trs by data source
            createTrsByData: function(data, refreshFlag) {
                var list
                
                if (!that.$tbody) that.$tbody = $('<tbody></tbody>')
                if (data) {
                    if (data.list) list = data.list
                    else list = data
                    
                    that.paging.total = list.length || 0
                    
                    if (!that.paging.total)
                        list = []
                        
                    if (typeof data === 'object' && that.paging.total) {
                        if (data[BJUI.pageInfo.total]) that.paging.total = parseInt(data[BJUI.pageInfo.total], 10)
                        if (data[BJUI.pageInfo.pageSize]) {
                            if (refreshFlag && that.paging.pageSize != data[BJUI.pageInfo.pageSize]) {
                                that.$boxP && that.$boxP.trigger('bjui.datagrid.paging.pageSize', data[BJUI.pageInfo.pageSize])
                            }
                            that.paging.pageSize = parseInt(data[BJUI.pageInfo.pageSize], 10)
                        }
                    }
                    
                    that.paging.pageCount = tools.getPageCount(that.paging.pageSize, that.paging.total)
                    
                    if (that.paging.pageCurrent > that.paging.pageCount) that.paging.pageCurrent = that.paging.pageCount
                    if (!that.paging.pageCurrent) that.paging.pageCurrent = 1
                    
                    this.initTbody(list, refreshFlag)
                }
                
                if (!that.init_tbody) that.$tbody.appendTo(that.$tableB)
                if (!that.init_thead) that.initThead()
            },
            // initTbody
            initTbody: function(data, refreshFlag) {
                var tools  = this, allData = that.allData, type = options.dataType || 'json', model = that.columnModel, hiddenFields = that.hiddenFields, regional = that.regional, newData = [], attach = that.attach, json
                var paging = that.paging, start = 0, end = paging.pageSize
                var doInit = function() {
                    type = type.toLowerCase()
                    if (data) allData = that.allData = data
                    if (options.local === 'local') that.$element.data('allData', data)
                    if (!allData.length) {
                        end = 0
                    } else {
                        if (options.local === 'local') {
                            start = (paging.pageSize * (paging.pageCurrent - 1))
                            end   = start + paging.pageSize
                            if (paging.total != allData.length) paging.total = allData.length
                            if (start > allData.length) start = paging.pageSize * (paging.pageCount - 1)
                        } else {
                            if (allData.length > paging.pageSize) end = paging.pageSize
                        }
                    }
                    if (end > allData.length) end = allData.length
                    
                    // array to json
                    if (type === 'array' && data && data.length && $.type(data[0]) === 'array') {
                        var a1 = start, a2 = end, arrData = [], _index
                        
                        if (options.local === 'local') {
                            a1 = 0
                            a2 = allData.length
                        }
                        for (var i = a1; i < a2; i++) {
                            json   = {}
                            _index = 0
                            $.each(allData[i], function(k, v) {
                                var obj, val = v
                                
                                if (model[_index] && model[_index].gridNumber)   _index ++
                                if (model[_index] && model[_index].gridCheckbox) _index ++
                                if (typeof val === 'string') val = '"'+ val +'"'
                                
                                if (model[_index] && !model[_index].gridEdit) {
                                    obj = '{"'+ model[_index].name +'":'+ val +'}'
                                    $.extend(json, JSON.parse(obj))
                                } else { // init hidden fields
                                    if (model[_index] && model[_index].gridEdit) _index ++
                                    if (_index >= model.length && hiddenFields) {
                                        if (hiddenFields[k - model.length]) {
                                            obj = '{"'+ hiddenFields[k - model.length] +'":'+ val +'}'
                                            $.extend(json, JSON.parse(obj))
                                        }
                                    }
                                }
                                _index ++
                            })
                            
                            arrData.push(json)
                        }
                        
                        allData = that.allData = arrData
                    }
                    
                    // create cuttent page data
                    for (var i = start; i < end; i++) {
                        json = $.extend({}, that.allData[i], attach)
                        newData.push(json)
                    }
                    
                    tools.createTrs(newData, refreshFlag)
                    
                    that.data = newData
                    
                    that.$element.trigger('afterLoad.bjui.datagrid', {datas:newData})
                }
                
                if (refreshFlag && that.$boxM) {
                    that.$boxM.show().trigger('bjui.ajaxStop').trigger('bjui.ajaxStart', [50, doInit])
                } else {
                    doInit()
                }
            },
            // create tbody - tr
            createTrs: function(datas, refreshFlag) {
                var tools = this, model = that.columnModel, paging = that.paging, trs = [], editFrag = BJUI.doRegional(FRAG.gridEditBtn, that.regional), childFrag = BJUI.doRegional(FRAG.gridExpandBtn, that.regional), lockedCols = [], isRenderOnly = false
                
                if (refreshFlag) {
                    // remebered lock columns
                    $.each(model, function(i, n) {
                        if (n.locked) {
                            that.colLock(n.th, false)
                            n.lock_refresh = true
                        }
                    })
                    
                    that.$tbody.empty()
                    that.$lockTableH && that.$lockTableH.empty()
                    that.$lockTableB && that.$lockTableB.empty()
                }
                
                if (!datas.length && !refreshFlag) {
                    var emptyObj = {}
                    
                    emptyObj[model[0].name] = '0'
                    isRenderOnly = true
                    datas = []
                    datas.push(emptyObj)
                }
                
                var begintime = new Date().getTime()
                
                that.begintime = begintime
                
                for (var i = 0, l = datas.length; i < l; i++) {
                    var trData = datas[i], modellength = model.length, linenumber = options.linenumberAll ? ((paging.pageCurrent - 1) * paging.pageSize + (i + 1)) : (i + 1),
                        tds = [], n, tdHtml = BJUI.StrBuilder(), $td, name, label, _label, render_label, align, cls, display
                    
                    $.extend(trData, {gridNumber:linenumber, gridIndex:i})
                    
                    for (var j = 0; j < modellength; j++) {
                        n       = model[j] 
                        name    = n.name || 'datagrid-noname'
                        label   = trData[name]
                        align   = ''
                        cls     = []
                        _label  = ''
                        display = ''
                        render_label = ''
                        
                        if (typeof label === 'undefined' || label === 'null' || label === null) label = ''
                        _label = label
                        
                        if (n.align) align = ' align="'+ n.align +'"'
                        if (n.gridChild) label = childFrag
                        if (n.gridCheckbox) label = '<div><input type="checkbox" data-toggle="icheck" name="datagrid.checkbox" value="true"></div>'
                        if (n.gridEdit) {
                            label = editFrag
                            cls.push(that.classnames.s_edit)
                        }
                        
                        /* for tfoot */
                        if (n.calc) {
                            if (!n.calc_count) n.calc_count = datas.length
                            
                            var number = label ? (String(label).isNumber() ? Number(label) : 0) : 0
                            
                            if (n.calc === 'sum' || n.calc === 'avg') n.calc_sum = (n.calc_sum || 0) + number
                            else if (n.calc === 'max') n.calc_max = n.calc_max ? (n.calc_max < number ? number : n.calc_max) : number
                            else if (n.calc === 'min') n.calc_min = n.calc_min ? (n.calc_min > number ? number : n.calc_min) : number
                        }
                        
                        if (n.gridChild)    cls.push(that.classnames.td_child)
                        if (n.gridNumber)   cls.push(that.classnames.td_linenumber)
                        if (n.gridCheckbox) cls.push(that.classnames.td_checkbox)
                        
                        if (cls.length) cls = ' class="'+ cls.join(' ') +'"'
                        else cls = ''
                        
                        if (refreshFlag && n.hidden) display = ' style="display:none;"'
                        
                        /* render */
                        if (n.items && !n.render) {
                            if (n.attrs && n.attrs['multiple'])
                                n.render = $.datagrid.renderItemMulti
                            else
                                n.render = $.datagrid.renderItem
                        }
                        if (n.render && typeof n.render === 'string') n.render = n.render.toFunc()
                        if (n.render && typeof n.render === 'function') {
                            if (n.items) {
                                if (typeof n.items === 'string') {
                                    if (n.items.trim().startsWith('[')) n.items = n.items.toObj()
                                    else n.items = n.items.toFunc()
                                }
                                
                                if (!that.renderTds) that.renderTds = []
                                
                                var delayRender = function(index, label, trData, n) {
                                    $.when(n.items.call(that)).done(function(item) {
                                        n.items = item
                                        
                                        that.delayRender --
                                    })
                                }
                                
                                if (typeof n.items === 'function') {
                                    if (!i) {
                                        if (!that.delayRender) that.delayRender = 0
                                        that.delayRender ++
                                        delayRender((i * j), _label, trData, n)
                                    }
                                    that.renderTds.push({trindex:i, tdindex:j, label:_label, data:trData, render:n.render})
                                } else {
                                    render_label = n.render.call(that, _label, trData, n.items)
                                }
                            } else {
                                render_label = n.render.call(that, _label, trData)
                            }
                        }
                        
                        tdHtml
                            .add('<td')
                            .add(align)
                            .add(cls)
                            .add(display)
                            .add('><div>')
                            .add(render_label || label)
                            .add('</div></td>')
                        
                        tds.push(tdHtml.toString())
                    }
                    
                    trs.push('<tr>'+ tds.join('') +'</tr>')
                    
                    if (isRenderOnly) {
                        trs = []
                        trs.push(tools.createNoDataTr(true) || '')
                    } else {
                        trs.push(tools.createChildTr(null, trData))
                    }
                }
                
                that.$tbody.html(trs.join(''))
                
                if (refreshFlag) {
                    that.initEvents()
                    if (options.editMode) that.edit()
                    
                    if (!datas.length)
                        tools.createNoDataTr()
                    
                    that.$boxP && that.$boxP.trigger('bjui.datagrid.paging.jump')
                    
                    // locked
                    $.each(model, function(i, n) {
                        if (n.lock_refresh) {
                            that.colLock(n.th, true)
                            delete n.lock_refresh
                        }
                    })
                    
                    setTimeout(function() {
                        that.$tableB.initui()
                        that.$lockTableB && that.$lockTableB.initui()
                        
                        that.fixedHeight()
                        
                        that.$boxM && that.$boxM.trigger('bjui.ajaxStop').hide()
                    }, datas.length + 1)
                }
            },
            replacePlh: function(url, data) {
                return url.replace(/{\/?[^}]*}/g, function($1) {
                    var key = $1.replace(/[{}]+/g, ''), val = data[key]
                    
                    if (typeof val === 'undefined' || val === 'null' || val === null)
                        val = ''
                    
                    return val
                })
            },
            createNoDataTr: function(str) {
                if (that.options.showNoDataTip) {
                    if (str) {
                        return '<tr class="datagrid-nodata"><td colspan="'+ that.columnModel.length +'">'+ (typeof that.options.showNoDataTip === 'string' ? that.options.showNoDataTip : BJUI.getRegional('datagrid.noData')) +'</td></tr>'
                    } else if (!that.$tbody.find('> tr').length) {
                        $('<tr class="datagrid-nodata"></tr>').html('<td colspan="'+ that.columnModel.length +'">'+ (typeof that.options.showNoDataTip === 'string' ? that.options.showNoDataTip : BJUI.getRegional('datagrid.noData')) +'</td>').appendTo(that.$tbody)
                    }
                }
            },
            createChildTr: function($tr, trData) {
                if ($tr && $tr.next() && $tr.next().hasClass(that.classnames.tr_child))
                    return
                
                if (options.hasChild && options.childOptions && options.childOptions.dataUrl) {
                    that.childOptions = $.extend(true, {}, Datagrid.DEFAULTS, options.childOptions)
                    
                    var child = '<tr class="'+ that.classnames.tr_child +'"><td colspan="'+ that.columnModel.length +'" style="width:100%; padding:10px; background:#FAFAFA;"><table class="table-child"></table></td></tr>'
                    
                    if ($tr && $tr.length)
                        $tr.after(child)
                    else
                        return child
                }
            },
            // Parameters can be (jQuery Object || number)
            getNoChildTrIndex: function(row) {
                var index 
                
                if (isNaN(row)) {
                    if (!row || !row.length) return -1
                    index = row.index()
                } else {
                    index = parseInt(row, 10)
                }
                if (that.options.hasChild && that.options.childOptions)
                    index = index * 2
                
                return index
            },
            // Parameters can be (jQuery Object || number)
            getNoChildDataIndex: function(row) {
                var data_index
                
                if (isNaN(row))
                    data_index = this.getNoChildTrIndex(row)
                else
                    data_index = parseInt(row, 10)
                
                if (data_index === -1) return data_index
                if (that.options.hasChild && that.options.childOptions)
                    data_index = data_index / 2
                
                return data_index
            },
            // ajax load data by url
            loadData: function(data, refreshFlag) {
                var tools = this, url = options.dataUrl, dataType = options.dataType || 'json', model = that.columnModel
                
                that.$boxM && that.$boxM.show().trigger('bjui.ajaxStart')
                
                dataType = dataType.toLowerCase()
                if (dataType === 'array') dataType = 'text'
                
                if (options.postData) {
                    if (typeof options.postData === 'string') {
                        if (options.postData.trim().startsWith('{')) options.postData = options.postData.toObj()
                        else options.postData = options.postData.toFunc()
                    }
                    if (typeof options.postData === 'function') {
                        options.postData = options.postData.apply()
                    }
                    if (typeof options.postData === 'object') {
                        if (!data) data = options.postData
                        else data = $.extend({}, options.postData, data)
                    }
                }
                
                BJUI.ajax('doajax', {
                    target: options.target,
                    url       : url,
                    data      : data || {},
                    type      : options.loadType,
                    cache     : options.cache || false,
                    dataType  : dataType,
                    okCallback: function(response) {
                        if (dataType === 'json') {
                            tools.createTrsByData(response, refreshFlag)
                        } else if (dataType === 'text') {
                            if ($.type(response) !== 'array')
                                response = []
                            
                            tools.createTrsByData(response, refreshFlag)
                        } else if (dataType === 'xml') {
                            var xmlData = [], obj
                            
                            $(response).find('row').each(function() {
                                obj = {}
                                
                                $(this).find('cell').each(function(i) {
                                    var $cell = $(this), label = $cell.text(), name = $cell.attr('name')
                                    
                                    obj[name] = label
                                })
                                
                                xmlData.push(obj)
                            })
                            
                            if (xmlData.length) tools.createTrsByData(xmlData, refreshFlag)
                        } else {
                            BJUI.debug('Datagrid Plugin: The options \'dataType\' is incorrect!')
                        } 
                    },
                    errCallback: function() {
                        that.destroy()
                    },
                    failCallback: function() {
                        that.destroy()
                    }
                })
            },
            // append columns
            appendColumns: function() {
                that.childColumn      = {name:'gridChild', gridChild:true, width:30, minWidth:30, label:'...', align:'center', menu:false, edit:false, quicksort:false}
                that.linenumberColumn = {name:'gridNumber', gridNumber:true, width:30, minWidth:30, label:'No.', align:'center', menu:false, edit:false, quicksort:false}
                that.checkboxColumn   = {name:'gridCheckbox', gridCheckbox:true, width:30, minWidth:30, label:'Checkbox', align:'center', menu:false, edit:false, quicksort:false}
                that.editBtnsColumn   = {name:'gridEdit', gridEdit:true, width:110, minWidth:110, label:(typeof options.showEditbtnscol === 'string' ? options.showEditbtnscol : 'Edit'), align:'center', menu:false, edit:false, hide:false, quicksort:false}
            },
            // setBoxb - height
            setBoxbH: function(height) {
                var boxH = height || that.boxH || options.height, topM = 0, h
                
                if (boxH < 100) return
                if (isNaN(boxH)) {
                    if (boxH === 'auto') {
                        boxH = (that.$boxT ? that.$boxT.outerHeight() : 0)
                             + (that.$boxH ? that.$boxH.outerHeight() : 0)
                             + (that.$toolbar ? that.$toolbar.outerHeight() : 0) 
                             + (that.$boxP ? that.$boxP.outerHeight() : 0)
                             + (that.$boxB ? that.$boxB.outerHeight() : 0)
                             + (that.$boxF ? that.$boxF.outerHeight() : 0)
                             + 25
                        
                        that.$grid.height(boxH)
                        that.boxH = boxH
                    } else {
                        boxH = that.$grid.height()
                    }
                }
                
                if (that.$boxT) {
                    h     = that.$boxT.outerHeight()
                    boxH -= h
                    topM += h
                }
                if (that.$toolbar) {
                    h     = that.$toolbar.outerHeight()
                    boxH -= h
                    topM += h
                }
                if (that.$boxP)
                    boxH -= that.$boxP.outerHeight()
                if (that.$boxF)
                    boxH -= that.$boxF.outerHeight()
                
                topM += that.$tableH.outerHeight()
                boxH -= that.$boxH.outerHeight()
                
                if (boxH < 0) boxH = 0
                
                that.$boxB.height(boxH)
                that.$boxM.height(boxH).css({top:topM})
                that.$lockB && that.$lockB.height(boxH)
                
                if (that.$element.data('bjui.datagrid.parent'))
                    that.$element.data('bjui.datagrid.parent').closest('table').datagrid('fixedHeight')
            },
            // column menu - toggle show submenu
            showSubMenu: function($li, $menu, $submenu) {
                var left, width = $menu.outerWidth(), submenu_width = $submenu.data('width') || $submenu.outerWidth(), animate_op, boxWidth = that.$boxH.width()
                var hidesubmenu = function($li, $menu, $submenu) {
                    left       = $menu.offset().left - that.$grid.offset().left - 1
                    animate_op = {left:'50%'}
                    
                    $li.removeClass('active')
                    
                    if ($menu.hasClass('position-right') || (boxWidth - left < width + submenu_width)) {
                        $submenu.css({left:'auto', right:'100%'})
                        animate_op = {right:'50%'}
                    } else {
                        $submenu.css({left:'100%', right:'auto'})
                    }
                    animate_op.opacity = 0.2
                    
                    $submenu.stop().animate(animate_op, 'fast', function() {
                        $(this).hide()
                    })
                }
                
                $li.hover(function() {
                    $submenu.appendTo($li)
                    if ($li.hasClass(that.classnames.li_filter) && $submenu.is(':visible')) {
                        return false
                    } else {
                        var $filterli = $li.siblings('.'+ that.classnames.li_filter)
                        
                        if ($filterli.length && $filterli.hasClass('active')) {
                            hidesubmenu($filterli, $menu, $filterli.find('> .'+ that.classnames.s_filter))
                        }
                    }
                    left       = $menu.offset().left - that.$grid.offset().left - 1
                    animate_op = {left:'100%'}
                    
                    if ($menu.hasClass('position-right') || (boxWidth - left < width + submenu_width)) {
                        $submenu.css({left:'auto', right:'50%'})
                        animate_op = {right:'100%'}
                    } else {
                        $submenu.css({left:'50%', right:'auto'})
                    }
                    animate_op.opacity = 1
                    
                    $li.addClass('active')
                    $submenu.show().stop().animate(animate_op, 'fast')
                }, function() {
                    if ($li.hasClass(that.classnames.li_filter)) {
                        return false
                    }
                    hidesubmenu($li, $menu, $submenu)
                })
                
                $li.on('bjui.datagrid.th.submenu.hide', function(e, menu, submenu) {
                    hidesubmenu($(this), menu, submenu)
                })
            },
            // column menu - lock/unlock
            locking: function($th) {
                var index= $th.data('index'), columnModel = that.columnModel[index], lockFlag = columnModel.lock, locked = columnModel.locked, $menu = that.$menu, $ul = $menu.find('> ul'), $lockli = $ul.find('> li.'+ that.classnames.li_lock), $unlockli = $lockli.next()
                    
                if (locked) {
                    $lockli.addClass('disable')
                    $unlockli.removeClass('disable')
                } else {
                    $unlockli.addClass('disable')
                    $lockli.removeClass('disable')
                }
                
                if (lockFlag) {
                    $lockli.show().off('click').on('click', function() {
                        if ($lockli.hasClass('disable')) return
                        
                        $menu.hide().data('bjui.datagrid.menu.btn').removeClass('active')
                        that.colLock($th, true)
                    })
                    
                    $unlockli.show().off('click').on('click', function() {
                        if ($unlockli.hasClass('disable')) return
                        
                        $menu.hide().data('bjui.datagrid.menu.btn').removeClass('active')
                        that.colLock($th, false)
                    })
                } else {
                    $lockli.hide().off('click')
                    $unlockli.hide().off('click')
                }
            },
            // create show/hide column panel
            createShowhide: function() {
                var $showhide
                
                if (!that.$showhide) {
                    that.col_showhide_count = that.columnModel.length
                    $showhide = $('<ul class="'+ that.classnames.s_showhide +'" role="menu"></ul>')
                    
                    $.each(that.columnModel, function(i, n) {
                        if (n.gridNumber || n.gridCheckbox || n.gridEdit) that.col_showhide_count --
                        
                        var $col = $(FRAG.gridShowhide.replaceAll('#index#', n.index).replaceAll('#label#', (n.label || ''))).toggleClass('nodisable', !!(n.gridNumber || n.gridCheckbox || n.gridEdit))
                        var colClick = function(n) {
                            $col.click(function() {
                                if ($(this).hasClass('disable')) return false
                                
                                var $this = $(this), check = !$this.find('i').hasClass('fa-check-square-o'), index = n.index
                                
                                $this.toggleClass('datagrid-col-check')
                                    .find('i').attr('class', 'fa fa'+ (check ? '-check' : '') +'-square-o')
                                
                                that.showhideColumn(n.th, check)
                                
                                if (!(n.gridNumber || n.gridCheckbox || n.gridEdit)) {
                                    that.col_showhide_count = check ? that.col_showhide_count + 1 : that.col_showhide_count - 1
                                }
                                
                                if (that.col_showhide_count == 1) $showhide.find('> li.datagrid-col-check').addClass('disable')
                                else $showhide.find('> li.disable').removeClass('disable')
                                
                                $showhide.find('> li.nodisable').removeClass('disable')
                            })
                        }
                        
                        colClick(n)
                        $col.appendTo($showhide)
                        
                        if (n.hide) $col.trigger('click')
                    })
                    
                    $showhide.appendTo(that.$grid)
                    $showhide.data('width', $showhide.outerWidth())
                    that.$showhide = $showhide
                }
            },
            // column - display/hide
            showhide: function(model, showFlag) {
                var index = model.index, $th = model.th, $trs = that.$tbody.find('> tr'), display = showFlag ? '' : 'none'
                var setColspan = function(column) {
                    var _colspan = column.colspan
                    
                    if (showFlag) _colspan ++
                    else _colspan --
                    
                    if (!_colspan) column.th.css('display', 'none')
                    else column.th.css('display', '')
                    
                    column.th.attr('colspan', _colspan)
                    column.colspan = _colspan
                    
                    if (column.parent) setColspan(column.parent)
                }
                
                if (typeof model.hidden === 'undefined') model.hidden = false
                if (model.hidden === !showFlag) return
                
                model.hidden = !showFlag
                
                $th.css('display', display)
                $trs.find('> td:eq('+ index +')').css('display', display)
                that.$colgroupH.find('> col').eq(index).css('display', display)
                that.$colgroupB.find('> col').eq(index).css('display', display)
                that.$thead.find('> tr.datagrid-filter > th:eq('+ index +')').css('display', display)
                if (that.$boxF) {
                    that.$tableF.find('> thead > tr > th:eq('+ index +')').css('display', display)
                    that.$colgroupF.find('> col').eq(index).css('display', display)
                }
                
                if (model.calc) {
                    that.$tfoot && that.$tfoot.trigger('bjui.datagrid.tfoot.resizeH')
                }
                
                if (model.parent) setColspan(model.parent)
                
                // fixed width && height for child datagrid
                that.$tbody.find('> tr.'+ that.classnames.tr_child +':visible > td table').trigger('bjui.datagrid.child.resize')
            },
            // jump to page
            jumpPage: function(pageCurrent, pageSize) {
                var allData = that.allData, filterDatas
                
                if (pageCurrent) {
                    that.paging.oldPageCurrent = that.paging.pageCurrent
                    that.paging.pageCurrent    = pageCurrent
                }
                if (pageSize) {
                    that.paging.oldPageSize = that.paging.pageSize
                    
                    that.paging.pageSize  = pageSize
                    that.paging.pageCount = this.getPageCount(pageSize, that.paging.total)
                    
                    if (that.paging.pageCurrent > that.paging.pageCount)
                        that.paging.pageCurrent = that.paging.pageCount
                }
                
                if (options.local === 'remote') {
                    filterDatas = this.getRemoteFilterData(true)
                    this.loadData(filterDatas, true)
                } else {
                    this.initTbody(allData, true)
                }
            },
            // column - quicksort
            quickSort: function(model) {
                if (that.isDom) {
                    if (options.local === 'local') return
                    options.sortAll = true
                }
                
                if (that.$tbody.find('> tr.'+ that.classnames.tr_edit).length) {
                    that.$tbody.alertmsg('info', BJUI.getRegional('datagrid.editMsg'))
                    return
                }
                
                var $th = model.th, data = that.data, allData = that.allData, postData, direction, name = model.name, type = model.type, $ths = that.$thead.find('> tr > th.datagrid-quicksort-th')
                
                if (!name) name = 'datagrid-noname'
                
                var sortData = function(data) {
                    data.sort(function(a, b) {
                        var typeA = (typeof a[name]), typeB = (typeof b[name])
                        
                        if (type === 'boolean' || type === 'number' || (typeA = typeB === 'number') || (typeA = typeB === 'boolean')) {
                            return model.sortAsc ? (a[name] - b[name]) : (b[name] - a[name])
                        } else {
                            return model.sortAsc ? String(a[name]).localeCompare(b[name]) : String(b[name]).localeCompare(a[name])
                        }
                    })
                }
                
                $ths.find('> div > .datagrid-label > i').remove()
                if (model.sortAsc) {
                    direction = 'desc'
                    model.sortAsc = false
                } else {
                    direction = 'asc'
                    model.sortAsc = true
                }
                $th.find('> div > .datagrid-label').prepend('<i class="fa fa-long-arrow-'+ (model.sortAsc ? 'up' : 'down') +'"></i>')
                
                if (options.sortAll) {
                    if (options.local === 'remote') {
                        postData = {}
                        postData[BJUI.pageInfo.orderField]     = name
                        postData[BJUI.pageInfo.orderDirection] = direction
                        postData[BJUI.pageInfo.pageSize]       = that.paging.pageSize
                        postData[BJUI.pageInfo.pageCurrent]    = that.paging.pageCurrent
                        
                        this.loadData(postData, true)
                    } else {
                        sortData(allData)
                        this.initTbody(allData, true)
                    }
                } else {
                    sortData(data)
                    this.createTrs(data, true)
                }
            },
            quickFilter: function(model, filterDatas) {
                if (that.isDom) {
                    if (options.local != 'remote') {
                        BJUI.debug('Datagrid Plugin: Please change the local option is remote!')
                        return
                    }
                    if (!options.dataUrl) {
                        BJUI.debug('Datagrid Plugin: Not Set the dataUrl option!')
                        return
                    }
                }
                
                var tools = this, $th = model.th, data = that.data, allData = that.allData, name = model.name, postData, fDatas
                var switchOperator = function(operator, val1, val2, model) {
                    var compare = false
                    
                    switch (operator) {
                    case '=':
                        compare = String(val1) === String(val2)
                        break
                    case '!=':
                        compare = String(val1) !== String(val2)
                        break
                    case '>':
                        compare = parseFloat(val2) > parseFloat(val1)
                        break
                    case '<':
                        compare = parseFloat(val2) < parseFloat(val1)
                        break
                    case 'like':
                        if (model && model.type === 'select') {
                            compare = String(val1) === String(val2)
                            if (model.attrs && model.attrs.multiple) {
                                if ($.isArray(val1)) {
                                    compare = $.inArray(val2, val1) != -1
                                }
                            }
                        } else {
                            compare = String(val2).indexOf(String(val1)) >= 0
                        }
                        break
                    default:
                        break
                    }
                    
                    return compare
                }
                var filterData = function(data, filterDatas) {
                    var grepFun = function(n) {
                        var count = 0
                        
                        $.each(filterDatas, function(name, v) {
                            var op = v.datas
                            
                            count ++
                            if (!op) {
                                count --
                                v.model.isFiltered = false
                                v.model.th.trigger('bjui.datagrid.th.filter', [false])
                                if (v.model.$quickfilter) v.model.$quickfilter.trigger('bjui.datagrid.thead.clearfilter')
                                
                                return true
                            }
                            
                            v.model.isFiltered = true
                            v.model.th.trigger('bjui.datagrid.th.filter', [true])
                            
                            if (op.andor) {
                                if (op.andor === 'and') {
                                    if (switchOperator(op.operatorA, op.valA, n[name], v.model) && switchOperator(op.operatorB, op.valB, n[name], v.model)) {
                                        count --
                                    }
                                } else if (op.andor === 'or') {
                                    if (switchOperator(op.operatorA, op.valA, n[name], v.model) || switchOperator(op.operatorB, op.valB, n[name], v.model)) {
                                        count --
                                    }
                                }
                            } else {
                                if (op.operatorB) {
                                    if (switchOperator(op.operatorB, op.valB, n[name], v.model)) {
                                        count --
                                    }
                                } else {
                                    if (switchOperator(op.operatorA, op.valA, n[name], v.model)) {
                                        count --
                                    }
                                }
                            }
                        })
                        
                        return !count ? true : false
                    }
                    
                    return $.grep(data, function(n, i) {
                        return grepFun(n)
                    })
                }
                
                if (!that.filterDatas) that.filterDatas = {}
                if (options.filterMult) {
                    that.filterDatas[name] = {datas:filterDatas, model:model}
                } else {
                    that.filterDatas = {}
                    that.filterDatas[name] = {datas:filterDatas, model:model}
                }
                
                if (options.local !== 'remote' && allData) {
                    if (!that.oldAllData) that.oldAllData = allData.concat()
                    else allData = that.oldAllData.concat()
                }
                
                if (options.filterAll) {
                    if (options.local === 'remote') {
                        tools.loadData(tools.getRemoteFilterData(), true)
                    } else {
                        fDatas = filterData(allData, that.filterDatas)
                        
                        that.paging.pageCurrent = 1
                        that.paging.pageCount   = this.getPageCount(that.paging.pageSize, fDatas.length)
                        
                        this.initTbody(fDatas, true)
                    }
                } else {
                    if (that.isDom) {
                        tools.loadData(tools.getRemoteFilterData(), true)
                    } else {
                        if (!that.oldData) that.oldData = data.concat()
                        else data = that.oldData.concat()
                        
                        fDatas = filterData(data, that.filterDatas)
                        
                        this.createTrs(fDatas, true)
                    }
                }
            },
            getRemoteFilterData: function(isPaging, pageSize, pageCurrent) {
                var filterDatas = {}
                
                if (that.filterDatas && !$.isEmptyObject(that.filterDatas)) {
                    $.each(that.filterDatas, function(name, v) {
                        if (!v.datas) {
                            v.model.isFiltered = false
                            v.model.th.trigger('bjui.datagrid.th.filter', [false])
                            if (v.model.$quickfilter) v.model.$quickfilter.trigger('bjui.datagrid.thead.clearfilter')
                            return true
                        }
                        
                        v.model.isFiltered = true
                        v.model.th.trigger('bjui.datagrid.th.filter', [true])
                        
                        if (options.jsonPrefix)
                            name = options.jsonPrefix +'.'+ name
                        
                        if (v.datas.andor)
                            filterDatas['andor'] = v.datas.andor
                        if (v.datas.operatorA) {
                            filterDatas[name] = v.datas.valA
                            filterDatas[name +'.operator'] = v.datas.operatorA
                        }
                        if (v.datas.operatorB) {
                            if (filterDatas[name]) {
                                filterDatas[name] = [filterDatas[name], v.datas.valB]
                                filterDatas[name +'.operator'] = [filterDatas[name +'.operator'], v.datas.operatorB]
                            } else {
                                filterDatas[name] = v.datas.valB
                                filterDatas[name +'.operator'] = v.datas.operatorB
                            }
                        }
                    })
                    
                    if (!isPaging) that.paging.pageCurrent = 1
                }
                
                // paging
                filterDatas[BJUI.pageInfo.pageSize]    = that.paging.pageSize
                filterDatas[BJUI.pageInfo.pageCurrent] = that.paging.pageCurrent
                
                that.$element.data('filterDatas', filterDatas)
                
                return filterDatas
            },
            // set data for Dom
            setDomData: function(tr) {
                var columnModel = that.columnModel, data = {}, hideDatas = tr.attr('data-hidden-datas'), attach = that.attach
                    
                tr.find('> td').each(function(i) {
                    var $td = $(this), model = columnModel[i], val = $td.attr('data-val') || $td.text()
                    
                    if (!model.name) data['datagrid-noname'+ i] = val
                    else data[model.name] = val
                })
                
                if (hideDatas) hideDatas = hideDatas.toObj()
                $.extend(data, attach, {gridNumber:(tr.index() + 1)}, hideDatas)
                
                tr.data('initData', data)
                
                return data
            },
            // init inputs array for edit
            initEditInputs: function() {
                var columnModel = that.columnModel
                
                that.inputs = []
                
                $.each(columnModel, function(i, op) {
                    var name = op.name, rule = '', pattern = '', selectoptions = [], attrs = ''
                    
                    if (!op) return
                    if (op.attrs && typeof op.attrs === 'object') {
                        $.each(op.attrs, function(i, n) {
                            if (typeof n === 'object') n = JSON.stringify(n).replaceAll('\"', '\'')
                            attrs += ' '+ i +'='+ n
                        })
                    }
                    
                    if (op === that.childColumn || op === that.linenumberColumn || op === that.checkboxColumn || op === that.editBtnsColumn) {
                        that.inputs.push('')
                    } else if (name) {
                        if (op.rule) rule = ' data-rule="'+ op.label +'：'+ op.rule +'"'
                        else if (op.type === 'date') rule = ' data-rule="pattern('+ (op.pattern || 'yyyy-MM-dd') +')"';
                        if (op.type) {
                            switch (op.type) {
                            case 'date':
                                if (!op.pattern) op.pattern = 'yyyy-MM-dd'
                                pattern = ' data-pattern="'+ op.pattern +'"'
                                that.inputs.push('<input type="text" name="'+ name +'" data-toggle="datepicker"'+ pattern + rule + attrs +'>')
                                
                                break
                            case 'select':
                                if (!op.items) return
                                
                                $.each(op.items, function(i, n) {
                                    $.each(n, function(key, value) {
                                        selectoptions.push('<option value="'+ key +'">'+ value +'</option>')
                                    })
                                })
                                
                                that.inputs.push('<select name="'+ name +'" data-toggle="selectpicker"'+ rule + attrs +' data-width="100%">'+ selectoptions.join('') +'</select>')
                                
                                break
                            case 'boolean':
                                that.inputs.push('<input type="checkbox" name="'+ name +'" data-toggle="icheck"'+ rule + attrs +' value="true">')
                                
                                break
                            case 'lookup':
                                that.inputs.push('<input type="text" name="'+ name +'" data-toggle="lookup" data-custom-event="true"'+ rule + attrs +'>')
                                
                                break
                            case 'findgrid':
                                that.inputs.push('<input type="text" name="'+ name +'" data-toggle="findgrid" data-custom-event="true"'+ rule + attrs +'>')
                                
                                break
                            case 'spinner':
                                that.inputs.push('<input type="text" name="'+ name +'" data-toggle="spinner"'+ rule + attrs +'>')
                                
                                break
                            case 'textarea':
                                that.inputs.push('<textarea data-toggle="autoheight" rows="1"'+ rule + attrs +'></textarea>')
                                
                                break
                            default:
                                that.inputs.push('<input type="text" name="'+ name +'"'+ rule + attrs +'>')
                                break
                            }
                        } else {
                            that.inputs.push('<input type="text" name="'+ name +'"'+ rule + attrs +'>')
                        }
                    } else {
                        that.inputs.push('')
                    }
                })
                
                return that.inputs
            },
            contextmenuH: function() {
                var tools = this
                
                that.$tableH.on('contextmenu', 'tr:not(.datagrid-filter)', function(e) {
                    if (!that.$showhide) tools.createShowhide()
                    
                    var posX = e.pageX
                    var posY = e.pageY
                    
                    if ($(window).width()  < posX + that.$showhide.width())  posX -= that.$showhide.width()
                    if ($(window).height() < posY + that.$showhide.height()) posY -= that.$showhide.height()
                    
                    if (that.$menu) {
                        that.$grid.trigger('click.bjui.datagrid.filter')
                    }
                    
                    that.$showhide
                        .appendTo('body')
                        .css({left:posX, top:posY, opacity:1, 'z-index':9999}).show()
                    
                    $(document).on('click', function(e) {
                        var $showhide = $(e.target).closest('.'+ that.classnames.s_showhide)
                        
                        if (!$showhide.length)
                            that.$showhide.css({left:'50%', top:0, opacity:0.2, 'z-index':''}).hide().appendTo(that.$grid)
                    })
                    
                    e.preventDefault()
                    e.stopPropagation()
                })
            },
            contextmenuB: function($tr, isLock) {
                $tr.contextmenu('show', 
                        {
                            exclude : 'input, .bootstrap-select',
                            items:[
                                {
                                    icon  : 'refresh',
                                    title : BJUI.getRegional('datagrid.refresh'),
                                    func  : function(parent, menu) {
                                        that.refresh()
                                    }
                                },
                                {
                                    title : 'diver'
                                },
                                {
                                    icon  : 'plus',
                                    title : BJUI.getRegional('datagrid.add'),
                                    func  : function(parent, menu) {
                                        that.add()
                                    }
                                },
                                {
                                    icon  : 'edit',
                                    title : BJUI.getRegional('datagrid.edit'),
                                    func  : function(parent, menu) {
                                        var $tr = parent
                                        
                                        if (isLock) $tr = that.$tbody.find('> tr:eq('+ $tr.index() +')')
                                        that.doEditRow($tr)
                                    }
                                },
                                {
                                    icon  : 'undo',
                                    title : BJUI.getRegional('datagrid.cancel'),
                                    func  : function(parent, menu) {
                                        var $tr = parent
                                        
                                        if (isLock) $tr = that.$tbody.find('> tr:eq('+ $tr.index() +')')
                                        
                                        if (!$tr.hasClass(that.classnames.tr_edit)) {
                                            $tr = that.$tbody.find('> tr.'+ that.classnames.tr_edit)
                                        }
                                        that.doCancelEditRow($tr)
                                    }
                                },
                                {
                                    icon  : 'remove',
                                    title : BJUI.getRegional('datagrid.del'),
                                    func  : function(parent, menu) {
                                        var $tr = parent
                                        
                                        if (isLock) $tr = that.$tbody.find('> tr:eq('+ $tr.index() +')')
                                        that.delRows($tr)
                                    }
                                }
                            ]
                        }
                    )
            }
        }
        
        return tools
    }
    
    Datagrid.prototype.init = function() {
        if (!this.$element.isTag('table')) return
        if (this.$element.data('bjui.datagrid.init')) return
        
        this.$element.data('bjui.datagrid.init', true)
        
        var that = this, options = that.options, tools = that.tools, $parent = that.$element.parent(), gridHtml = BJUI.StrBuilder()
        
        options.height   = options.height || 'auto'
        that.isDom       = false
        that.columnModel = []
        that.inputs      = []
        that.regional    = BJUI.regional.datagrid
        
        gridHtml
            .add('<div class="bjui-datagrid">')
            .add(options.gridTitle ? '<div class="datagrid-title">'+ options.gridTitle +'</div>' : '')
            .add(options.showToolbar ? '<div class="datagrid-toolbar"></div>' : '')
            .add('<div class="datagrid-box-h"><div class="datagrid-wrap-h"><table class="table table-bordered"><colgroup></colgroup></table></div></div>')
            .add('<div class="datagrid-box-b"><div class="datagrid-wrap-b"></div></div>')
            .add('<div class="datagrid-box-m"></div>')
            .add(options.paging ? '<div class="datagrid-paging-box"></div>' : '')
            .add('</div>')
        
        that.$grid    = $(gridHtml.toString()).insertAfter(that.$element).css('height', options.height)
        that.$boxH    = that.$grid.find('> div.datagrid-box-h')
        that.$boxB    = that.$boxH.next()
        that.$boxM    = that.$boxB.next().css('height', options.height)
        that.$boxP    = options.paging ? that.$boxM.next() : null
        that.$boxT    = options.gridTitle ? that.$grid.find('> div.datagrid-title') : null
        that.$toolbar = options.showToolbar ? that.$boxH.prev() : null
        that.$tableH  = that.$boxH.find('> div > table')
        that.$tableB  = that.$element
        
        that.$grid.data('bjui.datagrid.table', that.$element.clone())
        that.$boxB.find('> div').append(that.$element)
        
        that.initTop()
        
        if (typeof options.paging === 'string') options.paging = options.paging.toObj()
        that.paging = $.extend({}, {pageSize:30, selectPageSize:'30,60,90', pageCurrent:1, total:0, showPagenum:5}, (typeof options.paging === 'object') && options.paging)
        that.attach = {gridNumber:0, gridCheckbox:'#checkbox#', gridEdit:'#edit#'}
        that.$thead = that.$element.find('> thead')
        that.$tbody = that.$element.find('> tbody')
        
        if (that.$tbody && that.$tbody.find('> tr').length) {
            that.isDom = true
            
            that.setColumnModel()
            
            that.$tbody.find('> tr > td').each(function() {
                var $td = $(this), html = $td.html()
                
                $td.html('<div>'+ html +'</div>')
            })
            
            if (!that.paging.total) {
                that.paging.total = that.$tbody.find('> tr').length
                that.paging.pageCount = 1
            } else {
                that.paging.pageCount = tools.getPageCount(that.paging.pageSize, that.paging.total)
            }
            
            that.paging.pageCurrent = 1
            that.initThead()
        } else {
            that.$tbody = null
            that.$element.find('> tbody').remove()
            
            if (options.columns) {
                if (typeof options.columns === 'string') {
                    if (options.columns.trim().startsWith('[')) {
                        options.columns = options.columns.toObj()
                    } else {
                        options.columns = options.columns.toFunc()
                    }
                }
                if (typeof options.columns === 'function') {
                    options.columns = options.columns.call()
                }
                
                that.$thead = null
                that.$element.find('> thead').remove()
                that.createThead()
            } else {
                if (that.$thead && that.$thead.length && that.$thead.find('> tr').length) {
                    that.setColumnModel()
                } else {
                    BJUI.debug('Datagrid Plugin: No set options \'columns\' !')
                    that.destroy()
                    return
                }
            }
            
            if (options.data || options.dataUrl) {
                that.createTbody()
            } else {
                BJUI.debug('Datagrid Plugin: No options \'data\' or \'dataUrl\'!')
                that.destroy()
            }
        }
    }
    
    // DOM to datagrid - setColumnModel
    Datagrid.prototype.setColumnModel = function() {
        var that = this, options = that.options, $trs = that.$thead.find('> tr'), rows = [], ths = [], trLen = $trs.length
        
        if (!that.isDom) {
            that.tools.appendColumns()
            
            var $th, _rowspan = trLen > 1 ? ' rowspan="'+ trLen +'"' : ''
            
            if (options.showCheckboxcol) {
                that.columnModel.push(that.checkboxColumn)
                if (options.showCheckboxcol === 'lock') that.checkboxColumn.initLock = true
                
                $th = $('<th class="'+ that.classnames.td_checkbox +'"'+ _rowspan +'><input type="checkbox" data-toggle="icheck"></th>')
                $th.prependTo($trs.first())
                if (_rowspan) $th.data('datagrid.column', that.checkboxColumn)
            }
            if (options.showLinenumber) {
                that.columnModel.unshift(that.linenumberColumn)
                if (options.showLinenumber === 'lock') that.linenumberColumn.initLock = true
                
                $th = $('<th class="'+ that.classnames.td_linenumber +'"'+ _rowspan +'>No.</th>')
                $th.prependTo($trs.first())
                if (_rowspan) $th.data('datagrid.column', that.linenumberColumn)
            }
            if (options.showChildcol || (options.showChildcol === undefined && options.hasChild && options.childOptions)) {
                that.columnModel.unshift(that.childColumn)
                
                $th = $('<th class="'+ that.classnames.td_child +'"'+ _rowspan +'>...</th>')
                $th.prependTo($trs.first())
                if (_rowspan) $th.data('datagrid.column', that.childColumn)
            }
            if (options.showEditbtnscol) {
                $th = $('<th'+ _rowspan +'>'+ that.editBtnsColumn.label +'</th>')
                $th.appendTo($trs.first())
                if (_rowspan) $th.data('datagrid.column', that.editBtnsColumn)
                that.columnModel[$th.index()] = that.editBtnsColumn
            }
        }
        
        if ($trs.length && trLen == 1) {
            $trs.find('> th').each(function(i) {
                var $th = $(this).addClass('single-row').data('index', i), op = $th.data('options'), oW = $th.attr('width') || 'auto', label = $th.html()
                
                if (that.columnModel.length && that.columnModel[i]) {
                    op = that.columnModel[i]
                    op.index = i
                } else {
                    if (op && typeof op === 'string') op = op.toObj()
                    if (typeof op !== 'object') op = {}
                    
                    op.index = i
                    op.label = label
                    op.width = (typeof op.width === 'undefined') ? oW : op.width
                    
                    op = that.tools.setOp(op)
                    
                    that.columnModel[i] = op
                }
                
                that.columnModel[i].th = $th
                
                $th.html('<div><div class="datagrid-space"></div><div class="datagrid-label">'+ label +'</div><div class="'+ that.classnames.th_cell +'"><div class="'+ that.classnames.th_resizemark +'"></div></div></div>')
                if (op.menu && options.columnMenu) $th.addClass(that.classnames.th_menu)
                if (options.fieldSortable && op.quicksort) $th.addClass('datagrid-quicksort-th')
                if (op.align) $th.attr('align', op.align)
            })
        } else { // multi headers
            $trs.each(function(len) {
                var next_rows = [], next_ths = [], index = -1, next_index = 0
                
                if (rows.length) {
                    next_rows = rows.concat()
                    next_ths  = ths.concat()
                }
                rows = []
                ths  = []
                
                $(this).find('> th').each(function(i) {
                    var $th = $(this), op = $th.data('options') || $th.data('datagrid.column') || {}, colspan = parseInt(($th.attr('colspan') || 0), 10), rowspan = parseInt(($th.attr('rowspan') || 0), 10), oW = $th.attr('width') || 'auto', label = $th.html()
                    
                    if (op && typeof op === 'string') op = op.toObj()
                    if (typeof op !== 'object') op = {}
                    if (BJUI.isIE(8) && colspan === 1) colspan = 0
                    
                    op.label = label
                    op.th    = $th
                    if (op.gridCheckbox) op.label = 'Checkbox'
                    
                    index++
                    if (colspan) {
                        op.colspan = colspan
                        for (var start_index = (next_rows.length ? next_rows[index] : index), k = start_index; k < (start_index + colspan); k++) {
                            rows[next_index++]  = k
                            ths[next_index - 1] = op
                        }
                        index += (colspan - 1)
                        
                        $th.data('index', index)
                        
                        if (next_rows.length) {
                            op.parent = next_ths[index]
                        }
                    }
                    if (!rowspan || rowspan == 1) $th.addClass('single-row')
                    if (!colspan) {
                        op.width = (typeof op.width === 'undefined') ? oW : op.width
                        
                        op = that.tools.setOp(op)
                        $th.html('<div><div class="datagrid-space"></div><div class="datagrid-label">'+ label +'</div><div class="'+ that.classnames.th_cell +'"><div class="'+ that.classnames.th_resizemark +'"></div></div></div>')
                        
                        if (op.menu && options.columnMenu) $th.addClass(that.classnames.th_menu)
                        if (options.fieldSortable && op.quicksort) $th.addClass('datagrid-quicksort-th')
                        if (op.align) $th.attr('align', op.align)
                        if (!next_rows.length) {
                            op.index = index
                            that.columnModel[index] = op
                        } else {
                            op.index  = next_rows[index]
                            op.parent = next_ths[index]
                            that.columnModel[next_rows[index]] = op
                        }
                        
                        $th.data('index', op.index)
                    } else {
                        $th.html('<div><div class="datagrid-space"></div><div class="datagrid-label">'+ label +'</div><div class="'+ that.classnames.th_cell +'"><div class="'+ that.classnames.th_resizemark +'"></div></div></div>')
                    }
                })
            })
        }
    }
    
    // create thead by columns
    Datagrid.prototype.createThead = function() {
        var that = this, options = that.options, columns = options.columns, rowArr = [], rows = [], label, align, width, colspan, rowspan, resize, menu,
            columns2Arr = function(columns, rowArr, index, parent) {
                if (!rowArr) rowArr = []
                if (!index)   index = 0
                if (!rowArr[index]) rowArr[index] = []
                
                $.each(columns, function(i, n) {
                    var len = rowArr[index].length, colspan
                    
                    if (parent) n.parent = parent
                    if (n.columns) {
                        colspan = n.columns.length
                        if (index && n.parent) {
                            that.tools.setColspan(n.parent, colspan)
                        }
                        
                        n.index     = that.columnModel.length + colspan - 1
                        n.colspan   = colspan
                        n.quicksort = false
                        rowArr[index][len++] = n
                        
                        return columns2Arr(n.columns, rowArr, index + 1, n)
                    } else {
                        n.rowspan = index
                        n.index   = that.columnModel.length
                        
                        n = that.tools.setOp(n)
                        
                        rowArr[index][len++] = n
                        that.columnModel.push(n)
                    }
                })
                
                return rowArr
            }
        
        that.tools.appendColumns()
        
        if (options.showCheckboxcol) {
            columns.unshift(that.checkboxColumn)
            if (options.showCheckboxcol === 'lock') that.checkboxColumn.initLock = true
        }
        if (options.showLinenumber) {
            columns.unshift(that.linenumberColumn)
            if (options.showLinenumber === 'lock') that.linenumberColumn.initLock = true
        }
        if (options.showChildcol || (options.showChildcol === undefined && options.hasChild && options.childOptions)) {
            columns.unshift(that.childColumn)
        }
        if (options.showEditbtnscol) columns.push(that.editBtnsColumn)
        
        rowArr = columns2Arr(columns, rowArr)
        // the last model can't lock
        that.columnModel[that.columnModel.length - (options.showEditbtnscol ? 2 : 1)].lock = false
        // hidden fields
        if (options.hiddenFields) that.hiddenFields = options.hiddenFields
        // create thead
        that.$thead  = $('<thead></thead>')
        $.each(rowArr, function(i, arr) {
            var $tr = $('<tr style="height:25px;"></tr>'), $num = '<th class="datagrid-number"></th>', $th
            
            $.each(arr, function(k, n) {
                label   = n.label || n.name
                align   = n.align ? (' align="'+ n.align +'"') : ''
                width   = n.width ? (' width="'+ n.width +'"') : ''
                colspan = n.colspan ? ' colspan="'+ n.colspan +'"' : ''
                rowspan = (rowArr.length - n.rowspan > 1) ? ' rowspan="'+ (rowArr.length - n.rowspan) +'"' : ''
                resize  = '<div class="'+ that.classnames.th_resizemark +'"></div>'
                menu    = ''
                
                if (n.gridCheckbox) label = '<input type="checkbox" data-toggle="icheck">'
                if (n.colspan) align = ' align="center"'
                if (n.thalign) align = ' align="'+ n.thalign +'"'
                if (n.menu && options.columnMenu) menu = ' class="'+ that.classnames.th_menu +'"'
                
                $th = $('<th'+ menu + width + align + colspan + rowspan +'><div><div class="datagrid-space"></div><div class="datagrid-label">'+ label +'</div><div class="'+ that.classnames.th_cell +'">'+ resize +'</div></div></th>')
                $th.data('index', n.index).appendTo($tr)
                
                if (!rowspan) $th.addClass('single-row')
                if (n.gridChild) $th.addClass(that.classnames.td_child)
                if (n.gridNumber) $th.addClass(that.classnames.td_linenumber)
                if (n.gridCheckbox) $th.addClass(that.classnames.td_checkbox)
                if (options.fieldSortable && n.quicksort) $th.addClass('datagrid-quicksort-th')
                
                n.th = $th
            })
            
            $tr.appendTo(that.$thead)
        })
        
        that.$thead.appendTo(that.$element).initui()
    }
    
    Datagrid.prototype.createTbody = function() {
        var that = this, options = that.options, data = options.data, model = that.columnModel, cols = []
        
        if (data) {
            if (typeof data === 'string') {
                if (data.trim().startsWith('[') || data.trim().startsWith('{')) {
                    data = data.toObj()
                } else {
                    data = data.toFunc()
                }
            }
            if (typeof data === 'function') {
                data = data.call()
            }
            
            options.data = data
            that.tools.createTrsByData(data)
        } else if (options.dataUrl) {
            that.tools.loadData()
        }
    }
    
    Datagrid.prototype.refresh = function() {
        var that = this, options = that.options, tools = that.tools, isDom = that.isDom, pageInfo = BJUI.pageInfo, paging = that.paging, postData = {}
        
        if (!options.dataUrl) {
            if (options.data && options.data.length) {
                tools.initTbody(that.allData, true)
                return
            }
            
            BJUI.debug('Datagrid Plugin: Not Set the dataUrl option!')
            return
        }
        
        if (!options.postData || !options.postData[pageInfo.pageSize]) {
            postData[pageInfo.pageSize]    = paging.pageSize
            postData[pageInfo.pageCurrent] = paging.pageCurrent
        }
        
        tools.loadData(postData, true)
        
        // clear fiter
        that.filterDatas = null
        $.each(that.columnModel, function(i, n) {
            n.th.trigger('bjui.datagrid.th.filter', [false])
            n.isFiltered = false
            if (n.$quickfilter) n.$quickfilter.trigger('bjui.datagrid.thead.clearfilter')
        })
        // clear sort
        that.$thead.find('> tr > th.datagrid-quicksort-th').find('> div > .datagrid-label > i').remove()
    }
    
    Datagrid.prototype.refreshParent = function() {
        var that = this, $parent = that.$element.data('bjui.datagrid.parent')
        
        if ($parent && $parent.length)
            $parent.closest('table').datagrid('refresh')
    }
    
    Datagrid.prototype.refreshChild = function(row) {
        var that = this, $trs = that.$tbody.find('> tr'), $table,
            refresh = function(obj) {
                $table = obj.data('bjui.datagrid.child')
                
                if ($table && $table.length && $table.isTag('table'))
                    $table.datagrid('refresh')
            }
        
        if (row instanceof jQuery) {
            row.each(function() {
                refresh($(this))
            })
        } else if (isNaN(row)) {
            $.each(row.split(','), function(i, n) {
                if (n * 2 < $trs.length)
                    refresh($trs.eq(n * 2))
            })
        } else {
            if (row * 2 < $trs.length)
                refresh($trs.eq(row * 2))
        }
    }
    
    // api
    Datagrid.prototype.showChild = function(row, flag, func) {
        if (typeof flag === 'undefined')
            flag = true
        
        var that   = this, options = that.options, $child, $td, $table, index, trData, childOptions, dataUrl, $trs = that.$tbody.find('> tr:not(.'+ that.classnames.tr_child +')'),
            fixedH = function() {
                if (!options.fullGrid)
                    that.fixedWidth()
                
                that.fixedHeight()
            },
            fixedL = function(index, showorhide, height) {
                if (that.$lockTableB) {
                    var $locktr = that.$lockTableB.find('> tbody > tr:eq('+ index +')')
                    
                    $locktr.toggle(showorhide)
                    
                    if (height)
                        $locktr.height(height)
                    else if (!$locktr.height())
                        $locktr.height($child.height())
                }
            },
            show = function($tr, $child, $table) {
                $td.find('> div').html(BJUI.doRegional(FRAG.gridShrinkBtn, that.regional))
                
                $child.fadeIn('normal', function() {
                    if (!$table.data('bjui.datagrid.init')) {
                        childOptions = $.extend(true, {}, that.childOptions), dataUrl = childOptions.dataUrl
                        
                        if (that.isDom) trData = $tr.data('initData') || that.tools.setDomData($tr)
                        else {
                            trData = that.data[that.tools.getNoChildDataIndex($tr.index())]
                        }
                        
                        if (dataUrl && !dataUrl.isFinishedTm()) {
                            dataUrl = that.tools.replacePlh(dataUrl, trData)
                            
                            if (!dataUrl.isFinishedTm()) {
                                BJUI.debug('Datagrid Plugin: The datagrid options \'childOptions\' in the \'dataUrl\' options is incorrect: '+ dataUrl)
                            } else {
                                childOptions.dataUrl = dataUrl
                            }
                        }
                        
                        $table
                            .datagrid(childOptions)
                            .data('bjui.datagrid.parent', $tr)
                            .on('completed.bjui.datagrid', $.proxy(function() {
                                fixedH()
                                fixedL(index, true, $child.outerHeight())
                                
                                if (func)
                                    func.apply(that, [$table])
                            }, that))
                            .on('bjui.datagrid.child.resize', function() {
                                $table
                                    .datagrid('fixedWidth')
                                    .datagrid('fixedHeight')
                            })
                        
                        $tr.data('bjui.datagrid.child', $table)
                    } else {
                        fixedH()
                        fixedL(index, true)
                        
                        if (func)
                            func.apply(that, [$table])
                    }
                })
            },
            hide = function($tr, $child, $table) {
                $child.fadeOut('normal', function() {
                    $td.find('> div').html(BJUI.doRegional(FRAG.gridExpandBtn, that.regional))
                    
                    fixedH()
                    fixedL(index, false)
                    
                    if (func)
                        func.apply(that, [$table])
                })
            },
            showhide = function($tr) {
                $child = $tr.next('.'+ that.classnames.tr_child)
                
                if ($child && $child.length) {
                    $td    = $tr.find('> td.'+ that.classnames.td_child)
                    index  = $child.index()
                    $table = $child.find('> td').find('table.table-child')
                    
                    if ($table && $table.length) {
                        if ($child.is(':visible')) {
                            if (!flag) hide($tr, $child, $table)
                        } else {
                            if (flag) show($tr, $child, $table)
                        }
                    }
                }
            }
        
        if (func) {
            if (typeof func === 'string')
                func = func.toFunc()
            if (typeof func !== 'function')
                func = false
        }
        
        if (row instanceof jQuery) {
            row.each(function() {
                showhide($(this))
            })
        } else if (isNaN(row)) {
            $.each(row.split(','), function(i, n) {
                var tr = $trs.eq(parseInt(n.trim(), 10))
                
                if (tr && tr.length)
                    showhide(tr)
            })
        } else if (!isNaN(row)) {
            var tr = $trs.eq(row)
            
            if (tr && tr.length)
                showhide(tr)
        }
    }
    
    // api
    Datagrid.prototype.updateRow = function(row, updateData) {
        var that = this, options = that.options, data_index, data, url, $tr,
            doUpdate = function(tr, updateData) {
                $.extend(data, typeof updateData === 'object' && updateData)
                
                that.dialogEditComplete(tr, data)
                
                // refresh child
                if (data['refresh.datagrid.child']) {
                    var $child = tr.data('bjui.datagrid.child')
                    
                    if ($child && $child.length)
                        $child.datagrid('refresh')
                    else
                        that.showChild(row)
                }
                
                // fixedH
                if (options.height === 'auto') {
                    that.$boxB.scrollTop(5)
                    if (that.$boxB.scrollTop)
                        that.fixedHeight()
                }
            }
        
        if (row instanceof jQuery) {
            $tr = row
        } else if (!isNaN(row)) {
            $tr = that.$tbody.find('> tr:not(.'+ that.classnames.tr_child +')').eq(parseInt(row, 10))
        } else {
            BJUI.debug('Datagrid Plugin: Func \'updateRow\', Parameter \'row\' is incorrect!')
            return
        }
        
        if (that.isDom) data = $tr.data('initData') || that.tools.setDomData($tr)
        else {
            data_index = that.tools.getNoChildDataIndex($tr.index())
            data = that.data[data_index]
        }
        
        if (updateData) {
            if (typeof updateData === 'string') {
                if (updateData.trim().startsWith('{'))
                    updateData = updateData.toObj()
                else
                    updateData = updateData.toFunc()
            }
            if (typeof updateData === 'function')
                updateData = updateData.apply()
                
            if (typeof updateData !== 'object' && !options.updateRowUrl) {
                BJUI.debug('Datagrid Plugin: Func \'updateRow\', Parameter \'updateData\' is incorrect!')
                return
            }
            
            doUpdate($tr, updateData)
        } else if (options.updateRowUrl) {
            url = that.tools.replacePlh(options.updateRowUrl, data)
            
            if (!url.isFinishedTm()) {
                BJUI.debug('Datagrid Plugin: The datagrid options \'updateRowUrl\' is incorrect!')
            } else {
                BJUI.ajax('doajax', {
                    url       : url,
                    type      : options.loadType,
                    okCallback: function(json) {
                        doUpdate($tr, json)
                    }
                })
            }
        } else {
            BJUI.debug('Datagrid Plugin: The datagrid options \'updateRowUrl\' is not set!')
        }
    }
    
    // api
    Datagrid.prototype.doAjaxRow = function(row, opts) {
        var that = this, options = that.options, $tr, data, data_index, url
        
        if (row instanceof jQuery) {
            $tr = row
        } else if (!isNaN(row)) {
            $tr = that.$tbody.find('> tr:not(.'+ that.classnames.tr_child +')').eq(parseInt(row, 10))
        } else {
            BJUI.debug('Datagrid Plugin: Func \'doAjaxRow\', Parameter \'row\' is incorrect!')
            return
        }
        if (typeof opts === 'object' && opts.url) {
            if (typeof opts.reload === 'undefined')
                opts.reload = false
            if (!opts.callback && !opts.okCallback) {
                opts.okCallback = function(json, options) {
                    that.updateRow($tr, typeof json === 'object' && !json[BJUI.keys.statusCode] && json)
                }
            }
            
            if (that.isDom) data = $tr.data('initData') || that.tools.setDomData($tr)
            else {
                data_index = that.tools.getNoChildDataIndex($tr.index())
                data = that.data[data_index]
            }
            
            url = opts.url
            
            if (!data || data.addFlag)
                url = url.replace(/{\/?[^}]*}/g, '')
            else
                url = that.tools.replacePlh(url, data)
            
            if (!url.isFinishedTm()) {
                BJUI.debug('Datagrid Plugin: Func \'doAjaxRow\', options \'url\' is incorrect: '+ url)
            }
            
            opts.url = url
            
            BJUI.ajax('doajax', opts)
        } else {
            BJUI.debug('Datagrid Plugin: Func \'doAjaxRow\', options is incorrect or the property \'url\' is not set!')
        }
    }
    
    Datagrid.prototype.reload = function(option) {
        var options = this.options
        
        if (option && typeof option === 'object') {
            if (option.clearOldPostData)
                delete options.postData
            
            $.extend(true, options, option)
        }
        
        if (!options.dataUrl && options.data) {
            this.allData = options.data
        }
        
        this.refresh()
    }
    
    Datagrid.prototype.destroy = function() {
        var that = this, $element = that.$grid.data('bjui.datagrid.table')
        
        if ($element) {
            that.$element.html($element.html()).insertBefore(that.$grid)
            that.$grid.remove()
        }
    }
    
    Datagrid.prototype.initTop = function() {
        var that = this, options = that.options, regional = that.regional, hastoolbaritem = false, $group, groupHtml = '<div class="btn-group" role="group"></div>', btnHtml = '<button type="button" class="btn" data-icon=""></button>'
        
        if (options.showToolbar) {
            if (options.toolbarItem || options.toolbarCustom) {
                if (options.toolbarItem) {
                    var itemFunc = options.toolbarItem.toFunc()
                    
                    if (typeof itemFunc === 'function') {
                        options.toolbarItem = itemFunc.apply()
                    }
                    
                    hastoolbaritem = true
                    if (options.toolbarItem.indexOf('all') >= 0) options.toolbarItem = 'add, edit, cancel, save, |, del, |, refresh, |, import, export'
                    $.each(options.toolbarItem.split(','), function(i, n) {
                        n = n.trim().toLocaleLowerCase()
                        if (!$group || n === '|') {
                            $group = $(groupHtml).appendTo(that.$toolbar)
                            if (n === '|') return true
                        }
                        
                        if (n === 'add') {
                            that.$toolbar_add = $(btnHtml).attr('data-icon', 'plus').addClass('btn-blue').text(BJUI.getRegional('datagrid.add'))
                                .appendTo($group)
                                .on('click', function(e) {
                                    that.add()
                                })
                        } else if (n === 'edit') {
                            that.$toolbar_edit = $(btnHtml).attr('data-icon', 'edit').addClass('btn-green').text(BJUI.getRegional('datagrid.edit'))
                                .appendTo($group)
                                .on('click', function(e) {
                                    var $selectTrs = that.$tbody.find('> tr.'+ that.classnames.tr_selected)
                                    
                                    if (!options.editMode) return false
                                    if (!$selectTrs.length) {
                                        $(this).alertmsg('info', BJUI.getRegional('datagrid.selectMsg'))
                                    } else {
                                        if (options.inlineEditMult) {
                                            that.doEditRow($selectTrs)
                                        } else {
                                            if (that.$lastSelect) that.doEditRow(that.$lastSelect)
                                            else that.doEditRow($selectTrs.first())
                                        }
                                    }
                                })
                        } else if (n === 'cancel') {
                            that.$toolbar_calcel = $(btnHtml).attr('data-icon', 'undo').addClass('btn-orange').text(BJUI.getRegional('datagrid.cancel'))
                                .appendTo($group)
                                .on('click', function(e) {
                                    that.doCancelEditRow(that.$tbody.find('> tr.'+ that.classnames.tr_edit))
                                })
                        } else if (n === 'save') {
                            that.$toolbar_save = $(btnHtml).attr('data-icon', 'save').addClass('btn-default').text(BJUI.getRegional('datagrid.save'))
                                .appendTo($group)
                                .on('click', function(e) {
                                    that.doSaveEditRow()
                                })
                        } else if (n === 'del') {
                            that.$toolbar_del = $(btnHtml).attr('data-icon', 'times').addClass('btn-red').text(BJUI.getRegional('datagrid.del'))
                                .appendTo($group)
                                .on('click', function(e) {
                                    var $selectTrs = that.$tbody.find('> tr.'+ that.classnames.tr_selected)
                                    
                                    if ($selectTrs.length) {
                                        that.delRows($selectTrs)
                                    } else {
                                        $(this).alertmsg('info', BJUI.getRegional('datagrid.selectMsg'))
                                    }
                                })
                        } else if (n === 'refresh') {
                            that.$toolbar_refresh = $(btnHtml).attr('data-icon', 'refresh').addClass('btn-green').text(BJUI.getRegional('datagrid.refresh'))
                                .appendTo($group)
                                .on('click', function(e) {
                                    that.refresh()
                                })
                        } else if (n === 'import') {
                            that.$toolbar_add = $(btnHtml).attr('data-icon', 'sign-in').addClass('btn-blue').text(BJUI.getRegional('datagrid.import'))
                                .appendTo($group)
                                .on('click', function(e) {
                                    if (options.importOption) {
                                        var opts = options.importOption
                                        
                                        if (typeof opts === 'string')
                                            opts = opts.toObj()
                                        
                                        if (opts.options && opts.options.url) {
                                            if (opts.type === 'dialog') {
                                                that.$grid.dialog(opts.options)
                                            } else if (opts.type === 'navtab') {
                                                that.$grid.navtab(opts.options)
                                            } else {
                                                that.$grid.bjuiajax('doajax', opts.options)
                                            }
                                        }
                                    }
                                })
                        } else if (n === 'export') {
                            that.$toolbar_add = $(btnHtml).attr('data-icon', 'sign-out').addClass('btn-green').text(BJUI.getRegional('datagrid.export'))
                                .appendTo($group)
                                .on('click', function(e) {
                                    if (options.exportOption) {
                                        var opts = options.exportOption
                                        
                                        if (typeof opts === 'string')
                                            opts = opts.toObj()
                                        
                                        if (opts.options && opts.options.url) {
                                            if (opts.type === 'dialog') {
                                                BJUI.dialog(opts.options)
                                            } else if (opts.type === 'navtab') {
                                                BJUI.navtab(opts.options)
                                            } else if (opts.type === 'file') {
                                                opts.options.target = that.$boxB
                                                BJUI.ajax('ajaxdownload', opts.options)
                                            } else {
                                                BJUI.ajax('doajax', opts.options)
                                            }
                                        }
                                    }
                                })
                        }
                    })
                }
                
                if (options.toolbarCustom) {
                    var $custom, $custombox = $('<div style="display:inline-block;"></div>')
                    
                    if (typeof options.toolbarCustom === 'string') {
                        var custom = $(options.toolbarCustom)
                        
                        if (custom && custom.length) {
                            $custom = custom
                        } else {
                            custom = custom.toFunc()
                            if (custom) {
                                $custom = custom.call(that)
                                if (typeof $custom === 'string') $custom = $($custom)
                            }
                        }
                    } else if (typeof options.toolbarCustom === 'function') {
                        $custom = options.toolbarCustom.call(that)
                        if (typeof $custom === 'string') $custom = $($custom)
                    } else {
                        $custom = options.toolbarCustom
                    }
                    
                    if ($custom && $custom.length && typeof $custom !== 'string') {
                        if (hastoolbaritem) {
                            $custombox.css('margin-left', '5px')
                        }
                        $custombox.appendTo(that.$toolbar)
                        $custom.appendTo($custombox)
                    }
                }
                
                that.$toolbar.initui()
            }
        }
    }
    
    Datagrid.prototype.initThead = function() {
        var that = this, options = that.options, tools = that.tools, columnModel = that.columnModel, width, cols = [], $tableB, $grid = $('<div class="bjui-datagrid"></div>'), $firstTr, rowspan
        
        that.$tableH.append(that.$thead)
        
        that.init_thead    = true
        that.$trsH         = that.$thead.find('> tr')
        that.table_width   = 0
        that.$colgroupH    = that.$tableH.find('> colgroup')
        that.fixtedColumnWidthCount = 0
        
        $.each(that.columnModel, function(i, n) {
            var lockWidth = ''
            
            if (n === that.linenumberColumn || n === that.checkboxColumn || n === that.childColumn || n === that.editBtnsColumn)
                lockWidth = ' class="datagrid_col_lockwidth"'
            
            width = n.width
            
            if (!width || width === 'auto') {
                if (!$tableB) {
                    $tableB = that.$element.clone().addClass('table table-bordered').appendTo($grid)
                    $tableB.prepend(that.$thead.clone())
                    $grid.appendTo($('body'))
                    $tableB.attr('style', 'width:auto !important;').initui()
                }
                
                that.fixtedColumnWidthCount ++
                n.fixedWidth = true
                
                $firstTr = $tableB.find('> tbody > tr:first-child')
                
                if ($firstTr.hasClass("datagrid-nodata")) {
                    if (that.$trsH.length > 1)
                        rowspan = that.$trsH.length - parseInt(n.th.attr('rowspan') || 1, 10)
                    else
                        rowspan = 0
                    
                    width = $tableB.find('> thead > tr:eq('+ rowspan +') > th:eq('+ n.th.index() +')').outerWidth() + 5
                } else {
                    width = ($tableB.find('> tbody > tr:first-child > td:eq('+ i +')').outerWidth()) + 5
                }
            }
            
            cols.push('<col style="width:'+ width +'px;"'+ lockWidth +'>')
            n.width = width
            that.table_width += width
        })
        
        if ($grid)
            $grid.remove()
        
        that.$colgroupH.html(cols.join(''))
        
        // fixed div height for th
        setTimeout(function() {
            that.$thead.find('> tr:not(.datagrid-filter)').each(function() {
                $(this).find('> th').each(function() {
                    var $th = $(this), height = $th.outerHeight(), $div = $th.find('> div')
                    
                    $div.height(height)
                })
            })
        }, 10)
        
        // thead - events
        var $ths = that.$trsH.find('> th')
        // events - quicksort
        $ths.filter('.datagrid-quicksort-th')
            .on('click.bjui.datagrid.quicksort', function(e) {
                var $target = $(e.target)
                
                if (!$target.closest('.'+ that.classnames.th_cell).length && !that.isResize)
                    tools.quickSort(columnModel[$(this).data('index')])
            })
        
        // events - filter
        $ths.filter('.datagrid-column-menu')
            .on('bjui.datagrid.th.filter', function(e, flag) {
                var $th = $(this), $btn = $th.find('> div > .'+ that.classnames.th_cell +'> .'+ that.classnames.btn_menu +'> .btn')
                
                if (flag) {
                    $th.addClass('filter-active')
                    $btn.find('> i').attr('class', 'fa fa-filter')
                } else {
                    $th.removeClass('filter-active')
                    $btn.find('> i').attr('class', 'fa fa-bars')
                }
            })
        
        // events - contextmenu
        if (options.contextMenuH) {
            tools.contextmenuH()
        }
        
        that.initTbody()
        
        if (options.columnResize) that.colResize()
        if (options.columnMenu)   that.colMenu()
        if (options.paging)       that.initPaging()
        if (options.editMode)     that.edit()
        if (!that.$element.hasClass('table-child'))
            that.resizeGrid()
        
        var delayFunc = function() {
            if (options.showTfoot) that.initTfoot()
            
            tools.setBoxbH()
            
            /* render */
            if (that.renderTds && that.renderTds.length) {
                var $trs = that.$tbody.find('> tr:not(.'+ that.classnames.tr_child +', .datagrid-nodata)'), j = that.renderTds && that.renderTds.length
                
                for (var i = 0; i < j; i++) {
                    var obj = that.renderTds[i], label = obj.render.call(that, obj.label, obj.trData, that.columnModel[obj.tdindex].items)
                    
                    $trs.eq(obj.trindex).find('> td:eq('+ obj.tdindex +')').html('<div>'+ label +'</div>')
                }
            }
            
            that.initEvents()
            that.$tableB.initui()
            that.$lockTableB && that.$lockTableB.initui()
            
            setTimeout(function() {
                that.fixedWidth('init')
                that.initLock()
                that.$element.trigger('completed.bjui.datagrid', {datas:that.data})
                that.$boxM && that.$boxM.trigger('bjui.ajaxStop').hide()
            }, 50)
            
            that.delayFilterTimeout && clearInterval(that.delayFilterTimeout)
        }
        
        if (options.filterThead) {
            if (that.delayRender) {
                that.delayFilterTimeout = setInterval(function() {
                    if (!that.delayRender) {
                        that.filterInThead()
                        delayFunc()
                    }
                }, 100)
            } else {
                that.filterInThead()
                delayFunc()
            }
        } else {
            delayFunc()
        }
    }
    
    Datagrid.prototype.fixedWidth = function(isInit) {
        var that = this, options = that.options, bW, excludeW = 0, fixedW, columnModel = that.columnModel, length = columnModel.length
        
        if (isInit && that.initFixedW) return
        that.initFixedW = true
        
        var setNewWidth = function() {
            if (String(that.options.width).endsWith('%'))
                that.$grid.css('width', '')
            
            that.$boxH.find('> div').css('width', '')
            that.$boxB.find('> div').css('width', '')
            that.$boxF && that.$boxF.find('> div').css('width', '')
            that.$boxP && that.$boxP.find('> div.paging-content').css('width', '')
            
            bW = that.$boxB.find('> div').width()
            
            if (that.options.hasChild) {
                that.$boxB.scrollTop(5)
                
                if (that.$boxB.scrollTop())
                    bW = bW - 18
            }
            
            if (bW) {
                that.$boxB.find('> div').width(bW)
                that.$boxH.find('> div').width(bW)
                that.$boxF && that.$boxF.find('> div').width(bW)
                
                if (that.table_width > bW || options.fullGrid)
                    that.$boxP && that.$boxP.find('> div.paging-content').width(bW)
                else
                    that.$boxP && that.$boxP.find('> div.paging-content').width(that.table_width)
            }
            
            if (options.fullGrid) {
                var $firstTr = that.$tbody.find('> tr:first'), width, rowspan, $cols = that.$colgroupB.find('> col'), $col
                
                $cols.filter(':not(.datagrid_col_lockwidth)').css('width', '')
                
                $.each(that.columnModel, function(i, n) {
                    if (n === that.linenumberColumn || n === that.checkboxColumn || n === that.childColumn || n === that.editBtnsColumn) {
                        return true
                    }
                    
                    if ($firstTr.hasClass("datagrid-nodata")) {
                        if (that.$trsH.length > 1)
                            rowspan = that.$trsH.length - parseInt(n.th.attr('rowspan') || 1, 10)
                        else
                            rowspan = 0
                            
                        width = that.$trsH.eq(rowspan).find('> th:eq('+ n.th.index() +')').width()
                    } else {
                        width = ($firstTr.find('> td:eq('+ i +')').width())
                    }
                    
                    $cols.eq(i).css('width', width)
                })
                
                that.$colgroupH.html(that.$colgroupB.html())
            }
        }
        
        setNewWidth()
    }
    
    Datagrid.prototype.fixedHeight = function(height) {
        var that = this, options = that.options
        
        if (options.height === 'auto') {
            that.boxH = 'auto'
            that.$grid.css('height', '')
            that.$boxB.css('height', '')
            that.tools.setBoxbH()
        } else
            that.tools.setBoxbH(height)
        
        // if scrollLeft
        that.$boxB.scrollLeft(5)
        
        if (that.$boxB.scrollLeft())
            that.fixedWidth()
    }
    
    Datagrid.prototype.initTbody = function() {
        var that = this, options = that.options, tools = that.tools, $trs = that.$tbody.find('> tr'), $tds = $trs.find('> td'), width = '0'
        
        that.init_tbody = true
        that.$colgroupB = that.$colgroupH.clone()
        that.$tableB.prepend(that.$colgroupB)
        
        if (options.fullGrid) width = '100%'
        
        that.$tableH.css('width', width)
        that.$tableB.css('width', width)
        
        // add class
        that.$tableB.removeAttr('data-toggle width').addClass('table table-bordered').removeClass('table-hover')
        
        that.$boxB
            .scroll(function() {
                that.$boxH.find('> div').prop('scrollLeft', this.scrollLeft)
                that.$boxF && that.$boxF.find('> div').prop('scrollLeft', this.scrollLeft)
                that.$lockB && that.$lockB.prop('scrollTop', this.scrollTop)
            })
        
        // if DOM to datagrid
        if (that.isDom) {
            if (options.showLinenumber) {
                that.showLinenumber(options.showLinenumber)
            }
            if (options.showCheckboxcol) {
                that.showCheckboxcol(options.showCheckboxcol)
            }
            if (options.showEditbtnscol) {
                that.showEditCol(options.showEditbtnscol)
            }
            
            that.$grid.data(that.datanames.tbody, that.$tbody.clone())
        }
    }
    
    // init events(only tbody)
    Datagrid.prototype.initEvents = function($trs) {
        var that = this, options = that.options, trs = that.$tbody.find('> tr')
        
        if (!$trs) $trs = trs
        
        $trs.on('click.bjui.datagrid.tr', function(e, checkbox) {
            var $tr = $(this), index = $tr.index(), data, $selectedTrs = that.$tbody.find('> tr.'+ that.classnames.tr_selected), $last = that.$lastSelect, checked, $lockTrs = that.$lockTbody && that.$lockTbody.find('> tr')
            
            if (checkbox) {
                checked = checkbox.is(':checked')
                if (!checked) that.$lastSelect = $tr
                that.selectedRows($tr, !checked)
            } else {
                if ($tr.hasClass(that.classnames.tr_edit)) return
                if (options.selectMult) {
                    that.selectedRows($tr)
                } else {
                    if (!BJUI.KeyPressed.ctrl && !BJUI.KeyPressed.shift) {
                        if ($selectedTrs.length > 1 && $tr.hasClass(that.classnames.tr_selected)) {
                            that.selectedRows($selectedTrs.not($tr))
                            that.$lastSelect = $tr
                        } else {
                            if ($selectedTrs.length && $selectedTrs[0] != this) that.selectedRows(null)
                            if (!$tr.hasClass(that.classnames.tr_selected)) that.$lastSelect = $tr
                            that.selectedRows($tr)
                        }
                    } else {
                        window.getSelection ? window.getSelection().removeAllRanges() : document.selection.empty() //clear selection
                        
                        if (BJUI.KeyPressed.ctrl) {
                            if (!$tr.hasClass(that.classnames.tr_selected)) that.$lastSelect = $tr
                            that.selectedRows($tr)
                        } else if (BJUI.KeyPressed.shift) {
                            if (!$last) $last = that.$lastSelect = $tr
                            if ($last.length) {
                                that.selectedRows(null)
                                if ($last.index() != index) {
                                    if ($last.index() > index) {
                                        that.selectedRows($tr.nextUntil($last).add($tr).add($last), true)
                                    } else {
                                        that.selectedRows($tr.prevUntil($last).add($tr).add($last), true)
                                    }
                                } else {
                                    that.selectedRows(index)
                                }
                            }
                        }
                    }
                }
            }
            
            if (that.isDom)
                data = that.tools.setDomData($tr)
            else
                data = that.data[that.tools.getNoChildDataIndex(index)]
            
            that.$element.trigger('clicked.bjui.datagrid.tr', {data:data})
        })
        .on('mouseenter.bjui.datagrid', function(e) {
            var $tr = $(this), index = $tr.index()
            
            $tr.addClass('datagrid-hover')
            that.$lockTbody && that.$lockTbody.find('> tr:eq('+ index +')').addClass('datagrid-hover')
        })
        .on('mouseleave.bjui.datagrid', function(e) {
            var $tr = $(this), index = $tr.index()
            
            $tr.removeClass('datagrid-hover')
            that.$lockTbody && that.$lockTbody.find('> tr:eq('+ index +')').removeClass('datagrid-hover')
        })
        // custom event - delete 
        .on('bjui.datagrid.tr.delete', function(e) {
            e.stopPropagation()
            
            var $tr = $(this), tr_index = $tr.index(), data_index = tr_index, data = that.data, gridIndex, allData = that.allData, $lockTrs = that.$lockTbody && that.$lockTbody.find('> tr')
            
            if ($tr.hasClass('datagrid-nodata')) return false
            
            if (that.options.hasChild && that.options.childOptions) {
                data_index = data_index / 2
                
                // remove child dom
                $tr.next().remove()
                $lockTrs && $lockTrs.eq(tr_index).next().remove()
            }
            if (!that.isDom) {
                gridIndex    = data[data_index].gridIndex
                that.data    = data.remove(data_index)     // remove data in the current page data
                that.allData = allData.remove(gridIndex)   // remove data in allData
            }
            
            /* update gridNumber */
            if ($.inArray(that.linenumberColumn, that.columnModel) != -1) {
                $tr.nextAll(':not(.'+ that.classnames.tr_child +')').each(function() {
                    var $td = $(this).find('> td.'+ that.classnames.td_linenumber), num = parseInt($td.text(), 10)
                    
                    $td.text(num - 1)
                })
                
                $lockTrs && $lockTrs.eq(tr_index).trigger('bjui.datagrid.tr.delete', [tr_index])
            }
            
            // remove dom
            $tr.remove()
            $lockTrs && $lockTrs.eq(tr_index).remove()
            
            // no data
            that.tools.createNoDataTr()
        })
        
        // child
        that.$grid.off('click.bjui.datagrid.tr.child').on('click.bjui.datagrid.tr.child', 'td.'+ that.classnames.td_child, function(e) {
            e.stopPropagation()
            
            var $this = $(this), $tr = $this.closest('tr'), $child = $tr.next('.'+ that.classnames.tr_child)
            
            if ($child && $child.length)
                that.showChild($tr, !$child.is(':visible'))
        })
        // td checkbox
        .off('ifClicked').on('ifClicked', 'td.'+ that.classnames.td_checkbox +' input', function(e) {
            e.stopPropagation()
            
            var $this = $(this), $tr = $this.closest('tr'), tr_index = $tr.index()
            
            that.$tbody.find('> tr:eq('+ tr_index +')').trigger('click.bjui.datagrid.tr', [$this])
        })
        // th checkbox - check all
        .off('ifChanged').on('ifChanged', 'th.'+ that.classnames.td_checkbox +' input', function(e) {
            e.stopPropagation()
            
            var checked = $(this).is(':checked'), $trs = that.$tbody.find('> tr:not(".'+ that.classnames.tr_child +'")')
            
            that.selectedRows($trs, checked)
        })
        
        
        //contextmenu
        if (options.contextMenuB) {
            $trs.each(function() {
                that.tools.contextmenuB($(this))
            })
        }
        
        // custom update
        that.$tableB.off('click.bjui.datagrid.refresh').on('click.bjui.datagrid.refresh', 'tbody > tr > td [data-toggle="update.datagrid.tr"]', function(e) {
            e.stopPropagation()
            
            that.updateRow($(this).closest('tr'))
        })
        // custom edit
        .off('click.bjui.datagrid.edit').on('click.bjui.datagrid.edit', 'tbody > tr > td [data-toggle="edit.datagrid.tr"]', function(e) {
            e.stopPropagation()
            
            var $this = $(this), opts = $this.data('options'), $tr = $this.closest('tr')
            
            if (opts && typeof opts === 'string') opts = opts.toObj()
            
            if (typeof opts === 'object')
                that.externalEdit($tr, opts)
            else
                that.doEditRow($tr)
        })
        // custom ajax
        .off('click.bjui.datagrid.ajax').on('click.bjui.datagrid.ajax', 'tbody > tr > td [data-toggle="ajax.datagrid.tr"]', function(e) {
            e.stopPropagation()
            
            var $this = $(this), opts = $this.data()
            
            if (opts.options && typeof opts.options === 'string') opts.options = opts.options.toObj()
            $.extend(opts, typeof opts.options === 'object' && opts.options)
            
            that.doAjaxRow($this.closest('tr'), opts)
        })
        // custom addChild
        .off('click.bjui.datagrid.addchild').on('click.bjui.datagrid.addchild', 'tbody > tr > td [data-toggle="addchild.datagrid.tr"]', function(e) {
            e.stopPropagation()
            
            var $this = $(this), $tr = $this.closest('tr'), $table = $tr.data('bjui.datagrid.child'), $child = $tr.next('.'+ that.classnames.tr_child), trData, data = $this.data('addData'), addData,
                replaceData = function(data) {
                    return data.replace(/#\/?[^#]*#/g, function($1) {
                        var key = $1.replace(/[##]+/g, ''), val = trData[key]
                        
                        if (typeof val === 'undefined' || val === 'null' || val === null)
                            val = ''
                        
                        return val
                    })
                },
                doAdd = function($table) {
                    if (data) {
                        if (typeof data === 'string') {
                            data = replaceData(data)
                            
                            if (data.trim().startsWith('{'))
                                data = data.toObj()
                            else
                                data = data.toFunc()
                        } else {
                            if (typeof data === 'function') {
                                data = data.toFunc()
                            }
                            if (typeof data === 'object') {
                                data = JSON.stringify(data)
                            }
                            
                            data = replaceData(data).toObj()
                        } 
                        
                        if (typeof data === 'object') {
                            addData = data
                        }
                    }
                    
                    $table.datagrid('add', false, addData)
                }
            
            if ($child && $child.length) {
                if (that.isDom) trData = $tr.data('initData') || tools.setDomData($tr)
                else trData = that.data[that.tools.getNoChildDataIndex($tr.index())]
                
                if ($table && $table.length) {
                    doAdd($table)
                } else {
                    that.showChild($tr, true, doAdd)
                }
            }
        })
        // custom delete
        .off('click.bjui.datagrid.del').on('click.bjui.datagrid.del', 'tbody > tr > td [data-toggle="del.datagrid.tr"]', function(e) {
            e.stopPropagation()
            
            that.delRows($(this).closest('tr'))
        })
    }
    
    Datagrid.prototype.initTfoot = function() {
        var that = this, options = that.options, tools = that.tools, columnModel = that.columnModel, $tr = $('<tr></tr>')
        
        that.$boxF      = $('<div class="datagrid-box-f"></div>')
        that.$colgroupF = that.$colgroupH.clone()
        that.$tableF    = that.$tableH.clone().empty()
        that.$tableF.append(that.$colgroupF)
        that.$boxF.append($('<div class="datagrid-wrap-h"></div>').append(that.$tableF))
        that.$boxF.insertAfter(that.$boxB)
        
        that.$tfoot = $('<thead></thead>')
        $.each(columnModel, function(i, n) {
            var $th = $('<th><div></div></th>')
            
            if (n.calc) {
                var calc_html = '<div><div class="datagrid-calcbox">#tit#</div>#number#</div>'
                
                if (n.calc === 'avg')
                    $th.html(calc_html.replace('#tit#', (n.calcTit || 'AVG')).replace('#number#', (n.calc_sum / n.calc_count).toFixed(n.calcDecimal || 2)))
                else if (n.calc === 'count')
                    $th.html(calc_html.replace('#tit#', (n.calcTit || 'COUNT')).replace('#number#', (n.calc_count)))
                else if (n.calc === 'sum')
                    $th.html(calc_html.replace('#tit#', (n.calcTit || 'SUM')).replace('#number#', (n.calc_sum)))
                else if (n.calc === 'max')
                    $th.html(calc_html.replace('#tit#', (n.calcTit || 'MAX')).replace('#number#', (n.calc_max)))
                else if (n.calc === 'min')
                    $th.html(calc_html.replace('#tit#', (n.calcTit || 'MIN')).replace('#number#', (n.calc_min)))
            }
            
            if (n.hidden) $th.css('display', 'none')
            
            $th.appendTo($tr)
        })
        
        that.$tfoot.append($tr).appendTo(that.$tableF)
        
        // events
        that.$tfoot.on('bjui.datagrid.tfoot.resizeH', function() {
            tools.setBoxbH(options.height)
        })
    }
    
    // selected row
    Datagrid.prototype.selectedRows = function(rows, selected) {
        var that = this, $lockTrs = that.$lockTbody && that.$lockTbody.find('> tr'), $trs = that.$tbody.find('> tr')
        var selectedTr = function(n) {
            if (typeof selected === 'undefined') selected = true
            if ($trs.eq(n).hasClass(that.classnames.tr_child)) return
            
            $trs.eq(n)
                .toggleClass(that.classnames.tr_selected, selected)
                .find('> td.'+ that.classnames.td_checkbox +' input').iCheck(selected ? 'check' : 'uncheck')
            
            $lockTrs && $lockTrs.eq(n)
                .toggleClass(that.classnames.tr_selected, selected)
                .find('> td.'+ that.classnames.td_checkbox +' input').iCheck(selected ? 'check' : 'uncheck')
        }
        
        if (rows === null) {
            $trs.removeClass(that.classnames.tr_selected)
                .find('> td.'+ that.classnames.td_checkbox +' input').iCheck('uncheck')
                
            $lockTrs && $lockTrs.removeClass(that.classnames.tr_selected)
                .find('> td.'+ that.classnames.td_checkbox +' input').iCheck('uncheck')
        } else if (typeof rows === 'object') {
            rows.each(function() {
                var $row = $(this), index = $row.index()
                
                if ($row.hasClass(that.classnames.tr_child)) return true
                
                if (typeof selected !== 'undefined') {
                    selectedTr(index)
                } else {
                    $row.toggleClass(that.classnames.tr_selected)
                        .trigger('bjui.datagrid.tr.selected')
                        .find('> td.'+ that.classnames.td_checkbox +' input').iCheck(($row.hasClass(that.classnames.tr_selected) ? 'check' : 'uncheck'))
                    
                    $lockTrs && $lockTrs.eq(index)
                        .toggleClass(that.classnames.tr_selected)
                        .trigger('bjui.datagrid.tr.selected')
                        .find('> td.'+ that.classnames.td_checkbox +' input').iCheck(($row.hasClass(that.classnames.tr_selected) ? 'check' : 'uncheck'))
                }
            })
        } else if (isNaN(rows)) {
            $.each(rows.split(','), function(i, n) {
                selectedTr(parseInt(n.trim(), 10))
            })
        } else if (!isNaN(rows)) {
            selectedTr(parseInt(rows, 10))
        }
        
        if (that.$lastSelect && !that.$lastSelect.hasClass(that.classnames.tr_selected)) {
            that.$lastSelect = null
        }
        
        // selectedTrs
        var $selectedTrs = that.$tbody.find('> tr.'+ that.classnames.tr_selected), datas = []
        
        $selectedTrs.each(function() {
            var $tr = $(this), data_index = $tr.index(), data
            
            data_index = that.tools.getNoChildDataIndex(data_index)
            
            if (that.isDom) data = $tr.data('initData') || that.tools.setDomData($tr)
            else data = that.data[data_index]
            
            datas.push(data)
        })
        
        that.$element.data('selectedTrs', $selectedTrs).data('selectedDatas', datas)
    }
    
    //lock
    Datagrid.prototype.initLock = function() {
        var that = this, columnModel = that.columnModel
        
        that.col_lock_count = 0
        $.each(that.columnModel, function(i, n) {
            if (n.initLock) that.col_lock_count ++
        })
        
        if (that.col_lock_count) that.doLock()
    }
    
    //api - colLock
    Datagrid.prototype.colLock = function(column, lockFlag) {
        var that = this, $th, index, columnModel 
        
        if ($.type(column) === 'number') {
            index = parseInt(column, 10)
            if (index < 0 || index > that.columnModel.length - 1) return
            columnModel = that.columnModel[index]
            $th         = columnModel.th
        } else {
            $th         = column
            index       = $th.data('index')
            columnModel = that.columnModel[index]
        }
        
        if (columnModel === that.editBtnsColumn) return // edit btn column
        else if (columnModel.index === that.columnModel.length - 1) return // last column
        if (typeof columnModel.locked === 'undefined') columnModel.locked = false
        if (columnModel.locked === lockFlag) return
        
        columnModel.initLock = lockFlag
        
        if (lockFlag) {
            that.col_lock_count ++
        } else {
            that.col_lock_count --
        }
        if (that.col_lock_count < 0) that.col_lock_count = 0
        
        that.doLock()
    }
    
    Datagrid.prototype.fixedLockItem = function(type) {
        var that = this, columnModel = that.columnModel, $filterThs = that.$thead.find('> tr.datagrid-filter > th'), $lockTrs = that.$lockTbody && that.$lockTbody.find('> tr')
        
        // out
        if (!type) {
            var fixedTh = function($th, $lockTh) {
                $lockTh.clone().insertAfter($lockTh)
                $lockTh.hide().insertAfter($th)
                $th.remove()
            }
            
            // filterThead
            if ($filterThs && $filterThs.length) {
                that.$lockThead && that.$lockThead.find('> tr.datagrid-filter > th:visible').each(function() {
                    var $lockTh = $(this), index = $lockTh.index(), $th = $filterThs.eq(index)
                    
                    fixedTh($th, $lockTh)
                })
            }
            
            //thead checkbox
            if (that.$lockThead) {
                // checkbox
                if ($.inArray(that.checkboxColumn, columnModel) != -1 && that.checkboxColumn.locked) {
                    var $lockTh = that.$lockThead.find('> tr:first > th.'+ that.classnames.td_checkbox), index = that.checkboxColumn.index, $th = that.$thead.find('> tr:first > th:eq('+ index +')')
                    
                    fixedTh($th, $lockTh)
                }
            }
            
            // inline edit && checkbox td
            if ($lockTrs && $lockTrs.length) {
                $lockTrs.each(function() {
                    var $lockTr = $(this), tr_index = $lockTr.index(), $tr, $td,
                        fixedTd = function($lockTd, tr_index, td_index) {
                            $tr = that.$tbody.find('> tr:eq('+ tr_index +')')
                            $td = $tr.find('> td:eq('+ td_index +')')
                            $lockTd.clone().insertAfter($lockTd)
                            $lockTd.hide().insertAfter($td)
                            $td.remove()
                        }
                    
                    if ($lockTr.hasClass(that.classnames.tr_edit)) {
                        var $lockTd = $lockTr.find('> td:eq('+ columnModel.lockIndex +')'), td_index = $lockTd.index()
                        
                        if ($lockTd.hasClass(that.classnames.td_edit)) {
                            fixedTd($lockTd, tr_index, td_index)
                        }
                    }
                    
                    if ($.inArray(that.checkboxColumn, columnModel) != -1 && that.checkboxColumn.locked) {
                        $lockTr.find('> td.'+ that.classnames.td_checkbox).each(function() {
                            var $lockTd = $(this), td_index = that.checkboxColumn.index
                            
                            fixedTd($lockTd, tr_index, td_index)
                        })
                    }
                })
            }
        } else { //in
            var fixedTh = function($th, $lockTh) {
                $th.clone().html('').insertAfter($th)
                $th.show().insertAfter($lockTh)
                $lockTh.remove()
            }
            
            // filterThead
            if ($filterThs && $filterThs.length) {
                that.$lockThead.find('> tr.datagrid-filter > th:visible').each(function() {
                    var $lockTh = $(this), index = $lockTh.index(), $th = $filterThs.eq(index)
                    
                    fixedTh($th, $lockTh)
                })
            }
            
            //thead checkbox
            if (that.$lockThead) {
                // checkbox
                if ($.inArray(that.checkboxColumn, columnModel) != -1 && that.checkboxColumn.locked) {
                    var $lockTh = that.$lockThead.find('> tr:first > th.'+ that.classnames.td_checkbox), index = that.checkboxColumn.index, $th = that.$thead.find('> tr:first > th:eq('+ index +')')
                    
                    fixedTh($th, $lockTh)
                }
            }
            
            // inline edit && checkbox td
            if ($lockTrs && $lockTrs.length) {
                $lockTrs.each(function() {
                    var $lockTr = $(this), tr_index = $lockTr.index(), $tr, $td,
                        fixedTd = function($lockTd, tr_index, td_index) {
                            $tr = that.$tbody.find('> tr:eq('+ tr_index +')')
                            $td = $tr.find('> td:eq('+ td_index +')')
                            $td.clone().insertAfter($td)
                            $td.show().insertAfter($lockTd)
                            $lockTd.remove()
                        }
                    
                    if ($lockTr.hasClass(that.classnames.tr_edit)) {
                        $lockTr.find('> td.'+ that.classnames.td_edit +':visible').each(function() {
                            var $lockTd = $(this), td_index = $lockTd.index(), model = columnModel[td_index]
                            
                            if (model.locked) {
                                fixedTd($lockTd, tr_index, td_index)
                            }
                        })
                    }
                    if ($.inArray(that.checkboxColumn, columnModel) != -1 && that.checkboxColumn.locked) {
                        $lockTr.find('> td.'+ that.classnames.td_checkbox).each(function() {
                            var $lockTd = $(this), td_index = that.checkboxColumn.index
                            
                            fixedTd($lockTd, tr_index, td_index)
                        })
                    }
                })
            }
        }
    }
    
    //locking
    Datagrid.prototype.doLock = function() {
        var that = this, options = that.options, tools = that.tools, columnModel = that.columnModel, tableW = that.$tableH.width(), width = 0, $trs, $lockTrs, lockedLen = 0
        var hasFoot = that.$boxF && true, top = 0
        
        if (!that.$lockBox || !that.$lockBox.length) {
            that.$lockBox = $('<div class="datagrid-box-l"></div>')
            that.$lockH   = $('<div class="datagrid-box-h"></div>')
            that.$lockB   = $('<div class="datagrid-box-b"></div>')
            that.$lockF   = $('<div class="datagrid-box-f"></div>')
            
            that.$lockTableH = $('<table class="table table-bordered"></table>')
            that.$lockTableB = $('<table></table>').addClass(that.$tableB.attr('class'))
            that.$lockTableF = $('<table class="table table-bordered"></table>')
            
            that.$lockH.append(that.$lockTableH)
            that.$lockB.append(that.$lockTableB)
            that.$lockF.append(that.$lockTableF)
            
            that.$lockBox.append(that.$lockH).append(that.$lockB).prependTo(that.$grid)
            if (hasFoot) {
                that.$lockBox.append(that.$lockF)
                that.$lockF.css('margin-top', (that.$boxB.outerHeight() - that.$boxB[0].clientHeight)).height(that.$boxF.outerHeight())
            }
        } else {
            that.fixedLockItem()
            that.$lockTableH.empty()
            that.$lockTableB.empty()
            that.$lockTableF && that.$lockTableF.empty()
        }
        
        if (that.$boxT)    top += that.$boxT.outerHeight()
        if (that.$toolbar) top += that.$toolbar.outerHeight()
        if (top) that.$lockBox.css({top:top})
        
        // display initLock columns, hide other
        $.each(columnModel, function(i, n) {
            n.lockShow = false
            n.lockHide = false
            if (n.initLock) {
                if (n.hidden) tools.showhide(n, true)
                n.lockHide  = true
                n.locked    = true
                n.lockIndex = lockedLen ++
                width      += n.width
            } else {
                n.lockShow = true
                if (!n.hidden) tools.showhide(n, false)
                else n.lockShow = false
                if (n.locked) n.lockShow = true
                n.locked   = false
            }
        })
        
        that.$lockThead     = that.$thead.clone(true)
        that.$lockTbody     = that.$tbody.clone()
        that.$lockColgroupH = that.$colgroupH.clone()
        that.$lockColgroupB = that.$colgroupB.clone()
        
        that.$lockTableH.append(that.$lockColgroupH).append(that.$lockThead).css('width', width)
        that.$lockTableB.append(that.$lockColgroupB).append(that.$lockTbody).css('width', width)
        
        if (hasFoot) {
            that.$lockTfoot     = that.$tableF.find('> thead').clone()
            that.$lockColgroupF = that.$colgroupF.clone()
            that.$lockTableF.append(that.$lockColgroupF).append(that.$lockTfoot).css('width', width)
        }
        
        // display unlock columns, hide locked columns
        $.each(that.columnModel, function(i, n) {
            if (n.lockShow) tools.showhide(n, true)
            if (n.lockHide) tools.showhide(n, false)
        })
        
        that.$boxH.find('> div').css('width', '')
        that.$boxB.find('> div').css('width', '')
        that.$boxF && that.$boxF.find('> div').css('width', '')
        
        setTimeout(function() {
            var bw = that.$boxB.find('> div').width()
            
            that.$boxB.find('> div').width(bw)
            that.$boxH.find('> div').width(bw)
            that.$boxF && that.$boxF.find('> div').width(bw)
        }, 50)
        
        if (!that.col_lock_count) that.$lockBox.hide()
        else that.$lockBox.show()
        
        // colspan for child tr && nodata tr
        that.$tbody.find('> .'+ that.classnames.tr_child +', .datagrid-nodata').each(function() {
            $(this).find('> td').attr('colspan', that.columnModel.length - that.col_lock_count)
        })
        
        if (width > 1) width = width - 1
        that.$boxH.css('margin-left', width)
        that.$boxB.css('margin-left', width)
        if (hasFoot) that.$boxF.css('margin-left', width)
        
        // fixed height
        that.$lockB.height(that.$boxB[0].clientHeight)
        that.$lockB.prop('scrollTop', that.$boxB[0].scrollTop)
        
        var lockH = that.$lockTableH.height(), H = that.$thead.height(), lockFH = that.$lockTableF && that.$lockTableF.height(), HF = that.$tableF && that.$tableF.height()
        
        if (lockH != H) {
            if (lockH < H) that.$lockTableH.height(H)
            else that.$tableH.height(lockH)
        }
        
        if (lockFH && HF && (lockFH != HF)) {
            if (lockFH < HF) that.$lockTableF.find('> thead > tr:first-child > th:visible:first').height(HF)
            else that.$tableF.find('> thead > tr:first-child > th:visible:first').height(lockFH)
        }
        
        $lockTrs = that.$lockTbody.find('> tr')
        $trs     = that.$tbody.find('> tr')
        
        setTimeout(function() {
            var lockBH = that.$lockTableB.height(), HB = that.$tableB.height()
            
            if (lockBH != HB) {
                if (lockBH > HB) {
                    $lockTrs.each(function(tr_index) {
                        var $lockTr = $(this), $lockTd = $lockTr.find('> td:visible:first'), newH = $lockTd.outerHeight()
                        
                        if (newH > 30) {
                            $lockTr.height(newH)
                            $trs.eq(tr_index).height(newH)
                        }
                    })
                } else {
                    $trs.each(function(tr_index) {
                        var $tr = $(this), $td = $tr.find('> td:visible:first'), newH = $td.outerHeight()
                        
                        if (newH > 30) {
                            $tr.height(newH)
                            $lockTrs.eq(tr_index).height(newH)
                        }
                    })
                }
            }
        }, 20)
        
        that.fixedLockItem(1)
        
        // remove hidden tds
        $lockTrs.find('> td:hidden').remove()
        
        // events
        that.initLockEvents($lockTrs)
    }
    
    // init lockTr Events
    Datagrid.prototype.initLockEvents = function($locktrs) {
        if (!this.$lockTbody) return
        
        var that = this, options = that.options
        
        if (!$locktrs) $locktrs = that.$lockTbody.find('> tr')
        
        $locktrs
            .on('click.bjui.datagrid.tr', function(e) {
                var index = $(this).index(), $td = $(e.target).closest('td')
                
                that.$tbody.find('> tr:eq('+ index +')').trigger('click.bjui.datagrid.tr')
            })
            .on('bjui.datagrid.tr.delete', function(e, index) {
                var $tr = $(this)
                
                if (that.linenumberColumn && that.linenumberColumn.locked) {
                    $tr.nextAll(':not(.'+ that.classnames.tr_child +')').each(function() {
                        var $td = $(this).find('> td.'+ that.classnames.td_linenumber), num = parseInt($td.text(), 10)
                        
                        $td.text(num - 1)
                    })
                }
            })
            .on('mouseenter.bjui.datagrid', function(e) {
                var $tr = $(this), index = $tr.index()
                
                $tr.addClass('datagrid-hover')
                that.$tbody.find('> tr:eq('+ index +')').addClass('datagrid-hover')
            })
            .on('mouseleave.bjui.datagrid', function(e) {
                var $tr = $(this), index = $tr.index()
                
                $tr.removeClass('datagrid-hover')
                that.$tbody.find('> tr:eq('+ index +')').removeClass('datagrid-hover')
            })
        
        //contextmenu
        if (options.contextMenuB) {
            $locktrs.each(function() {
                that.tools.contextmenuB($(this), true)
            })
        }
    }
    
    //api - filterInThead
    Datagrid.prototype.filterInThead = function() {
        var that = this, options = that.options, tools = that.tools, regional = that.regional, columnModel = that.columnModel, filterData = {}
        var $tr = $('<tr class="datagrid-filter"></tr>')
        var onFilter = function($input, model, $th) {
            var type = model.type
            
            if (type === 'date') {
                $input
                    .on('afterchange.bjui.datepicker', function(e, data) {
                        doFilter(model, $input.val())
                    })
                    .change(function() {
                        doFilter(model, $input.val())
                    })
            } else if (type === 'findgrid') {
                $th.on('afterchange.bjui.findgrid', '[data-toggle="findgrid"]', function(e, data) {
                    doFilter(model, data.value)
                })
                
                $input.change(function() {
                    doFilter(model, $input.val())
                })
            } else if (type === 'lookup') {
                $th.on('customEvent.bjui.lookup', '[data-toggle="lookupbtn"]', function(e, args) {
                    for (var key in args) {
                        if (model.name == key) {
                            $input.val(args[key])
                            doFilter(model, args[key])
                        }
                    }
                })
                
                $input.change(function() {
                    doFilter(model, $input.val())
                })
            } else {
                $input.change(function() {
                    doFilter(model, $input.val())
                })
            }
        }
        var doFilter = function(model, val) {
            tools.quickFilter(model, val ? {operatorA:'like', valA:val} : null)
        }
        
        if (!that.inputs || !that.inputs.length) tools.initEditInputs()
        
        $.each(columnModel, function(i, n) {
            var $input = $(that.inputs[i]), $th = $('<th></th>'), attrs = ''
            
            if (!n.quickfilter) {
                $th.appendTo($tr)
                return true
            }
            else if (n.type === 'findgrid') $input.data('context', $tr)
            else if (n.type === 'spinner') $input = $('<input type="text" name="'+ n.name +'">')
            else if (n.type === 'boolean') $input = $(BJUI.doRegional('<select name="'+ n.name +'" data-toggle="selectpicker"><option value="">#all#</option><option value="true">#true#</option><option value="false">#false#</option></select>', regional))
            else if (n.type === 'select') {
                if (n.attrs && typeof n.attrs === 'object') {
                    $.each(n.attrs, function(i, n) {
                        attrs += ' '+ i +'='+ n
                    })
                }
                if ($input.find('> option:first-child').val() && (!n.attrs || !n.attrs.multiple)) {
                    $input = $('<select name="'+ n.name +'" data-toggle="selectpicker"'+ attrs +'></select>')
                        .append(BJUI.doRegional('<option value="">#all#</option>', regional))
                        .append($input.html())
                        
                    $input.val('') // for IE8
                }
            }
            
            $th.append($input)
            
            if (n.hidden) $th.hide()
            if (n.type === 'boolean') $th.attr('align', 'center')
            $th.appendTo($tr)
            
            $input.data('clearFilter', false)
            
            onFilter($input, n, $th)
            
            // events - clear filter
            $input.on('bjui.datagrid.thead.clearfilter', function() {
                $input.val('')
                if (n.type === 'boolean' || n.type === 'select') $input.selectpicker('refresh')
            })
            
            n.$quickfilter = $input
        })
        
        $tr.appendTo(that.$thead).initui()
    }
    
    //api - showhide linenumber column
    Datagrid.prototype.showLinenumber = function(flag) {
        var that = this, options = that.options, model = that.columnModel, numberModel, modelOrder = -1, data = that.data, numberModel_index = $.inArray(that.linenumberColumn, model)
        
        if (numberModel_index != -1)
            numberModel = model[numberModel_index]
        
        if (numberModel) {
            if (typeof flag === 'string' && (flag === 'lock' || flag === 'unlock')) {
                that.colLock(numberModel.th, flag === 'lock' ? true : false)
            } else {
                that.showhideColumn(numberModel.th, flag ? true : false)
            }
        } else if (flag) {
            modelOrder = $.inArray(that.childColumn, model)
            
            modelOrder ++
            numberModel = that.linenumberColumn
            numberModel.index = modelOrder
            model.splice(modelOrder, 0, numberModel)
            
            if (that.inputs && that.inputs.length)
                that.inputs = that.inputs.splice(modelOrder, 0, '')
            
            var $trsH = that.$thead.find('> tr'), col = '<col style="width:30px;">', $th, $filterTr = $trsH.filter('.datagrid-filter'), rowspan = $trsH.length - $filterTr.length
            
            $th = $('<th align="center"'+ (rowspan > 1 ? ' rowspan="'+ rowspan +' "' : '') +'class="'+ that.classnames.td_linenumber + (rowspan == 1 ? ' single-row' : '') +'"><div><div class="datagrid-space"></div><div class="datagrid-label">'+ that.linenumberColumn.label +'</div></div></th>')
            
            that.$colgroupH.find('> col:eq('+ modelOrder +')').before(col)
            that.$colgroupB.find('> col:eq('+ modelOrder +')').before(col)
            that.$colgroupF && that.$colgroupF.find('> col:eq('+ modelOrder +')').before(col)
            $filterTr.length && $filterTr.find('> th:eq('+ modelOrder +')').before('<th></th>')
            $trsH.first().find('> th:eq('+ modelOrder +')').before($th)
            that.$tableF && that.$tableF.find('> thead > tr > th:eq('+ modelOrder +')').before('<th></th>')
            
            numberModel.th    = $th
            numberModel.width = 30
            
            that.$tbody.find('> tr').each(function(i) {
                var $tr = $(this), colspan = that.columnModel.length, linenumber = i, paging = that.paging
                
                if ($tr.hasClass(that.classnames.tr_child) || $tr.hasClass('datagrid-nodata'))
                    $tr.find('> td').attr('colspan', colspan)
                else {
                    linenumber = that.tools.getNoChildDataIndex(linenumber)
                    if (options.linenumberAll)
                        linenumber = ((paging.pageCurrent - 1) * paging.pageSize + (linenumber))
                    
                    $tr.find('> td:eq('+ modelOrder +')').before('<td align="center" class="'+ that.classnames.td_linenumber +'">'+ (linenumber + 1) +'</td>')
                }
            })
            
            that.$tableF && that.$tableF.find('> thead > tr > th:eq('+ modelOrder +')').before('<th></th>')
            
            $.each(model, function(i, n) {
                n.index = i
                if (n.th) n.th.data('index', i)
            })
            
            $th.find('> div').height($th.outerHeight())
            
            if (flag === 'lock') {
                that.colLock($th, true)
            }
            if (that.$showhide) {
                that.$showhide.remove()
                that.colShowhide(options.columnShowhide)
            }
        }
    }
    
    //api - showhide checkbox column
    Datagrid.prototype.showCheckboxcol = function(flag) {
        var that = this, options = that.options, model = that.columnModel, numberModel = model[0], checkModel, modelOrder = -1, checkModel_index = $.inArray(that.checkboxColumn, model)
        
        if (checkModel_index != -1)
            checkModel = that.columnModel[checkModel_index]
        
        if (checkModel) {
            if (typeof flag === 'string' && (flag === 'lock' || flag === 'unlock')) {
                that.colLock(checkModel.th, flag === 'lock' ? true : false)
            } else {
                that.showhideColumn(checkModel.th, flag)
            }
        } else if (flag) {
            modelOrder = $.inArray(that.linenumberColumn, model)
            if (modelOrder == -1)
                modelOrder = $.inArray(that.childColumn, model)
            
            modelOrder ++
            checkModel = that.checkboxColumn
            checkModel.index = modelOrder
            model.splice(modelOrder, 0, checkModel)
            
            if (that.inputs && that.inputs.length)
                that.inputs = that.inputs.splice(modelOrder, 0, '')
                
            var $trsH = that.$thead.find('> tr'), col = '<col style="width:30px;">', $th, $td, $filterTr = $trsH.filter('.datagrid-filter'), rowspan = $trsH.length - $filterTr.length
            
            $th = $('<th align="center"'+ (rowspan > 1 ? ' rowspan="'+ rowspan +' "' : '') +'class="'+ that.classnames.td_checkbox + (rowspan == 1 ? ' single-row' : '') +'"><div><div class="datagrid-space"></div><div class="datagrid-label"><input type="checkbox" data-toggle="icheck"></div></th>')
            
            that.$colgroupH.find('> col:eq('+ modelOrder +')').before(col)
            that.$colgroupB.find('> col:eq('+ modelOrder +')').before(col)
            that.$colgroupF && that.$colgroupF.find('> col:eq('+ modelOrder +')').before(col)
            $filterTr.length && $filterTr.find('> th:eq('+ modelOrder +')').before('<th></th>')
            $trsH.first().find('> th:eq('+ modelOrder +')').before($th)
            that.$tableF && that.$tableF.find('> thead > tr > th:eq('+ modelOrder +')').before('<th></th>')
            $th.initui()
            
            checkModel.th    = $th
            checkModel.width = 30
            
            that.$tbody.find('> tr').each(function(i) {
                var $tr = $(this), colspan = that.columnModel.length
                
                if ($tr.hasClass(that.classnames.tr_child) || $tr.hasClass('datagrid-nodata'))
                    $tr.find('> td').attr('colspan', colspan)
                else {
                    $td = $('<td align="center" class="'+ that.classnames.td_checkbox +'"><input type="checkbox" data-toggle="icheck" name="datagrid.checkbox"></td>')
                    $tr.find('> td:eq('+ modelOrder +')').before($td)
                    $td.initui()
                }
            })
            
            $.each(model, function(i, n) {
                n.index = i
                if (n.th) n.th.data('index', i)
            })
            
            $th.find('> div').height($th.outerHeight())
            
            if (flag === 'lock') {
                that.colLock($th, true)
            }
            if (that.$showhide) {
                that.$showhide.remove()
                that.colShowhide(options.columnShowhide)
            }
        }
    }
    
    //api - showhide checkbox column
    Datagrid.prototype.showEditCol = function(flag) {
        var that = this, options = that.options, model = that.columnModel, editModel = model[model.length - 1], data = that.data
        
        if (editModel === that.editBtnsColumn) {
            that.showhideColumn(editModel.th, flag ? true : false)
        } else if (flag) {
            var $trsH = that.$thead.find('> tr'), col = '<col style="width:110px;">', $th, $td, $filterTr = $trsH.filter('.datagrid-filter'), rowspan = $trsH.length - $filterTr.length
            
            editModel = that.editBtnsColumn
            model.push(editModel)
            
            that.$colgroupH.append(col)
            that.$colgroupB.append(col)
            that.$colgroupF && that.$colgroupF.append(col)
            $th = $('<th align="center" rowspan="'+ rowspan +'">'+ that.editBtnsColumn.label +'</th>')
            $trsH.first().append($th)
            $filterTr.length && $filterTr.append('<th></th>')
            $th.initui().data('index', model.length - 1)
            editModel.th    = $th
            editModel.width = 110
            editModel.index = model.length - 1
            
            that.$tbody.find('> tr').each(function(i) {
                var $tr = $(this), colspan = that.columnModel.length
                
                if ($tr.hasClass(that.classnames.tr_child) || $tr.hasClass('datagrid-nodata'))
                    $tr.find('> td').attr('colspan', colspan)
                else {
                    $td = $('<td align="center" class="'+ that.classnames.s_edit +'">'+ BJUI.doRegional(FRAG.gridEditBtn, that.regional) +'</td>')
                    $tr.append($td)
                    $td.initui()
                }
            })
            
            that.edit(that.$tbody.find('> tr'))
            
            that.$tableF && that.$tableF.find('> thead > tr').append('<th></th>')
            
            if (that.$showhide) {
                that.$showhide.remove()
                that.colShowhide(options.columnShowhide)
            }
        }
    }
    
    //resize
    Datagrid.prototype.colResize = function() {
        var that        = this,
            tools       = that.tools,
            columnModel = that.columnModel,
            $thead      = that.$thead,
            $resizeMark = that.$grid.find('> .resizeProxy')
        
        if (!$resizeMark.length) {
            $resizeMark = $('<div class="resizeProxy" style="left:0; display:none;"></div>')
            $resizeMark.appendTo(that.$grid)
        }
        
        $thead.find('> tr > th').each(function(i) {
            var $th = $(this),  $resize = $th.find('> div > .'+ that.classnames.th_cell +'> .'+ that.classnames.th_resizemark)
            
            $resize.on('mousedown.bjui.datagrid.resize', function(e) {
                var ofLeft = that.$boxH.scrollLeft(), marginLeft = parseInt(that.$boxH.css('marginLeft') || 0, 10), left, index = $th.data('index'), model = columnModel[index], width = model.th.width()
                    , $trs = that.$tbody.find('> tr'), $lockTrs = that.$lockTbody && that.$lockTbody.find('> tr'), lockH = that.$lockTableB && that.$lockTableB.height(), H = that.$tableB.height(), lockH_new, H_new
                
                if (isNaN(marginLeft)) marginLeft = 0
                left = tools.getRight($th) - ofLeft + marginLeft
                
                that.isResize = true
                
                if (model.locked) {
                    left = tools.getRight4Lock(model.lockIndex)
                    if (model.lockWidth) width = model.lockWidth
                }
                
                $resizeMark
                    .show()
                    .css({
                        left   : left,
                        bottom : (that.$boxP ? that.$boxP.outerHeight() : 0),
                        cursor : 'col-resize'
                    })
                    .basedrag({
                        scop  : true, cellMinW:20, relObj:$resizeMark,
                        move  : 'horizontal',
                        event : e,
                        stop  : function() {
                            var new_left = $resizeMark.position().left,
                                move     = new_left - left,
                                newWidth = move + width,
                                tableW   = that.$tableH.width() + move,
                                lockW    = that.$lockTableH && that.$lockTableH.width() + move
                            
                            if (newWidth < 5) newWidth = 20
                            if (model.minWidth && newWidth < model.minWidth) newWidth = model.minWidth
                            if (newWidth != width + move) {
                                tableW   = tableW - move + (newWidth - width)
                                lockW    = lockW - move + (newWidth - width)
                            }
                            
                            model.width = newWidth
                            
                            if (model.locked) {
                                if (lockW < (that.$grid.width() * 0.75)) {
                                    model.lockWidth = newWidth
                                    that.$lockColgroupH.find('> col:eq('+ index +')').width(newWidth)
                                    that.$lockColgroupB.find('> col:eq('+ index +')').width(newWidth)
                                    that.$lockColgroupF && that.$lockColgroupF.find('> col:eq('+ index +')').width(newWidth)
                                    
                                    that.$lockTableH.width(lockW)
                                    that.$lockTableB.width(lockW)
                                    that.$lockTableF && that.$lockTableF.width(lockW)
                                    
                                    var margin = that.$lockBox.width()
                                    
                                    that.$boxH.css('margin-left', margin - 1)
                                    that.$boxB.css('margin-left', margin - 1)
                                    that.$boxH.find('> div').width(that.$boxH.width())
                                    that.$boxB.find('> div').width(that.$boxH.width())
                                    that.$boxF && that.$boxF.css('margin-left', margin - 1)
                                    
                                    that.$colgroupH.find('> col:eq('+ index +')').width(newWidth)
                                    that.$colgroupB.find('> col:eq('+ index +')').width(newWidth)
                                    that.$colgroupF && that.$colgroupF.find('> col:eq('+ index +')').width(newWidth)
                                }
                            } else {
                                setTimeout(function() {
                                    that.$colgroupH.find('> col:eq('+ index +')').width(newWidth)
                                    that.$colgroupB.find('> col:eq('+ index +')').width(newWidth)
                                    that.$colgroupF && that.$colgroupF.find('> col:eq('+ index +')').width(newWidth)
                                }, 1) //setTimeout for chrome
                            }
                            
                            /* fixed height */
                            setTimeout(function() {
                                $trs.css('height', '')
                                H_new = that.$tableB.height()
                                
                                if (that.$lockTbody) {
                                    $lockTrs.css('height', '')
                                    lockH_new = that.$lockTableB.height()
                                    if (lockH_new != lockH || H_new != H) {
                                        if (lockH_new > H_new) {
                                            $lockTrs.each(function(tr_index) {
                                                var $lockTr = $(this), $lockTd = $lockTr.find('> td:eq('+ model.lockIndex +')'), newH = $lockTd.outerHeight()
                                                
                                                if (newH > 30) {
                                                    $lockTr.height(newH)
                                                    $trs.eq(tr_index).height(newH)
                                                }
                                            })
                                        } else {
                                            $trs.each(function(tr_index) {
                                                var $tr = $(this), $td = $tr.find('> td:eq('+ index +')'), newH = $td.outerHeight()
                                                
                                                if (newH > 30) {
                                                    $tr.height(newH)
                                                    $lockTrs.eq(tr_index).height(newH)
                                                }
                                            })
                                        }
                                    }
                                    
                                    that.$lockB.height(that.$boxB[0].clientHeight)
                                }
                                
                                if (model.calc) that.$tfoot && that.$tfoot.trigger('bjui.datagrid.tfoot.resizeH')
                                
                                that.isResize = false
                            }, 10)
                            
                            $resizeMark.hide()
                            that.resizeFlag = true
                        }
                    })
            })
        })
    }
    
    //column - add menu button
    Datagrid.prototype.colMenu = function() {
        var that = this, options = that.options, tools = that.tools, regional = that.regional, $ths = that.$trsH.find('> th.'+ that.classnames.th_menu), $menu = that.$grid.find('> .'+ that.classnames.s_menu)
        
        if (!$menu.legnth) {
            $menu = $(BJUI.doRegional(FRAG.gridMenu, regional))
            $menu.hide().appendTo(that.$grid)
            that.$menu = $menu
        }
        that.colShowhide(options.columnShowhide)
        
        $ths.each(function() {
            var $th     = $(this),
                index   = $th.data('index'),
                model   = that.columnModel[index],
                $cell   = $th.find('> div > .'+ that.classnames.th_cell),
                $btnBox = $cell.find('> .'+ that.classnames.btn_menu),
                $btn
            
            if (!$btnBox.length) {
                $btn    = $('<button type="button" class="btn btn-default"><i class="fa fa-bars"></button>'),
                $btnBox = $('<div class="'+ that.classnames.btn_menu +'"></div>').append($btn)
                
                $btnBox.appendTo($cell)
                
                $btn.click(function() {
                    var $tr = $th.closest('tr'), rowspan = parseInt(($th.attr('rowspan') || 1), 10), left = $(this).offset().left - that.$grid.offset().left - 1, top = (that.$trsH.length - rowspan) * 25 + (13 * rowspan) + 11, $showhide = $menu.find('> ul > li.datagrid-li-showhide'), menu_width, submenu_width 
                    var $otherBtn = $menu.data('bjui.datagrid.menu.btn')
                    
                    if ($otherBtn && $otherBtn.length) $otherBtn.removeClass('active')
                    $(this).addClass('active')
                    if ($showhide.length && that.$showhide) {
                        that.$showhide.appendTo($showhide)
                        submenu_width = that.$showhide.data('width')
                    }
                    $menu
                        .css({'position':'absolute', 'top':top, left:left})
                        .show()
                        .data('bjui.datagrid.menu.btn', $btn)
                        .siblings('.'+ that.classnames.s_menu).hide()
                    
                    menu_width = $menu.outerWidth()
                    
                    var position = function(left) {
                        if (that.$boxH.width() - left < menu_width) {
                            $menu.css({left:left - menu_width + 18}).addClass('position-right')
                        } else {
                            $menu.css({left:left}).removeClass('position-right')
                        }
                    }
                    var fixedLeft = function($btn) {
                        that.$boxB.scroll(function() {
                            var left = $btn.offset().left - that.$grid.offset().left - 1
                            
                            position(left)
                        })
                    }
                    
                    position(left)
                    fixedLeft($btn)
                    
                    if (options.columnFilter) that.colFilter($th)
                    else $menu.find('> ul > li.'+ that.classnames.li_filter).hide()
                    
                    tools.locking($th)
                    
                    // quick sort
                    var $asc  = $menu.find('> ul > li.'+ that.classnames.li_asc),
                        $desc = $asc.next()
                    
                    $asc.click(function() {
                        model.sortAsc = false
                        tools.quickSort(model)
                    })
                    
                    $desc.click(function() {
                        model.sortAsc = true
                        tools.quickSort(model)
                    })
                    
                    $menu.on('bjui.datagrid.th.sort', function(e, asc) {
                        $asc.toggleClass('sort-active', asc)
                        $desc.toggleClass('sort-active', !asc)
                    })
                })
            }
        })
        
        /* hide filterbox */
        that.$grid.on('click.bjui.datagrid.filter', function(e) {
            var $target = $(e.target), $menu = that.$grid.find('.'+ that.classnames.s_menu +':visible')
            
            if ($menu.length && !$target.closest('.'+ that.classnames.btn_menu).length) {
                if (!$target.closest('.'+ that.classnames.s_menu).length) {
                    $menu.hide().data('bjui.datagrid.menu.btn').removeClass('active')
                }
            }
        })
    }
    
    // show or hide columns on btn menu
    Datagrid.prototype.colShowhide = function(showFlag) {
        var that = this, options = that.options, tools = that.tools, $menu = that.$menu, $ul = $menu.find('> ul'), $showhideli = $ul.find('> li.'+ that.classnames.li_showhide)
        
        if (showFlag) {
            if (!that.$showhide) {
                tools.createShowhide()
                tools.showSubMenu($showhideli, $menu, that.$showhide)
            }
        } else {
            $showhideli.hide()
        }
    }
    
    // api - show or hide column
    Datagrid.prototype.showhideColumn = function(column, showFlag) {
        var that = this, tools = that.tools, index, model
        
        if ($.type(column) === 'number') {
            index = parseInt(column, 10)
            if (index < 0) return
        } else {
            index = column.data('index')
        }
        
        model = that.columnModel[index]
        
        if (model) {
            if (model.locked) {
                if (showFlag) return
                else that.colLock(model.th, showFlag)
            }
            tools.showhide(model, showFlag)
        }
    }
    
    // filter
    Datagrid.prototype.colFilter = function($th, filterFlag) {
        var that  = this, options = that.options, tools = that.tools, regional = that.regional, $filter = $th.data('bjui.datagrid.filter'), $menu = that.$menu, $filterli = $menu.find('> ul > li.'+ that.classnames.li_filter)
        var model = that.columnModel[$th.data('index')]
        
        if (!that.inputs || !that.inputs.length) tools.initEditInputs()
        if (model.quickfilter) {
            $filterli.find('.'+ that.classnames.s_filter).addClass('hide')
            
            if (!$filter || !$filter.length) {
                $filter = $(BJUI.doRegional(FRAG.gridFilter.replaceAll('#label#', $th.text()), regional)).hide().appendTo(that.$grid)
                
                var index = $th.data('index'), model = that.columnModel[index], type = model.type || 'string', operator = model.operator || [],
                    $filterA = $filter.find('span.filter-a'),
                    $filterB = $filter.find('span.filter-b'),
                    $select  = $('<select data-toggle="selectpicker" data-container="true"></select>'),
                    $input   = $(that.inputs[index]),
                    $valA, $valB
                
                $input.removeAttr('data-rule').attr('size', 10).addClass('filter-input')
                
                if (type === 'string' || type === 'lookup' || type === 'findgrid') {
                    if (!operator.length) operator = ['=', '!=', 'like']
                    if (type === 'findgrid') {
                        $input.data('context', $filter)
                    }
                } else if (type === 'number' || type === 'int' || type === 'spinner') {
                    if (type === 'spinner') $input.removeAttr('data-toggle')
                    if (!operator.length) operator = ['=', '!=', '>', '<', '>=', '<=']
                } else if (type === 'date') {
                    if (!operator.length) operator = ['=', '!=']
                } else if (type === 'boolean') {
                    if (!operator.length) operator = ['=', '!=']
                    $input = $(BJUI.doRegional('<select name="'+ model.name +'" data-toggle="selectpicker"><option value="">#all#</option><option value="true">#true#</option><option value="false">#false#</option></select>', regional))
                } else if (type === 'select') {
                    if (!operator.length) operator = ['=', '!=']
                    $input.attr('data-width', '80')
                    if ($input.find('> option:first-child').val()) {
                        $input = $('<select name="'+ model.name +'" data-toggle="selectpicker" data-width="80"></select>')
                            .append(BJUI.doRegional('<option value="">#all#</option>', regional))
                            .append($input.html())
                    }
                }
                
                for (var i = 0, l = operator.length; i < l; i++) {
                    $select.append('<option value="'+ (operator[i]) +'">'+ (operator[i]) +'</option>')
                }
                
                $valA = $input
                $valB = $valA.clone()
                
                $filterA.append($select).append($input)
                $filterB.append($select.clone()).append($valB)
                
                $th.data('bjui.datagrid.filter', $filter)
                
                $filter.appendTo($filterli)
                $filter.data('width', $filter.outerWidth()).hide().initui()
                
                // lookup - events
                $filter.on('customEvent.bjui.lookup', '[data-toggle="lookupbtn"]', function(e, args) {
                    for (var key in args) {
                        if (model.name == key) {
                            $input.val(args[key])
                        }
                    }
                })
                
                /* events */
                var $ok      = $filter.find('button.ok'),
                    $clear   = $filter.find('button.clear'),
                    $selects = $filter.find('select'),
                    $selA    = $selects.first(),
                    $selB    = $selects.last(),
                    $andOr   = $selects.eq(1)
                    
                $ok.click(function() {
                    var operatorA = $selA.val(), valA = $valA.val().trim(), operatorB = $selB.val(), valB = $valB.val().trim(), andor = $andOr.val()
                    var filterDatas = {}
                    
                    if (valA.length) {
                        $.extend(filterDatas, {operatorA:operatorA, valA:valA})
                    }
                    if (valB.length) {
                        if (valA.length) $.extend(filterDatas, {andor:andor})
                        $.extend(filterDatas, {operatorB:operatorB, valB:valB})
                    }
                    if (!$.isEmptyObject(filterDatas)) {
                        tools.quickFilter(that.columnModel[$th.data('index')], filterDatas)
                        that.$grid.trigger('click')
                        $filterli.trigger('bjui.datagrid.th.submenu.hide', [$menu, $filter])
                    }
                })
                
                $clear.click(function() {
                    var model = that.columnModel[$th.data('index')]
                    
                    $selects.find('> option:first').prop('selected', true)
                    $selects.selectpicker('refresh')
                    $valA.val('')
                    $valB.val('')
                    if (model.isFiltered) {
                        tools.quickFilter(model, null)
                        that.$grid.trigger('click')
                        $filterli.trigger('bjui.datagrid.th.submenu.hide', [$menu, $filter])
                    }
                })
            }
            
            tools.showSubMenu($filterli, $menu, $filter.removeClass('hide'))
            
            $menu.find('> ul > li:not(".'+ that.classnames.li_filter +'")').on('mouseover', function() {
                if ($filterli.hasClass('active'))
                    $filterli.trigger('bjui.datagrid.th.submenu.hide', [$menu, $filter])
            })
        } else {
            $filterli.hide()
        }
    }
    
    // paging
    Datagrid.prototype.initPaging = function() {
        var that = this, tools = that.tools, options = that.options, paging = that.paging, pr = BJUI.regional.pagination, btnpaging = FRAG.gridPaging, pageNums = [], pageCount = paging.pageCount, interval, selectPages = [], pagingHtml = BJUI.StrBuilder()
        
        interval = tools.getPageInterval(pageCount, paging.pageCurrent, paging.showPagenum)
        
        for (var i = interval.start; i < interval.end; i++) {
            pageNums.push(FRAG.gridPageNum.replace('#num#', i).replace('#active#', (paging.pageCurrent == i ? ' active' : '')))
        }
        
        btnpaging = BJUI.doRegional(btnpaging.replaceAll('#pageCurrent#', paging.pageCurrent).replaceAll('#count#', paging.total +'/'+ parseInt((pageCount || 0), 10)), pr)
        
        pagingHtml
            .add('<div class="paging-content" style="width:'+ that.$boxB.width() +'px;">')
            .add('<div class="datagrid-pagesize"><button type="button" class="btn-default btn-refresh" title="'+ pr.refresh +'" data-icon="refresh"></button>')
            .add('<select data-toggle="selectpicker"></select>')
            .add('</div>')
            .add('<div class="datagrid-paging">')
            .add(btnpaging.replace('#pageNumFrag#', pageNums.join('')))
            .add('</div>')
            .add('</div>')
        
        that.$boxP.html(pagingHtml.toString())
        that.$boxP.initui()
        
        //events
        var $select    = that.$boxP.find('div.datagrid-pagesize > select'),
            $pagenum   = that.$boxP.find('ul.pagination'),
            $pagetotal = $pagenum.find('> li.page-total'),
            $jumpto    = $pagetotal.next(),
            $first     = $jumpto.next(),
            $prev      = $first.next(),
            $next      = $prev.nextAll('.page-next'),
            $last      = $next.next()
        
        var disablePrev = function() {
            $first.addClass('disabled')
            $prev.addClass('disabled')
        }
        var enablePrev = function() {
            $first.removeClass('disabled')
            $prev.removeClass('disabled')
        }
        var disableNext = function() {
            $next.addClass('disabled')
            $last.addClass('disabled')
        }
        var enableNext = function() {
            $next.removeClass('disabled')
            $last.removeClass('disabled')
        }
        var pageFirst = function() {
            disablePrev()
            enableNext()
        }
        var pageLast = function() {
            enablePrev()
            disableNext()
        }
        var setPageSize = function(pageSize) {
            $select.empty()
            
            if (!pageSize) pageSize = that.paging.pageSize
            
            selectPages = paging.selectPageSize.split(',')
            selectPages.push(String(pageSize))
            
            $.unique(selectPages).sort(function(a, b) { return a - b })
            
            var opts = []
            
            $.each(selectPages, function(i, n) {
                opts.push('<option value="'+ n +'"'+ (n == paging.pageSize && 'selected') +'>'+ n +'/'+ pr.page +'</option>')
            })
            
            $select.html(opts.join('')).selectpicker('refresh')
        }
        
        if (paging.pageCurrent == 1) pageFirst()
        if (paging.pageCurrent == paging.pageCount) {
            pageLast()
            if (paging.pageCurrent == 1) disablePrev()
        }
        if (!paging.total) disableNext()
        setPageSize()
        
        that.$boxP.on('click.datagrid.pagenum', 'li.page-num', function(e) {
            var $num = $(this)
            
            if (!$num.hasClass('active')) {
                that.jumpPage($num.text())
            }
            
            e.preventDefault()
        }).on('click.datagrid.refresh', 'button.btn-refresh', function() {
            that.refresh()
        }).on('bjui.datagrid.paging.jump', function(e) {
            var pageCurrent = that.paging.pageCurrent, interval = tools.getPageInterval(that.paging.pageCount, pageCurrent, paging.showPagenum), pageNums = []
            
            for (var i = interval.start; i < interval.end; i++) {
                pageNums.push(FRAG.gridPageNum.replace('#num#', i).replace('#active#', (pageCurrent == i ? ' active' : '')))
            }
            
            $pagenum.find('> li.page-num').remove()
            $prev.after(pageNums.join(''))
            
            if (pageCurrent == 1) {
                pageFirst()
                if (pageCurrent == that.paging.pageCount) disableNext()
                if (!that.paging.total) disableNext()
            } else if (pageCurrent == that.paging.pageCount) {
                pageLast()
            } else {
                enablePrev()
                enableNext()
            }
            
            $jumpto.find('input').val(pageCurrent)
            $pagetotal.find('> span').html(that.paging.total +'/'+ that.paging.pageCount)
        }).on('bjui.datagrid.paging.pageSize', function(e, pageSize) {
            setPageSize(pageSize)
        }).on('change', 'div.datagrid-pagesize > select', function() {
            var pageSize = $(this).val()
            
            that.jumpPage(null, pageSize)
        })
        
        $jumpto.find('input').on('keyup', function(e) {
            if (e.which === BJUI.keyCode.ENTER) {
                var page = $(this).val()
                
                if (page) that.jumpPage(page)
            }
        })
        
        $first.on('click', function() {
            if (that.paging.pageCurrent > 1) 
                that.jumpPage(1)
        })
        
        $prev.on('click', function() {
            if (that.paging.pageCurrent > 1)
                that.jumpPage(that.paging.pageCurrent - 1)
        })
        
        $next.on('click', function() {
            if (that.paging.pageCurrent < that.paging.pageCount)
                that.jumpPage(that.paging.pageCurrent + 1)
        })
        
        $last.on('click', function() {
            if (that.paging.pageCurrent < that.paging.pageCount)
                that.jumpPage(that.paging.pageCount)
        })
    }
    
    Datagrid.prototype.jumpPage = function(pageCurrent, pageSize) {
        var that = this, paging = that.paging, pageCount = paging.pageCount
        
        if (pageCurrent && isNaN(pageCurrent)) return
        if (pageSize && isNaN(pageSize))       return
        if (pageCurrent) {
            pageCurrent = parseInt(pageCurrent, 10)
            
            if (pageCurrent < 1)         pageCurrent = 1
            if (pageCurrent > pageCount) pageCurrent = pageCount
            if (pageCurrent == paging.pageCurrent) return
        }
        if (pageSize) {
            pageSize = parseInt(pageSize, 10)
            
            if (that.options.local != 'remote') {
                if (paging.pageSize > paging.total) return
            }
        }
        
        that.tools.jumpPage(pageCurrent, pageSize)
    }
    
    // api - add
    Datagrid.prototype.add = function(addLocation, addData) {
        if (!this.tools.beforeEdit()) return
        
        if (!this.options.editUrl) {
            BJUI.debug('Datagrid Plugin: Edit url is not set!')
            return
        }
        
        if (!this.options.editMode) return
        if (!this.options.inlineEditMult) {
            this.doCancelEditRow(this.$tbody.find('> tr.'+ this.classnames.tr_edit))
        } else if (this.options.editMode != 'inline' && this.$tbody.find('> tr.'+ this.classnames.tr_add).length) {
            return
        }
        
        var that = this, options = that.options, tools = that.tools, paging = that.paging, trs, obj = {}, data = [], addObj, startNumber = (paging.pageCurrent - 1) * paging.pageSize, linenumber
        
        var addTr = function(linenumber) {
            var $tr = $('<tr></tr>').addClass(that.classnames.tr_add), $lockTr = $tr.clone()
            
            $.each(that.columnModel, function(i, n) {
                var label = '', $td = $('<td></td>')
                
                if (n.gridChild)
                    $td.addClass(that.classnames.td_child).html('<div>'+ BJUI.doRegional(FRAG.gridExpandBtn, that.regional) +'</div>')
                else if (n.gridNumber)
                    $td.addClass(that.classnames.td_linenumber).text(0)
                else if (n.gridCheckbox)
                    $td.addClass(that.classnames.td_checkbox).html('<div><input type="checkbox" data-toggle="icheck" name="datagrid.checkbox" value="true"></div>')
                else if (n.gridEdit)
                    $td.addClass(that.classnames.s_edit).data('isAdd', true).html(BJUI.doRegional(FRAG.gridEditBtn, that.regional))
                else $td.text('')
                
                if (n.hidden) $td.css('display', 'none')
                if (n.align)  $td.attr('align', n.align)
                
                if (n.name) obj[n.name] = ''
                
                if (n.locked) {
                    if (n.gridCheckbox) {
                        $td.clone().hide().appendTo($tr)
                        $td.show().appendTo($lockTr)
                    } else {
                        $td.clone().show().appendTo($lockTr)
                        $td.hide().appendTo($tr)
                    }
                } else {
                    $td.appendTo($tr)
                }
            })
            
            if (addData && typeof addData === 'object')
                $tr.data('datagrid.addData', addData)
            
            obj = $.extend({}, that.attach, obj)
            if (!that.emptyData) that.emptyData = obj
            
            return {tr:$tr, lockTr:$lockTr.find('> td').length ? $lockTr : null}
        }
        
        if (!addLocation) addLocation = options.addLocation || 'first'
        
        if (!that.$lastSelect) {
            if (addLocation === 'prev') addLocation = 'first'
            else if (addLocation === 'next') addLocation = 'last'
        }
        
        if (addLocation === 'first') {
            linenumber = 0
            trs = addTr(linenumber)
            trs.tr.prependTo(that.$tbody)
            if (trs.lockTr) trs.lockTr.prependTo(that.$lockTbody)
        } else if (addLocation === 'last') {
            linenumber = that.data ? that.data.length : 0
            trs = addTr(linenumber)
            trs.tr.appendTo(that.$tbody)
            if (trs.lockTr) trs.lockTr.appendTo(that.$lockTbody)
        } else if (addLocation === 'prev') {
            linenumber = that.$lastSelect.index()
            trs = addTr(linenumber)
            trs.tr.insertBefore(that.$lastSelect)
            if (trs.lockTr) trs.lockTr.insertBefore(that.$lockTbody.find('> tr:eq('+ that.$lastSelect.index() +')'))
        } else if (addLocation === 'next') {
            linenumber = that.$lastSelect.index() + 1
            trs = addTr(linenumber)
            trs.tr.insertAfter(that.$lastSelect)
            if (trs.lockTr) trs.lockTr.insertAfter(that.$lockTbody.find('> tr:eq('+ that.$lastSelect.index() +')'))
        }
        
        var addData = $.extend({}, that.emptyData, {addFlag:true})
        
        if (!that.data) that.data = []
        if (!that.allData) that.allData = []
        if (that.allData.length) {
            that.allData.splice(linenumber + startNumber, 0, addData)
        } else {
            that.allData.push(addData)
        }
        
        if (that.data.length) {
            that.data.splice(linenumber, 0, addData)
        } else {
            that.data.push(addData)
        }
        
        $.each(that.data, function(i, data) {
            var linenumber = options.linenumberAll ? (startNumber + (i + 1)) : (i + 1)
            
            $.extend(data, {gridNumber:linenumber, gridIndex:i})
        })
        
        trs.tr.initui()
        trs.lockTr && trs.lockTr.initui()
        
        if (options.showNoDataTip)
            that.$tbody.find('> tr.datagrid-nodata').remove()
        if (options.height === 'auto')
            that.fixedHeight()
        
        setTimeout(function() {
            that.initEvents(trs.tr)
        }, 20)
        
        if (trs.lockTr) that.initLockEvents(trs.lockTr)
        that.edit(trs.tr)
        
        if (options.hasChild && options.childOptions)
            trs.tr.after('<tr class="'+ that.classnames.tr_child +'"></tr>')
        
        if (options.editMode != 'dialog') {
            that.doEditRow(trs.tr, 'inline', true)
        } else {
            that.dialogEdit(trs.tr, true)
        }
    }
    
    // edit
    Datagrid.prototype.edit = function($trs) {
        var that = this, options = that.options, tools = that.tools, type = options.editMode, columnModel = that.columnModel, $editTd
        
        that.editInit = false
        
        if (!type) return
        if (typeof type === 'object') {
            var editOptions = {}, types = ['dialog', 'navtab', 'div'], editFlag = false
            
            that.editOptions = null
            
            for (var key in type) {
                if ($.inArray(key, types) != -1) {
                    editOptions.type    = key
                    editOptions.options = type[key]
                    
                    editFlag = true
                    
                    break
                }
            }
            
            if (!editFlag) {
                BJUI.debug('Dialog Plugn: The options \'editModel\' set error!')
                return
            }
            
            if (!$.isEmptyObject(editOptions))
                that.editOptions = editOptions
            
        } else {
            if (that.options.editUrl)
                that.options.editUrl = that.options.editUrl.replace(/{\/?[^}]*}/g, '')
            
            if (type != 'dialog')
                type = 'inline'
        }
        
        if (!$trs) $trs = that.$tbody.find('> tr')
        
        $editTd = $trs.find('> td.'+ that.classnames.s_edit)
        
        that.editInit = true
        
        /* events */
        $editTd.each(function() {
            var $td = $(this), $btns = $td.find('button'), $edit = $btns.first(), $update = $edit.next(), $save = $update.next(), $cancel = $save.next(), $delete = $cancel.next()
            
            $edit.on('click', function(e, data) {
                var $btn = $(this), $tr = $btn.closest('tr'), data_index = $tr.index(), isAdd = $td.data('isAdd')
                
                data_index = that.tools.getNoChildDataIndex(data_index)
                
                if (!data) {
                    if (that.isDom) data = $tr.data('initData') || tools.setDomData($tr)
                    else data = that.data[data_index]
                }
                if (!tools.beforeEdit($tr, data)) {
                    return false
                }
                if (that.editOptions) {
                    that.externalEdit($tr, null, data)
                    return false
                }
                if (type != 'dialog') {
                    that.inlineEdit($tr, isAdd)
                    
                    $btns.hide()
                    $update.show()
                    $cancel.show()
                    
                    if (isAdd) {
                        $update.hide()
                        $save.show()
                    }
                } else {
                    that.dialogEdit($tr, isAdd)
                }
                
                e.stopPropagation()
            })
            
            $save.on('click', function(e) {
                var $btn = $(this), $tr = $btn.closest('tr')
                
                that.updateEdit($tr, $btn)
                
                e.stopPropagation()
            }).on('bjui.datagrid.update.tr', function() {
                $btns.hide()
                $edit.show()
                $delete.show()
            })
            
            $update.on('click', function(e) {
                var $btn = $(this), $tr = $btn.closest('tr')
                
                that.updateEdit($tr, $btn)
                
                e.stopPropagation()
            }).on('bjui.datagrid.update.tr', function() {
                $btns.hide()
                $edit.show()
                $delete.show()
            })
            
            $cancel.on('click', function(e) {
                var $btn = $(this), $tr = $btn.closest('tr')
                
                that.cancelEdit($tr)
                
                $btns.hide()
                $edit.show()
                $delete.show()
                
                e.stopPropagation()
            })
            
            $delete.on('click', function(e) {
                var $btn = $(this), $tr = $btn.closest('tr')
                
                that.delRows($tr)
                
                e.stopPropagation()
            })
        })
    }
    
    Datagrid.prototype.externalEdit = function(row, editOpts, data) {
        var that = this, options = that.options, editOptions = {}, $tr, data_index, editUrl, type, types = ['dialog', 'navtab', 'div']
        
        if (editOpts && typeof editOpts === 'object') {
            for (var key in editOpts) {
                if ($.inArray(key, types) != -1) {
                    editOptions.type    = key
                    editOptions.options = editOpts[key]
                    
                    break
                }
            }
        } else
            editOptions = $.extend({}, that.editOptions) 
        
        if (row instanceof jQuery) {
            $tr = row
        } else if (!isNaN(row)) {
            $tr = that.$tbody.find('> tr:not(.'+ that.classnames.tr_child +')').eq(parseInt(row, 10))
        } else {
            BJUI.debug('Datagrid Plugin: Func \'externalEdit\', Parameter \'row\' is incorrect!')
            return
        }
        
        if (typeof editOptions === 'undefined') {
            BJUI.debug('Datagrid Plugin: Func \'externalEdit\', Parameter \'editOptions\' is incorrect!')
            return
        }
        
        if (editOptions) {
            if (!data) {
                if (that.isDom) data = $tr.data('initData') || that.tools.setDomData($tr)
                else {
                    data_index = that.tools.getNoChildDataIndex($tr.index())
                    data = that.data[data_index]
                }
            }
            if (!editOptions.options.url || editOptions.options['datagrid.nourl']) {
                editOptions.options['datagrid.nourl'] = true
                editOptions.options.url = options.editUrl
            }
            
            editUrl = editOptions.options.url
            
            if (editUrl && !editUrl.isFinishedTm()) {
                if (!data || data.addFlag)
                    editUrl = editUrl.replace(/{\/?[^}]*}/g, '')
                else
                    editUrl = that.tools.replacePlh(editUrl, data)
                
                if (!editUrl.isFinishedTm()) {
                    BJUI.debug('Datagrid Plugin: Func \'externalEdit\', the property \'url\' of options \'editOptions\' is incorrect: '+ editUrl)
                } else {
                    editUrl = editUrl
                }
            }
            
            if (editUrl) {
                editOptions.options.url = editUrl
                type = editOptions.type
                
                if ($tr.data('datagrid.addData')) {
                    if (editOptions.options.data)
                        $.extend(editOptions.options.data, $tr.data('datagrid.addData'))
                    else
                        editOptions.options.data = $tr.data('datagrid.addData')
                }
                
                if (!editOptions.options.id)
                    editOptions.options.id = 'datagrid-external-edit'+ (new Date().getTime())
                
                // for dialog && navtab (if not save)
                editOptions.options.onClose = function() {
                    if ($tr.hasClass(that.classnames.tr_add))
                        that.cancelEdit($tr)
                }
                
                var okCallback = function(json) {
                    var complete = false, returnData
                    
                    if ($.type(json) === 'array') {
                        complete   = true
                        returnData = json[0]
                    } else if (typeof json === 'object') {
                        complete = true
                        returnData = json
                    }
                    
                    if (complete) {
                        $.extend(data, typeof returnData === 'object' && returnData)
                        
                        // if add to the empty grid
                        if ($tr.hasClass(that.classnames.tr_add) && $tr.length === that.$tbody.find('> tr:not(.'+ that.classnames.tr_child +')').length && that.fixtedColumnWidthCount) {
                            that.fixedColumnWidth = true
                        }
                        
                        if (data.addFlag) data.addFlag = false
                        
                        that.dialogEditComplete($tr, data)
                        
                        if (type === 'dialog')
                            BJUI.dialog('close', editOptions.options.id)
                        else if (type === 'navtab')
                            BJUI.navtab('closeTab', editOptions.options.id)
                            
                        that.tools.afterSave($tr, data)
                        
                        // refresh child
                        if (data['refresh.datagrid.child']) {
                            var $child = $tr.data('bjui.datagrid.child')
                            
                            if ($child && $child.length)
                                $child.datagrid('refresh')
                            else
                                that.showChild($tr)
                        }
                    }
                }
                
                editOptions.options.onLoad = function($box) {
                    var $form = $box.find('form.datagrid-edit-form')
                    
                    if ($form && $form.length) {
                        $form = $form.first()
                        
                        $form
                            .removeAttr('okCallback')
                            .data('okCallback', $.proxy(okCallback, that))
                    }
                }
                
                if (type === 'dialog')
                    BJUI.dialog(editOptions.options)
                else if (type === 'navtab')
                    BJUI.navtab(editOptions.options)
                else if (type === 'div')
                    BJUI.ajax('doload', editOptions.options)
                
            }
        }
    }
    
    // Api - inline edit tr
    Datagrid.prototype.doEditRow = function(rows, type, isAdd) {
        if (!this.editInit) return
        
        var that = this, $trs, $editBtn, datas = []
        
        type = type || that.options.editMode
        
        if (typeof rows === 'object') {
            $trs = rows
        } else if (isNaN(rows)) {
            var $myTrs = that.$tbody.find('> tr:not(.'+ that.classnames.tr_child +')'), $editTrs, rows = rows.split(',')
            
            rows = rows.unique()
            rows.sort(function(a, b) {return a.trim() - b.trim()})
            
            $.each(rows, function(i, n) {
                var row = parseInt(n.trim(), 10), tr
                
                tr = $myTrs.eq(row)
                
                if (tr && tr.length) {
                    if (!$editTrs) $editTrs = tr
                    else $editTrs = $editTrs.add(tr)
                }
            })
            
            $trs = $editTrs
        } else if (!isNaN(rows)) {
            $trs = that.$tbody.find('> tr:not(.'+ that.classnames.tr_child +')').eq(rows)
        }
        
        if (!$trs.length) return
        
        $trs.each(function() {
            var $tr = $(this), data_index = $tr.index(), data
            
            data_index = that.tools.getNoChildDataIndex(data_index)
            
            if (that.isDom) data = $tr.data('initData') || tools.setDomData($tr)
            else data = that.data[data_index]
            
            datas.push(data)
        })
        
        if (!that.tools.beforeEdit($trs, datas)) {
            return
        }
        
        if (!that.options.editUrl) {
            BJUI.debug('Datagrid Plugin: Edit url is not set!')
            return
        }
        
        if (that.editOptions) {
            that.externalEdit($trs.last(), null, datas[$trs.length - 1])
        } else {
            $trs.each(function(i) {
                var $tr = $(this)
                
                $editBtn = $tr.find('> td.'+ that.classnames.s_edit +' button.edit')
                
                if (type != 'dialog') {
                    if ($editBtn.length) $editBtn.trigger('click', [datas[i]])
                    else that.inlineEdit($tr, isAdd, datas[i])
                } else {
                    that.dialogEdit($tr, isAdd, datas[i])
                    return false
                }
            })
        }
    }
    
    // Api - cancel edit
    Datagrid.prototype.doCancelEditRow = function(row) {
        var that = this, $trs
        
        if ($.type(row) === 'number') {
            $trs = this.$tbody.find('> tr').eq(row)
        } else {
            $trs = row
        }
        
        $trs.each(function() {
            var $tr = $(this), $cancelBtn = $tr.find('> td.'+ that.classnames.s_edit +' > button.cancel')
            
            if ($cancelBtn.length) {
                $cancelBtn.trigger('click')
            } else {
                that.cancelEdit($tr)
            }
        })
    }
    
    // Api - save edit tr
    Datagrid.prototype.doSaveEditRow = function(row) {
        var that = this, options = that.options, $tr
        
        if ($.type(row) === 'number') {
            $tr = this.$tbody.find('> tr').eq(row)
        } else if (row) {
            $tr = row
        } else {
            $tr = that.$tbody.find('> tr.'+ that.classnames.tr_edit)
        }
        
        if (!$tr.length) {
            that.$grid.alertmsg('info', BJUI.getRegional('datagrid.saveMsg'))
            return
        }
        if ($tr.length == 1) {
            if ($tr.hasClass(that.classnames.tr_edit))
                this.updateEdit($tr)
        } else {
            if (options.saveAll) {
                that.saveAll($tr)
            } else {
                $tr.each(function() {
                    that.updateEdit($(this))
                })
            }
        }
    }
    
    // Api - del tr
    Datagrid.prototype.delRows = function(rows) {
        var that  = this, options = that.options, beforeDelete = options.beforeDelete, confirmMsg = options.delConfirm, $trs
        
        if (beforeDelete) {
            if (typeof beforeDelete === 'string') beforeDelete = beforeDelete.toFunc()
            if (typeof beforeDelete === 'function') {
                if (!beforeDelete.call(this)) {
                    return
                }
            }
        }
        
        if (typeof rows === 'object') {
            $trs = rows
        } else if (isNaN(rows)) {
            var $myTrs = that.$tbody.find('> tr:not(.'+ that.classnames.tr_child +')'), $delTrs, rows = rows.split(',')
            
            rows = rows.unique()
            rows.sort(function(a, b) {return a.trim() - b.trim()})
            
            $.each(rows, function(i, n) {
                var tr = $myTrs.eq(parseInt(n.trim(), 10))
                
                if (tr && tr.length) {
                    if (!$delTrs) $delTrs = tr
                    else $delTrs = $delTrs.add(tr)
                }
            })
            
            $trs = $delTrs
        } else if (!isNaN(rows)) {
            $trs = this.$tbody.find('> tr:not(.'+ that.classnames.tr_child +')').eq(rows)
        }
        
        if (!$trs || !$trs.length) return
        
        var delEnd = function() {
            $trs.each(function() {
                var $tr = $(this), childUpdate = that.options.childUpdate, $parent = that.$element.data('bjui.datagrid.parent'),
                    updateParent = function($parent) {
                        $parent.closest('table').datagrid('updateRow', $parent)
                    }
                // update child parent
                if ($parent && childUpdate) {
                    if (typeof childUpdate === 'string') {
                        if (childUpdate.indexOf('all') !== -1 || childUpdate.indexOf('del') !== -1)
                            updateParent($parent)
                    } else {
                        updateParent($parent)
                    }
                }
                
                $tr.trigger('bjui.datagrid.tr.delete')
            })
            
            that.tools.afterDelete()
            
            if (options.height === 'auto')
                that.fixedHeight()
        }
        
        var doDel = function() {
            var $addTrs = $trs.filter('.'+ that.classnames.tr_add)
            
            if ($addTrs.length) {
                that.cancelEdit($addTrs)
                
                if (!$trs.not($addTrs).length)
                    return
            }
            
            // remote delete
            if (options.delUrl) {
                var postData = [], callback = options.delCallback
                
                $trs.not($addTrs).each(function() {
                    var $tr = $(this), index = $tr.index(), data, delData
                    
                    if (that.isDom) data = $tr.data('initData') || that.tools.setDomData($tr)
                    else data = that.data[that.tools.getNoChildDataIndex(index)]
                    
                    if (options.delPK) {
                        postData.push(data[options.delPK])
                    } else {
                        if (options.jsonPrefix) {
                            delData = {}
                            $.each(data, function(name, value) {
                                if (name === 'gridCheckbox' || name === 'gridEdit') return true
                                delData[options.jsonPrefix +'.'+ name] = value
                            })
                        } else {
                            delData = $.extend({}, data)
                            delete delData.gridCheckbox
                            delete delData.gridEdit
                        }
                        
                        postData.push(delData)
                    }
                })
                
                if (typeof callback === 'string') callback = callback.toFunc()
                
                var type = options.delType, opts = {url:options.delUrl, data:(options.delPK ? [{ name:options.delPK, value:postData.join(',') }] : JSON.stringify(postData)), type:'POST', okCallback:callback || function(json) { delEnd() }}
                
                if (type && type === 'raw' && !options.delPK) {
                    opts.contentType = 'application/json'
                } else {
                    !options.delPK && (opts.data = {json:opts.data})
                    type && type !== 'raw' && (opts.type = type)
                }
                
                BJUI.ajax('doajax', opts)
            } else { // local delete
                delEnd()
            }
        }
        
        if (confirmMsg) {
            if (typeof confirmMsg !== 'string') confirmMsg = $trs.length == 1 ? BJUI.getRegional('datagrid.delMsg') : BJUI.getRegional('datagrid.delMsgM')
            
            that.$grid.alertmsg('confirm', confirmMsg, {
                okCall:function() {
                    doDel()
                }
            })
        } else {
            doDel()
        }
    }
    
    // inline edit
    Datagrid.prototype.inlineEdit = function($tr, isAdd, data) {
        if (!this.tools.beforeEdit($tr, data)) {
            return false
        }
        
        var that = this, options = that.options, tools = that.tools, columnModel = that.columnModel, $tds = $tr.find('> td'), tds_length = $tds.length, tr_index = $tr.index(), data_index = tr_index
        
        data_index = tools.getNoChildDataIndex(data_index)
        
        if (!data) {
            if (that.isDom) data = $tr.data('initData') || tools.setDomData($tr)
            else data = that.data[data_index]
        }
        
        if ($tr.hasClass(that.classnames.tr_edit)) return false
        if (!that.inputs || !that.inputs.length) tools.initEditInputs()
        
        $tr.addClass(that.classnames.tr_edit).data(that.datanames.changeData, {})
        if ($tr.data('validator')) $tr.validator('destroy') //remove old validate
        
        if (!options.inlineEditMult) {
            that.doCancelEditRow($tr.siblings('.'+ that.classnames.tr_edit))
        }
        
        that.$lastEditTr = $tr
        
        $tds.each(function(i) {
            var $td = $(this), op = columnModel[i], val = op && op.name && data[op.name], html = $td.html(), input = that.inputs[i], $input
            var onChange = function($el, $td, val) {
                var changeData = $tr.data(that.datanames.changeData), jsontype = op.jsontype, defaultVal = (typeof op.defaultVal === 'undefined') ? null : op.defaultVal
                
                switch (op.type) {
                case 'date':
                    $el
                        .on('afterchange.bjui.datepicker', function(e, data) {
                            $td.addClass(that.classnames.td_changed)
                            if ($el.val() == val) $td.removeClass(that.classnames.td_changed)
                            changeData[op.name] = $el.val()
                        })
                        .change(function() {
                            $td.addClass(that.classnames.td_changed)
                            if ($el.val() == val) $td.removeClass(that.classnames.td_changed)
                            changeData[op.name] = $el.val()
                        })
                    
                    break
                case 'select':
                    $el.change(function() {
                        var value = $(this).val()
                        
                        $td.addClass(that.classnames.td_changed)
                        
                        if (value == String(val)) $td.removeClass(that.classnames.td_changed)
                        
                        if ($el.prop('multiple')) {
                            $.isArray(value) && (value = value.join(','))
                        } else if (jsontype) {
                            if (jsontype === 'boolean') {
                                value = Boolean(value)
                            } else if (jsontype === 'number') {
                                !isNaN(Number(value)) && (value = Number(value))
                            }
                        }
                        
                        changeData[op.name] = value
                    })
                    
                    break
                case 'boolean':
                    $el.on('ifChanged', function() {
                        $td.toggleClass(that.classnames.td_changed)
                        
                        var checked = $(this).is(':checked')
                        
                        if (checked == val)
                            $td.removeClass(that.classnames.td_changed)
                        
                        changeData[op.name] = checked
                    })
                    
                    break
                case 'findgrid':
                    changeData[op.name] = $el.val()
                    
                    $td.on('afterchange.bjui.findgrid', '[data-toggle="findgrid"]', function(e, data) {
                        var value = data.value
                        
                        $td.toggleClass(that.classnames.td_changed)
                        
                        if (value == changeData[op.name])
                            $td.removeClass(that.classnames.td_changed)
                        if (jsontype && jsontype === 'number')
                            !isNaN(Number(value)) && (value = Number(value))
                        
                        changeData[op.name] = value
                    })
                    
                    $el.change(function() {
                        var value = $(this).val()
                        
                        $td.addClass(that.classnames.td_changed)
                        
                        if (value == val)
                            $td.removeClass(that.classnames.td_changed)
                        if (jsontype && jsontype === 'number')
                            !isNaN(Number(value)) && (value = Number(value))
                        
                        changeData[op.name] = value
                    })
                    
                    break
                case 'lookup':
                    $td.on('customEvent.bjui.lookup', '[data-toggle="lookupbtn"]', function(e, args) {
                        $td.toggleClass(that.classnames.td_changed)
                        for (var key in args) {
                            if (typeof data[key] !== 'undefined') {
                                changeData[key] = args[key]
                            }
                            if (op.name == key) {
                                if ($el.val() == args[key]) $td.removeClass(that.classnames.td_changed)
                                else $el.val(args[key])
                            }
                        }
                    })
                    
                    $el.change(function() {
                        $td.addClass(that.classnames.td_changed)
                        if ($el.val() == val) $td.removeClass(that.classnames.td_changed)
                        changeData[op.name] = $el.val()
                    })
                    
                    break
                case 'spinner':
                    $el
                        .on('afterchange.bjui.spinner', function(e, data) {
                            $td.addClass(that.classnames.td_changed)
                            if ($el.val() == val) $td.removeClass(that.classnames.td_changed)
                            changeData[op.name] = Number($el.val())
                        })
                        .change(function() {
                            $td.addClass(that.classnames.td_changed)
                            if ($el.val() == val) $td.removeClass(that.classnames.td_changed)
                            changeData[op.name] = Number($el.val())
                        })
                    
                    
                    break
                default:
                    $el.change(function() {
                        var value = $(this).val()
                        
                        $td.addClass(that.classnames.td_changed)
                        
                        if (value == val)
                            $td.removeClass(that.classnames.td_changed)
                        if (jsontype && jsontype === 'number')
                            !isNaN(Number(value)) && (value = Number(value))
                        
                        changeData[op.name] = value
                    })
                    
                    break
                }
                
                if (isAdd) {
                    if (op.type === 'boolean') {
                        defaultVal = Boolean(defaultVal)
                        changeData[op.name] = defaultVal
                        $el.prop('checked', defaultVal)
                    } else {
                        if (defaultVal != null) {
                            if ($el.isTag('select') && $el.prop('multiple')) {
                                $el.val($.isArray(defaultVal) ? defaultVal : defaultVal.split(','))
                            } else {
                                $el.val(String(defaultVal))
                            }
                            if (jsontype) {
                                if (jsontype === 'number')
                                    !isNaN(Number(defaultVal)) && (defaultVal = Number(defaultVal))
                                else if (jsontype === 'boolean')
                                    defaultVal = Boolean(defaultVal)
                            }
                            
                            changeData[op.name] = defaultVal
                        } else {
                            ($el.isTag('select') && !$el.prop('multiple')) && (changeData[op.name] = $el.val())
                        }
                    }
                } else if (jsontype) {
                    $el.trigger('change')
                }
            }
            
            $td.data(that.datanames.td_html, html)
            
            if (isAdd) {
                if (!op.add) input = ''
            } else {
                if (data.addFlag) data.addFlag = false
                if (!op.edit) input = ''
            }
            
            if (input) {
                $input = $(input)
                
                if (typeof val === 'undefined' || val === 'null' || val === null)
                    val = ''
                
                if (op.type === 'boolean')
                    $input.prop('checked', val)
                else if (op.type === 'findgrid')
                    $input.data('context', $tr).val(String(val))
                else {
                    $input.val(String(val))
                    
                    if ($input.isTag('select') && $input.prop('multiple') && val && !$.isArray(val)) {
                        $input.val(val.split(','))
                    }
                }
                
                if (isAdd) {
                    if (op.addAttrs && typeof op.addAttrs === 'object') {
                        $.each(op.addAttrs, function(i, n) {
                            $input.attr(i, n)
                        })
                    }
                } else {
                    if (op.editAttrs && typeof op.editAttrs === 'object') {
                        $.each(op.editAttrs, function(i, n) {
                            $input.attr(i, n)
                        })
                    }
                }
                
                $td
                    .empty()
                    .append($input)
                    .addClass(that.classnames.td_edit)
                    
                onChange($input, $td, val)
                
                if (op.locked) {
                    var $lockTr = that.$lockTbody.find('tr:eq('+ tr_index +')')
                    var $lockTd = $lockTr.find('> td:eq('+ op.lockIndex +')')
                    
                    $td.clone().html(html).insertAfter($td)
                    $td.show().insertAfter($lockTd).initui()
                    $lockTd.remove()
                }
            }
            
            if (!--tds_length) {
                $tr
                    .initui()
                    .validator({
                        msgClass : 'n-bottom',
                        theme    : 'red_bottom_effect_grid'
                    })
            }
        })
    }
    
    Datagrid.prototype.saveAll = function($trs) {
        var that = this, options = that.options, callback = options.editCallback, $tr, data, data_index, datas = [], changeData, tempData, postData = [], returnData = [], len = $trs && $trs.length
        
        if (!$trs || $trs.length) {
            $trs = that.$tbody.find('> tr.'+ that.classnames.tr_edit)
            len  = $trs.length
        }
        
        if (!len) return
        
        $trs.each(function() {
            $tr = $(this)
            
            data_index = that.tools.getNoChildDataIndex($tr.index())
            data = that.isDom ? $tr.data('initData') : that.data[data_index]
            datas.push(data)
            
            $tr.isValid(function(v) {
                if (v) {
                    // Update data
                    changeData = $tr.data(that.datanames.changeData)
                    $.extend(data, changeData)
                    // Specification post data
                    if (options.jsonPrefix) {
                        tempData = {}
                        $.each(data, function(name, value) {
                            if (name === 'gridChild' || name === 'gridCheckbox' || name === 'gridEdit') return true
                            tempData[options.jsonPrefix +'.'+ name] = value
                        })
                    } else {
                        tempData = $.extend({}, data)
                        
                        delete tempData.gridChild
                        delete tempData.gridCheckbox
                        delete tempData.gridEdit
                    }
                    
                    len --
                    postData.push(tempData)
                } else {
                    postData = []
                    
                    return false
                }
            })
        })
        
        // do save
        if (!len) {
            // Callback
            if (callback) {
                callback = callback.toFunc()
            } else {
                callback = function(json) {
                    if ($.type(json) === 'array') {
                        returnData = json
                    } else if (typeof json === 'object') {
                        returnData.push(json)
                    }
                    
                    // if add to the empty grid
                    if ($trs.filter('.'+ that.classnames.tr_add).length === that.$tbody.find('> tr:not(.'+ that.classnames.tr_child +')').length && that.fixtedColumnWidthCount) {
                        that.fixedColumnWidth = true
                    }
                    
                    $trs.each(function(i) {
                        $tr = $(this)
                        data_index = $tr.index()
                        
                        if (that.columnModel[0] === that.childColumn)
                            data_index = data_index / 2
                        
                        data = that.isDom ? $tr.data('initData') : that.data[data_index]
                        
                        $.extend(data, typeof returnData[i] === 'object' && returnData[i])
                        
                        if (that.allData && that.allData[data.gridIndex]) {
                            $.extend(that.allData[data.gridIndex], data)
                        }
                        
                        that.inlineEditComplete($tr, data)
                    })
                    
                    that.tools.afterSave($trs, postData)
                }
            }
            // Do ajax
            if (that.tools.beforeSave($trs, datas)) {
                var type = options.editType, opts = {url:options.editUrl, data:JSON.stringify(postData), type:'POST', okCallback:callback}
                
                if (type && type === 'raw') {
                    opts.contentType = 'application/json'
                } else {
                    opts.data = {json:opts.data}
                    type && (opts.type = type)
                }
                
                BJUI.ajax('doajax', opts)
            }
        }
    }
    
    // update - inline edit
    Datagrid.prototype.updateEdit = function($tr, $btn) {
        var that = this, options = that.options, callback = options.editCallback, data, datas = [], changeData, tempData, postData = [], returnData, data_index = $tr.index()
        
        data_index = that.tools.getNoChildDataIndex(data_index)
        
        if (that.isDom) data = $tr.data('initData')
        else data = that.data[data_index]
        
        if ($tr.hasClass(that.classnames.tr_edit)) {
            // validate
            $tr.isValid(function(v) {
                if (v) {
                    // Update data
                    changeData = $tr.data(that.datanames.changeData)
                    $.extend(data, changeData)
                    // Specification post data
                    if (options.jsonPrefix) {
                        tempData = {}
                        $.each(data, function(name, value) {
                            if (name === 'gridChild' || name === 'gridCheckbox' || name === 'gridEdit') return true
                            tempData[options.jsonPrefix +'.'+ name] = value
                        })
                    } else {
                        tempData = $.extend({}, data)
                        
                        delete tempData.gridChild
                        delete tempData.gridCheckbox
                        delete tempData.gridEdit
                    }
                    // Callback
                    if (callback) {
                        callback = callback.toFunc()
                    } else {
                        callback = function(json) {
                            if ($.type(json) === 'array') {
                                returnData = json[0]
                            } else if (typeof json === 'object') {
                                returnData = json
                            }
                            
                            $.extend(data, typeof returnData === 'object' && returnData)
                            
                            if (that.allData && that.allData[data.gridIndex]) {
                                $.extend(that.allData[data.gridIndex], data)
                            }
                            
                            // if add to the empty grid
                            if ($tr.hasClass(that.classnames.tr_add) && $tr.length === that.$tbody.find('> tr:not(.'+ that.classnames.tr_child +')').length && that.fixtedColumnWidthCount) {
                                that.fixedColumnWidth = true
                            }
                            
                            that.inlineEditComplete($tr, data, $btn)
                            that.tools.afterSave($tr, data)
                        }
                    }
                    // Do ajax
                    datas.push(data)
                    if (that.tools.beforeSave($tr, datas)) {
                        postData.push(tempData)
                        
                        var type = options.editType, opts = {url:options.editUrl, data:JSON.stringify(postData), type:'POST', okCallback:callback}
                        
                        if (type && type === 'raw') {
                            opts.contentType = 'application/json'
                        } else {
                            opts.data = {json:opts.data}
                            type && (opts.type = type)
                        }
                        
                        BJUI.ajax('doajax', opts)
                    }
                }
            })
        }
    }
    
    /* cancel - inline edit */
    Datagrid.prototype.cancelEdit = function($trs) {
        var that = this, columnModel = that.columnModel
        
        $trs.each(function() {
            var $tr = $(this), tr_index = $tr.index(), data_index = tr_index
            
            if ($tr.hasClass(that.classnames.tr_edit)) {
                $tr
                    .removeClass(that.classnames.tr_edit)
                    .find('> td.'+ that.classnames.td_edit).each(function() {
                        var $td = $(this), td_index = $td.index(), model = columnModel[td_index], html = $td.data(that.datanames.td_html)
                        
                        $td.removeClass(that.classnames.td_edit).removeClass(that.classnames.td_changed).html(html)
                        if (model.locked) {
                            var $lockTr = that.$lockTbody.find('tr:eq('+ tr_index +')')
                            var $lockTd = $lockTr.find('> td:eq('+ model.lockIndex +')')
                            
                            html = $lockTd.data(that.datanames.td_html)
                            
                            $lockTr.removeClass(that.classnames.tr_edit)
                            $lockTd.removeClass(that.classnames.td_edit).removeClass(that.classnames.td_changed).html(html)
                        }
                    })
            }
            
            if ($tr.hasClass(that.classnames.tr_add)) {
                data_index = that.tools.getNoChildDataIndex(data_index)
                
                that.data = that.data.remove(data_index)
                
                if ($tr.next().hasClass(that.classnames.tr_child)) {
                    $tr.next().remove()
                    that.$lockTbody && that.$lockTbody.find('> tr:eq('+ tr_index +')').next().remove()
                }
                
                that.$lockTbody && that.$lockTbody.find('> tr:eq('+ tr_index +')').remove()
                $tr.remove()
                
                that.tools.createNoDataTr()
                
                if (that.options.height === 'auto')
                    that.fixedHeight()
            }
        })
    }
    
    // inline editComplete
    Datagrid.prototype.inlineEditComplete = function($tr, trData, $btn) {
        var that = this, columnModel = that.columnModel, tr_index = $tr.index(), $tds = $tr.find('> td'), hasLinenumber = false, $lockTr = that.$lockTbody && that.$lockTbody.find('> tr:eq('+ tr_index +')')
        
        $.each(columnModel, function(i, n) {
            if (n.gridNumber) hasLinenumber = true
            if (n.gridChild || n.gridNumber || n.gridCheckbox || n.gridEdit) return true
            
            var label = n.name ? trData[n.name] : '', render_label, $td = $tds.eq(n.index)
            
            if (typeof label === 'undefined') label = ''
            
            $td.text(label).removeClass(that.classnames.td_edit).removeClass(that.classnames.td_changed)
            
            if (n.render && typeof n.render === 'function') {
                if (n.items) {
                    render_label = n.render.call(that, label, trData, n.items)
                    $td.html(render_label)
                } else {
                    render_label = n.render.call(that, label, trData)
                    $td.html(render_label)
                }
            } else if (n.items) {
                render_label = Datagrid.renderItem.call(that, label, trData, n.items)
                $td.html(render_label)
            }
            
            if (n.locked && $lockTr) {
                var $lockTd = $lockTr.find('> td:eq('+ n.lockIndex +')')
                
                $lockTd.removeClass(that.classnames.td_changed).html($td.html())
            }
        })
        
        $tr.removeClass(that.classnames.tr_edit).initui()
        if ($lockTr)
            $lockTr.removeClass(that.classnames.tr_edit).initui()
        
        if (!$btn) $btn = $tds.filter('.'+ that.classnames.s_edit).find('button.update')
        if ($btn && $btn.length)
            $btn.trigger('bjui.datagrid.update.tr')
        
        if ($tr.hasClass(that.classnames.tr_add)) {
            $tr.removeClass(that.classnames.tr_add)
            $tr.find('> td.'+ that.classnames.s_edit).removeData('isAdd')
            
            // update linenumber
            if (hasLinenumber) {
                var lock
                
                if (that.linenumberColumn.locked) {
                    that.colLock(that.linenumberColumn.th, false)
                    lock = true
                } 
                
                that.$tbody.find('> tr:not(.'+ that.classnames.tr_child +')').each(function(i) {
                    var $tr = $(this)
                    
                    $tr.find('> td.'+ that.classnames.td_linenumber).text(i + 1)
                })
                
                if (lock)
                    that.colLock(that.linenumberColumn.th, true)
            }
            
            // child
            $tr.next('.'+ that.classnames.tr_child).remove()
            that.tools.createChildTr($tr, trData)
        }
    }
    
    // inline edit
    Datagrid.prototype.dialogEdit = function($tr, isAdd, data) {
        if (!this.tools.beforeEdit($tr, data)) {
            return false
        }
        
        var that = this, options = that.options, tools = that.tools, columnModel = that.columnModel, tr_index = $tr.index(), data_index = tr_index, $dialog, $form, html = '', title
        
        if (!data) {
            data_index = tools.getNoChildDataIndex(data_index)
            
            if (that.isDom) data = $tr.data('initData') || tools.setDomData($tr)
            else data = that.data[data_index]
        }
        
        if (!that.inputs || !that.inputs.length) tools.initEditInputs()
        
        title = options.gridTitle || 'datagrid'
        
        if (isAdd) {
            title += ' - '+ BJUI.getRegional('datagrid.add')
        } else {
            if (data.addFlag) data.addFlag = false
            title += ' - '+ BJUI.getRegional('datagrid.edit')
        }
        
        $dialog = $('<div><div class="bjui-pageContent"></div><div class="bjui-pageFooter"></div></div>')
        $form   = $('<form class="datagrid-dialog-edit-form"></form>')
        
        var onChange = function($tr, $form, $el, model) {
            var changeData = $tr.data(that.datanames.changeData), jsontype = model.jsontype, defaultVal = (typeof model.defaultVal === 'undefined') ? null : model.defaultVal
            
            switch (model.type) {
            case 'date':
                $el
                    .on('afterchange.bjui.datepicker', function(e, data) {
                        changeData[model.name] = $(this).val()
                    })
                    .change(function() {
                        changeData[model.name] = $(this).val()
                    })
                
                break
            case 'select':
                $el.change(function() {
                    var $element = $(this), val = $element.val(), multiple = $element.prop('multiple')
                    
                    if (multiple && $.isArray(val)) {
                        val = val.join(',')
                    }
                    if (!multiple && jsontype) {
                        if (jsontype === 'boolean') {
                            val = Boolean(val)
                        } else if (jsontype === 'number') {
                            !isNaN(Number(val)) && (val = Number(val))
                        }
                    }
                    
                    changeData[model.name] = val
                })
                
                break
            case 'boolean':
                $el.on('ifChanged', function() {
                    changeData[model.name] = $(this).is(':checked')
                })
                
                break
            case 'findgrid':
                $form.on('afterchange.bjui.findgrid', '[data-toggle="findgrid"]', function(e, data) {
                    var val = data.value
                    
                    if (jsontype && jsontype === 'number')
                        !isNaN(Number(val)) && (val = Number(val))
                    
                    changeData[model.name] = val
                })
                
                $el.change(function() {
                    changeData[model.name] = $(this).val()
                })
                
                break
            case 'lookup':
                $form.on('customEvent.bjui.lookup', '[data-toggle="lookupbtn"]', function(e, args) {
                    for (var key in args) {
                        if (typeof data[key] !== 'undefined') {
                            changeData[key] = args[key]
                        }
                        if (model.name == key) {
                            $(this).val(args[key])
                        }
                    }
                })
                
                $el.change(function() {
                    changeData[model.name] = $(this).val()
                })
                
                break
            case 'spinner':
                $el
                    .on('afterchange.bjui.spinner', function(e, data) {
                        changeData[model.name] = Number($(this).val())
                    })
                    .change(function() {
                        changeData[model.name] = Number($(this).val())
                    })
                
                break
            default:
                $el.change(function() {
                    var val = $(this).val()
                    
                    if (jsontype && jsontype === 'number')
                        !isNaN(Number(val)) && (val = Number(val))
                    
                    changeData[model.name] = val
                })
                
                break
            }
            
            if (isAdd) {
                if (model.type === 'boolean') {
                    defaultVal = Boolean(defaultVal)
                    changeData[model.name] = defaultVal
                    $el.prop('checked', defaultVal)
                } else {
                    if (defaultVal != null) {
                        if ($el.isTag('select') && $el.prop('multiple')) {
                            $el.val($.isArray(defaultVal) ? defaultVal : defaultVal.split(','))
                        } else {
                            $el.val(String(defaultVal))
                        }
                        if (jsontype) {
                            if (jsontype === 'number')
                                !isNaN(Number(defaultVal)) && (defaultVal = Number(defaultVal))
                            else if (jsontype === 'boolean')
                                defaultVal = Boolean(defaultVal)
                        }
                        
                        changeData[model.name] = defaultVal
                    } else {
                        ($el.isTag('select') && !$el.prop('multiple')) && (changeData[model.name] = $el.val())
                    }
                }
            } else if (jsontype) {
                $el.trigger('change')
            }
        }
        
        var onLoad = function($dialog) {
            var $form   = $dialog.find('form.datagrid-dialog-edit-form'),
                $btns   = $dialog.find('div.bjui-pageFooter button'),
                $prev   = $btns.first(),
                $next   = $btns.eq(1),
                $cancel = $btns.eq(2),
                $save   = $btns.last(),
                trindex, dataindex
            
            var createForm = function(data, $form, $tr) {
                $form.empty()
                if (!$tr.data(that.datanames.changeData)) $tr.data(that.datanames.changeData, {})
                
                if ($form.data('validator')) $form.validator('destroy')
                
                $.each(columnModel, function(i, n) {
                    if (!n.name || n === that.childColumn || n === that.linenumberColumn || n === that.checkboxColumn || n === that.editBtnsColumn) return true
                    
                    var input = that.inputs[i], $input, $p = $('<p></p>'), id = 'datagrid-dialog-edit-column-'+ i, val = data[n.name]
                    
                    if (isAdd) {
                        if (!n.add) input = ''
                    } else {
                        if (!n.edit) input = ''
                    }
                    
                    if (typeof val === 'undefined' || val === 'null' || val === null)
                        val = ''
                    
                    if (input) {
                        $input = $(input).attr('id', id)
                        if ($input.isTag('select')) $input.attr('data-width', 'auto')
                        else if (!$input.isTag('checkbox')) $input.attr('size', 30)
                        
                        if (n.type === 'boolean') {
                            $input.prop('checked', val)
                        } else if (n.type === 'findgrid') {
                            $input.val(String(val)).data('context', $form)
                        } else {
                            $input.val(String(val))
                        }
                        
                        if ($input.isTag('select') && $input.prop('multiple') && val && !$.isArray(val)) {
                            $input.val(val.split(','))
                        }
                        
                        if (isAdd) {
                            if (n.addAttrs && typeof n.addAttrs === 'object') {
                                $.each(n.addAttrs, function(k, v) {
                                    $input.attr(k, v)
                                })
                            }
                        } else {
                            if (n.editAttrs && typeof n.editAttrs === 'object') {
                                $.each(n.editAttrs, function(k, v) {
                                    $input.attr(k, v)
                                })
                            }
                        }
                    } else if (!isAdd) {
                        if (!n.edit)
                            input = val
                    }
                    
                    $p
                        .append('<label class="control-label x120" for="'+ id +'">'+ n.label +'：</label>')
                        .append($('<span class="datagrid-dialog-column-span"></span>').append($input || input))
                        .appendTo($form)
                    
                    if ($input)
                        onChange($tr, $form, $input, n)
                })
                
                $form
                    .initui()
                    .validator({
                        msgClass : 'n-bottom',
                        theme    : 'red_bottom_effect_grid'
                    })
            }
            
            if ($form.is(':empty')) createForm(data, $form, $tr)
            
            trindex = $tr.index()
            
            if (that.columnModel[0] === that.childColumn)
                trindex = trindex * 2
            
            if (!trindex) $prev.addClass('disabled')
            if (trindex == that.data.length - 1) $next.addClass('disabled')
            
            $prev.click(function() {
                var $tr_prev = $tr.prev(), data
                
                if (that.options.hasChild && that.options.childOptions)
                    $tr_prev = $tr_prev.prev()
                if ($tr_prev.length) {
                    dataindex = that.tools.getNoChildDataIndex($tr_prev.index())
                        
                    if (that.isDom) {
                        data = $tr_prev.data('initData') || tools.setDomData($tr_prev)
                    } else {
                        data = that.data[dataindex]
                    }
                    
                    $tr = $tr_prev
                    createForm(data, $form, $tr)
                    $next.removeClass('disabled')
                    
                    if (!$tr_prev.prev().length) $prev.addClass('disabled')
                } else {
                    $prev.addClass('disabled')
                }
            })
            
            $next.click(function() {
                var $tr_next = $tr.next(), data, $next_next
                
                if (that.options.hasChild && that.options.childOptions)
                    $tr_next = $tr_next.next()
                if ($tr_next.length) {
                    $next_next = $tr_next.next()
                    dataindex  = that.tools.getNoChildDataIndex($tr_next.index())
                    
                    if (that.options.hasChild && that.options.childOptions)
                        $next_next = $next_next.length && $next_next.next()
                    if (that.isDom) {
                        data = $tr_next.data('initData') || tools.setDomData($tr_next)
                    } else {
                        data = that.data[dataindex]
                    }
                    
                    $tr = $tr_next
                    createForm(data, $form, $tr)
                    $form.initui()
                    $prev.removeClass('disabled')
                    
                    if (!$next_next || !$next_next.length) $next.addClass('disabled')
                } else {
                    $next.addClass('disabled')
                }
            })
            
            $save.click(function() {
                var changeData, data, datas = [], postData, returnData, callback = options.editCallback
                
                dataindex = that.tools.getNoChildDataIndex($tr.index())
                
                if (that.isDom) data = $tr.data('initData')
                else data = that.data[dataindex]
                
                $form.isValid(function(v) {
                    if (v) {
                        changeData = $tr.data(that.datanames.changeData)
                        $.extend(data, changeData)
                        
                        if (options.jsonPrefix) {
                            postData = {}
                            $.each(data, function(name, value) {
                                if (name === 'gridChild' || name === 'gridCheckbox' || name === 'gridEdit') return true
                                if (!name || !edit || !add) return true
                                postData[options.jsonPrefix +'.'+ name] = value
                            })
                        } else {
                            postData = $.extend({}, data)
                            delete postData.gridCheckbox
                            delete postData.gridEdit
                        }
                        
                        // Callback
                        if (callback) {
                            callback = callback.toFunc()
                        } else {
                            callback = function(json) {
                                if ($.type(json) === 'array') {
                                    returnData = json[0]
                                } else if (typeof json === 'object') {
                                    returnData = json
                                }
                                
                                $.extend(data, typeof returnData === 'object' && returnData)
                                
                                // if add to the empty grid
                                if ($tr.hasClass(that.classnames.tr_add) && $tr.length === that.$tbody.find('> tr:not(.'+ that.classnames.tr_child +')').length && that.fixtedColumnWidthCount) {
                                    that.fixedColumnWidth = true
                                }
                                
                                that.dialogEditComplete($tr, data)
                                that.$grid.dialog('close', 'datagrid-dialog-edit')
                                that.tools.afterSave($tr, data)
                            }
                        }
                        
                        // Do ajax
                        datas.push(data)
                        if (that.tools.beforeSave($tr, datas)) {
                            var type = options.editType, opts = {url:options.editUrl, data:JSON.stringify(postData), type:'POST', okCallback:callback}
                            
                            if (type && type === 'raw') {
                                opts.contentType = 'application/json'
                            } else {
                                opts.data = {json:opts.data}
                                type && (opts.type = type)
                            }
                            
                            BJUI.ajax('doajax', opts)
                        }
                    }
                })
            })
            
            $cancel.click(function() {
                that.$grid.dialog('close', 'datagrid-dialog-edit')
            })
        }
        
        var onClose = function() {
            var addRemove = false
            
            that.$tbody.find('> tr.'+ that.classnames.tr_add).each(function() {
                var $tr = $(this), trindex = $tr.index(), dataindex = trindex
                
                dataindex = that.tools.getNoChildDataIndex(dataindex)
                
                that.data = that.data.remove(dataindex)
                
                if ($tr.next().hasClass(that.classnames.tr_child)) {
                    $tr.next().remove()
                    that.$lockTbody && that.$lockTbody.find('> tr:eq('+ trindex +')').next().remove()
                }
                
                that.$lockTbody && that.$lockTbody.find('> tr:eq('+ trindex +')').remove()
                $tr.remove()
                
                addRemove = true
            })
            
            if (addRemove && that.options.height === 'auto')
                that.fixedHeight()
        }
        
        $dialog.find('> div:first')
            .append($form)
            .next().append(BJUI.doRegional(FRAG.gridDialogEditBtns, that.regional))
        
        var dialog_options = $.extend({}, {id:'datagrid-dialog-edit', fresh:true, target:$dialog[0], width:520, height:400, mask:true, title:title, onLoad:onLoad, onClose:onClose}, (typeof options.editDialogOp === 'object' && options.editDialogOp))
        
        that.$grid.dialog(dialog_options)
    }
    
    // dialog editComplete
    Datagrid.prototype.dialogEditComplete = function($tr, trData) {
        var that = this, columnModel = that.columnModel, tr_index = $tr.index(), $tds = $tr.find('> td'), hasLinenumber = false, $trs = that.$tbody.find('> tr'), $lockTr = that.$lockTbody && that.$lockTbody.find('> tr:eq('+ tr_index +')')
        
        $.each(columnModel, function(i, n) {
            if (n.gridNumber) hasLinenumber = true
            if (n.gridChild || n.gridNumber || n.gridCheckbox || n.gridEdit) return true
            
            var label = n.name ? trData[n.name] : '', render_label, $td = $tds.eq(n.index)
            
            if (typeof label === 'undefined' || label === 'null' || label === null) label = ''
            
            $td.text(label).removeClass(that.classnames.td_edit).removeClass(that.classnames.td_changed)
            
            if (n.render && typeof n.render === 'function') {
                if (n.items) {
                    render_label = n.render.call(that, label, trData, n.items)
                    $td.html(render_label)
                } else {
                    render_label = n.render.call(that, label, trData)
                    $td.html(render_label)
                }
            } else if (n.items) {
                render_label = Datagrid.renderItem.call(that, label, trData, n.items)
                $td.html(render_label)
            }
            
            if (n.locked && $lockTr) {
                var $lockTd = $lockTr.find('> td:eq('+ n.lockIndex +')')
                
                $lockTd.removeClass(that.classnames.td_edit).removeClass(that.classnames.td_changed).html($td.html())
            }
        })
        
        $tr.initui()
        if ($lockTr)
            $lockTr.initui()
        
        if ($tr.hasClass(that.classnames.tr_add)) {
            $tr.removeClass(that.classnames.tr_add)
            
            // update linenumber
            if (hasLinenumber) {
                var lock
                
                if (that.linenumberColumn.locked) {
                    that.colLock(that.linenumberColumn.th, false)
                    lock = true
                } 
                
                that.$tbody.find('> tr:not(.'+ that.classnames.tr_child +')').each(function(i) {
                    var $tr = $(this)
                    
                    $tr.find('> td.'+ that.classnames.td_linenumber).text(i + 1)
                })
                
                if (lock)
                    that.colLock(that.linenumberColumn.th, true)
            }
            
            // child
            $tr.next('.'+ that.classnames.tr_child).remove()
            that.tools.createChildTr($tr, trData)
        }
    }
    
    /* resize */
    Datagrid.prototype.resizeGrid = function() {
        var that = this, $target = that.$grid.getPageTarget(), parentW, parentH
        var _resizeGrid = function() {
            
            if (that.initFixedW && String(that.options.width).endsWith('%')) {
                parentW = that.$grid.parent().width()
                
                that.fixedWidth()
                
                if (that.options.hasChild && that.options.childOptions) {
                    that.$tbody.find('> tr.'+ that.classnames.tr_child +':visible').each(function() {
                        var $child = $(this), $tr = $child.prev(), $table = $tr.data('bjui.datagrid.child')
                        
                        if ($table && $table.length) {
                            $table.datagrid('fixedWidth')
                        }
                    })
                }
            }
            
            if (String(that.options.height).endsWith('%')) {
                that.tools.setBoxbH()
            }
        }
        
        // for tab
        $('a[data-toggle="tab"]').on('shown.bs.tab', $.proxy(function(e) {
            if (!that.$element.data('bjui.datagrid.init.tab')) {
                var $target = $(e.target), $box = $target.data('target'), href = $target.attr('href')
                
                if (!$box)
                    $box = $(href)
                
                if ($box && $box.length) {
                    if ($box.find(that.$element).length) {
                        that.$element.data('bjui.datagrid.init.tab', true)
                        that.$element.datagrid('fixedHeight')
                    }
                }
            }
        }, that))
        
        $(window).on(BJUI.eventType.resizeGrid, $.proxy(_resizeGrid, that))
    }
    
    
    // DATAGRID PLUGIN DEFINITION
    // =======================
    
    function Plugin(option) {
        var args     = arguments,
            property = option
        
        return this.each(function () {
            var $this   = $(this),
                options = $.extend(true, {}, Datagrid.DEFAULTS, typeof option === 'object' && option),
                data    = $this.data('bjui.datagrid')
            
            if (!data) $this.data('bjui.datagrid', (data = new Datagrid(this, options)))
            if (typeof property === 'string' && $.isFunction(data[property])) {
                [].shift.apply(args)
                if (!args) data[property]()
                else data[property].apply(data, args)
            } else {
                data.init()
            }
        })
    }

    var old = $.fn.datagrid

    $.fn.datagrid             = Plugin
    //$.fn.datagrid.Constructor = Datagrid
    $.datagrid                = Datagrid
    
    // DATAGRID NO CONFLICT
    // =================
    
    $.fn.datagrid.noConflict = function () {
        $.fn.datagrid = old
        return this
    }
    
    // DATAGRID DATA-API
    // ==============
    
    $(document).on(BJUI.eventType.initUI, function(e) {
        $(e.target).find('table[data-toggle="datagrid"]').each(function() {
            var $this = $(this), options = $this.data()
            
            if (!$this.length) return
            
            if (options.options && typeof options.options === 'string') options.options = options.options.toObj()
            $.extend(options, typeof options.options === 'object' && options.options)
            
            Plugin.call($this, options)
        })
    })
    
}(jQuery);
/*!
 * B-JUI  v1.3 beta2 (http://b-jui.com)
 * Git@OSC (http://git.oschina.net/xknaan/B-JUI)
 * Copyright 2014 K'naan.
 * Licensed under Apache (http://www.apache.org/licenses/LICENSE-2.0)
 */

/* ========================================================================
 * B-JUI: bjui-tablefixed.js  v1.3 beta2
 * @author K'naan
 * http://git.oschina.net/xknaan/B-JUI/blob/master/BJUI/js/bjui-tablefixed.js
 * ========================================================================
 * Copyright 2014 K'naan.
 * Licensed under Apache (http://www.apache.org/licenses/LICENSE-2.0)
 * ======================================================================== */

+function ($) {
    'use strict';
    
    // TABLEFIXED CLASS DEFINITION
    // ======================
    
    var Tablefixed = function(element, options) {
        this.$element = $(element)
        this.options  = options
        this.tools    = this.TOOLS()
    }
    
    Tablefixed.SCROLLW  = 18
    
    Tablefixed.DEFAULTS = {
        width: '100%'
    }
    
    Tablefixed.prototype.TOOLS = function() {
        var that  = this
        var tools = {
            getLeft: function($obj) {
                var width = 0
                
                $obj.prevAll().each(function() {
                    width += $(this).outerWidth()
                })
                
                return width
            },
            getRight: function($obj) {
                var width = 0
                
                $obj.prevAll().addBack().each(function() {
                    width += $(this).outerWidth()
                })
                
                return width - 1
            },
            getCellNum: function($obj) {
                return $obj.prevAll().addBack().size()
            },
            getColspan: function($obj) {
                return $obj.attr('colspan') || 1
            },
            getStart: function($obj) {
                var start = 1
                
                $obj.prevAll().each(function() {
                    start += parseInt($(this).attr('colspan') || 1)
                })
                
                return start
            },
            getPageCoord: function(element) {
                var coord = {x: 0, y: 0}
                
                while (element) {
                    coord.x += element.offsetLeft
                    coord.y += element.offsetTop
                    element = element.offsetParent
                }
                
                return coord
            },
            getOffset: function($obj, e) {
                if (!$.support.leadingWhitespace) {
                    var $objset = $obj.offset()
                    var evtset = {
                        offsetX: e.pageX || e.screenX,
                        offsetY: e.pageY || e.screenY
                    }
                    var offset = {
                        offsetX: evtset.offsetX - $objset.left,
                        offsetY: evtset.offsetY - $objset.top
                    }
                    
                    return offset
                }
                
                var target = e.target
                
                if (target.offsetLeft == undefined){
                    target = target.parentNode
                }
                
                var pageCoord  = this.getPageCoord(target)
                var eventCoord = {
                    x: window.pageXOffset + e.clientX,
                    y: window.pageYOffset + e.clientY
                }
                var offset = {
                    offsetX: eventCoord.x - pageCoord.x,
                    offsetY: eventCoord.y - pageCoord.y
                }
                
                return offset
            }
        }
        
        return tools
    }
    
    Tablefixed.prototype.resetWidth = function() {
        var $fixed = this.$element,
            width  = $fixed.width(),
            $table = $fixed.find('table'),
            tableW = $table && $table.width(),
            $ths   = $table.eq(0) && $table.eq(0).find('tr:first-child > th'),
            $tds   = $table.eq(1) && $table.eq(1).find('tr:first-child > td')
        
        if ($table && ((width - tableW)  < Tablefixed.SCROLLW)) {
            var fixedW = parseInt((width - tableW) / $ths.length)
            
            $table.width(width - Tablefixed.SCROLLW)
            $ths.each(function(i) {
                var tw = parseInt($(this).css('width'))
                
                $(this).width(tw + fixedW)
                if ($tds.eq(i)) $tds.eq(i).width(tw + fixedW)
            })
        }
    }
    
    Tablefixed.prototype.init = function() {
        if (!this.$element.isTag('table')) return
        
        this.$container = this.$element.parent().addClass('bjui-resizeGrid')
        this.$fixed     = undefined
        var width       = this.$container.width()
        var height      = this.options.height
        
        if (this.$container.hasClass('tab-pane')) width = this.$container.parent().width() - 20
        if (typeof this.options.width === 'string' && this.options.width.indexOf('%')) {
            this.options.newWidth = width * (this.options.width.replace('%', '') / 100)
        } else {
            this.options.newWidth = parseInt(this.options.width)
        }
        
        this.options.styles = []
        this.$element.wrap('<div class="bjui-tablefixed clearfix"></div>')
        this.$fixed = this.$element.parent()
        this.initHead()
        this.initBody()
        this.resizeCol()
        this.resizeGrid()
        
        if (height && !this.$fixed.closest('.tab-content').length) this.$fixed.height(height).addClass('fixedH')
    }
    
    Tablefixed.prototype.initHead = function() {
        var styles  = this.options.styles = []
        var $hTrs   = this.$element.find('thead > tr')
        var $fThs   = $hTrs.eq(0).find('> th')
        var $table  = this.$element
        var fixedW  = 0
        var hTh     = []
        var cols    = []
        var jj      = -1
        
        $fThs.each(function(i) {
            var $th     = $(this),
                colspan = parseInt($th.attr('colspan') || 1),
                width   = $th.attr('width'),
                align   = $th.attr('align'),
                w       = ''
            for (var k = 0; k < colspan; k++) {
                if (colspan == 1 && width) w = ' width="'+ width +'"'
                if (align) $th.removeAttr('align').addClass(align)
                hTh.push('<th'+ w +'></th>')
            }
            $th.attr('colsNum', jj += colspan)
            cols[i] = colspan
        })
        
        var thLen = hTh.length,
            $hTh  = $('<tr class="resize-head">'+ hTh.join('') +'</tr>')
        
        if ($hTrs.length > 1) {
            jj = 0
            var $ths2 = $hTrs.eq(1).find('> th')
            $.each(cols, function(i, n) {
                n = parseInt(n)
                if (n > 1) {
                    var colsNum = parseInt($fThs.eq(i).attr('colsnum'))
                    for (var k = n - 1; k >= 0; k--) {
                        var $th  = $ths2.eq(jj++), myNum = colsNum - k, width = $th.attr('width'), align = $th.attr('align')
                        var $_th = $hTh.find('> th').eq(myNum)
                        
                        if ($th && $th.length) $th.attr('colsnum', myNum)
                        if (width)  $_th.attr('width', width)
                        if (align)  $th.addClass(align).removeAttr('align')
                    }
                }
            })
        }
        
        this.$fixed.html(this.$element.html())
        var $thead  = this.$fixed.find('thead')
        
        $thead.prepend($hTh)
        $hTh.find('> th').each(function(i) {
            var $th   = $(this)
            var style = [], width = $th.innerWidth()
            
            style[0]  = parseInt(width)
            fixedW   += style[0]
            styles[styles.length] = style
        })
        
        fixedW = parseInt((this.options.newWidth - Tablefixed.SCROLLW - fixedW) / thLen)
        var $ths = $thead.find('> tr:eq(0) > th')
        
        this.options.$ths = $ths
        $ths.each(function(i) {
            var $th = $(this), style = styles[i], w = $th.attr('width')
            
            $th
                .removeAttr('align')
                .width(style[0] + fixedW)
            
            style[0] = (style[0] + fixedW)
            if (w) {
                style[0] = parseInt(w)
                $th.width(w).removeAttr('width')
            }
        })
        
        $thead.find('> tr:gt(0) > th').each(function() {
            var $th = $(this)
            
            $th.html('<div class="fixedtableCol">'+ $th.html() +'</div>')
        })
        
        $thead.wrap('<div class="fixedtableHeader" style="width:'+ (this.options.newWidth - Tablefixed.SCROLLW) + 'px;overflow:hidden;"><div class="fixedtableThead"><table class="table table-bordered" style="width:'+ (this.options.newWidth - Tablefixed.SCROLLW) + 'px; max-width:'+ (this.options.newWidth - Tablefixed.SCROLLW) +'px;"></table></div></div>')
        this.$fixed.append('<div class="resizeMarker" style="display:none; height:300px; left:57px;"></div><div class="resizeProxy" style="left:377px; display:none; height:300px;"></div>')
    }
    
    Tablefixed.prototype.initBody = function() {
        var that      = this
        var $tbody    = this.$fixed.find('> tbody')
        var styles    = this.options.styles
        var style, height
        
        if (this.options.height) {
            height = (this.options.height - this.$fixed.find('.fixedtableHeader').height()) +'px'
        } else {
            height = '100%'
            
            var resizeH = function() {
                var _height = that.$fixed.parent().height()
                
                that.$fixed.parent().css('overflow', 'hidden')
                that.$fixed.height(_height)
                    .find('.fixedtableScroller').height(_height - that.$fixed.find('.fixedtableHeader').height())
            }
            
            $(document).one(BJUI.eventType.afterInitUI, function(e) {
                resizeH()
            })
        }
            
        style = 'style="height:'+ height +'; overflow-y:auto;"'
        
        $tbody.wrap('<div class="fixedtableScroller"'+ style +' style="width:'+ (this.options.newWidth) +'px;"><div class="fixedtableTbody"><table style="width:'+ (this.options.newWidth - Tablefixed.SCROLLW) +'px; max-width:'+ (this.options.newWidth - Tablefixed.SCROLLW) +'px;"></table></div></div>')
        
        if (!this.$element.attr('class')) $tbody.parent().addClass('table table-striped table-bordered table-hover')
        else $tbody.parent().addClass(this.$element.attr('class'))
        if (typeof this.$element.attr('data-selected-multi') !== 'undefined') $tbody.parent().attr('data-selected-multi', this.$element.attr('data-selected-multi'))
        
        $tbody.before('<thead><tr class="resize-head">'+ this.$fixed.find('thead > tr').html() +'</tr></thead>')
        this.options.$tds = $tbody.prev().find('> tr:first-child > th')
        if (this.options.nowrap) $tbody.parent().addClass('nowrap')
       
        $tbody.closest('.fixedtableScroller').scroll(function(e) {
            var $scroller  = $(this)
            var scrollLeft = $scroller.scrollLeft()
            var $header    = $scroller.prev().find('> .fixedtableThead')
            
            $header.css({ 'position':'relative', 'left':-scrollLeft })
            
            return false
        })
    }
    
    Tablefixed.prototype.resizeCol = function() {
        var that   = this
        var $fixed = this.$fixed
        var $ths   = this.options.$ths
        var $tds   = this.options.$tds
        var tools  = this.tools
        
        $fixed.find('thead > tr:gt(0) > th').each(function(i) {
            var $th = $(this)
            
            $th.mouseover(function(e) {
                var ofLeft    = parseInt($fixed.find('.fixedtableThead').css('left')) || 0
                var offset    = tools.getOffset($th, e).offsetX
                var $resizeTh = $ths.eq($th.attr('colsnum'))
                
                if ($th.outerWidth() - offset < 5) {
                    $th.css('cursor', 'col-resize').off('mousedown.bjui.tablefixed.resize').on('mousedown.bjui.tablefixed.resize', function(event) {
                        $fixed.find('> .resizeProxy')
                            .show()
                            .css({
                                left:   tools.getRight($resizeTh) + ofLeft + $fixed.position().left,
                                top:    $fixed.position().top,
                                height: $fixed.height(),
                                cursor: 'col-resize'
                            })
                            .basedrag({
                                scop:  true, cellMinW:20, relObj:$fixed.find('.resizeMarker'),
                                move:  'horizontal',
                                event: event,
                                stop:  function() {
                                    var pleft   = $fixed.find('.resizeProxy').position().left
                                    var mleft   = $fixed.find('.resizeMarker').position().left
                                    var move    = pleft - mleft - $resizeTh.outerWidth() - 9
                                    var cellNum = tools.getCellNum($resizeTh)
                                    var oldW    = $resizeTh.width(), newW = $resizeTh.width() + move
                                    var $dcell  = $tds.eq(cellNum - 1)
                                    var tableW  = $fixed.find('> .fixedtableHeader .table').width()
                                    
                                    $resizeTh.width(newW)
                                    $dcell.width(newW)
                                    
                                    $fixed.find('.table').width(tableW + move)
                                    $fixed.find('.resizeMarker, .resizeProxy').hide()
                                    
                                    if ((tableW + move + Tablefixed.SCROLLW) < that.options.newWidth) {
                                        $fixed.find('.fixedtableScroller').width(tableW + move + Tablefixed.SCROLLW)
                                    } else {
                                        var newW = $fixed.closest('.bjui-resizeGrid').innerWidth()
                                        if ((tableW + move + Tablefixed.SCROLLW) < newW) newW = (tableW + move + Tablefixed.SCROLLW)
                                        
                                        $fixed.find('.fixedtableHeader').width(newW - Tablefixed.SCROLLW)
                                        $fixed.find('.fixedtableScroller').width(newW)
                                        $fixed.width(newW)
                                    }
                                    $fixed.data('resizeGrid', true)
                                }
                            })
                        
                        $fixed
                            .find('> .resizeMarker')
                            .show()
                            .css({
                                left:   tools.getLeft($resizeTh) + ofLeft + $fixed.position().left,
                                top:    $fixed.position().top,
                                height: $fixed.height()
                            })
                    })
                } else {
                    $th
                        .css('cursor', 'default')
                        .off('mousedown.bjui.tablefixed.resize')
                }
                
                return false
            })
        })
    }
    
    Tablefixed.prototype.setOrderBy = function(options) {
        var $th       = this.$element,
            $orderBox = $th.find('.fixedtableCol'),
            $order    = $(BJUI.doRegional(FRAG.orderby, BJUI.regional.orderby))
            
        options = options || this.options
        
        $th.addClass('orderby')
        if (options.orderDirection) {
            if (!BJUI.ui.clientPaging) $th.addClass(options.orderDirection)
            $th.pagination('setClientOrder', {orderField:options.orderField, orderDirection:options.orderDirection})
        }
        if (!$orderBox.length) {
            $orderBox = $('<div class="fixedtableCol">'+ $th.html() +'</div>')
                .appendTo($th.empty())
        }
        
        $order
            .data('orderField', options.orderField)
            .appendTo($orderBox)
            .pagination('orderBy')
    }
    
    Tablefixed.prototype.resizeGrid = function() {
        var that = this
        var _resizeGrid = function() {
            $('div.bjui-resizeGrid').each(function() {
                var $this  = $(this),
                    width  = $this.width(),
                    height = $this.height(),
                    $fixed = $this.find('.bjui-tablefixed'),
                    fixedH = $fixed.find('.fixedtableThead').height(),
                    newWidth = that.options.newWidth,
                    realWidth
                
                if (width) {
                    $this.find('.bjui-tablefixed').each(function() {
                        var $fixed = $(this)
                        
                        if (!$fixed.data('resizeGrid')) realWidth = width
                        else realWidth = newWidth
                        
                        $fixed.width(realWidth)
                        $fixed.find('.table').width(realWidth - Tablefixed.SCROLLW)
                        $fixed.find('.fixedtableHeader').width(realWidth - Tablefixed.SCROLLW)
                        $fixed.find('.fixedtableScroller').width(realWidth)
                    })
                }
                
                /* resizeH */
                $this.css('overflow', 'hidden')
                $fixed.height(height)
                    .find('.fixedtableScroller').height(height - fixedH)
                
            })
            
            var resizeH = function() {
                var _height = that.$fixed.parent().height()
                
                that.$fixed.parent().css('overflow', 'hidden')
                that.$fixed.height(_height)
                    .find('.fixedtableScroller').height(_height - that.$fixed.find('.fixedtableHeader').height())
            }
        }
        
        $(window).on(BJUI.eventType.resizeGrid, _resizeGrid)
    }
    
    
    // TABLEFIXED PLUGIN DEFINITION
    // =======================
    
    function Plugin(option) {
        var args     = arguments
        var property = option
        
        return this.each(function () {
            var $this   = $(this)
            var options = $.extend({}, Tablefixed.DEFAULTS, $this.data(), typeof option === 'object' && option)
            var data    = $this.data('bjui.tablefixed')
            
            if (!data) $this.data('bjui.tablefixed', (data = new Tablefixed(this, options)))
            if (typeof property === 'string' && $.isFunction(data[property])) {
                [].shift.apply(args)
                if (!args) data[property]()
                else data[property].apply(data, args)
            } else {
                data.init()
            }
        })
    }

    var old = $.fn.tablefixed

    $.fn.tablefixed             = Plugin
    $.fn.tablefixed.Constructor = Tablefixed
    
    // TABLEFIXED NO CONFLICT
    // =================
    
    $.fn.tablefixed.noConflict = function () {
        $.fn.tablefixed = old
        return this
    }
    
    // TABLEFIXED DATA-API
    // ==============

    $(document).on(BJUI.eventType.initUI, function(e) {
        var $this = $(e.target).find('table[data-toggle="tablefixed"]')
        
        if (!$this.length) return
        
        Plugin.call($this)
    })
    
    /* orderby */
    $(document).on(BJUI.eventType.afterInitUI, function(e) {
        var $this = $(e.target).find('th[data-order-field]')
        
        if (!$this.length) return
        
        Plugin.call($this, 'setOrderBy')
    })
    
    /* selected tr */
    $(document).on('click.bjui.tr.data-api', 'tr[data-id]', function(e) {
        var $this     = $(this),
            $table    = $this.closest('table'),
            multi     = $table.data('selectedMulti'),
            id        = $this.attr('data-id'),
            clsName   = 'selected',
            $selected = $table.closest('.unitBox').find('#bjui-selected')
        
        $this.toggleClass(clsName)
        if (multi) {
            id = []
            $this.siblings('.'+ clsName).add(($this.hasClass(clsName) ? $this : '')).each(function() {
                id.push($(this).attr('data-id'))
            })
            id = id.join(',')
        } else {
            $this.siblings().removeClass(clsName)
            if (!$this.hasClass(clsName)) id = ''
        }
        if ($selected && $selected.length) {
            $selected.val(id)
        } else {
            $selected = $('<input type="hidden" id="bjui-selected" value="'+ id +'">')
            $selected.appendTo($table.closest('.unitBox'))
        }
    })
    
}(jQuery);
/*!
 * B-JUI  v1.3 beta2 (http://b-jui.com)
 * Git@OSC (http://git.oschina.net/xknaan/B-JUI)
 * Copyright 2014 K'naan.
 * Licensed under Apache (http://www.apache.org/licenses/LICENSE-2.0)
 */

/* ========================================================================
 * B-JUI: bjui-tabledit.js  v1.3 beta2
 * @author K'naan
 * http://git.oschina.net/xknaan/B-JUI/blob/master/BJUI/js/bjui-tabledit.js
 * ========================================================================
 * Copyright 2014 K'naan.
 * Licensed under Apache (http://www.apache.org/licenses/LICENSE-2.0)
 * ======================================================================== */

+function ($) {
    'use strict';
    
    // TABLEDIT CLASS DEFINITION
    // ======================
    
    var Tabledit = function(element, options) {
        this.$element = $(element)
        this.options  = options
        this.tools    = this.TOOLS()
        this.$tbody   = this.$element.find('> tbody')
        if (!this.$tbody.length) {
            this.$tbody = $('<tbody></tbody>')
            this.$element.append(this.$tbody)
        }
        this.$numAdd =
        this.$btnAdd = null
    }
    
    Tabledit.DEFAULTS = {
        singleNoindex : true
    }
    
    Tabledit.EVENTS = {
        afterDelete: 'afterdelete.bjui.tabledit'
    }
    
    Tabledit.prototype.TOOLS = function() {
        var that = this
        var tools = {
            initSuffix: function($tbody) {
                var $trs = $tbody.find('> tr')
                
                $trs.each(function(i) {
                    var $tr = $(this)
                    
                    $tr.find(':input, :file, a, label, div').each(function() {
                        var $child = $(this),
                            name   = $child.attr('name'), 
                            val    = $child.val(),
                            fors   = $child.attr('for'),
                            id     = $child.attr('id'),
                            href   = $child.attr('href'),
                            group  = $child.attr('data-group'),
                            suffix = $child.attr('data-suffix')
                        
                        if (name) $child.attr('name', name.replaceSuffix(i))
                        if (fors) $child.attr('for', fors.replaceSuffix(i))
                        if (id)   $child.attr('id', id.replaceSuffix(i).replaceSuffix2(i))
                        if (href) $child.attr('href', href.replaceSuffix(i))
                        if (group)   $child.attr('data-group', group.replaceSuffix(i))
                        if (suffix)  $child.attr('data-suffix', suffix.replaceSuffix(i))
                        if (val && val.indexOf('#index#') >= 0) $child.val(val.replace('#index#', i + 1))
                        if ($child.hasClass('no')) {
                            var prefix = $child.data('prefix') ? $child.data('prefix') : ''
                            
                            $child.val(prefix + (i + 1))
                        }
                    })
                })
            },
            // Enter for Tab
            initEnter: function($tbody) {
                var $texts = $tbody.find(':text')
                
                $texts.each(function(i) {
                    $(this).bind('keydown', function (e) {
                        if (e.which == BJUI.keyCode.ENTER) {
                            var nexInd = i + 1
                            
                            if ($texts.eq(nexInd)) {
                                $texts.eq(nexInd).focus()
                            }
                            e.preventDefault()
                        }
                    })
                })
                this.initInput($tbody)
            },
            initInput: function($tbody) {
                $tbody.find('> tr > td').each(function() {
                    var $span = $(this).find('.input-hold')
                    
                    if (!$span.length) {
                        $span = $('<span class="input-hold" style="display:block; padding:0 4px; height:0px; font-size:12px; visibility:hidden;"></span>')
                        $(this).append($span)
                    }
                    if (!$.support.leadingWhitespace) { // for ie8
                        $(this).on('propertychange', ':text', function(e) {
                            $span.text($(this).val())
                        })
                    } else {
                        $(this).on('input', ':text', function(e) {
                            $span.text($(this).val())
                        })
                    }
                })
            },
            initTbody: function() {
                var $table  = that.$element,
                    $tbody  = that.$tbody
                    
                $tbody.find('> tr').each(function() {
                    var $tr = $(this), $tds = $tr.find('> td'), $ths = $table.data('bjui.tabledit.tr').clone().find('> th')
                    
                    $tr.data('bjui.tabledit.oldTds', $tr.html())
                    
                    $ths.each(function(i) {
                        var $td = $tds.eq(i), val = $td.data('val'),
                            $th = $(this), $child = $th.children(), $pic = $th.find('.pic-box')
                        
                        if (typeof val === 'undefined') val = $td.html()
                        if (!$td.data('noedit')) {
                            if ($child.length) {
                                if ($child.is('input:checkbox') || $child.is('input:radio')) {
                                    $child.filter('[value="'+ val +'"]').attr('checked', 'checked')
                                } else if ($child.isTag('select')) {
                                    $child.find('option[value="'+ $td.data('val') +'"]').attr('selected', 'selected')
                                } else if ($pic.length) {
                                    if ($td.data('val')) $th.find('.pic-name').val($td.data('val'))
                                    $pic.html($td.html())
                                } else if ($child.hasClass('wrap_bjui_btn_box')) {
                                    $child.find('input[data-toggle]').attr('value', val +'')
                                } else if ($child.is('textarea')) {
                                    $child.html(val)
                                    if ($child.attr('data-toggle') == 'kindeditor') {
                                        $child.attr('data-toggle-old', 'kindeditor').removeAttr('data-toggle')
                                    }
                                } else {
                                    $child.attr('value', val +'')
                                }
                                $td.html($th.html())
                            }
                        }
                    })
                    
                    $tr.on('dblclick', $.proxy(function(e) { _doEdit($tr) }, that)).initui()
                    that.tools.initSuffix($tbody)
                    _doRead($tr)
                })
                
                $tbody
                    .on('click.bjui.tabledit.readonly', '[data-toggle="doedit"]', function(e) {
                        _doEdit($(this).closest('tr'))
                    })
                    .on('click.bjui.tabledit.readonly', '[data-toggle="dosave"]', function(e) {
                        var $tr = $(this).closest('tr'), index = $tr.index(), callback = that.options.callback
                        
                        if (that.options.action) {
                            $tr.wrap('<form action="" method="POST"></form>')
                            if ($tr.attr('data-id')) {
                                var name = $table.find('> thead > tr:eq(0)').data('idname') || 'id'
                                
                                $tr.before('<input type="hidden" name="'+ name.replaceSuffix(index) +'" value="'+ $tr.attr('data-id') +'">')
                            }
                            
                            var data = $tr.parent().serializeArray()
                            
                            if (that.options.singleNoindex) {
                                $.each(data, function(ii, nn) {
                                    $.extend(nn, {name:nn.name.replaceSuffix(0)})
                                })
                            }
                            
                            $tr.prev('input').remove()
                            $tr
                                .unwrap()
                                .isValid(function(v) {
                                    if (v) {
                                        if (callback) {
                                            callback = callback.toFunc()
                                        } else {
                                            callback = function(json) {
                                                if (json[BJUI.keys.statusCode] == BJUI.statusCode.ok) {
                                                    _doRead($tr)
                                                } else {
                                                    $tr.bjuiajax('ajaxDone', json)
                                                }
                                            }
                                        }
                                        $tr.bjuiajax('doAjax', {url:that.options.action, data:data, type:that.options.type || 'POST', callback:callback})
                                    }
                                })
                        } else {
                            _doRead($tr)
                        }
                    })
                
                that.tools.initEnter($tbody)
                
                function _doEdit($tr) {
                    $tr.removeClass('readonly').find('> td *').each(function() {
                        var $this = $(this), $td = $this.closest('td'), val = $td.data('val'), toggle = $this.attr('data-toggle-old'), readonly = $td.data('readonly')
                        
                        if (typeof val === 'undefined') val = $td.html()
                        if ($td.data('notread')) return true
                        if ($this.isTag('select'))
                            $this.val($td.attr('data-val')).selectpicker('refresh').nextAll('.bootstrap-select').removeClass('readonly').find('button').removeClass('disabled')
                        if ($this.is(':checkbox')) {
                            $this.closest('.icheckbox_minimal-purple').removeClass('disabled')
                            $this.closest('.icheckbox_minimal-purple').find('ins').removeClass('readonly')
                        }
                        if ($this.is(':radio')) {
                            $this.closest('.iradio_minimal-purple').removeClass('disabled')
                            $this.closest('.iradio_minimal-purple').find('ins').removeClass('readonly')
                        }
                        if (toggle) {
                            if (toggle == 'dosave') return true
                            else $this.removeAttr('data-toggle-old').attr('data-toggle', toggle)
                            if (toggle == 'spinner') {
                                $this.spinner('destroy').spinner()
                            }
                            if (toggle == 'kindeditor') {
                                //$this.attr('data-toggle', 'kindeditor')
                                $td.initui()
                            }
                        }
                        if ($this.is(':text') || $this.is('textarea')) {
                            $this.off('keydown.readonly')
                            if (readonly) $this.prop('readonly', true)
                        }
                        
                        $this.find('.bjui-lookup, .bjui-spinner, .bjui-upload').show()
                    })
                    
                    $tr.find('[data-toggle="doedit"]')
                        .attr('data-toggle', 'dosave')
                        .text('完成')
                }
                function _doRead($tr) {
                    $tr.addClass('readonly').find('> td *').each(function() {
                        var $this = $(this), $td = $this.closest('td'), toggle = $this.attr('data-toggle')
                        
                        if ($td.data('notread')) return true
                        if ($this.isTag('select'))
                            $this.nextAll('.bootstrap-select').addClass('readonly').find('button').addClass('disabled')
                        if ($this.is(':checkbox')) {
                            $this.closest('.icheckbox_minimal-purple').addClass('disabled')
                            $this.closest('.icheckbox_minimal-purple').find('ins').addClass('readonly')
                        }
                        if ($this.is(':radio')) {
                            $this.closest('.iradio_minimal-purple').addClass('disabled')
                            $this.closest('.iradio_minimal-purple').find('ins').addClass('readonly')
                        }
                        if (toggle) {
                            if (toggle == 'doedit' || toggle == 'dosave') return true
                            else $this.removeAttr('data-toggle').attr('data-toggle-old', toggle)
                            if (toggle == 'kindeditor') {
                                KindEditor.remove($this)
                            }
                        }
                        if ($this.is(':text') || $this.is('textarea'))
                            $this.on('keydown.readonly', function(e) { e.preventDefault() })
                        
                        $this.find('.bjui-lookup, .bjui-spinner, .bjui-upload').hide()
                    })
                    
                    $tr.find('[data-toggle="dosave"]')
                        .attr('data-toggle', 'doedit')
                        .text('编辑')
                }
            },
            doAdd: function() {
                var tool   = this
                var $table = that.$element
                
                if (!that.$numAdd || !that.$btnAdd) return
                $table
                    .on('keydown.bjui.tabledit.add', 'thead .num-add', function(e) {
                        if (e.which == BJUI.keyCode.ENTER) {
                            that.$btnAdd.trigger('click.bjui.tabledit.add')
                            
                            e.preventDefault()
                        }
                    })
                    .on('click.bjui.tabledit.add', 'thead .row-add', function(e) {
                        var rowNum = 1
                        
                        if (!isNaN(that.$numAdd.val())) rowNum = parseInt(that.$numAdd.val())
                        that.add($table, rowNum)
                        
                        e.preventDefault()
                    })
            },
            doDel: function($tbody) {
                var tool     = this
                var delEvent = 'click.bjui.tabledit.del'
                
                $tbody.off(delEvent).on(delEvent, '.row-del', function(e) {
                    var $btnDel = $(this)
                    
                    if ($btnDel.data('confirmMsg')) {
                        $btnDel.alertmsg('confirm', $btnDel.data('confirmMsg'), {okCall: function() { tool.delData($btnDel) }})
                    } else {
                        tool.delData($btnDel)
                    }
                    
                    e.preventDefault()
                })
            },
            delData: function($btnDel) {
                var tool    = this
                var $tbody  = $btnDel.closest('tbody')
                var options = $btnDel.data()
                var _delRow = function(json) {
                    $btnDel.closest('tr').remove()
                    tool.initSuffix($tbody)
                    tool.afterDelete($tbody)
                    if (options.callback) (options.callback.toFunc()).apply(that, [json])
                }
                
                if ($btnDel.is('[href^=javascript:]') || $btnDel.is('[href^="#"]')) {
                    _delRow()
                } else {
                    $btnDel.bjuiajax('doAjax', {
                        url      : $btnDel.attr('href'),
                        data     : options.data,
                        callback : _delRow
                    })
                }
            },
            afterDelete: function($tbody) {
                var deletedEvent = $.Event(Tabledit.EVENTS.afterDelete, {relatedTarget: $tbody[0]})
                
                that.$element.trigger(deletedEvent)
                if (deletedEvent.isDefaultPrevented()) return
            }
        }
        
        return tools
    }
    
    Tabledit.prototype.init = function() {
        var that    = this
        var tools   = this.tools
        var $table  = this.$element.addClass('bjui-tabledit'), $tr = $table.find('> thead > tr:first'), $tbody = this.$tbody
        var trHtml  = $table.find('> thead > tr:first').html()
        
        $tr.find('> th').each(function() {
            var $th   = $(this)
            var title = $th.attr('title')
            var add   = $th.data('addtool')
            
            if (title) $th.html(title)
            if (add) {
                var $addBox   = $('<span style="position:relative;"></span>')
                
                $th.empty()
                that.$numAdd = $('<input type="text" value="1" class="form-control num-add" size="2" title="待添加的行数">')
                that.$btnAdd = $('<a href="javascript:;" class="row-add" title="添加行"><i class="fa fa-plus-square"></i></a>')
                $addBox.append(that.$numAdd).append(that.$btnAdd).appendTo($th)
            }
        })
        $table.data('bjui.tabledit.tr', $('<tr>'+ trHtml +'</tr>'))
        tools.initTbody()
        tools.doAdd()
        tools.doDel($tbody)
    }
    
    Tabledit.prototype.add = function($table, num) {
        var tools  = this.tools
        var $tbody = $table.find('> tbody')
        var $firstTr, $tr = $table.data('bjui.tabledit.tr')
        
        for (var i = 0; i < num; i++) {
            $tr.find('> th').each(function() { $(this).replaceWith('<td>'+ $(this).html() +'</td>') })
            
            var $addTr = $tr.clone()
            
            if (!i) $firstTr = $addTr
            $addTr.hide().appendTo($tbody)
            tools.initSuffix($tbody)
            tools.initEnter($tbody)
            $addTr.show().css('display', '').initui()
        }
        /*置入焦点*/
        if ($firstTr && $firstTr.length) {
            var $input = $firstTr.find(':text')
            
            $input.each(function() {
                var $txt = $(this)
                
                if (!$txt.prop('readonly')) {
                    $txt.focus()
                    return false
                }
            })
        }
    }
    
    // TABLEDIT PLUGIN DEFINITION
    // =======================
    
    function Plugin(option) {
        var args     = arguments
        var property = option
        
        return this.each(function () {
            var $this   = $(this)
            var options = $.extend({}, Tabledit.DEFAULTS, $this.data(), typeof option === 'object' && option)
            var data    = $this.data('bjui.tabledit')
            
            if (!data) $this.data('bjui.tabledit', (data = new Tabledit(this, options)))
            if (typeof property === 'string' && $.isFunction(data[property])) {
                [].shift.apply(args)
                if (!args) data[property]()
                else data[property].apply(data, args)
            } else {
                data.init()
            }
        })
    }

    var old = $.fn.tabledit

    $.fn.tabledit             = Plugin
    $.fn.tabledit.Constructor = Tabledit
    
    // TABLEDIT NO CONFLICT
    // =================
    
    $.fn.tabledit.noConflict = function () {
        $.fn.tabledit = old
        return this
    }
    
    // TABLEDIT DATA-API
    // ==============

    $(document).on(BJUI.eventType.initUI, function(e) {
        var $this = $(e.target).find('table[data-toggle="tabledit"]')
        
        if (!$this.length) return
        
        Plugin.call($this)
    })
    
    // init add tr
    $(document).on(BJUI.eventType.afterInitUI, function(e) {
        var $this = $(e.target).find('table[data-toggle="tabledit"]')
        
        $this.each(function() {
            if ($(this).is('[data-initnum]')) {
                var initNum = $(this).data('initnum')
                
                if (initNum > 0) {
                    Plugin.call($(this), 'add', $(this), initNum)
                }
            }
        })
    })
    
    $(document).on('click.bjui.tabledit.data-api', '[data-toggle="tableditadd"]', function(e) {
        var $this = $(this)
        var num   = $this.data('num') || 1
        var table = $this.data('target')
        
        if (!table || !$(table).length) return
        if (!$(table).isTag('table')) return
        Plugin.call($this, 'add', $(table), num)
        
        e.preventDefault()
    })
    
}(jQuery);
/*!
 * B-JUI  v1.3 beta2 (http://b-jui.com)
 * Git@OSC (http://git.oschina.net/xknaan/B-JUI)
 * Copyright 2014 K'naan.
 * Licensed under Apache (http://www.apache.org/licenses/LICENSE-2.0)
 */

/* ========================================================================
 * B-JUI: bjui-spinner.js  v1.3 beta2
 * @author K'naan
 * http://git.oschina.net/xknaan/B-JUI/blob/master/BJUI/js/bjui-spinner.js
 * ========================================================================
 * Copyright 2014 K'naan.
 * Licensed under Apache (http://www.apache.org/licenses/LICENSE-2.0)
 * ======================================================================== */

+function ($) {
    'use strict';
    
    // SPINNER CLASS DEFINITION
    // ======================
    var Spinner = function(element, options) {
        this.$element = $(element)
        this.options  = options
        this.tools    = this.TOOLS()
        this.$spinner = null
        this.height   = this.$element.addClass('form-control').innerHeight()
        this.ivalue   = Number(this.$element.val()) || 0
    }
    
    Spinner.DEFAULTS = {
        min: 0,
        max: 100,
        step: 1,
        decimalPlace: 0
    }
    
    Spinner.EVENTS = {
        afterChange : 'afterchange.bjui.spinner'
    }
    
    Spinner.prototype.TOOLS = function() {
        var that  = this
        var tools = {
            changeVal: function($btn) {
                var $input = that.$element
                var ivalue = Number($input.val()) || Number(that.ivalue)
                var type   = $btn.data('add') || -1
                var istart = that.options.min, iend = that.options.max, istep = that.options.step
                
                if (type == 1) {
                    if (ivalue <= iend - istep)
                        ivalue = ivalue + istep
                } else if (type == -1) {
                    if (ivalue >= (istart + istep))
                        ivalue = ivalue - istep
                } else if (ivalue > iend) {
                    ivalue = iend
                } else if (ivalue < istart) {
                    ivalue = istart
                }
                if (that.options.decimalPlace)
                    ivalue = new String(ivalue.toFixed(that.options.decimalPlace))
                
                that.ivalue = ivalue
                
                $input
                    .val(ivalue)
                    .trigger(Spinner.EVENTS.afterChange, {value:ivalue})
            }
        }
        
        return tools
    }
    
    Spinner.prototype.init = function() {
        var that     = this
        var $element = this.$element
        var options  = this.options
        
        if (isNaN(this.options.min) || isNaN(this.options.max) || isNaN(this.options.step)) {
            BJUI.debug('Spinner Plugin: Parameter is non-numeric type!')
            return
        }
        
        this.addBtn()
    }
    
    Spinner.prototype.addBtn = function() {
        var that = this, $element = that.$element
        
        if (!this.$lookBtn && !$element.parent().hasClass('wrap_bjui_btn_box')) {
            this.$spinner = $(FRAG.spinnerBtn)
            
            $element.css({'paddingRight':'13px'}).wrap('<span class="wrap_bjui_btn_box"></span>')
            
            var $box = $element.parent()
        
            $box.css('position', 'relative')
            this.$spinner.css({'height':this.height}).appendTo($box)
            this.$spinner.on('selectstart', function() { return false })
            
            var timer = null
            
            that.$spinner.find('li').on('click', function(e) {
                that.tools.changeVal($(this))
            }).on('mousedown', function() {
                var $btn = $(this)
                
                timer = setInterval(function() {
                    that.tools.changeVal($btn)
                }, 150)
            }).on('mouseup', function() { clearTimeout(timer) })
        }
    }
    
    Spinner.prototype.destroy = function() {
        if (this.$element.parent().hasClass('wrap_bjui_btn_box')) {
            this.$element.parent().find('.bjui-spinner').remove()
            this.$element.unwrap()
        }
    }
    
    // SPINNER PLUGIN DEFINITION
    // =======================
    
    function Plugin(option) {
        var args     = arguments
        var property = option
        
        return this.each(function () {
            var $this   = $(this)
            var options = $.extend({}, Spinner.DEFAULTS, $this.data(), typeof option === 'object' && option)
            var data    = $this.data('bjui.spinner')
            
            if (!data) $this.data('bjui.spinner', (data = new Spinner(this, options)))
            if (typeof property === 'string' && $.isFunction(data[property])) {
                [].shift.apply(args)
                if (!args) data[property]()
                else data[property].apply(data, args)
            } else {
                data.init()
            }
        })
    }
    
    var old = $.fn.spinner
    
    $.fn.spinner             = Plugin
    $.fn.spinner.Constructor = Spinner
    
    // SPINNER NO CONFLICT
    // =================
    
    $.fn.spinner.noConflict = function () {
        $.fn.spinner = old
        return this
    }
    
    // SPINNER DATA-API
    // ==============

    $(document).on(BJUI.eventType.initUI, function(e) {
        var $this = $(e.target).find('input[data-toggle="spinner"]')
        
        if (!$this.length) return
        
        Plugin.call($this)
    })

}(jQuery);
/*!
 * B-JUI  v1.3 beta2 (http://b-jui.com)
 * Git@OSC (http://git.oschina.net/xknaan/B-JUI)
 * Copyright 2014 K'naan.
 * Licensed under Apache (http://www.apache.org/licenses/LICENSE-2.0)
 */

/* ========================================================================
 * B-JUI: bjui-lookup.js  v1.3 beta2
 * @author K'naan
 * http://git.oschina.net/xknaan/B-JUI/blob/master/BJUI/js/bjui-lookup.js
 * ========================================================================
 * Copyright 2014 K'naan.
 * Licensed under Apache (http://www.apache.org/licenses/LICENSE-2.0)
 * ======================================================================== */

+function ($) {
    'use strict';
    
    // LOOKUP GLOBAL ELEMENTS
    // ======================
    
    var group, suffix, $currentLookup
    
    // LOOKUP CLASS DEFINITION
    // ======================
    
    var Lookup = function(element, options) {
        this.$element = $(element)
        this.options  = options
        this.$lookBtn = null
    }
    
    Lookup.DEFAULTS = {
        url       : null,
        id        : null,
        mask      : true,
        width     : 600,
        height    : 400,
        title     : 'Lookup',
        maxable   : true,
        resizable : true
    }
    
    Lookup.EVENTS = {
        afterChange : 'afterchange.bjui.lookup'
    }
    
    Lookup.prototype.init = function() {
        var that = this, options = this.options, tools = this.tools
        
        if (!options.url) {
            BJUI.debug('Lookup Plugin: Error trying open a lookup dialog, url is undefined!')
            return false
        } else {
            options.url = decodeURI(options.url).replacePlh(that.$element.closest('.unitBox'))
            if (!options.url.isFinishedTm()) {
                that.$element.alertmsg('error', (options.warn || BJUI.regional.plhmsg))
                BJUI.debug('Lookup Plugin: The lookup\'s url is incorrect, url:'+ options.url)
                return false
            }
            options.url = encodeURI(options.url)
        }
        
        group          = this.options.group  || null
        suffix         = this.options.suffix || null
        $currentLookup = this.$element
        
        if (suffix) suffix = suffix.trim()
        
        this.open(that.$element)
    }
    
    Lookup.prototype.addBtn = function() {
        var that = this, $element = that.$element
        
        if (!this.$lookBtn && !$element.parent().hasClass('wrap_bjui_btn_box')) {
            this.$lookBtn = $(FRAG.lookupBtn)
            this.$element.css({'paddingRight':'15px'}).wrap('<span class="wrap_bjui_btn_box"></span>')
            
            var $box   = this.$element.parent()
            var height = this.$element.addClass('form-control').innerHeight()
            
            $box.css({'position':'relative', 'display':'inline-block'})
            
            $.each(that.options, function(key, val) {
                if (key != 'toggle') that.$lookBtn.data(key, val)
            })
            this.$lookBtn.css({'height':height, 'lineHeight':height +'px'}).appendTo($box)
            this.$lookBtn.on('selectstart', function() { return false })
        }
    }
    
    Lookup.prototype.open = function($obj) {
        var that = this, options = this.options
        
        $obj.dialog({id:options.id || 'lookup_dialog', url:options.url, title:options.title, width:options.width, height:options.height, mask:options.mask, maxable:options.maxable, resizable:options.resizable})
    }
    
    Lookup.prototype.getField = function(key) {
        return (group ? (group +'.') : '') + (key) + (suffix ? suffix : '')
    }
    
    Lookup.prototype.setSingle = function(args,type) {
        if (typeof args === 'string')
            args  = new Function('return '+ args)()
        this.setVal(args,type)
    }
    
    Lookup.prototype.setMult = function(id,type) {
        var args  = {}
        var $unitBox = this.$element.closest('.unitBox')
        
        $unitBox.find('[name="'+ id +'"]').filter(':checked').each(function() {
            var _args = new Function('return '+ $(this).val())()
            
            for (var key in _args) {
                var value = args[key] ? args[key] +',' : ''
                
                args[key] = value + _args[key]
            }
        })
        
        if ($.isEmptyObject(args)) {
            this.$element.alertmsg('error', this.$element.data('warn') || BJUI.regional.selectmsg)
            return
        }
        
        this.setVal(args,type)
    }
    
    Lookup.prototype.setVal = function(args, type) {
        var that = this
        var $box = $currentLookup.closest('.unitBox')
        var newValue  /* @description 增加 @author 小策一喋 */
        
        // for datagrid
        if ($currentLookup.data('customEvent')) {
            $currentLookup.trigger('customEvent.bjui.lookup', [args])
        } else {
            $box.find(':input').each(function() {
                var $input = $(this), inputName = $input.attr('name')
                
                for (var key in args) {
                    var name = that.getField(key)
                    
                    if (name == inputName) {

                        /* @description 增加 追加参数 @author 小策一喋 */
                        if(type == 1)
                            newValue = $input.val() ? $input.val() + ',' + args[key] : args[key]
                        else
                            newValue = args[key]

                        $input
                            .val(newValue) /* @description 修改 args[key] 为 newValue @author 小策一喋 */
                            .trigger(Lookup.EVENTS.afterChange, {value:args[key]})
                            
                        break
                    }
                }
            })
        }
        
        this.$element.dialog('closeCurrent')
    }
       
    // LOOKUP PLUGIN DEFINITION
    // =======================
    
    function Plugin(option) {
        var args     = arguments
        var property = option
        
        return this.each(function () {
            var $this   = $(this)
            var options = $.extend({}, Lookup.DEFAULTS, $this.data(), typeof option === 'object' && option)
            var data    = $this.data('bjui.lookup')
            
            if (!data) {
                $this.data('bjui.lookup', (data = new Lookup(this, options)))
            } else if ($this.data('newurl')) {
                data.options.url = $this.data('newurl')
                $this.data('bjui.dialog', null)
            }
            if (typeof property === 'string' && $.isFunction(data[property])) {
                [].shift.apply(args)
                if (!args) data[property]()
                else data[property].apply(data, args)
            } else {
                data.init()
            }
        })
    }

    var old = $.fn.lookup

    $.fn.lookup             = Plugin
    $.fn.lookup.Constructor = Lookup
    
    // LOOKUP NO CONFLICT
    // =================
    
    $.fn.lookup.noConflict = function () {
        $.fn.lookup = old
        return this
    }
    
    // LOOKUP DATA-API
    // ==============

    $(document).on(BJUI.eventType.initUI, function(e) {
        var $this = $(e.target).find('[data-toggle="lookup"]')
        
        if (!$this.length) return
        
        Plugin.call($this, 'addBtn')
    })
    
    $(document).on('click.bjui.lookup.data-api', '[data-toggle="lookupbtn"]', function(e) {
        var $this = $(this)
        
        if ($this.attr('href') && !$this.data('url')) $this.attr('data-url', $this.attr('href'))
        if (!$this.data('title')) $this.attr('data-title', $this.text())
        
        Plugin.call($this)
        
        e.preventDefault()
    })
    
    $(document).on('click.bjui.lookupback.data-api', '[data-toggle="lookupback"]', function(e) {
        var $this = $(this)
        var args  = $this.data('args')
        var mult  = $this.data('lookupid')
        var type = $('input[name="lookupType"]:checked').val() /* @description 新增 获取是否追加框值 @author 小策一喋 */
        
        if (args)
            Plugin.call($this, 'setSingle', args, type) /* @description 修改 增加type参数 @author 小策一喋 */
        else if (mult)
            Plugin.call($this, 'setMult', mult, type) /* @description 修改 增加type参数 @author 小策一喋 */
            
        e.preventDefault()
    })
    
}(jQuery);
/*!
 * B-JUI  v1.3 beta2 (http://b-jui.com)
 * Git@OSC (http://git.oschina.net/xknaan/B-JUI)
 * Copyright 2014 K'naan.
 * Licensed under Apache (http://www.apache.org/licenses/LICENSE-2.0)
 */

/* ========================================================================
 * B-JUI: bjui-findgrid.js  v1.3 beta2
 * @author K'naan
 * http://git.oschina.net/xknaan/B-JUI/blob/master/BJUI/js/bjui-findgrid.js
 * ========================================================================
 * Copyright 2014 K'naan.
 * Licensed under Apache (http://www.apache.org/licenses/LICENSE-2.0)
 * ======================================================================== */

+function ($) {
    'use strict';
    
    // FINDGRID GLOBAL ELEMENTS
    // ======================
    
    var group, suffix, pk, include, exclude, append, oldData, onSelect, $box, $currentFindGrid
    
    // FINDGRID CLASS DEFINITION
    // ======================
    
    var FindGrid = function(element, options) {
        this.$element = $(element)
        this.options  = options
        this.$findBtn = null
    }
    
    FindGrid.DEFAULTS = {
        pk           : null,
        oldData      : null,
        group        : null,
        suffix       : null,
        include      : null,
        exclude      : null,
        multiple     : false,
        append       : false,
        empty        : true,
        dialogOptions: {
            id        : null,
            mask      : true,
            width     : 600,
            height    : 400,
            title     : 'FindGrid',
            maxable   : true,
            resizable : true
        },
        gridOptions : {
            width      : '100%',
            height     : '100%',
            columnMenu : false,
            sortAll    : true,
            filterAll  : true,
            fullGrid   : true
        },
        context     : null,
        onSelect    : null
    }
    
    FindGrid.EVENTS = {
        afterChange : 'afterchange.bjui.findgrid'
    }
    
    FindGrid.getField = function(key) {
        return (group ? (group +'.') : '') + (key) + (suffix ? suffix : '')
    }
    
    FindGrid.empty = function() {
        if (!include) {
            BJUI.debug('FindGrid Plugin: No set options \'include\' !')
            return
        }
        
        var that = this, includes = include.split(','), $inputs = $box.find(':text, :input:hidden, textarea, select'), includeKeys = {}
        
        for (var i = 0; i < includes.length; i++) {
            var arr = includes[i].split(':'), key, fieldKey
            
            if (arr.length == 2) {
                fieldKey = arr[0].trim()
                key      = arr[1].trim()
            } else {
                fieldKey = includes[i].trim()
                key      = fieldKey
            }
            
            includeKeys[that.getField(fieldKey)] = true
        }
        
        for (key in includeKeys) {
            $inputs.filter('[name="'+ key +'"]')
                .val('')
                .trigger(FindGrid.EVENTS.afterChange, {value:'', data:''})
        }
    }
    
    FindGrid.setSingle = function(data) {
        var that   = this
        var setVal = function($input, fieldKey, value) {
            var name = that.getField(fieldKey)
            
            if (name == $input.attr('name')) {
                $input
                    .val(value)
                    .trigger(FindGrid.EVENTS.afterChange, {value:value, data:data})
                
                if ($input.isTag('select') && $input.data('toggle') && $input.data('toggle') === 'selectpicker') {
                    $input.selectpicker('refresh')
                }
            }
        }
        
        $box.find('input:text, input:hidden, textarea, select').each(function() {
            var $input = $(this), fieldKey, excludeKeys = []
            
            if (include) {
                var includes = include.split(',')
                
                for (var i = 0; i < includes.length; i++) {
                    var arr = includes[i].split(':'), key
                    
                    if (arr.length == 2) {
                        fieldKey = arr[0].trim()
                        key      = arr[1].trim()
                    } else {
                        fieldKey = includes[i].trim()
                        key      = fieldKey
                    }
                    
                    if (typeof data[key] !== 'undefined')
                        setVal($input, fieldKey, data[key])
                }
            } else {
                for (var key in data) {
                    if (exclude) {
                        $.each(exclude.split(','), function(i, n) {
                            excludeKeys.push(n.trim())
                        })
                        
                        if ($.inArray(key, excludeKeys) != -1) {
                            continue
                        }
                    }
                    
                    setVal($input, key, data[key])
                }
            }
        })
    }
    
    FindGrid.setMult = function(gridId) {
        if (typeof onSelect === 'function') {
            onSelect.call(that, data.data)
            return
        }
        
        var that = this, datas = $('#'+ gridId).data('selectedDatas'), data, inputLen = 0, newVal
        var refreshSelect = function($input) {
            if ($input.isTag('select') && $input.data('toggle') && $input.data('toggle') === 'selectpicker') {
                $input.selectpicker('refresh')
            }
        }
        
        if (datas && datas.length) {
            var $inputs = $box.find('input:text, input:hidden, textarea, select'), fieldKey, includeKeys = {}, okObj = {}, excludeKeys = [], v
            
            if (!append && oldData)
                oldData = []
            
            if (include) {
                var includes = include.split(',')
                
                for (var i = 0; i < includes.length; i++) {
                    var arr = includes[i].split(':'), key, obj
                    
                    if (arr.length == 2) {
                        fieldKey = arr[0].trim()
                        key      = arr[1].trim()
                    } else {
                        fieldKey = includes[i].trim()
                        key      = fieldKey
                    }
                    
                    includeKeys[that.getField(fieldKey)] = key
                }
            } else {
                for (var key in datas[0]) {
                    if (exclude) {
                        $.each(exclude.split(','), function(i, n) {
                            excludeKeys.push(n.trim())
                        })
                        if ($.inArray(key, excludeKeys) === -1) {
                            includeKeys[that.getField(key)] = key
                        }
                    } else {
                        includeKeys[that.getField(key)] = key
                    }
                }
            }
            
            $inputs = $($.map($inputs, function(n) {
                var $n = $(n), name = $n.attr('name')
                
                if (!name) return null
                if (!includeKeys[name]) return null
                
                okObj[name] = includeKeys[name]
                
                return n
            }))
            
            for (var j = 0; j < datas.length; j++) {
                data = datas[j]
                
                if (oldData && $.inArray(data[pk], oldData) != -1)
                    continue
                
                $inputs.each(function(k) {
                    var $input = $(this), name = $input.attr('name'), value = $input.val()
                    
                    if (!newVal) newVal = new Array()
                    if (!newVal[k]) newVal[k] = []
                    
                    if (!append) {
                        $input.val('')
                        refreshSelect($input)
                    } else {
                        if (value) {
                            newVal[k].push(value)
                            
                            if ($input.isTag('select') && $input.prop('multiple')) {
                                newVal[k] = $.type(value) === 'array' ? value : []
                            }
                        }
                    }
                    
                    newVal[k].push(data[okObj[name]])
                    
                    if (oldData && $.inArray(data[pk], oldData) === -1)
                        oldData.push(data[pk])
                })
            }
            
            if (newVal) {
                $inputs.each(function(k) {
                    var $input = $(this)
                    
                    v = newVal[k].join(',')
                    
                    if ($input.isTag('select') && $input.prop('multiple'))
                        v = newVal[k]
                    
                    $input
                        .val(v)
                        .trigger(FindGrid.EVENTS.afterChange, {value:v, data:datas})
                    
                    $currentFindGrid.data('oldData', oldData)
                    
                    refreshSelect($input)
                })
            }
            
            BJUI.dialog('closeCurrent')
        }
    }
    
    FindGrid.prototype.init = function() {
        var that = this, options = this.options, gridOptions = options.gridOptions, tools = this.tools
        
        group            = options.group  || null
        suffix           = options.suffix || null
        $currentFindGrid = that.$element
        oldData          = options.oldData
        pk               = options.pk || null
        include          = options.include || null
        exclude          = options.exclude || null
        
        if (options.context) {
            if (options.context instanceof jQuery)
                $box = options.context
            else
                $box = $(options.context)
        }
        if (!$box || !$box.length)
            $box = that.$element.closest('.unitBox')
        if (suffix)
            suffix = suffix.trim()
        
        if (pk) {
            if ($currentFindGrid.data('oldData')) {
                oldData = $currentFindGrid.data('oldData')
            } else {
                if (typeof oldData !== 'undefined') {
                    if (typeof oldData === 'string')
                        oldData = oldData.split(',')
                    else if (!$.isArray(oldData))
                        oldData = []
                } else {
                    oldData = []
                }
            }
        } else {
            oldData = null
        }
        
        this.open(that.$element)
    }
    
    FindGrid.prototype.addBtn = function() {
        var that = this, $element = that.$element, options = $element.data('bjui.findgrid.options')
        
        if (!this.$findBtn && !$element.parent().hasClass('wrap_bjui_btn_box')) {
            this.$findBtn = $(FRAG.findgridBtn)
            this.$element.css({'paddingRight':'15px'}).wrap('<span class="wrap_bjui_btn_box"></span>')
            
            var $box   = this.$element.parent()
            var height = this.$element.addClass('form-control').innerHeight()
            
            $box.css({'position':'relative', 'display':'inline-block'})
            
            delete options.toggle
            
            that.$findBtn.data('bjui.findgrid.options', options)
            
            this.$findBtn.css({'height':height, 'lineHeight':height +'px'}).appendTo($box)
            this.$findBtn.on('selectstart', function() { return false })
        }
    }
    
    FindGrid.prototype.open = function($obj) {
        var that = this, options = this.options, dialogOptions = options.dialogOptions, gridOptions = options.gridOptions, timestamp = (new Date().getTime())
        
        if (!dialogOptions.id)
            dialogOptions.id = 'dialog_findgrid_'+ timestamp
        if (!options.gridId)
            options.gridId = 'datagrid_findgrid_'+ timestamp
        
        gridOptions.showToolbar = true
        
        if (options.empty) {
            if (!gridOptions.toolbarCustom) gridOptions.toolbarCustom = ''
        }
        if (options.multiple) {
            if (typeof gridOptions.showCheckboxcol === 'undefined') {
                gridOptions.showCheckboxcol = true
            }
            if (!gridOptions.toolbarCustom) gridOptions.toolbarCustom = ''
            
            gridOptions.selectMult  = true
            
            // set multiple
            gridOptions.toolbarCustom += '　<button type="button" class="btn-blue" onclick="$.fn.findgrid.Constructor.setMult(\''+ options.gridId +'\')">'+ (BJUI.getRegional('findgrid.choose')) +'</button>'
            gridOptions.toolbarCustom += '　<label class="ilabel"><input type="checkbox" data-toggle="icheck" id="checkbox_findgrid_'+ timestamp +'" '+ (options.append ? 'checked' : '') +'>&nbsp;'+ (BJUI.getRegional('findgrid.append')) +'</label>'
            
            if (options.append)
                append = true
        }
        
        if (options.empty)
            gridOptions.toolbarCustom += '　<button type="button" class="btn-orange" onclick="$.fn.findgrid.Constructor.empty(\''+ options.gridId +'\')">'+ (BJUI.getRegional('findgrid.empty')) +'</button>'
        
        delete dialogOptions.url
        delete dialogOptions.target
        
        if (options.onSelect) {
            onSelect = options.onSelect
            if (typeof onSelect === 'string') onSelect = onSelect.toFunc()
        } else {
            onSelect = null
        }
        
        dialogOptions.html = '<div class="bjui-pageContent tableContent"><table id="'+ options.gridId +'"></table></div>'
        dialogOptions.onLoad = function($dialog) {
            var gridId = '#'+ options.gridId, $grid = $(gridId)
            
            $grid.datagrid(gridOptions)
            
            // after load - selected row by (oldData && pk)
            if ($.isArray(oldData) && oldData.length && pk) {
                $(document).on('afterLoad.bjui.datagrid', gridId, function(e, data) {
                    if (data.datas) {
                        $.each(data.datas, function(i, data) {
                            if (data[pk]) {
                                if ($.inArray(data[pk], oldData) != '-1') {
                                    $grid.datagrid('selectedRows', i, true)
                                }
                            }
                        })
                    }
                })
            }
            
            // set single
            if (!options.multiple) {
                $(document).on('clicked.bjui.datagrid.tr', gridId, function(e, data) {
                    if (typeof onSelect === 'function')
                        onSelect.call(that, data.data)
                    else {
                        FindGrid.setSingle(data.data)
                        BJUI.dialog('closeCurrent')
                    }
                })
            }
            
            // append checkbox
            $(document).on('ifChanged', '#checkbox_findgrid_'+ timestamp, function(e) {
                append = $(this).is(':checked')
            })
        }
        
        BJUI.dialog(dialogOptions)
    }
    
    // FINDGRID PLUGIN DEFINITION
    // =======================
    
    function Plugin(option) {
        var args     = arguments
        var property = option
        
        return this.each(function () {
            var $this   = $(this),
                options = {},
                data
            
            $.extend(true, options, FindGrid.DEFAULTS, typeof option === 'object' && option)
            
            data = new FindGrid(this, options)
            
            if (typeof property === 'string' && $.isFunction(data[property])) {
                [].shift.apply(args)
                if (!args) data[property]()
                else data[property].apply(data, args)
            } else {
                data.init()
            }
        })
    }
    
    var old = $.fn.findgrid
    
    $.fn.findgrid             = Plugin
    $.fn.findgrid.Constructor = FindGrid
    
    // FINDGRID NO CONFLICT
    // =================
    
    $.fn.findgrid.noConflict = function () {
        $.fn.findgrid = old
        return this
    }
    
    // FINDGRID DATA-API
    // ==============
    
    $(document).on(BJUI.eventType.initUI, function(e) {
        $(e.target).find('input[data-toggle="findgrid"]').each(function() {
            var $this = $(this), data = $this.data(), options = data.options
            
            if (options) {
                if (typeof options === 'string') {
                    if (options.trim().startsWith('{')) 
                        options = options.toObj()
                    else
                        options = options.toFunc()
                }
                if (typeof options === 'function') {
                    options = options.apply()
                }
                if (typeof options === 'object') {
                    delete data.options
                    
                    $.extend(data, options)
                }
            }
            
            $this.data('bjui.findgrid.options', data)
            Plugin.call($this, 'addBtn')
        })
    })
    
    $(document).on('click.bjui.findgrid.data-api', '[data-toggle="findgridbtn"]', function(e) {
        var $this = $(this), opts = $this.data('bjui.findgrid.options')
        
        if (!opts) {
            var data = $this.data(), options = data.options
            
            if (options) {
                if (typeof options === 'string') {
                    if (options.trim().startsWith('{')) 
                        options = options.toObj()
                    else
                        options = options.toFunc()
                }
                if (typeof options === 'function') {
                    options = options.apply()
                }
                if (typeof options === 'object') {
                    delete data.options
                    
                    $.extend(data, options)
                }
            }
            opts = data
        }
        
        delete opts['bjui.findgrid.options']
        
        Plugin.call($this, opts)
        
        e.preventDefault()
    })
    
}(jQuery);
/*!
 * B-JUI  v1.3 beta2 (http://b-jui.com)
 * Git@OSC (http://git.oschina.net/xknaan/B-JUI)
 * Copyright 2014 K'naan.
 * Licensed under Apache (http://www.apache.org/licenses/LICENSE-2.0)
 */

/* ========================================================================
 * B-JUI: bjui-tags.js  v1.3 beta2
 * @author K'naan
 * http://git.oschina.net/xknaan/B-JUI/blob/master/BJUI/js/bjui-tags.js
 * ========================================================================
 * Copyright 2014 K'naan.
 * Licensed under Apache (http://www.apache.org/licenses/LICENSE-2.0)
 * ======================================================================== */

+function ($) {
    'use strict';
    
    // TAGS CLASS DEFINITION
    // ======================
    var Tags = function(element, options) {
        this.$element = $(element).addClass('tag-input')
        this.options  = options
        this.tools    = this.TOOLS()
        this.$box     = $(this.$element.wrap('<div class="bjui-tags"></div>')).parent()
        this.timeout  = null
        this.$tagsArr = {}
        this.tags     = []
    }
    
    Tags.DEFAULTS = {
        width    : 300,
        url      : '',
        global   : false,
        type     : 'GET',
        tagname  : 'tag',     // Appended "<input type='hidden'>" name attribute
        max      : 0,         // The maximum allowable number of tags(0=unlimited)
        clear    : false,     // If not found, clear the input characters
        lightCls : 'tags-highlight'
    }
    
    Tags.EVENTS = {
        afterCreated : 'aftercreated.bjui.tags'
    }
    
    Tags.prototype.TOOLS = function() {
        var that  = this, options = this.options
        var tools = {
            keyDown: function(e) {
                if (e.which == 13) {
                    return false
                }
            },
            keyUp: function(e) {
                switch(e.which) {
                case BJUI.keyCode.BACKSPACE:
                    if (!$.trim(that.$element.val()).length) {
                        that.tools.removeMenu()
                        return false
                    }
                    break
                case BJUI.keyCode.ESC:
                    that.tools.removeMenu()
                    break
                case BJUI.keyCode.DOWN:
                    if (!that.$menu || !that.$menu.length) return
                    
                    var $highlight = that.$menu.find('> .'+ options.lightCls),
                        $first     = that.$menu.find('> li:first-child')
                    
                    if (!$highlight.length) {
                        $first.addClass(options.lightCls)
                    } else {
                        var $hight_next = $highlight.removeClass(options.lightCls).next()
                        
                        if ($hight_next.length) {
                            $hight_next.addClass(options.lightCls)
                        } else {
                            $first.addClass(options.lightCls)
                        }
                    }
                    return false
                    break
                case BJUI.keyCode.UP:
                    if (!that.$menu || !that.$menu.length) return
                    var $highlight = that.$menu.find('> .'+ options.lightCls),
                        $last      = that.$menu.find('> li:last-child')
                    
                    if (!$highlight.length) {
                        $last.addClass(options.lightCls)
                    } else {
                        var $hight_prev = $highlight.removeClass(options.lightCls).prev()
                        
                        if ($hight_prev.length) {
                            $hight_prev.addClass(options.lightCls)
                        } else {
                            $last.addClass(options.lightCls)
                        }
                    }
                    return false
                    break
                case BJUI.keyCode.ENTER:
                    if (options.max > 0 && that.$tagsArr.length >= options.max) return false
                    
                    var label = false, value = false, item = null
                    var $selectedItem = that.$menu && that.$menu.find('> .'+ options.lightCls)
                    
                    if ($selectedItem && $selectedItem.length) {
                        label = $selectedItem.text()
                        item  = $selectedItem.data('item')
                        value = item.value
                    } else {
                        label = $.trim(that.$element.val())
                        
                        if (!label.length) return false
                        if (options.clear) {
                            if ($.inArray(label, that.tags) == -1) {
                                that.$element.val('')
                                return false
                            }
                        }
                        value = label
                    }
                    if (!label) return
                    
                    /* Check the repeatability */
                    var isRepeat = false
                    
                    that.$tagsArr.length && that.$tagsArr.each(function() {
                        if ($(this).val() == value) {
                            isRepeat = true
                            return
                        }
                    })
                    
                    if (isRepeat) {
                        that.$element.val('')
                        return false
                    }
                    
                    that.tools.createTag(label, value)
                    that.tools.removeMenu()
                    that.$element.val('')
                    
                    //events
                    $.proxy(that.tools.onAfterCreated(item, value), that)
                    
                    return false
                    break
                }
            },
            query: function() {
                if (that.timeout) clearTimeout(that.timeout)
                
                that.timeout = setTimeout(that.tools.doQuery, 300)
            },
            doQuery: function() {
                if (options.max > 0 && that.$tagsArr.length >= options.max) return
                
                var term = that.$element.val(), $menu = that.$box.find('> .tags-menu'), tags = [], $item = null
                var $parentBox = that.$element.closest('.navtab-panel').length ? $.CurrentNavtab : $.CurrentDialog
                
                if (that.$element.closest('.bjui-layout').length) $parentBox = that.$element.closest('.bjui-layout')
                if (!term.length) return
                
                that.$element.one('ajaxStart', function() {
                    $parentBox.trigger('bjui.ajaxStart')
                }).one('ajaxStop', function() {
                    $parentBox.trigger('bjui.ajaxStop')
                })
                
                $.ajax({
                    url      : options.url,
                    global   : options.global,
                    type     : options.type,
                    data     : {term: term},
                    dataType : 'json',
                    success  : function(json) {
                        if (json.length != 0) {
                            if (!$menu.length) $menu = $('<ul class="tags-menu"></ul>')
                            
                            $menu.empty().hide().appendTo(that.$box)
                            
                            for (var i = 0; i < json.length; i++) {
                                $item = $('<li class="tags-item">'+ json[i].label + '</li>').data('item', json[i])
                                $item.appendTo($menu)
                                tags.push(json[i].label)
                            }

                            that.tags = tags
                            
                            $menu
                                .css({'top':that.$element.position().top + (that.$element.outerHeight()), 'left':that.$element.position().left})
                                .fadeIn()
                                .find('> li')
                                    .hover(function() {
                                        $(this).addClass(options.lightCls).siblings().removeClass(options.lightCls)
                                    }, function() {
                                        $(this).removeClass(options.lightCls)
                                    })
                                    .click(function() {
                                        var label    = $(this).text()
                                        var item     = $(this).data('item')
                                        var value    = item.value
                                        var isRepeat = false
                                        
                                        that.$box.find('input:hidden').each(function() {
                                            if ($(this).val() == value) {
                                                isRepeat = true
                                                return
                                            }
                                        })
                                        
                                        if (isRepeat) {
                                            that.$element.val('')
                                            $menu.remove()
                                            return
                                        }
                                        
                                        $.proxy(that.tools.createTag(label, value), that)
                                        
                                        $menu.remove()
                                        that.$element.val('')
                                        
                                        //events
                                        $.proxy(that.tools.onAfterCreated(item, value), that)
                                    })
                            
                            that.$menu = $menu
                        }
                    }
                })
            },
            createTag: function(label, value) {
                var $btn = $('<span class="label label-tag" data-value="' + value +'" style="margin-left: 1px; margin-top: 1px;"><i class="fa fa-tag"></i> ' + label + '&nbsp;&nbsp;<a href="#" class="close">&times;</a></span>')
                
                $btn
                    .insertBefore(that.$element)
                    .find('a.close')
                    .click(function() {
                        var value = $btn.data('value')
                        
                        that.$box.find('input:hidden').each(function() {
                            if ($(this).val() == value) {
                                $(this).remove()
                            }
                        })
                        
                        $btn.remove()
                        that.$tagsArr = that.$box.find('input[name="'+ that.options.tagname +'"]')
                    })
                
                var $hidden = $('<input type="hidden" name="'+ that.options.tagname +'">').val(value)
                
                $hidden.appendTo(that.$box)
                that.$tagsArr = that.$box.find('input[name="'+ that.options.tagname +'"]')
            },
            removeMenu: function() {
                if (that.$menu) that.$menu.remove()
            },
            onAfterCreated: function(item, value) {
                var alltags = []
                
                that.$tagsArr.length && that.$tagsArr.each(function() {
                    alltags.push($(this).val())
                })
                
                that.$element.trigger(Tags.EVENTS.afterCreated, {item:item, value:value, tags:alltags.join(',')})
            }
        }
        
        return tools
    }
    
    Tags.prototype.init = function() {
        var that     = this
        var $element = this.$element
        var options  = this.options
        
        if (!(options.url)) {
            BJUI.debug('Tags Plugin: Do query tags, url is undefined!')
            return
        } else {
            options.url = decodeURI(options.url).replacePlh($element.closest('.unitBox'))
            
            if (!options.url.isFinishedTm()) {
                $element.alertmsg('error', (options.warn || BJUI.regional.plhmsg))
                BJUI.debug('Tags Plugin: The query tags url is incorrect, url: '+ options.url)
                return
            }
            
            options.url = encodeURI(options.url)
        }
        if (isNaN(this.options.max)) {
            BJUI.debug('Tags Plugin: Parameter \'max\' is non-numeric type!')
            return
        }
        
        that.$box
            .width(options.width)
            .on('click', function() {
                $element.focus()
            })
        
        $element
            //.on('blur', $.proxy(this.tools.removeMenu, this))
            .on('keydown', $.proxy(this.tools.keyDown, this))
            .on('keyup', $.proxy(this.tools.keyUp, this))
        
        if (!$.support.leadingWhitespace) { // for ie8
            $element.on('propertychange', $.proxy(this.tools.query, this))
        } else {
            $element.on('input', $.proxy(this.tools.query, this))
        }
        
        $(document).on('click.bjui.tags', $.proxy(function(e) {
            if (!$(e.target).closest(this.$box).length) this.tools.removeMenu()
        }, this))
    }
    
    Tags.prototype.destroy = function() {
        if (this.$tags) {
            this.$element.upwrap()
            $tags.remove()
        }
    }
    
    // TAGS PLUGIN DEFINITION
    // =======================
    
    function Plugin(option) {
        var args     = arguments
        var property = option
        
        return this.each(function () {
            var $this   = $(this)
            var options = $.extend({}, Tags.DEFAULTS, $this.data(), typeof option === 'object' && option)
            var data    = $this.data('bjui.tags')
            
            if (!data) $this.data('bjui.tags', (data = new Tags(this, options)))
            if (typeof property === 'string' && $.isFunction(data[property])) {
                [].shift.apply(args)
                if (!args) data[property]()
                else data[property].apply(data, args)
            } else {
                data.init()
            }
        })
    }
    
    var old = $.fn.tags
    
    $.fn.tags             = Plugin
    $.fn.tags.Constructor = Tags
    
    // TAGS NO CONFLICT
    // =================
    
    $.fn.tags.noConflict = function () {
        $.fn.tags = old
        return this
    }
    
    // TAGS DATA-API
    // ==============

    $(document).on(BJUI.eventType.initUI, function(e) {
        var $this = $(e.target).find('input[data-toggle="tags"]')
        
        if (!$this.length) return
        
        Plugin.call($this)
    })

}(jQuery);
/*!
 * B-JUI  v1.3 beta2 (http://b-jui.com)
 * Git@OSC (http://git.oschina.net/xknaan/B-JUI)
 * Copyright 2014 K'naan.
 * Licensed under Apache (http://www.apache.org/licenses/LICENSE-2.0)
 */

/* ========================================================================
 * B-JUI: bjui-upload.js  v1.3 beta2
 * @author K'naan
 * http://git.oschina.net/xknaan/B-JUI/blob/master/BJUI/js/bjui-upload.js
 * ========================================================================
 * Copyright 2014 K'naan.
 * Licensed under Apache (http://www.apache.org/licenses/LICENSE-2.0)
 * ======================================================================== */

+function ($) {
    'use strict';
    
    // UPLOAD CLASS DEFINITION
    // ======================
    var Upload = function(element, options) {
        this.$element      = $(element)
        this.options       = options
        this.tools         = this.TOOLS()
    }
    
    Upload.DEFAULTS = {
        fileTypeExts        : '*.jpg;*.png',     //允许上传的文件类型，格式'*.jpg;*.doc'
        uploader            : '',     //文件提交的地址
        auto                : false,  //是否开启自动上传
        method              : 'POST', //发送请求的方式，get或post
        multi               : false,  //是否允许选择多个文件
        formData            : {},     //发送给服务端的参数，格式：{key1:value1,key2:value2}
        fileObjName         : 'file', //在后端接受文件的参数名称，如PHP中的$_FILES['file']
        fileSizeLimit       : 204800, //允许上传的文件大小，单位KB
        previewImg          : true,   //是否预览上传图片
        previewLoadimg      : null,   //预览图片前的载入图标
        dragDrop            : false,  //是否允许拖动上传
        showUploadedPercent : true,   //是否实时显示上传的百分比，如20%
        showUploadedSize    : true,   //是否实时显示已上传的文件大小，如1M/2M
        buttonText          : '选择上传文件',     //上传按钮上的文字
        removeTimeout       : 1e3,              //上传完成后进度条的消失时间
        itemTemplate        : FRAG.uploadTemp,  //上传队列显示的模板
        breakPoints         : false,            //是否开启断点续传
        fileSplitSize       : 1024 * 1024,      //断点续传的文件块大小，单位Byte，默认1M
        onUploadStart       : null,  //上传开始时的动作
        onUploadSuccess     : null,  //上传成功的动作
        onUploadComplete    : null,  //上传完成的动作
        onUploadError       : null,  //上传失败的动作
        onInit              : null,  //初始化时的动作
        onCancel            : null,  //删除掉某个文件后的回调函数，可传入参数file
        onSelect            : null
    }
    
    Upload.MIMETYPES = {
        zip  :[ 'application/x-zip-compressed' ],
        jpg  :[ 'image/jpeg' ],
        png  :[ 'image/png' ],
        gif  :[ 'image/gif' ],
        swf  :[ 'application/x-shockwave-flash' ],
        doc  :[ 'application/msword' ],
        xls  :[ 'application/vnd.ms-excel' ],
        docx :[ 'application/vnd.openxmlformats-officedocument.wordprocessingml.document' ],
        xlsx :[ 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' ],
        ppt  :[ 'application/vnd.ms-powerpoint' ],
        pptx :[ 'application/vnd.openxmlformats-officedocument.presentationml.presentation' ],
        mp3  :[ 'audio/mpeg' ],
        mp4  :[ 'video/mp4' ],
        pdf  :[ 'application/pdf' ],
        txt  :[ 'text/plain' ],
        xml  :[ 'text/xml' ]
    }
    
    Upload.prototype.TOOLS = function() {
        var that  = this, options = this.options
        var tools = {
            //将文件的单位由bytes转换为KB或MB，若第二个参数指定为true，则永远转换为KB
            formatFileSize: function(size, byKB) {
                if (size > 1024 * 1024 && !byKB)
                    size = (Math.round(size * 100 / (1024 * 1024)) / 100).toString() + 'MB'
                else
                    size = (Math.round(size * 100 / 1024) / 100).toString() + 'KB'
                
                return size
            },
            //根据文件序号获取文件
            getFile: function(index, files) {
                for (var i = 0; i < files.length; i++) {
                    if (files[i].index == index) return files[i]
                }
                return false
            },
            //将输入的文件类型字符串转化为数组,原格式为*.jpg;*.png
            getFileTypes: function(str) {
                var result = []
                var arr1   = str.split(';')
                
                for (var i = 0; i < arr1.length; i++) {
                    result.push(arr1[i].split('.').pop())
                }
                return result
            },
            //根据后缀名获得文件的mime类型
            getMimetype: function(name) {
                return Upload.MIMETYPES[name]
            },
            //根据配置的字符串，获得上传组件accept的值
            getAcceptString: function(str) {
                var types  = this.getFileTypes(str)
                var result = []
                
                for (var i = 0; i < types.length; i++) {
                    var mime = this.getMimetype(types[i])
                    
                    if (mime) result.push(mime)
                    else result.push('.'+ types[i])
                }
                return result.join(',')
            },
            //过滤上传文件
            filter: function(files) {
                var arr = []
                var typeArray = this.getFileTypes(options.fileTypeExts)
                
                if (typeArray.length > 0) {
                    for (var i = 0; i < files.length; i++) {
                        var thisFile = files[i]
                        
                        if (parseInt(this.formatFileSize(thisFile.size, true)) > options.fileSizeLimit) {
                            that.$element.alertmsg('error', '文件"'+ thisFile.name +'"大小超出限制！')
                            continue
                        }
                        if ($.inArray(thisFile.name.split('.').pop().toLowerCase(), typeArray) >= 0) {
                            arr.push(thisFile)
                        } else {
                            that.$element.alertmsg('error', '文件"'+ thisFile.name +'"类型不允许！')
                        }
                    }
                }
                return arr
            },
            //获取选择文件，file控件
            getFiles: function(e) {
                var files = e.target.files || e.dataTransfer.files // 获取文件列表对象
                
                files = this.filter(files)
                for (var i = 0; i < files.length; i++) {
                    files[i].id     = files[i].lastModifiedDate.getTime() +'_'+ files[i].size +'_'+ (files[i].type || '').replace(/\W/g, '')
                    this.renderQueueItem(files[i])
                    that.queueData.files++
                }
                
                return files
            },
            //生成上传队列Dom
            renderQueueItem: function(file) {
                var uploadedSize = 0
                var $temp = $(options.itemTemplate
                        .replace('{fileId}', file.id)
                        .replace('{fileName}', file.name)
                        .replace('#upConfirm#', BJUI.regional.upload.upConfirm)
                        .replace('#upPause#', BJUI.regional.upload.upPause)
                        .replace('#upCancel#', BJUI.regional.upload.upCancel)
                        .replace('{percent}', '0.00%')
                        .replace('{uploadedSize}', '0KB')
                        .replace('{fileSize}', this.formatFileSize(file.size)))
                
                //如果是自动上传，去掉上传按钮
                if (options.auto) {
                    $temp.find('> .info > .up_confirm').remove()
                }
                $temp.data('upfile', file)
                that.$uploadFileList.append($temp)
                //如果断点续传
                if (options.breakPoints) {
                    uploadedSize = this.getUploadedSize(file.id)
                    if (uploadedSize > file.size) uploadedSize = file.size
                }
                this.showProgress(file.id, uploadedSize, file.size)
                //判断是否预览图片
                if (options.previewImg && file.type.indexOf('image') != -1) {
                    var $prevbox = $temp.find('> .preview > .img')
                    
                    if (options.previewLoadimg) $prevbox.html('<img src="'+ options.previewLoadimg +'" height="114">')
                    this.previewImg(file, $prevbox)
                } else {
                    $temp.find('> .preview').remove()
                }
                //判断是否显示已上传文件大小
                if (options.showUploadedSize) {
                    var $fileSize = $temp.find('> .filesize')
                    
                    $fileSize.find('> .uploadedsize').html(this.formatFileSize(uploadedSize))
                    $fileSize.find('> .filesize').html(this.formatFileSize(file.size))
                } else {
                    $temp.find('> .filesize').remove()
                }
                //判断是否显示上传百分比
                if (options.showUploadedPercent) {
                    $temp.find('> .percent').html((uploadedSize / file.size * 100).toFixed(2) +'%')
                } else {
                    $temp.find('> .percent').remove()
                }
                options.onSelect && options.onSelect(files)
                //判断是否是自动上传
                if (options.auto) that.fileUpload(file, uploadedSize)
                
                $temp.on('click.bjui.upload.confirm', '.up_confirm', function(e) {
                    var $this = $(this), $queue = $this.closest('.item')
                    
                    $this.hide().next().show()
                    that.fileUpload($queue.data('upfile'), uploadedSize)
                })
                $temp.on('click.bjui.upload.cancel', '.up_cancel', this.removeQueueItem)
            },
            successQueueItem: function(file, xhr) {
                tools.showProgress(file.id, file.size, file.size)
                options.onUploadSuccess && options.onUploadSuccess.toFunc().call(that, file, xhr.responseText, that.$element)
                //在指定的间隔时间后删掉进度条
                setTimeout(function() {
                    that.$element.find('#'+ file.id).fadeOut('normal', function() {
                        $(this).remove()
                        var filelen = that.$element.find('> .queue > .item:visible').length
                        
                        if (!filelen) {
                            that.$element.find('> .queue').hide()
                            that.$file.val('')
                        }
                    })
                }, options.removeTimeout)
            },
            removeQueueItem: function(e, xhr) {
                if (xhr) xhr.abort()
                
                $(this).closest('.item').fadeOut('normal', function() {
                    $(this).remove()
                    
                    var filelen = that.$element.find('> .queue > .item:visible').length
                    
                    if (!filelen) that.$element.find('> .queue').hide()
                })
                
                e.preventDefault()
            },
            //预览上传图片
            previewImg: function(file, $obj) {
                if (file && $obj.length) {
                    var reader = new FileReader()
                    
                    reader.onload = function(e) {
                        $obj.html('<img src="'+ e.target.result +'">')
                    }
                    reader.readAsDataURL(file)
                }
            },
            //上传进度条
            showProgress: function(fileId, uploadedSize, fileSize) {
                var initWidth     = uploadedSize / fileSize * 100 +'%',
                    initFileSize  = that.tools.formatFileSize(uploadedSize),
                    initUppercent = (uploadedSize / fileSize * 100).toFixed(2) +'%'
                that.$element.find('#'+ fileId +' > .progress > .bar').css('width', initWidth)
            },
            //断点续传：获取已上传的文件片断大小
            getUploadedSize: function(fileId) {
                return localStorage.getItem(fileId) * 1
            },
            //断点续传：保存已上传的文件片断大小
            saveUploadedSize:function(fileId, value) {
                localStorage.setItem(fileId, value)
            },
            //发送文件块函数
            sendBlob: function(url, xhr, file, formdata) {
                var fd = new FormData()
                
                xhr.open(options.method, url, true)
                xhr.setRequestHeader('X-Requested-With', 'XMLHttpRequest')
                //xhr.setRequestHeader('X_Requested_With', location.href.split('/')[5].replace(/[^a-z]+/g, '$'))
                fd.append(options.fileObjName, file)
                if (formdata) {
                    for (var key in formdata) {
                        fd.append(key, formdata[key])
                    }
                }
                xhr.send(fd)
            }
        }
        
        return tools
    }
    
    Upload.prototype.init = function() {
        var that     = this
        var $element = this.$element
        var options  = this.options
        
        if (!(options.uploader)) {
            BJUI.debug('Upload Plugin: The options uploader is undefined!')
            return
        } else {
            options.uploader = decodeURI(options.uploader).replacePlh($element.closest('.unitBox'))
            
            if (!options.uploader.isFinishedTm()) {
                $element.alertmsg('error', (options.warn || BJUI.regional.plhmsg))
                BJUI.debug('Upload Plugin: The options uploader is incorrect: '+ options.uploader)
                return
            }
            
            options.uploader = encodeURI(options.uploader)
        }
        
        if ($element.hasClass('bjui-upload')) return
        if (options.formData && typeof options.formData === 'string') {
            options.formData = options.formData.toObj()
        }
        
        var $uploadFrag = $(FRAG.uploadFrag
            .replaceAll('#multi#', options.multi ? 'multiple' : '')
            .replaceAll('#accept#', that.tools.getAcceptString(options.fileTypeExts))
            .replaceAll('#btnTxt#', (options.icon ? '<i class="fa fa-'+ options.icon +'">&nbsp;&nbsp;' : '') + options.buttonText))
        
        $element
            .addClass('bjui-upload')
            .append($uploadFrag)
        
        this.$file           = $element.find('> .bjui-upload-select-file')
        this.$uploadFileList = $element.find('> .queue')
        this.queueData       = { files:0, success:0, error:0 }
        
        //do select files
        $element
            .on('change.bjui.upload', '.bjui-upload-select-file', function(e) {
                that.fileSelect(e)
            })
            .on('click.bjui.upload', '.bjui-upload-select', function(e) {
                that.$file.trigger('click')
            })
        
        options.onInit && options.onInit()
        
        //如果允许拖动上传
        if (options.dragDrop) {
            /* 拖拽元素在目标元素头上移动的时候 */
            $element[0].ondragover = function(ev) {
                ev.preventDefault()
                return true
            }
            
            $element[0].ondrop = function(e) { 
                that.fileSelect(e)
                
                e.stopPropagation()
                e.preventDefault()
            }
        }
    }
    
    Upload.prototype.fileSelect = function(e) {
        this.$uploadFileList.show()
        this.tools.getFiles(e)
    }
    
    Upload.prototype.fileUpload = function(file, uploadedSize) {
        var that = this, $element = that.$element, options = that.options, tools = that.tools
        var xhr  = false, originalFile = file
        
        //校正进度条和上传比例的误差
        xhr = new XMLHttpRequest()
        
        if (options.breakPoints) {
            //对文件进行切割，并保留原来的信息
            file = originalFile.slice(uploadedSize, uploadedSize + options.fileSplitSize)
        }
        if (xhr.upload) {
            // 上传进度
            xhr.upload.onprogress = function(e) { that.onProgress(file, e.loaded, originalFile.size) }
            // 上传回调
            xhr.onreadystatechange = function(e) {
                if (xhr.readyState == 4 && xhr.status == 200) {
                    var returnData = JSON.parse(xhr.responseText), upOver = false
                    if (options.breakPoints) {
                        //更新已上传文件大小，保存到本地
                        uploadedSize += options.fileSplitSize
                        tools.saveUploadedSize(originalFile.id, uploadedSize)
                        //继续上传其他片段
                        if (uploadedSize < originalFile.size) {
                            file = originalFile.slice(uploadedSize, uploadedSize + options.fileSplitSize)
                            //上传文件
                            tools.sendBlob(options.uploader, xhr, file, options.formData)
                        } else {
                            upOver = true
                        }
                    } else {
                        upOver = true
                    }
                    if (upOver) {
                        that.queueData.success++
                        tools.successQueueItem(originalFile, xhr)
                        options.onUploadComplete && options.onUploadComplete(originalFile, xhr.responseText)
                    }
                } else {
                    that.queueData.error++
                    //错误回调
                    options.onUploadError && options.onUploadError(originalFile, xhr.responseText)
                }
                //队列完成回调
                if (options.onQueueComplete) {
                    if (that.queueData.files = that.queueData.success + that.queueData.error)
                        option.onQueueComplete(that.queueData)
                }
            }
            options.onUploadStart && options.onUploadStart()
            
            //开始上传
            options.formData.fileName = originalFile.name
            options.formData.lastModifiedDate = originalFile.lastModifiedDate.getTime()
            tools.sendBlob(options.uploader, xhr, file, options.formData)
        }
        
        //暂停事件
        $element
            .find('#'+ originalFile.id +' > .info > .up_pause')
            .on('click.bjui.upload.pause', function(e) {
                xhr.abort()
                $(this).hide().prev().show()
            })
        
        //取消事件
        $element
            .find('#'+ originalFile.id +' > .info > .up_cancel')
            .off('click.bjui.upload.cancel')
            .on('click.bjui.upload.cancel', $.proxy(function(e) {
                this.tools.removeQueueItem(e, xhr)
            }, this))
    }
    
    Upload.prototype.onProgress = function(file, loaded, total) {
        var that        = this, options = that.options
        var $progress   = that.$element.find('#'+ file.id + ' .progress')
        var thisLoaded  = loaded
        //根据上一次触发progress时上传的大小，得到本次的增量
        var lastLoaded  = $progress.attr('lastLoaded') || 0
        
        loaded -= parseInt(lastLoaded)
        if (loaded > file.size) loaded = file.size
        
        that.$progressBar = $progress.children('.bar')
        var oldWidth      = options.breakPoints ? parseFloat(that.$progressBar.get(0).style.width || 0) : 0
        var percent       = (loaded / total * 100 + oldWidth).toFixed(2)
        var percentText   = percent > 100 ? '100%' : percent + '%'
        
        //校正四舍五入的计算误差
        if (options.showUploadedSize) {
            var $filesize = $progress.nextAll('.filesize')
            
            $filesize.find('> .uploadedsize').text(that.tools.formatFileSize(loaded))
        }
        if (options.showUploadedPercent) {
            $progress.nextAll('.up_percent').text(percentText)
        }
        that.$progressBar.css('width', percentText)
        //记录本次触发progress时已上传的大小，用来计算下次需增加的数量
        if (thisLoaded < options.fileSplitSize) {
            $progress.attr('lastLoaded', thisLoaded)
        } else {
            $progress.removeAttr('lastLoaded')
        }
    }
    
    Upload.prototype.destroy = function() {
        
    }
    
    // UPLOAD PLUGIN DEFINITION
    // =======================
    
    function Plugin(option) {
        var args     = arguments,
            property = option
        
        if (window.FileReader) {
            return this.each(function () {
                var $this   = $(this),
                    options = $.extend({}, Upload.DEFAULTS, $this.data(), typeof option === 'object' && option),
                    data    = $this.data('bjui.upload')
                
                if (!data) $this.data('bjui.upload', (data = new Upload(this, options)))
                if (typeof property === 'string' && $.isFunction(data[property])) {
                    [].shift.apply(args)
                    if (!args) data[property]()
                    else data[property].apply(data, args)
                } else {
                    data.init()
                }
            })
        } else { //for IE8-9
            this.each(function() {
                if (!$.fn.uploadify) return
                var options = {
                    swf           : BJUI.PLUGINPATH +'uploadify/scripts/uploadify.swf',
                    fileTypeExts  : '*.jpg;*.png',
                    id            : 'fileInput',
                    fileObjName   : 'file',
                    fileSizeLimit : 204800,
                    buttonText    : '选择上传文件',
                    auto          : false,
                    multi         : false,
                    height        : 24
                }
                var $element = $(this), op = $element.data()
                
                if (!op.id) op.id = $element.attr('id')
                $.extend(options, op)
                if (!(options.uploader)) {
                    BJUI.debug('Upload Plugin: The options uploader is undefined!')
                    return
                } else {
                    options.uploader = decodeURI(options.uploader).replacePlh($element.closest('.unitBox'))
                    
                    if (!options.uploader.isFinishedTm()) {
                        $element.alertmsg('error', (options.warn || BJUI.regional.plhmsg))
                        BJUI.debug('Upload Plugin: The options uploader is incorrect: '+ options.uploader)
                        return
                    }
                    
                    options.uploader = encodeURI(options.uploader)
                }
                if (options.id == 'fileInput') options.id = options.id + (new Date().getTime())
                var $file = $('<input type="file" name="'+ options.name +'" id="'+ options.id +'">')
                
                if (options.onInit && typeof options.onInit === 'string')
                    options.onInit = options.onInit.toFunc()
                if (options.onCancel && typeof options.onCancel === 'string')
                    options.onCancel = options.onCancel.toFunc()
                if (options.onSelect && typeof options.onSelect === 'string')
                    options.onSelect = options.onSelect.toFunc()
                if (options.onUploadSuccess && typeof options.onUploadSuccess === 'string')
                    options.onUploadSuccess = options.onUploadSuccess.toFunc()
                if (options.onUploadComplete && typeof options.onUploadComplete === 'string')
                    options.onUploadComplete = options.onUploadComplete.toFunc()
                if (options.onUploadError && typeof options.onUploadError === 'string')
                    options.onUploadError   = options.onUploadError.toFunc()
                
                $file.appendTo($element)
                if (!options.auto) {
                    var $upBtn = $('<button class="btn btn-orange" data-icon="cloud-upload">开始上传</button>')
                    
                    $upBtn
                        .hide()
                        .insertAfter($element)
                        .click(function() {
                            $file.uploadify('upload', '*');
                            $(this).hide()
                        })
                        
                    options.onSelect = function() {
                        $upBtn.show()
                    }
                }
                $file.uploadify(options)
            })
        }
    }
    
    var old = $.fn.upload
    
    $.fn.upload             = Plugin
    $.fn.upload.Constructor = Upload
    
    // UPLOAD NO CONFLICT
    // =================
    
    $.fn.upload.noConflict = function () {
        $.fn.upload = old
        return this
    }
    
    // UPLOAD DATA-API
    // ==============
    
    $(document).on(BJUI.eventType.initUI, function(e) {
        var $this = $(e.target).find('[data-toggle="upload"]')
        
        if (!$this.length) return
        
        Plugin.call($this)
    })

}(jQuery);
/*!
 * B-JUI  v1.3 beta2 (http://b-jui.com)
 * Git@OSC (http://git.oschina.net/xknaan/B-JUI)
 * Copyright 2014 K'naan.
 * Licensed under Apache (http://www.apache.org/licenses/LICENSE-2.0)
 */

/* ========================================================================
 * B-JUI: bjui-theme.js  v1.3 beta2
 * @author K'naan
 * http://git.oschina.net/xknaan/B-JUI/blob/master/BJUI/js/bjui-theme.js
 * ========================================================================
 * Copyright 2014 K'naan.
 * Licensed under Apache (http://www.apache.org/licenses/LICENSE-2.0)
 * ======================================================================== */

+function ($) {
    'use strict';
    
    // THEME GLOBAL ELEMENTS
    // ======================
    
    var $themeLink, $themeLis
    
    $(function() {
        var INIT_THEME = function() {
            $themeLink = $('#bjui-link-theme')
            $themeLis  = $('#bjui-themes')
            if ($.cookie) {
                var themeName = $.cookie('bjui_theme') || 'blue'
                var $li = $themeLis.find('a.theme_'+ themeName)
                
                $li.theme({})
            }
        }
        
        INIT_THEME()
    })
    
    // THEME CLASS DEFINITION
    // ======================
    var Theme = function(element, options) {
        this.$element = $(element)
        this.options  = options
    }
    
    Theme.DEFAULTS = {
        theme: 'purple'
    }
    
    Theme.prototype.init = function() {
        if (!$themeLink.length) return
        var themeHref = $themeLink.attr('href')
        
        themeHref = themeHref.substring(0, themeHref.lastIndexOf('/'))
        themeHref = themeHref.substring(0, themeHref.lastIndexOf('/'))
        themeHref += '/'+ this.options.theme +'/core.css'
        $themeLink.attr('href', themeHref)
        
        var $themeA = this.$element.closest('ul').prev()
        var classA  = $themeA.attr('class')
        
        classA      = classA.replace(/(theme[\s][a-z]*)/g, '')
        $themeA.removeClass().addClass(classA).addClass('theme').addClass(this.options.theme)
        $themeLis.find('li').removeClass('active')
        this.$element.parent().addClass('active')
        this.cookie()
    }
    
    Theme.prototype.setTheme = function(themeName) {
        $themeLis.find('a.theme_'+ themeName).trigger('click')
    }
    
    Theme.prototype.cookie = function() {
        var theme = this.options.theme
        
        if ($.cookie) $.cookie('bjui_theme', theme, { path: '/', expires: 30 });
    }
    
    // THEME PLUGIN DEFINITION
    // =======================
    
    function Plugin(option) {
        var args     = arguments
        var property = option
        
        return this.each(function () {
            var $this   = $(this)
            var options = $.extend({}, Theme.DEFAULTS, $this.data(), typeof option === 'object' && option)
            var data    = $this.data('bjui.theme')
            
            if (!data) $this.data('bjui.theme', (data = new Theme(this, options)))
            if (typeof property === 'string' && $.isFunction(data[property])) {
                [].shift.apply(args)
                if (!args) data[property]()
                else data[property].apply(data, args)
            } else {
                data.init()
            }
        })
    }
    
    var old = $.fn.theme
    
    $.fn.theme             = Plugin
    $.fn.theme.Constructor = Theme
    
    // THEME NO CONFLICT
    // =================
    
    $.fn.theme.noConflict = function () {
        $.fn.theme = old
        return this
    }
    
    // THEME DATA-API
    // ==============

    $(document).on('click.bjui.theme.data-api', '[data-toggle="theme"]', function(e) {
        Plugin.call($(this))
        
        e.preventDefault()
    })

}(jQuery);
/*!
 * B-JUI  v1.3 beta2 (http://b-jui.com)
 * Git@OSC (http://git.oschina.net/xknaan/B-JUI)
 * Copyright 2014 K'naan.
 * Licensed under Apache (http://www.apache.org/licenses/LICENSE-2.0)
 */

/* ========================================================================
 * B-JUI: bjui-initui.js  v1.3 beta2
 * @author K'naan
 * http://git.oschina.net/xknaan/B-JUI/blob/master/BJUI/js/bjui-initui.js
 * ========================================================================
 * Copyright 2014 K'naan.
 * Licensed under Apache (http://www.apache.org/licenses/LICENSE-2.0)
 * ======================================================================== */

+function ($) {
    'use strict';
    
    // INITUI CLASS DEFINITION
    // ======================
    var Initui = function(element, options) {
        var $this     = this
        this.$element = $(element)
        this.options  = options
    }
    
    Initui.DEFAULTS = {}
    
    Initui.prototype.init = function() {
        var that = this, $element = that.$element
        
        $.when(that.initUI()).done(function(){
            $element.trigger(BJUI.eventType.afterInitUI)
        })
    }
    
    Initui.prototype.initUI = function() {
        var $element = this.$element
        
        $.when($element.trigger(BJUI.eventType.beforeInitUI)).done(function(){
            $element.trigger(BJUI.eventType.initUI)
        })
    }
    
    // INITUI PLUGIN DEFINITION
    // =======================
    
    function Plugin(option) {
        var args     = arguments,
            property = option
        
        return this.each(function () {
            var $this   = $(this),
                options = $.extend({}, Initui.DEFAULTS, $this.data(), typeof option === 'object' && option),
                data    = $this.data('bjui.initui')
            
            if (!data) $this.data('bjui.initui', (data = new Initui(this, options)))
            
            if (typeof property === 'string' && $.isFunction(data[property])) {
                [].shift.apply(args)
                if (!args) data[property]()
                else data[property].apply(data, args)
            } else {
                data.init()
            }
        })
    }

    var old = $.fn.initui

    $.fn.initui             = Plugin
    $.fn.initui.Constructor = Initui
    
    // INITUI NO CONFLICT
    // =================
    
    $.fn.initui.noConflict = function () {
        $.fn.initui = old
        return this
    }
    
    // INITUI DATA-API
    // ==============

    $(document).on('click.bjui.initui.data-api', '[data-toggle="initui"]', function(e) {
        Plugin.call($this, $this.data())
        
        e.preventDefault()
    })
    
    /* beforeInitUI */
    $(document).on(BJUI.eventType.beforeInitUI, function(e) {
        var $box    = $(e.target)
        var noinits = []
        var $noinit = $box.find('[data-noinit]')
        
        //progress
        $box.find('> .bjui-maskProgress').find('.progress').stop().animate({width:'85%'}, 'fast')
        
        // Hide not need to initialize the UI DOM
        $noinit.each(function(i) {
            var $this   = $(this)
            var pos     = {}
                        
            pos.$target = $this
            pos.$next   = $this.next()
            pos.$prev   = $this.prev()
            pos.$parent = $this.parent()
            pos.visible = $this.is(':visible') ? true : false
            
            noinits.push(pos)
            $this.remove()
        })
        
        $box.data('bjui.noinit', noinits)
    })
    
    /* initUI */
    $(document).on(BJUI.eventType.initUI, function(e) {
        var $box    = $(e.target)
        
        //progress
        $box.find('> .bjui-maskProgress').find('.progress').stop().animate({width:'95%'}, 'fast')
    })
    
    /* afterInitUI */
    $(document).on(BJUI.eventType.afterInitUI, function(e) {
        var $box    = $(e.target)
        var noinits = $box.data('bjui.noinit')
        var $form   = $box.find('> .bjui-pageContent').find('form')
        
        // Recovery not need to initialize the UI DOM
        if (noinits) {
            $.each(noinits, function(i, n) {
                if (n.$next.length) n.$next.before(n.$target)
                else if (n.$prev.length) n.$prev.after(n.$target)
                else if (n.$parent.length) n.$parent.append(n.$target)
                
                if (n.visible) n.$target.show()
                
                $box.removeData('bjui.noinit')
            })
        }
        
        /* resizePageH */
        $box.resizePageH()
        
        //submit
        if ($form.length) {
            $box.find('> .bjui-pageFooter').find(':submit').on('click.bjui.submit', function(e) {
                e.preventDefault()
                
                $form.submit()
            })
        }
        
        //progress
        $box.find('> .bjui-maskProgress').find('.progress').stop().animate({width:'100%'}, 'fast', function() {
            $box.find('> .bjui-ajax-mask').fadeOut('normal', function() { $(this).remove() })
        })
    })
    
    /* Lateral Navigation */
    $(document).one(BJUI.eventType.afterInitUI, function(e) {
        var $hnavbar = $('#bjui-hnav-navbar'), $active = $hnavbar.find('> li.active')
        
        if ($active.length && $active.find('> .items').length) {
            $active.find('> a').trigger('click')
        }
    })
    
    /* ajaxStatus */
    var bjui_ajaxStatus = function($target) {
        var $this    = $target
        var $offset  = $this
        var position = $this.css('position')
        
        if (position == 'static') $offset  = $this.offsetParent()
        
        var zIndex   = parseInt($offset.css('zIndex')) || 0
        var $ajaxBackground = $this.find('> .bjui-maskBackground')
        var $ajaxProgress   = $this.find('> .bjui-maskProgress')
            
        if (!$ajaxBackground.length) {
            $ajaxBackground = $(FRAG.maskBackground)
            $ajaxProgress   = $(BJUI.doRegional(FRAG.maskProgress, BJUI.regional))
            $this.prepend($ajaxBackground).prepend($ajaxProgress)
        }
        
        var bgZindex = parseInt($ajaxBackground.css('zIndex')) || 0
        var prZindex = parseInt($ajaxProgress.css('zIndex')) || 0
        
        $ajaxBackground.css('zIndex', zIndex + 1)
        $ajaxProgress.css('zIndex', zIndex + 2)
        
        return {$bg:$ajaxBackground, $pr:$ajaxProgress}
    }
    
    $(document)
        .on('bjui.ajaxStart', function(e, timeout, callback) {
            var ajaxMask = bjui_ajaxStatus($(e.target))
            
            ajaxMask.$bg.fadeIn()
            ajaxMask.$pr.fadeIn()
            ajaxMask.$pr.find('.progress').animate({width:'80%'}, timeout || 500)
            
            if (callback) {
                setTimeout(function() {
                    callback.toFunc().call(this)
                }, 25)
            }
        })
        .on('bjui.ajaxStop', function(e) {
            var ajaxMask = bjui_ajaxStatus($(e.target))
            
            ajaxMask.$pr.find('.progress').animate({width:'100%'}, 'fast', function() {
                ajaxMask.$bg.remove()
                ajaxMask.$pr.remove()
            })
        })
        .on('bjui.ajaxError', function(e) {
            var ajaxMask = bjui_ajaxStatus($(e.target))
            
            ajaxMask.$bg.remove()
            ajaxMask.$pr.remove()
        })
    
    $(document).on(BJUI.eventType.ajaxStatus, function(e) {
        var $target = $(e.target), ajaxMask = bjui_ajaxStatus($target)
        
        $target
            .one('ajaxStart', function() {
                ajaxMask.$bg.fadeIn()
                ajaxMask.$pr.fadeIn()
                
                ajaxMask.$pr.find('.progress').animate({width:'10%'}, 'fast')
            })
            .one('ajaxStop', function() {
                //ajaxMask.$bg.fadeOut()
                //ajaxMask.$pr.fadeOut()
                //ajaxMask.$pr.find('.progress').animate({width:'80%'}, 'fast')
            })
            .one('ajaxError', function() {
                ajaxMask.$bg.remove()
                ajaxMask.$pr.remove()
            })
    })
    
    /* Clean plugins generated 'Dom elements' in the body */
    var bodyClear = function($target) {
        $target.find('select[data-toggle="selectpicker"]').selectpicker('destroyMenu')
        $target.find('[data-toggle="selectztree"]').trigger('destroy.bjui.selectztree')
    }
    
    $(document).on(BJUI.eventType.beforeLoadDialog, function(e) {
        
    }).on(BJUI.eventType.beforeAjaxLoad, function(e) {
        bodyClear($(e.target))
    }).on(BJUI.eventType.beforeCloseNavtab, function(e) {
        bodyClear($(e.target))
    }).on(BJUI.eventType.beforeCloseDialog, function(e) {
        bodyClear($(e.target))
    })
    
    /* other */
    $(function() {
        $(document).on('keydown keyup', function(e) {
            if (e.which === BJUI.keyCode.CTRL) {
                BJUI.KeyPressed.ctrl = e.type == 'keydown' ? true : false
            }
            if (e.which === BJUI.keyCode.SHIFT) {
                BJUI.KeyPressed.shift = e.type == 'keydown' ? true : false
            }
        })
    })
    
}(jQuery);
/*!
 * B-JUI  v1.3 beta2 (http://b-jui.com)
 * Git@OSC (http://git.oschina.net/xknaan/B-JUI)
 * Copyright 2014 K'naan.
 * Licensed under Apache (http://www.apache.org/licenses/LICENSE-2.0)
 */

/* ========================================================================
 * B-JUI: bjui-plugins.js  v1.3 beta2
 * @author K'naan
 * http://git.oschina.net/xknaan/B-JUI/blob/master/BJUI/js/bjui-plugins.js
 * ========================================================================
 * Copyright 2014 K'naan.
 * Licensed under Apache (http://www.apache.org/licenses/LICENSE-2.0)
 * ======================================================================== */

+function ($) {
    'use strict';
    
    $(document).on(BJUI.eventType.initUI, function(e) {
        var $box    = $(e.target)
        
        // UI init begin...
        
        /* i-check */
        if ($.fn.iCheck) {
            var $icheck = $box.find('input[data-toggle="icheck"]')
            
            $icheck.each(function(i) {
                var $element = $(this),
                    id       = $element.attr('id'),
                    name     = $element.attr('name'),
                    label    = $element.data('label')
                
                if (label) $element.after('<label for="'+ id +'" class="ilabel">'+ label +'</label>')
                
                $element
                    .on('ifCreated', function(e) {
                        /* Fixed validate msgbox position */
                        var $parent = $(this).closest('div'),
                            $ilabel = $parent.next('[for="'+ id +'"]')
                        
                        $parent.attr('data-icheck', name)
                        $ilabel.attr('data-icheck', name)
                    })
                    .iCheck({
                        checkboxClass : 'icheckbox_minimal-purple',
                        radioClass    : 'iradio_minimal-purple',
                        increaseArea  : '20%' // optional
                    })
                    .on('ifChanged', function() {
                        /* Trigger validation */
                        $.fn.validator && $(this).trigger('validate')
                    })
                
                if ($element.prop('disabled')) $element.iCheck('disable')
            })
            /* i-check check all */
            $icheck.filter('.checkboxCtrl').on('ifChanged', function(e) {
                var checked = e.target.checked == true ? 'check' : 'uncheck'
                var group   = $(this).data('group')
                
                $box.find(':checkbox[name="'+ group +'"]').iCheck(checked)
            })
        }
        
        /* fixed ui style */
        $box.find('button').each(function() {
            var $element = $(this), icon = $element.data('icon')
            
            $element.addClass('btn')
            
            if (icon && !$element.find('> i').length) {
                icon = 'fa-'+ icon.replace('fa-', '')
                
                if (!$element.data('bjui.icon')) {
                    $element.html('<i class="fa '+ icon +'"></i> '+ $element.html()).data('bjui.icon', true)
                }
            }
        })
        
        $box.find('input:text, input:password').each(function() {
            var $element = $(this).addClass('form-control'), size = $element.attr('size') || 0, width = size * 10
                
            width && $element.css('width', width)
        })
        
        $box.find('textarea').each(function() {
            var $element = $(this).addClass('form-control'), cols = $element.attr('cols') || 0, width = cols * 10, toggle = $element.attr('data-toggle')
                
            width && $element.css('width', width)
            
            if (toggle && toggle == 'autoheight' && $.fn.autosize)
                $element.addClass('autosize').autosize()
        })
        
        $box.find('a.btn').each(function() {
            var $element = $(this), icon = $element.data('icon')
                
            if (icon && !$element.find('> i').length) {
                icon = 'fa-'+ icon.replace('fa-', '')
                
                if (!$element.data('bjui.icon')) {
                    $element.html('<i class="fa '+ icon +'"></i> '+ $element.html()).data('bjui.icon', true)
                }
            }
        })
        
        /* form validate */
        if ($.fn.validator) {
            $box.find('form[data-toggle="validate"]').each(function() {
                var $element = $(this), alertmsg = (typeof $element.data('alertmsg') == 'undefined') ? true : $element.data('alertmsg')
                
                $(this)
                    .validator({
                        valid: function(form) {
                            $(form).bjuiajax('ajaxForm', $(form).data())
                        },
                        validClass : 'ok',
                        theme      : 'red_right_effect'
                    })
                    .on('invalid.form', function(e, form, errors) {
                        if (alertmsg) $(form).alertmsg('error', BJUI.regional.validatemsg.replaceMsg(errors.length))
                    })
            })
        }
        
        /* moreSearch */
        $box.find('[data-toggle="moresearch"]').each(function() {
            var $element = $(this),
                $parent  = $element.closest('.bjui-pageHeader'),
                $more    = $parent && $parent.find('.bjui-moreSearch'),
                name     = $element.data('name')
            
            if (!$element.attr('title')) $element.attr('title', '更多查询条件')
            $element.click(function(e) {
                if (!$more.length) {
                    BJUI.debug('Not created \'moresearch\' box[class="bjui-moreSearch"]!')
                    return
                }
                $more.css('top', $parent.outerHeight() - 1)
                if ($more.is(':visible')) {
                    $element.html('<i class="fa fa-angle-double-down"></i>')
                    if (name) $('body').data('moresearch.'+ name, false)
                } else {
                    $element.html('<i class="fa fa-angle-double-up"></i>')
                    if (name) $('body').data('moresearch.'+ name, true)
                }
                $more.fadeToggle('slow', 'linear')
                
                e.preventDefault()
            })
            
            if (name && $('body').data('moresearch.'+ name)) {
                $more.css('top', $parent.outerHeight() - 1).fadeIn()
                $element.html('<i class="fa fa-angle-double-up"></i>')
            }
        })
        
        /* bootstrap - select */
        if ($.fn.selectpicker) {
            var $selectpicker       = $box.find('select[data-toggle="selectpicker"]')
            var bjui_select_linkage = function($obj, $next) {
                if (!$next || !$next.length) return
                
                var refurl    = $obj.data('refurl')
                var _setEmpty = function($select) {
                    var $_nextselect = $($select.data('nextselect'))
                    
                    if ($_nextselect && $_nextselect.length) {
                        var emptytxt = $_nextselect.data('emptytxt') || '&nbsp;'
                        
                        $_nextselect.html('<option>'+ emptytxt +'</option>').selectpicker('refresh')
                        _setEmpty($_nextselect)
                    }
                }
                
                if (($next && $next.length) && refurl) {
                    var val = $obj.data('val'), nextVal = $next.data('val')
                    
                    if (typeof val === 'undefined') val = $obj.val()
                    $.ajax({
                        type     : 'POST',
                        dataType : 'json', 
                        url      : refurl.replace('{value}', encodeURIComponent(val)), 
                        cache    : false,
                        data     : {},
                        success  : function(json) {
                            if (!json) return
                            
                            var html = '', selected = ''
                            
                            $.each(json, function(i) {
                                var value, label
                                
                                if (json[i] && json[i].length) {
                                    value = json[i][0]
                                    label = json[i][1]
                                } else {
                                    value = json[i].value
                                    label = json[i].label
                                }
                                if (typeof nextVal !== 'undefined') selected = value == nextVal ? ' selected' : ''
                                html += '<option value="'+ value +'"'+ selected +'>' + label + '</option>'
                            })
                            
                            $obj.removeAttr('data-val').removeData('val')
                            $next.removeAttr('data-val').removeData('val')
                            
                            if (!html) {
                                html = $next.data('emptytxt') || '&nbsp;'
                                html = '<option>'+ html +'</option>'
                            }
                            
                            $next.html(html).selectpicker('refresh')
                            _setEmpty($next)
                        },
                        error   : BJUI.ajaxError
                    })
                }
            }
            
            $selectpicker.each(function() {
                var $element  = $(this)
                var options   = $element.data()
                var $next     = $(options.nextselect)
                
                $element.addClass('show-tick')
                if (!options.style) $element.data('style', 'btn-default')
                if (!options.width) $element.data('width', 'auto')
                if (!options.container) $element.data('container', 'body')
                else if (options.container == true) $element.attr('data-container', 'false').data('container', false)
                
                $element.selectpicker()
                
                if ($next && $next.length && (typeof $next.data('val') != 'undefined'))
                    bjui_select_linkage($element, $next)
            })
            
            /* bootstrap - select - linkage && Trigger validation */
            $selectpicker.change(function() {
                var $element    = $(this)
                var $nextselect = $($element.data('nextselect'))
                
                bjui_select_linkage($element, $nextselect)
                
                /* Trigger validation */
                if ($element.attr('aria-required')) {
                    $.fn.validator && $element.trigger('validate')
                }
            })
        }
        
        if ($.fn.zTree) {
            /* zTree - plugin */
            $box.find('[data-toggle="ztree"]').each(function() {
                var $this = $(this), op = $this.data(), options = op.options, _setting
                
                if (options && typeof options === 'string') options = options.toObj()
                if (options) $.extend(op, typeof options === 'object' && options)
                
                _setting = op.setting
                
                if (!op.nodes) {
                    op.nodes = []
                    $this.find('> li').each(function() {
                        var $li   = $(this)
                        var node  = $li.data()
                        
                        if (node.pid) node.pId = node.pid
                        node.name = $li.html()
                        op.nodes.push(node)
                    })
                    $this.empty()
                } else {
                    if (typeof op.nodes === 'string') {
                        if (op.nodes.trim().startsWith('[') || op.nodes.trim().startsWith('{')) {
                            op.nodes = op.nodes.toObj()
                        } else {
                            op.nodes = op.nodes.toFunc()
                        }
                    }
                    if (typeof op.nodes === 'function') {
                        op.nodes = op.nodes.call(this)
                    }
                    
                    $this.removeAttr('data-nodes')
                }
                
                if (!op.showRemoveBtn) op.showRemoveBtn = false
                if (!op.showRenameBtn) op.showRenameBtn = false
                if (op.addHoverDom && typeof op.addHoverDom !== 'function')       op.addHoverDom    = (op.addHoverDom === 'edit')    ? _addHoverDom    : op.addHoverDom.toFunc()
                if (op.removeHoverDom && typeof op.removeHoverDom !== 'function') op.removeHoverDom = (op.removeHoverDom === 'edit') ? _removeHoverDom : op.removeHoverDom.toFunc()
                if (!op.maxAddLevel)   op.maxAddLevel   = 2
                
                var setting = {
                    view: {
                        addHoverDom    : op.addHoverDom || null,
                        removeHoverDom : op.removeHoverDom || null,
                        addDiyDom      : op.addDiyDom ? op.addDiyDom.toFunc() : null
                    },
                    edit: {
                        enable        : op.editEnable,
                        showRemoveBtn : op.showRemoveBtn,
                        showRenameBtn : op.showRenameBtn
                    },
                    check: {
                        enable    : op.checkEnable,
                        chkStyle  : op.chkStyle,
                        radioType : op.radioType
                    },
                    callback: {
                        onClick       : op.onClick      ? op.onClick.toFunc()      : null,
                        beforeDrag    : op.beforeDrag   ? op.beforeDrag.toFunc()   : _beforeDrag,
                        beforeDrop    : op.beforeDrop   ? op.beforeDrop.toFunc()   : _beforeDrop,
                        onDrop        : op.onDrop       ? op.onDrop.toFunc()       : null,
                        onCheck       : op.onCheck      ? op.onCheck.toFunc()      : null,
                        beforeRemove  : op.beforeRemove ? op.beforeRemove.toFunc() : null,
                        onRemove      : op.onRemove     ? op.onRemove.toFunc()     : null,
                        onNodeCreated : _onNodeCreated,
                        onCollapse    : _onCollapse,
                        onExpand      : _onExpand
                    },
                    data: {
                        simpleData: {
                            enable: op.simpleData || true
                        },
                        key: {
                            title: op.title || ''
                        }
                    }
                }
                
                if (_setting && typeof _setting === 'string') _setting = _setting.toObj()
                if (_setting) $.extend(true, setting, typeof _setting === 'object' && _setting)
                
                $.fn.zTree.init($this, setting, op.nodes)
                
                var IDMark_A = '_a'
                var zTree    = $.fn.zTree.getZTreeObj($this.attr('id'))
                
                if (op.expandAll) zTree.expandAll(true)
                
                // onCreated
                function _onNodeCreated(event, treeId, treeNode) {
                    if (treeNode.faicon) {
                        var $a    = $('#'+ treeNode.tId +'_a')
                        
                        if (!$a.data('faicon')) {
                            $a.data('faicon', true)
                              .addClass('faicon')
                              .find('> span.button').append('<i class="fa fa-'+ treeNode.faicon +'"></i>')
                        }
                    }
                    if (op.onNodeCreated) {
                        op.onNodeCreated.toFunc().call(this, event, treeId, treeNode)
                    }
                }
                // onCollapse
                function _onCollapse(event, treeId, treeNode) {
                    if (treeNode.faiconClose) {
                        $('#'+ treeNode.tId +'_ico').find('> i').attr('class', 'fa fa-'+ treeNode.faiconClose)
                    }
                    
                    if (op.onCollapse) {
                        op.onCollapse.toFunc().call(this, event, treeId, treeNode)
                    }
                }
                // onExpand
                function _onExpand(event, treeId, treeNode) {
                    if (treeNode.faicon && treeNode.faiconClose) {
                        $('#'+ treeNode.tId +'_ico').find('> i').attr('class', 'fa fa-'+ treeNode.faicon)
                    }
                    if (op.onExpand) {
                        op.onExpand.toFunc().call(this, event, treeId, treeNode)
                    }
                }
                // add button, del button
                function _addHoverDom(treeId, treeNode) {
                    var level = treeNode.level
                    var $obj  = $('#'+ treeNode.tId + IDMark_A)
                    var $add  = $('#diyBtn_add_'+ treeNode.id)
                    var $del  = $('#diyBtn_del_'+ treeNode.id)
                    
                    if (!$add.length) {
                        if (level < op.maxAddLevel) {
                            $add = $('<span class="tree_add" id="diyBtn_add_'+ treeNode.id +'" title="添加"></span>')
                            $add.appendTo($obj);
                            $add.on('click', function(){
                                zTree.addNodes(treeNode, {name:'新增Item'})
                            })
                        }
                    }
                    
                    if (!$del.length) {
                        var $del = $('<span class="tree_del" id="diyBtn_del_'+ treeNode.id +'" title="删除"></span>')
                        
                        $del
                            .appendTo($obj)
                            .on('click', function(event) {
                                var delFn = function() {
                                    $del.alertmsg('confirm', '确认要删除 '+ treeNode.name +' 吗？', {
                                        okCall: function() {
                                            zTree.removeNode(treeNode)
                                            if (op.onRemove) {
                                                var fn = op.onRemove.toFunc()
                                                
                                                if (fn) fn.call(this, event, treeId, treeNode)
                                            }
                                        },
                                        cancelCall: function () {
                                            return
                                        }
                                    })
                                }
                                
                                if (op.beforeRemove) {
                                    var fn = op.beforeRemove.toFunc()
                                    
                                    if (fn) {
                                        var isdel = fn.call(fn, treeId, treeNode)
                                        
                                        if (isdel && isdel == true) delFn()
                                    }
                                } else {
                                    delFn()
                                }
                            }
                        )
                    }
                }
                
                // remove add button && del button
                function _removeHoverDom(treeId, treeNode) {
                    var $add = $('#diyBtn_add_'+ treeNode.id)
                    var $del = $('#diyBtn_del_'+ treeNode.id)
                    
                    if ($add && $add.length) {
                        $add.off('click').remove()
                    }
                    
                    if ($del && $del.length) {
                        $del.off('click').remove()
                    }
                }
                
                // Drag
                function _beforeDrag(treeId, treeNodes) {
                    for (var i = 0; i < treeNodes.length; i++) {
                        if (treeNodes[i].drag === false) {
                            return false
                        }
                    }
                    return true
                }
                
                function _beforeDrop(treeId, treeNodes, targetNode, moveType) {
                    return targetNode ? targetNode.drop !== false : true
                }
            })
            
            /* zTree - drop-down selector */
            
            var $selectzTree = $box.find('[data-toggle="selectztree"]')
            
            $selectzTree.each(function() {
                var $this   = $(this)
                var options = $this.data(),
                    $tree   = $(options.tree),
                    w       = parseFloat($this.css('width')),
                    h       = $this.outerHeight()
                
                options.width   = options.width || $this.outerWidth()
                options.height  = options.height || 'auto'
                
                if (!$tree || !$tree.length) return
                
                var treeid = $tree.attr('id')
                var $box   = $('#'+ treeid +'_select_box')
                var setPosition = function($box) {
                    var top        = $this.offset().top,
                        left       = $this.offset().left,
                        $clone     = $tree.clone().appendTo($('body')),
                        treeHeight = $clone.outerHeight()
                    
                    $clone.remove()
                    
                    var offsetBot = $(window).height() - treeHeight - top - h,
                        maxHeight = $(window).height() - top - h
                    
                    if (options.height == 'auto' && offsetBot < 0) maxHeight = maxHeight + offsetBot
                    $box.css({top:(top + h), left:left, 'max-height':maxHeight})
                }
                
                $this.click(function() {
                    if ($box && $box.length) {
                        setPosition($box)
                        $box.show()
                        return
                    }
                    
                    var zindex = 2
                    var dialog = $.CurrentDialog
                    
                    if (dialog && dialog.length) {
                        zindex = dialog.css('zIndex') + 1
                    }
                    $box  = $('<div id="'+ treeid +'_select_box" class="tree-box"></div>')
                                .css({position:'absolute', 'zIndex':zindex, 'min-width':options.width, height:options.height, overflow:'auto', background:'#FAFAFA', border:'1px #EEE solid'})
                                .hide()
                                .appendTo($('body'))
                    
                    $tree.appendTo($box).css('width','100%').data('fromObj', $this).removeClass('hide').show()
                    setPosition($box)
                    $box.show()
                })
                
                $('body').on('mousedown', function(e) {
                    var $target = $(e.target)
                    
                    if (!($this[0] == e.target || ($box && $box.length > 0 && $target.closest('.tree-box').length > 0))) {
                        $box.hide()
                    }
                })
                
                var $scroll = $this.closest('.bjui-pageContent')
                
                if ($scroll && $scroll.length) {
                    $scroll.scroll(function() {
                        if ($box && $box.length) {
                            setPosition($box)
                        }
                    })
                }
                
                //destroy selectzTree
                $this.on('destroy.bjui.selectztree', function() {
                    $box.remove()
                })
            })
        }
        
        /* accordion */
        $box.find('[data-toggle="accordion"]').each(function() {
            var $this = $(this), hBox = $this.data('heightbox'), height = $this.data('height')
            var initAccordion = function(hBox, height) {
                var offsety   = $this.data('offsety') || 0,
                    height    = height || ($(hBox).outerHeight() - (offsety * 1)),
                    $pheader  = $this.find('.panel-heading'),
                    h1        = $pheader.outerHeight()
                
                h1 = (h1 + 1) * $pheader.length
                $this.css('height', height)
                height = height - h1
                $this.find('.panel-collapse').find('.panel-body').css('height', height)
            }
            
            if ($this.find('> .panel').length) {
                if (hBox || height) {
                    initAccordion(hBox, height)
                    $(window).resize(function() {
                        initAccordion(hBox, height)
                    })
                    
                    $this.on('hidden.bs.collapse', function (e) {
                        var $last = $(this).find('> .panel:last'), $a = $last.find('> .panel-heading > h4 > a')
                        
                        if ($a.hasClass('collapsed'))
                            $last.css('border-bottom', '1px #ddd solid')
                    })
                }
            }
        })
        
        /* Kindeditor */
        if (KindEditor) {
            $box.find('[data-toggle="kindeditor"]').each(function() {
                var $editor = $(this), options = $editor.data()
                
                if (options.items && typeof options.items === 'string')
                    options.items = options.items.replaceAll('\'', '').replaceAll(' ', '').split(',')
                if (options.afterUpload)         options.afterUpload = options.afterUpload.toFunc()
                if (options.afterSelectFile) options.afterSelectFile = options.afterSelectFile.toFunc()
                if (options.confirmSelect)     options.confirmSelect = options.confirmSelect.toFunc()
                
                var htmlTags = {
                    font : [/*'color', 'size', 'face', '.background-color'*/],
                    span : ['.color', '.background-color', '.font-size', '.font-family'
                            /*'.color', '.background-color', '.font-size', '.font-family', '.background',
                            '.font-weight', '.font-style', '.text-decoration', '.vertical-align', '.line-height'*/
                    ],
                    div : ['.margin', '.padding', '.text-align'
                            /*'align', '.border', '.margin', '.padding', '.text-align', '.color',
                            '.background-color', '.font-size', '.font-family', '.font-weight', '.background',
                            '.font-style', '.text-decoration', '.vertical-align', '.margin-left'*/
                    ],
                    table: ['align', 'width'
                            /*'border', 'cellspacing', 'cellpadding', 'width', 'height', 'align', 'bordercolor',
                            '.padding', '.margin', '.border', 'bgcolor', '.text-align', '.color', '.background-color',
                            '.font-size', '.font-family', '.font-weight', '.font-style', '.text-decoration', '.background',
                            '.width', '.height', '.border-collapse'*/
                    ],
                    'td,th': ['align', 'valign', 'width', 'height', 'colspan', 'rowspan'
                            /*'align', 'valign', 'width', 'height', 'colspan', 'rowspan', 'bgcolor',
                            '.text-align', '.color', '.background-color', '.font-size', '.font-family', '.font-weight',
                            '.font-style', '.text-decoration', '.vertical-align', '.background', '.border'*/
                    ],
                    a : ['href', 'target', 'name'],
                    embed : ['src', 'width', 'height', 'type', 'loop', 'autostart', 'quality', '.width', '.height', 'align', 'allowscriptaccess'],
                    img : ['src', 'width', 'height', 'border', 'alt', 'title', 'align', '.width', '.height', '.border'],
                    'p,ol,ul,li,blockquote,h1,h2,h3,h4,h5,h6' : [
                        'class', 'align', '.text-align', '.color', /*'.background-color', '.font-size', '.font-family', '.background',*/
                        '.font-weight', '.font-style', '.text-decoration', '.vertical-align', '.text-indent', '.margin-left'
                    ],
                    pre : ['class'],
                    hr : ['class', '.page-break-after'],
                    'br,tbody,tr,strong,b,sub,sup,em,i,u,strike,s,del' : []
                }
                
                KindEditor.create($editor, {
                    pasteType                : options.pasteType,
                    minHeight                : options.minHeight || 260,
                    autoHeightMode           : options.autoHeight || false,
                    items                    : options.items || KindEditor.options.items,
                    uploadJson               : options.uploadJson,
                    fileManagerJson          : options.fileManagerJson,
                    allowFileManager         : options.allowFileManager || true,
                    fillDescAfterUploadImage : options.fillDescAfterUploadImage || true, //上传图片成功后转到属性页，为false则直接插入图片[设为true方便自定义函数(X_afterSelect)]
                    afterUpload              : options.afterUpload,
                    afterSelectFile          : options.afterSelectFile,
                    X_afterSelect            : options.confirmSelect,
                    htmlTags                 : htmlTags,
                    cssPath                  : [
                                                    BJUI.PLUGINPATH + 'kindeditor_4.1.10/editor-content.css', 
                                                    BJUI.PLUGINPATH + 'kindeditor_4.1.10/plugins/code/prettify.css'
                                               ],
                    afterBlur                : function() { this.sync() }
                })
            })
        }
        
        if ($.fn.colorpicker) {
            /* colorpicker */
            $box.find('[data-toggle="colorpicker"]').each(function() {
                var $this     = $(this)
                var isbgcolor = $this.data('bgcolor')
                
                $this.colorpicker()
                if (isbgcolor) {
                    $this.on('changeColor', function(ev) {
                        $this.css('background-color', ev.color.toHex())
                    })
                }
            })
            
            $box.find('[data-toggle="clearcolor"]').each(function() {
                var $this   = $(this)
                var $target = $this.data('target') ? $($this.data('target')) : null
                
                if ($target && $target.length) {
                    $this.click(function() {
                        $target.val('')
                        if ($target.data('bgcolor')) $target.css('background-color', '')
                    })
                }
            })
        }
        
        /* tooltip */
        $box.find('[data-toggle="tooltip"]').each(function() {
            $(this).tooltip()
        })
        
        /* fixed dropdown-menu width */
        $box.find('[data-toggle="dropdown"]').parent().on('show.bs.dropdown', function(e) {
            var $this = $(this), width = $this.outerWidth(), $menu = $this.find('> .dropdown-menu'), menuWidth = $menu.outerWidth()
            
            if (width > menuWidth) {
                $menu.css('min-width', width)
            }
        })
        
        /* not validate */
        if ($.fn.validator) {
            $box.find('form[data-toggle="ajaxform"]').each(function() {
                $(this).validator({ignore: ':input'})
                $(this).validator('destroy')
            })
        }
        
        /* ========================================================================
         * @description highCharts
         * @author 小策一喋 <xvpindex@qq.com>
         * @Blog http://www.topjui.com
         * ======================================================================== */
        var $highcharts = $box.find('[data-toggle="highcharts"]')
        
        $highcharts.each(function(){
            var $element = $(this)
            var options  = $element.data()
            
            $.get(options.url, function(chartData){
                $element.highcharts(chartData)
            }, 'json')
        })
        
        /* ========================================================================
         * @description ECharts
         * @author 小策一喋 <xvpindex@qq.com>
         * @Blog http://www.topjui.com
         * ======================================================================== */
        var $echarts = $box.find('[data-toggle="echarts"]')
        
        $echarts.each(function(){
            var $element = $(this)
            var options  = $element.data()
            var theme    = options.theme ? options.theme : 'default'
            var typeArr  = options.type.split(',')
            
            require.config({
                paths: {
                    echarts: BJUI.PLUGINPATH + 'echarts'
                }
            })
            
            require(
                [
                    'echarts',
                    'echarts/theme/' + theme,
                    'echarts/chart/' + typeArr[0],
                    typeArr[1] ? 'echarts/chart/' + typeArr[1] : 'echarts'
                ],
                function (ec,theme) {
                    var myChart = ec.init($element[0],theme)
                    
                    $.get(options.url, function(chartData){
                        myChart.setOption(chartData)
                    }, 'json')
                }
            )
        })
        
    })
    
}(jQuery);