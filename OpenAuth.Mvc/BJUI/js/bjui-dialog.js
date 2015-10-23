/*!
 * B-JUI  v1.2 (http://b-jui.com)
 * Git@OSC (http://git.oschina.net/xknaan/B-JUI)
 * Copyright 2014 K'naan (xknaan@163.com).
 * Licensed under Apache (http://www.apache.org/licenses/LICENSE-2.0)
 */

/* ========================================================================
 * B-JUI: bjui-dialog.js  v1.2
 * @author K'naan (xknaan@163.com)
 * -- Modified from dwz.dialog.js, dwz.dialogDrag.js, dwz.resize.js (author:Roger Wu)
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
    var Dialog = function(element, options) {
        this.$element = $(element)
        this.options  = options
        this.tools    = this.TOOLS()
    }
    
    Dialog.DEFAULTS = {
        id          : 'dialog',
        title       : 'New Dialog',
        url         : undefined,
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
                    iTop   = that.options.max ? 0 : ((wH - height) / 2)
                
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
                var $dialogContent = $dialog.find('> .dialogContent'), onLoad
                
                options = options || $dialog.data('initOptions')
                onLoad  = options.onLoad ? options.onLoad.toFunc() : null
                
                $dialog.trigger(BJUI.eventType.beforeLoadDialog)
                
                if (options.url) {
                    $dialogContent.ajaxUrl({
                        type:options.type || 'GET', url:options.url, data:options.data || {}, loadingmask:options.loadingmask, callback:function(response) {
                            if (onLoad) onLoad.apply(that, [$dialog])
                            if (BJUI.ui.clientPaging && $dialog.data('bjui.clientPaging')) $dialog.pagination('setPagingAndOrderby', $dialog)
                        }
                    })
                } else if (options.target) {
                    var html = $(options.target).html() || $dialog.data('bjui.dialog.target')
                    
                    $(options.target).empty()
                    $dialog.data('bjui.dialog.target', html)
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
        var that    = this, options = that.options
        var $body   = $('body')
        var $dialog = $body.data(options.id)
        
        if (!options.target || !$(options.target).length) {
            if (!options.url && options.href) options.url = options.href
            if (!options.url) {
                BJUI.debug('Dialog Plugin: Error trying to open a dialog, url is undefined!')
                return
            } else {
                options.url = decodeURI(options.url).replacePlh(that.$element.closest('.unitBox'))
                
                if (!options.url.isFinishedTm()) {
                    that.$element.alertmsg('error', (options.warn || FRAG.alertPlhMsg.replace('#plhmsg#', BJUI.regional.plhmsg)))
                    BJUI.debug('Dialog Plugin: The new dialog\'s url is incorrect, url: '+ options.url)
                    return
                }
                
                options.url = encodeURI(options.url)
            }
        } else {
            options.url = undefined
        }
        if ($dialog) { //if the dialog id already exists
            var op = $dialog.data('initOptions') || options
            
            this.switchDialog($dialog)
            if ($dialog.is(':hidden')) $dialog.show()
            if (op.fresh || options.fresh || !op.url || op.url != options.url) {
                that.reload(options)
                $dialog.data('initOptions', options)
            }
        } else { //open a new dialog
            var dr     = BJUI.regional.dialog
            var dialog = FRAG.dialog
                .replace('#close#', dr.close)
                .replace('#maximize#', dr.maximize)
                .replace('#restore#', dr.restore)
                .replace('#minimize#', dr.minimize)
                .replace('#title#', dr.title)
            
            $dialog = $(dialog)
                .data('options', options)
                .data('initOptions', options)
                .css('zIndex', (zindex += 1))
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
                if (!options.drawable || $dialog.data('max')) return
                
                var $bar = $(this)
                
                that.switchDialog($dialog)
                that.resizeInit(e, $('#bjui-resizable'), $dialog, $bar)
                $bar.show()
                
                e.preventDefault()
            }).on('mouseup.bjui.dialog.resize', 'div[class^="resizable"]', function(e) {
                e.preventDefault()
            })
            
            $body.data(options.id, $dialog)
            this.tools.reload($dialog, options)
        }
        
        $.CurrentDialog = $current = $dialog
    }
    
    Dialog.prototype.addMask = function($dialog) {
        var $mask = $dialog.data('bjui.dialog.mask')
        
        $dialog.wrap('<div style="z-index:'+ zindex +'" class="bjui-dialog-wrap"></div>')
        $dialog.find('> .dialogHeader > a.minimize').hide()
        if (!$mask || !$mask.length) {
            $mask = $(FRAG.dialogMask)
            $mask.css('zIndex', 1).show().insertBefore($dialog)
            $dialog.data('bjui.dialog.mask', $mask)
        }
    }
    
    Dialog.prototype.refresh = function(id) {
        if (id && typeof id == 'string') {
            var arr = id.split(',')
            
            for (var i = 0; i < arr.length; i++) {
                var $dialog = $('body').data(arr[i].trim())
                
                if ($dialog) {
                    $dialog.removeData('bjui.clientPaging')
                    this.tools.reload($dialog)
                }
            }
        } else {
            $current.removeData('bjui.clientPaging')
            this.tools.reload($current)
        }
    }
    
    Dialog.prototype.reload = function(option, initOptionFlag) {
        var that    = this
        var options = $.extend({}, typeof option == 'object' && option)
        var $dialog = (options.id && $('body').data(options.id)) || that.getCurrent()
        
        if ($dialog && $dialog.length) {
            var initOptions = $dialog.data('initOptions'), op = $.extend({}, initOptions, options)
            var _reload = function() {
                var $dialogContent = $dialog.find('> .dialogContent')
                
                if (initOptions.width != op.width) {
                    if (!op.max) {
                        $dialog.animate({ width:op.width}, 'normal', function() { $dialogContent.width(op.width) })
                    } else {
                        $dialog.width(op.width)
                        $dialogContent.width(op.width)
                    }
                }
                if (initOptions.height != op.height) {
                    if (!op.max) {
                        $dialog.animate({ height:op.height }, 'normal', function() {
                            $dialogContent.height(op.height - $dialog.find('> .dialogHeader').outerHeight() - 6).resizePageH()
                        })
                    } else {
                        $dialog.height(op.height)
                        $dialogContent.height(op.height - $dialog.find('> .dialogHeader').outerHeight() - 6)
                    }
                }
                if (initOptions.maxable != op.maxable) {
                    if (op.maxable) $dialog.find('a.maximize').show()
                    else $dialog.find('a.maximize').hide()
                } 
                if (initOptions.minable != op.minable) {
                    if (op.minable) $dialog.find('a.minimize').show()
                    else $dialog.find('a.minimize').hide()
                }
                if (initOptions.max != op.max && op.max) setTimeout(that.maxsize($dialog), 10)
                if (initOptions.mask != op.mask) {
                    if (op.mask) {
                        that.addMask($dialog)
                        if ($.fn.taskbar) that.$element.taskbar('closeDialog', op.id)
                    } else if (op.minable && $.fn.taskbar) {
                        that.$element.taskbar({id:op.id, title:op.title})
                    }
                }
                if (initOptions.title != op.title) {
                    $dialog.find('> .dialogHeader > h1 > span.title').html(op.title)
                    $dialog.taskbar('changeTitle', op.id, op.title)
                }
                
                $dialog.data('options', op)
                
                if (!initOptionFlag) $dialog.data('initOptions', op)
                
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
        var $dialog, options
        
        if (typeof option == 'string') {
            $dialog = $('body').data(option)
            options = $dialog.data('options')
        } else if (typeof option == 'object') {
            $dialog = (option.id && $('body').data(option.id)) || this.getCurrent()
        }
        if ($dialog) {
            if (typeof option == 'object') {
                if (option.title) $dialog.find('> .dialogHeader > h1 > span.title').html(option.title)
                options = $.extend({}, option, $dialog.data('options'))
            }
            var $pagerForm = $dialog.find('#pagerForm'), data = {}, pageData = {}
            
            if ($pagerForm.attr('action')) options.url = $pagerForm.attr('action')
            if ($pagerForm && $pagerForm.length) {
                pageData = $pagerForm.serializeJson()
                if (!option || !option.type) options.type = $pagerForm.attr('method') || 'POST'
                if (clearQuery) {
                    var pageInfo = BJUI.pageInfo
                    
                    for (var key in pageInfo) {
                        data[pageInfo[key]] = pageData[pageInfo[key]]
                    }
                } else {
                    data = pageData
                }
                options.data = $.extend({}, options.data || {}, data)
            }
            
            this.reload(options, true)
        }
    }
    
    Dialog.prototype.getCurrent = function() {
        return $current
    }
    
    Dialog.prototype.switchDialog = function($dialog) {
        var index = $dialog.css('zIndex')
        
        if ($current && $current != $dialog) {
            var cindex = $current.css('zIndex')
            
            $current.css('zIndex', index)
            $dialog.css('zIndex', cindex)
            $.CurrentDialog = $current = $dialog
            if ($.fn.taskbar) this.$element.taskbar('switchTask', $dialog.data('options').id)
        }
        
        $dialog.addClass(shadow)
        $('body').find('> .bjui-dialog-container').not($dialog).removeClass(shadow)
    }
    
    Dialog.prototype.close = function(dialog) {
        var that        = this
        var $dialog     = (typeof dialog == 'string') ? $('body').data(dialog) : dialog
        var $mask       = $dialog.data('bjui.dialog.mask')
        var options     = $dialog.data('options')
        var target      = $dialog.data('bjui.dialog.target')
        var beforeClose = options.beforeClose ? options.beforeClose.toFunc() : null
        var onClose     = options.onClose ? options.onClose.toFunc() : null
        var canClose    = true
        
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
        
        $dialog.animate({top:-$dialog.outerHeight(), opacity:0.1}, 'normal', function() {
            $('body').removeData(options.id)
            $dialog.trigger(BJUI.eventType.beforeCloseDialog).remove()
            if (onClose) onClose.apply(that)
            
            var $dialogs  = $('body').find('.bjui-dialog-container')
            var $_current = undefined
            
            if ($dialogs.length) {
                $_current = that.$element.getMaxIndexObj($dialogs)
            } else {
                zindex   = Dialog.ZINDEX
                $current = null
            }
            if ($_current && $_current.is(':visible')) that.switchDialog($_current)
        })
    }
    
    Dialog.prototype.closeCurrent = function() {
        this.close($current)
    }
    
    Dialog.prototype.checkTimeout = function() {
        var $dialogConetnt = $current.find('> .dialogContent')
        var json = JSON.parse($dialogConetnt.html())
        
        if (json && json[BJUI.keys.statusCode] == BJUI.statusCode.timeout) this.closeCurrent()
    }
    
    Dialog.prototype.maxsize = function($dialog) {
        $dialog.data('original', {
            top: $dialog.css('top'),
            left: $dialog.css('left'),
            width: $dialog.css('width'),
            height: $dialog.css('height')
        }).data('max', true)
        $dialog.find('> .dialogHeader > a.maximize').hide()
        $dialog.find('> .dialogHeader > a.restore').show()
        
        var iContentW = $(window).width()
        var iContentH = $(window).height() - $('#bjui-taskbar').height() - 1
        
        $dialog.css({ top:0, left:0, width:iContentW, height:iContentH })
        this.tools.resizeContent($dialog, iContentW, iContentH)
    }
    
    Dialog.prototype.restore = function($dialog) {
        var original = $dialog.data('original')
        var dwidth   = parseInt(original.width)
        var dheight  = parseInt(original.height)
        
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
        var tmove
        var oleft  = parseInt($resizable.css('left'))
        var otop   = parseInt($resizable.css('top'))
        var height = parseInt($resizable.css('height'))
        var width  = parseInt($resizable.css('width'))
        
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
        var that   = this
        var target = $bar.attr('tar')
        
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
                oleft      : parseInt($resizable.css('left')) || 0,
                owidth     : parseInt($resizable.css('width')) || 0,
                otop       : parseInt($resizable.css('top')) || 0,
                oheight    : parseInt($resizable.css('height')) || 0,
                ox         : e.pageX || e.screenX,
                oy         : e.pageY || e.clientY
            }
            $(document).on('mouseup.bjui.dialog.resize', $.proxy(that.resizeStop, that))
            $(document).on('mousemove.bjui.dialog.resize', $.proxy(that.resizeStart, that))
        }
    }
    
    Dialog.prototype.resizeStart = function(e) {
        var current   = this.options.dragCurrent
        
        if (!current) return
        if (!e) var e = window.event
        
        var lmove     = (e.pageX || e.screenX) - current.ox
        var tmove     = (e.pageY || e.clientY) - current.oy
        
        var $mask = current.$dialog.data('bjui.dialog.mask')
        
        if (!$mask || !$mask.length)
            if ((e.pageY || e.clientY) <= 0 || (e.pageY || e.clientY) >= ($(window).height() - current.$dialog.find('> .dialogHeader').outerHeight())) return
        
        var target = current.target
        var width  = current.owidth
        var height = current.oheight
        
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
        
        $(document).off('mouseup.bjui.dialog.resize')
        $(document).off('mousemove.bjui.dialog.resize')
        this.options.dragCurrent = null
        this.resizeDialog(current.$resizable, current.$dialog, current.target)
        $('body').css('cursor', '')
        current.$resizable.hide()
    }
    
    // DIALOG PLUGIN DEFINITION
    // =======================
    
    function Plugin(option) {
        var args     = arguments
        var property = option
        
        return this.each(function () {
            var $this   = $(this)
            var options = $.extend({}, Dialog.DEFAULTS, typeof option == 'object' && option)
            var data    = $this.data('bjui.dialog')
            
            if (!data) $this.data('bjui.dialog', (data = new Dialog(this, options)))
            
            if (typeof property == 'string' && $.isFunction(data[property])) {
                [].shift.apply(args)
                if (!args) data[property]()
                else data[property].apply(data, args)
            } else {
                data = new Dialog(this, options)
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
    
    // DIALOG DATA-API
    // ==============

    $(document).on('click.bjui.dialog.data-api', '[data-toggle="dialog"]', function(e) {
        var $this   = $(this), href = $this.attr('href'), data = $this.data(), options = data.options
        
        if (options) {
            if (typeof options == 'string') options = options.toObj()
            if (typeof options == 'object')
                $.extend(data, options)
        }
        
        if (!data.title) data.title = $this.text()
        if (href && !data.url) data.url = href
        
        Plugin.call($this, data)
        
        e.preventDefault()
    })

}(jQuery);