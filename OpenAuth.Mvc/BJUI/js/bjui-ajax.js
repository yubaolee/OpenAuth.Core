/*!
 * B-JUI  v1.2 (http://b-jui.com)
 * Git@OSC (http://git.oschina.net/xknaan/B-JUI)
 * Copyright 2014 K'naan (xknaan@163.com).
 * Licensed under Apache (http://www.apache.org/licenses/LICENSE-2.0)
 */

/* ========================================================================
 * B-JUI: bjui-ajax.js  v1.2
 * @author K'naan (xknaan@163.com) 
 * -- Modified from dwz.ajax.js (author:ZhangHuihua@msn.com)
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
        reload      : true,
        loadingmask : true
    }
    
    Bjuiajax.NAVTAB = 'navtab'
    
    Bjuiajax.prototype.TOOLS = function() {
        var that  = this
        var tools = {
            getPagerForm: function($parent, args) {
                var form     = $parent.isTag('form') ? $parent[0] : $parent.find('#pagerForm:first')[0]
                var pageInfo = $.extend({}, BJUI.pageInfo)
                
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
    
    Bjuiajax.prototype.ajaxForm = function(options) {
        var that      = this
        var $form     = this.$element,
            callback  = options && options.callback,
            enctype   = $form.attr('enctype')
        
        options = $.extend({}, that.options, typeof options == 'object' && options)
        
        if (callback) callback = callback.toFunc()
        
        var successFn = function(data, textStatus, jqXHR) {
            callback ? callback.apply(that, [data, $form]) : $.proxy(that.ajaxCallback(data), that)
        }
        var _submitFn = function() {
            var op = {loadingmask:options.loadingmask, type:$form.attr('method'), url:$form.attr('action'), callback:successFn, error:$.proxy(that.ajaxError, that)}
            
            if (enctype && enctype == 'multipart/form-data') {
                if (window.FormData) {
                    $.extend(op, {data:new FormData($form[0]), contentType:false, processData:false}) 
                } else {
                    $.extend(op, {data:$form.serializeArray(), files:$form.find(':file'), iframe:true, processData:false})
                }
            } else {
                $.extend(op, {data:$form.serializeArray()})
            }
            $form.doAjax(op)
        }
        
        if (options.confirmMsg) {
            $form.alertmsg('confirm', options.confirmMsg, {okCall: _submitFn})
        } else {
            _submitFn()
        }
    }
    
    Bjuiajax.prototype.ajaxDone = function(json) {
        var $element = this.$element
        
        if (json[BJUI.keys.statusCode] == BJUI.statusCode.error) {
            if (json[BJUI.keys.message]) $element.alertmsg('error', json[BJUI.keys.message])
        } else if (json[BJUI.keys.statusCode] == BJUI.statusCode.timeout) {
            $element.alertmsg('info', json[BJUI.keys.message] || FRAG.sessionTimout)
            BJUI.loadLogin()
        } else {
            if (json[BJUI.keys.message]) $element.alertmsg('correct', json[BJUI.keys.message])
        }
    }
    
    Bjuiajax.prototype.ajaxError = function(xhr, ajaxOptions, thrownError) {
        var msg = xhr.responseText.trim()
        
        if (msg.startsWith('{')) {
            this.ajaxDone(msg.toObj())
        } else {
            this.$element.alertmsg('error', '<div>Http status: ' + xhr.status + ' ' + xhr.statusText + '</div>' 
                + '<div>ajaxOptions: '+ ajaxOptions +' </div>'
                + '<div>thrownError: '+ thrownError +' </div>'
                + '<div>'+ msg +'</div>')
        }
    }
    
    Bjuiajax.prototype.ajaxCallback = function(json) {
        var that     = this
        var $element = that.$element
        var $target  = $element.closest('.bjui-layout')
        
        that.ajaxDone(json)
        
        if (json[BJUI.keys.statusCode] == BJUI.statusCode.ok) {
            if ($target && $target.length) {
                that.divCallback(json, $target)
            } else {
                if (that.tools.getTarget() == Bjuiajax.NAVTAB) {
                    that.navtabCallback(json)
                } else {
                    that.dialogCallback(json)
                }
            }
        }
    }
    
    Bjuiajax.prototype.divCallback = function(json, $target) {
        var that = this
        
        if (json.tabid)
            setTimeout(function() { that.$element.navtab('reloadFlag', json.tabid) }, 100)
        if (json.dialogid)
            setTimeout(function() { that.$element.dialog('refresh', json.dialogid) }, 100)
        if (json.divid)
            setTimeout(function() { that.$element.bjuiajax('refreshDiv', json.divid) }, 100)
        if (that.options.reload) {
            var form = that.tools.getPagerForm($target)
            var url  = null, type = null
            
            if (form) {
                url  = form.attr('action')
                type = form.attr('method') || 'GET'
            } else {
                url  = $target.data('url')
                type = $target.data('type') || 'GET'
            }
            
            if (url) $target.ajaxUrl({url: url, type: type})
        }
        if (that.options.reloadNavtab)
            setTimeout(function() { that.$element.navtab('refresh') }, 100)
        if (json.forward) {
            var _forward = function() {
                $target.ajaxUrl({url: json.forward})
            }
            
            if (json.forwardConfirm) {
                that.$element.alertmsg('confirm', json.forwardConfirm, {
                    okCall: function() { _forward() }
                })
            } else {
                _forward()
            }
        }
    }
    
    Bjuiajax.prototype.navtabCallback = function(json) {
        var that = this
        
        if (json.tabid)
            setTimeout(function() { that.$element.navtab('reloadFlag', json.tabid) }, 100)
        if (json.dialogid)
            setTimeout(function() { that.$element.dialog('refresh', json.dialogid) }, 100)
        if (json.divid)
            setTimeout(function() { that.$element.bjuiajax('refreshDiv', json.divid) }, 100)
        if (json.datagrid) {
            setTimeout(function() {
                $.each(json.datagrid.join(','), function(i, n) {
                    $('#'+ n.trim()).datagrid('refresh')
                })
            }, 100)
        }
        if (json.closeCurrent && !json.forward)
            that.$element.navtab('closeCurrentTab')
        else if (that.options.reload)
            setTimeout(function() { that.$element.navtab('refresh') }, 100)
        if (json.forward) {
            var _forward = function() {
                that.$element.navtab('reload', {url:json.forward})
            }
            
            if (json.forwardConfirm) {
                that.$element.alertmsg('confirm', json.forwardConfirm, {
                    okCall: function() { _forward() },
                    cancelCall: function() { if (json.closeCurrent) { that.$element.navtab('closeCurrentTab') } }
                })
            } else {
                _forward()
            }
        }
    }
    
    Bjuiajax.prototype.dialogCallback = function(json) {
        var that = this
        
        if (json.tabid)
            setTimeout(function() { that.$element.navtab('reloadFlag', json.tabid) }, 100)
        if (json.dialogid)
            setTimeout(function() { that.$element.dialog('refresh', json.dialogid) }, 100)
        if (json.divid)
            setTimeout(function() { that.$element.bjuiajax('refreshDiv', json.divid) }, 100)
        if (json.closeCurrent && !json.forward)
            that.$element.dialog('closeCurrent')
        else if (that.options.reload)
            setTimeout(function() { that.$element.dialog('refresh') }, 100)
        if (that.options.reloadNavtab)
            setTimeout(function() { that.$element.navtab('refresh') }, 100)
        if (json.forward) {
            var _forward = function() {
                that.$element.dialog('reload', {url:json.forward})
            }
            
            if (json.forwardConfirm) {
                that.$element.alertmsg('confirm', json.forwardConfirm, {
                    okCall: function() { _forward() }
                })
            } else {
                _forward()
            }
        }
    }
    
    Bjuiajax.prototype.pageCallback = function(options, target) {
        var that    = this
        var op      = $.extend({}, Bjuiajax.DEFAULTS, options)
        var $target = target || null
        var form    = null
        
        if ($target && $target.length) {
            form = that.tools.getPagerForm($target, op)
            if (form) {
                $.extend(op, $(form).data())
                that.reloadDiv($target, {type:$(form).attr('method') || 'POST', url:$(form).attr('action'), data:$(form).serializeArray(), loadingmask:op.loadingmask})
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
    
    Bjuiajax.prototype.doSearch = function(options) {
        var that = this, $element = that.$element, form = null, op = {pageCurrent:1}, $target = $element.closest('.bjui-layout'), isValid = options.isValid
        
        options = $.extend({}, Bjuiajax.DEFAULTS, typeof options == 'object' && options)
        if (!options.url) options.url = $element.attr('action')
        if (!options.url) {
            BJUI.debug('Error trying to submit form action: action url is undefined!')
            return
        } else {
            options.url = decodeURI(options.url).replacePlh($element.closest('.unitBox'))
            
            if (!options.url.isFinishedTm()) {
                $element.alertmsg('error', (options.warn || FRAG.alertPlhMsg.replace('#plhmsg#', BJUI.regional.plhmsg)))
                BJUI.debug('The submit form action is incorrect: '+ options.url)
                return
            }
            
            options.url = encodeURI(options.url)
        }
        
        var search = function() {
            if ($target && $target.length) {
                form = that.tools.getPagerForm($target, op)
                
                var data = $element.serializeJson(), _data = {}
                
                if (options.clearQuery) {
                    var pageInfo = BJUI.pageInfo
                    
                    for (var key in pageInfo) {
                        _data[pageInfo[key]] = data[pageInfo[key]]
                    }
                    data = _data
                }
                that.reloadDiv($target, {type:$element.attr('method') || 'POST', url:options.url, data:data, loadingmask:options.loadingmask})
            } else {
                if (that.tools.getTarget() == Bjuiajax.NAVTAB) {
                    $target = $.CurrentNavtab
                    form    = that.tools.getPagerForm($target, op)
                    $element.navtab('reloadForm', options.clearQuery, options)
                } else {
                    $target = $.CurrentDialog
                    form    = that.tools.getPagerForm($target, op)
                    $element.dialog('reloadForm', options.clearQuery, options)
                }
            }
        }
        
        if (!isValid) {
            if ($.validator) {
                $element.isValid(function(v) {
                    if (v) search()
                })
            } else {
                search()
            }
        } else {
            search()
        }
    }
    
    Bjuiajax.prototype.doLoad = function(options) {
        var that = this, $element = that.$element, $target = options.target ? $(options.target) : null
        
        options = $.extend({}, Bjuiajax.DEFAULTS, typeof options == 'object' && options)
        if (!options.url) {
            BJUI.debug('Error trying to open a ajax link: The url is undefined!')
            return
        } else {
            options.url = decodeURI(options.url).replacePlh($element.closest('.unitBox'))
            
            if (!options.url.isFinishedTm()) {
                $element.alertmsg('error', (options.warn || FRAG.alertPlhMsg.replace('#plhmsg#', BJUI.regional.plhmsg)))
                BJUI.debug('The ajax link incorrect: '+ options.url)
                return
            }
            
            options.url = encodeURI(options.url)
        }
        
        if (!$target || !$target.length) {
            BJUI.debug('Not set loaded \'ajax\' content container, like [data-target].')
            return
        }
        
        if ($target && $target.length) {
            $target.removeData('bjui.clientPaging')
            that.reloadDiv($target, options)
        }
    }
    
    Bjuiajax.prototype.refreshLayout = function(options) {
        var that = this, $element = that.$element, $target = options.target ? $(options.target) : null
        
        options = $.extend({}, Bjuiajax.DEFAULTS, typeof options == 'object' && options)
        if (!$target || !$target.length) {
            if (autorefreshTimer) clearInterval(autorefreshTimer)
            BJUI.debug('Not set loaded \'ajax\' content container, like [data-target].')
            return
        }
        if ($target && $target.length) {
            $target.removeData('bjui.clientPaging')
            that.reloadDiv($target, $.extend({}, $target.data('options') || {}, options))
        }
    }
    
    Bjuiajax.prototype.reloadDiv = function($target, options) {
        var arefre = options.autorefresh && (isNaN(String(options.autorefresh)) ? 15 : options.autorefresh)
        
        $target
            .addClass('bjui-layout')
            .data('options', options)
            .ajaxUrl({ type:options.type, url:options.url, data:options.data, loadingmask:options.loadingmask, callback:function(html) {
                    if (BJUI.ui.clientPaging && $target.data('bjui.clientPaging'))
                        $target.pagination('setPagingAndOrderby', $target)
                    if (options.callback)
                        options.callback.apply(this, [$target])
                    if (autorefreshTimer)
                        clearInterval(autorefreshTimer)
                    if (arefre)
                        autorefreshTimer = setInterval(function() { $target.bjuiajax('refreshLayout', options) }, arefre * 1000)
                }
            })
    }
    
    Bjuiajax.prototype.refreshDiv = function(divid) {
        if (divid && typeof divid == 'string') {
            var arr = divid.split(',')
            
            for (var i = 0; i < arr.length; i++) {
                this.refreshLayout({target: '#'+ arr[i]})
            }
        }
    }
    
    Bjuiajax.prototype.doAjax = function(options) {
        var that = this, $element = that.$element
        
        options = $.extend({}, Bjuiajax.DEFAULTS, typeof options == 'object' && options)
        if (!options.url) {
            BJUI.debug('Error trying to open a ajax link: url is undefined!')
            return
        } else {
            options.url = decodeURI(options.url).replacePlh($element.closest('.unitBox'))
            
            if (!options.url.isFinishedTm()) {
                $element.alertmsg('error', (options.warn || FRAG.alertPlhMsg.replace('#plhmsg#', BJUI.regional.plhmsg)))
                BJUI.debug('The ajax url is incorrect: '+ options.url)
                return
            }
            
            options.url = encodeURI(options.url)
        }
        
        var callback = options.callback && options.callback.toFunc()
        var todo     = function() {
            $element.doAjax({type:options.type, url:options.url, data:options.data, callback:callback ? callback : $.proxy(function(data) {that.ajaxCallback(data)}, that)})
        }
        
        if (options.confirmMsg) {
            $element.alertmsg('confirm', options.confirmMsg, {
                okCall: function() {
                    todo()
                }
            })
        } else {
            todo()
        }
    }
    
    Bjuiajax.prototype.doExport = function(options) {
        var that = this, $element = that.$element, $target = options.target ? $(options.target) : null, form
        
        if (!options.url) {
            BJUI.debug('Error trying to open a ajax link: url is undefined!')
            return
        } else {
            options.url = decodeURI(options.url).replacePlh($element.closest('.unitBox'))
            
            if (!options.url.isFinishedTm()) {
                $element.alertmsg('error', (options.warn || FRAG.alertPlhMsg.replace('#plhmsg#', BJUI.regional.plhmsg)))
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
            if (form) options.url = encodeURI(options.url + (options.url.indexOf('?') == -1 ? '?' : '&') + $(form).serialize())
            
            $.fileDownload(options.url, {
                failCallback: function(responseHtml, url) {
                    if (responseHtml.trim().startsWith('{')) responseHtml = responseHtml.toObj()
                    that.ajaxDone(responseHtml)
                }
            })
        }
        
        if (options.confirmMsg) {
            $element.alertmsg('confirm', options.confirmMsg, {
                okCall: function() {
                    todo()
                }
            })
        } else {
            todo()
        }
    }
    
    Bjuiajax.prototype.doExportChecked = function(options) {
        var that = this, $element = that.$element, $target = options.target ? $(options.target) : null
        
        if (!options.url) {
            BJUI.debug('Error trying to open a export link: url is undefined!')
            return
        } else {
            options.url = decodeURI(options.url).replacePlh($element.closest('.unitBox'))
            
            if (!options.url.isFinishedTm()) {
                $element.alertmsg('error', (options.warn || FRAG.alertPlhMsg.replace('#plhmsg#', BJUI.regional.plhmsg)))
                BJUI.debug('The ajax url is incorrect: '+ options.url)
                return
            }
        }
        
        var todo = function() {
            if (!options.group) {
                that.$element.alertmsg('error', options.warn || FRAG.alertNoCheckGroup.replace('#nocheckgroup#', BJUI.regional.nocheckgroup))
                return
            }
            if (!$target || !$target.length) {
                if (that.tools.getTarget() == Bjuiajax.NAVTAB) {
                    $target = $.CurrentNavtab
                } else {
                    $target = $.CurrentDialog
                }
            }
            
            var ids     = []
            var $checks = $target.find(':checkbox[name='+ options.group +']:checked')
            
            if ($checks.length == 0) {
                that.$element.alertmsg('error', FRAG.alertNotChecked.replace('#notchecked#', BJUI.regional.notchecked))
                return
            }
            $checks.each(function() {
                ids.push($(this).val())
            })
            
            options.url = options.url.setUrlParam((options.idname ? options.idname : 'ids'), ids.join(','))
            
            $.fileDownload(options.url, {
                failCallback: function(responseHtml, url) {
                    if (responseHtml.trim().startsWith('{')) responseHtml = responseHtml.toObj()
                    that.ajaxDone(responseHtml)
                }
            })
        }
        
        if (options.confirmMsg) {
            $element.alertmsg('confirm', options.confirmMsg, {
                okCall: function() {
                    todo()
                }
            })
        } else {
            todo()
        }
    }
    
    Bjuiajax.prototype.doAjaxChecked = function(options) {
        var that = this, $element = that.$element, $target = options.target ? $(options.target) : null
        
        options = $.extend({}, Bjuiajax.DEFAULTS, typeof options == 'object' && options)
        if (!options.url) {
            BJUI.debug('Error trying to open a del link: url is undefined!')
            return
        } else {
            options.url = decodeURI(options.url).replacePlh($element.closest('.unitBox'))
            
            if (!options.url.isFinishedTm()) {
                $element.alertmsg('error', (options.warn || FRAG.alertPlhMsg.replace('#plhmsg#', BJUI.regional.plhmsg)))
                BJUI.debug('The ajax url is incorrect: '+ options.url)
                return
            }
        }
        
        var todo = function() {
            if (!options.group) {
                $element.alertmsg('error', options.warn || FRAG.alertNoCheckGroup.replace('#nocheckgroup#', BJUI.regional.nocheckgroup))
                return
            }
            if (!$target || !$target.length) {
                if (that.tools.getTarget() == Bjuiajax.NAVTAB) {
                    $target = $.CurrentNavtab
                } else {
                    $target = $.CurrentDialog
                }
            }
            
            var ids      = []
            var $checks  = $target.find(':checkbox[name='+ options.group +']:checked')
            var callback = options.callback && options.callback.toFunc()
            
            if ($checks.length == 0) {
                $element.alertmsg('error', FRAG.alertNotChecked.replace('#notchecked#', BJUI.regional.notchecked))
                return
            }
            $checks.each(function() {
                ids.push($(this).val())
            })
            
            options.url = options.url.setUrlParam((options.idname ? options.idname : 'ids'), ids.join(','))
            
            $element.doAjax({type:options.type, url:options.url, data:options.data, callback:callback ? callback : $.proxy(function(data) {that.ajaxCallback(data)}, that)})
        }
        
        if (options.confirmMsg) {
            $element.alertmsg('confirm', options.confirmMsg, {
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
        var args     = arguments
        var property = option
        
        return this.each(function () {
            var $this   = $(this)
            var options = $.extend({}, Bjuiajax.DEFAULTS, $this.data(), typeof option == 'object' && option)
            var data    = $this.data('bjui.bjuiajax')
            
            if (!data) $this.data('bjui.bjuiajax', (data = new Bjuiajax(this, options)))
            if (typeof property == 'string' && $.isFunction(data[property])) {
                [].shift.apply(args)
                if (!args) data[property]()
                else data[property].apply(data, args)
            } else {
                return
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
    
    // BJUIAJAX DATA-API
    // ==============
    
    $(document).on('submit.bjui.bjuiajax.data-api', 'form[data-toggle="ajaxform"]', function(e) {
        var $this = $(this), options = $this.data()
        
        Plugin.call($this, 'ajaxForm', options)
        
        e.preventDefault()
    })
    
    /* doSearch */
    $(function() {
        if ($.validator) {
            $(document).on(BJUI.eventType.initUI, function(e) {
                $(e.target).find('form[data-toggle="ajaxsearch"]').each(function() {
                    var $form = $(this), options = $form.data()
                    
                    options.isValid = true
                    $form.validator({
                        valid: function(form) {
                            Plugin.call($form, 'doSearch', options)
                        }
                    })
                })
            })
        } else {
            $(document).on('submit.bjui.bjuiajax.data-api', 'form[data-toggle="ajaxsearch"]', function(e) {
                var $this   = $(this), options = $this.data()
                
                Plugin.call($this, 'doSearch', options)
                
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
        
        Plugin.call($form, 'doSearch', options)
        
        e.preventDefault()
    })
    
    $(document).on('click.bjui.bjuiajax.data-api', '[data-toggle="ajaxload"]', function(e) {
        var $this   = $(this)
        var options = $this.data()
        
        if (!options.url) options.url = $this.attr('href')
        
        Plugin.call($this, 'doLoad', options)
        
        e.preventDefault()
    })
    
    $(document).on(BJUI.eventType.initUI, function(e) {
        var $box    = $(e.target).find('[data-toggle="autoajaxload"]')
        
        $box.each(function() {
            var $element = $(this), options = $element.data()
            
            options.target = this
            Plugin.call($element, 'doLoad', options)
        })
    })
    
    $(document).on('click.bjui.bjuiajax.data-api', '[data-toggle="refreshlayout"]', function(e) {
        var $this   = $(this)
        var options = $this.data()
        
        Plugin.call($this, 'refreshLayout', options)
    })
    
    $(document).on('click.bjui.bjuiajax.data-api', '[data-toggle="doajax"]', function(e) {
        var $this   = $(this)
        var options = $this.data()
        
        if (!options.url) options.url = $this.attr('href')
        
        Plugin.call($this, 'doAjax', options)
        
        e.preventDefault()
    })
    
    $(document).on('click.bjui.bjuiajax.data-api', '[data-toggle="doexport"]', function(e) {
        var $this   = $(this)
        var options = $this.data()
        
        if (!options.url) options.url = $this.attr('href')
        
        Plugin.call($this, 'doExport', options)
        
        e.preventDefault()
    })
    
    $(document).on('click.bjui.bjuiajax.data-api', '[data-toggle="doexportchecked"]', function(e) {
        var $this   = $(this)
        var options = $this.data()
        
        if (!options.url) options.url = $this.attr('href')
        
        Plugin.call($this, 'doExportChecked', options)
        
        e.preventDefault()
    })
    
    $(document).on('click.bjui.bjuiajax.data-api', '[data-toggle="doajaxchecked"]', function(e) {
        var $this   = $(this)
        var options = $this.data()
        
        if (!options.url) options.url = $this.attr('href')
        
        Plugin.call($this, 'doAjaxChecked', options)
        
        e.preventDefault()
    })
    
}(jQuery);