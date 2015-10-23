/*!
 * B-JUI  v1.2 (http://b-jui.com)
 * Git@OSC (http://git.oschina.net/xknaan/B-JUI)
 * Copyright 2014 K'naan (xknaan@163.com).
 * Licensed under Apache (http://www.apache.org/licenses/LICENSE-2.0)
 */

/* ========================================================================
 * B-JUI: bjui-alertmsg.js  v1.2
 * @author K'naan (xknaan@163.com)
 * -- Modified from dwz.alertMsg.js (author:ZhangHuihua@msn.com)
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
    var Alertmsg = function(element, options) {
        this.$element  = $(element)
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
        var that  = this, options = that.options
        var tools = {
            getTitle: function(key){
                return options.title || BJUI.regional.alertmsg.title[key]
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
                    if (options.displayPosition && options.displayPosition != 'topcenter')
                        position = options.displayPosition
                } else {
                    position = options.displayPosition
                }
                
                if (mode) {
                    if (options.displayMode && options.displayMode != 'silde')
                        mode = options.displayMode
                } else {
                    mode = options.displayMode
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
                    if (options.displayPosition && options.displayPosition != 'topcenter')
                        position = options.displayPosition
                } else {
                    position = options.displayPosition
                }
                
                if (mode) {
                    if (options.displayMode && options.displayMode != 'silde')
                        mode = options.displayMode
                } else {
                    mode = options.displayMode
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
                    .replace('#fa#', options.fas[type])
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
                
                if (options.mask == null) {
                    if (!(options.types.info == type || options.types.correct == type))
                        $alertbg.show()
                }
                if (options.autoClose == null) {
                    if (options.types.info == type || options.types.correct == type) {
                        if (alertTimeout) { 
                            if (options.alertTimeout && options.alertTimeout != 3000)
                                alertTimeout = options.alertTimeout
                        } else {
                            alertTimeout = options.alertTimeout
                        }
                        timer = setTimeout(function() { tools.close() }, alertTimeout)
                    }
                }
                
                $btns = $box.find('.btn')
                
                $btns.each(function(i) {
                    $(this).on('click', $.proxy(function() {
                            that.tools.close()
                            
                            var call = buttons[i].call
                            
                            if (typeof call == 'string')   call = call.toFunc() 
                            if (typeof call == 'function') call.call()
                        }, that)
                    )
                    
                    if (buttons[i].keyCode == BJUI.keyCode.ENTER) {
                        $(document).on('keydown.bjui.alertmsg.ok', {target:$btns.eq(i)}, tools.keydownOk)
                    }
                    if (buttons[i].keyCode == BJUI.keyCode.ESC) {
                        $(document).on('keydown.bjui.alertmsg.esc', {target:$btns.eq(i)}, tools.keydownEsc)
                    }
                })
            },
            alert: function(type, msg, btnoptions) {
                $.extend(options, typeof btnoptions == 'object' && btnoptions)
                
                var op      = $.extend({}, {okName:BJUI.regional.alertmsg.btnMsg.ok, okCall:null}, options)
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
        $.extend(this.options, typeof btnoptions == 'object' && btnoptions)
        
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
        var args     = arguments
        var property = option
        
        return this.each(function () {
            var $this   = $(this)
            var options = $.extend({}, Alertmsg.DEFAULTS, $this.data(), typeof option == 'object' && option)
            var data    = new Alertmsg(this, options)
            
            if (typeof property == 'string' && $.isFunction(data[property])) {
                [].shift.apply(args)
                if (!args) data[property]()
                else data[property].apply(data, args)
            } else {
                return
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
    
    // NAVTAB DATA-API
    // ==============
    
    $(document).on('click.bjui.alertmsg.data-api', '[data-toggle="alertmsg"]', function(e) {
        var $this = $(this), data = $this.data(), options = data.options, type, msg
        
        if (options) {
            if (typeof options == 'string') options = options.toObj()
            if (typeof options == 'object') {
                $.extend(data, options)
            }
        }
        
        type = data.type
        if (!type) return false
        
        Plugin.call($this, type, data.msg || type, data)
        
        e.preventDefault()
    })
    
}(jQuery);