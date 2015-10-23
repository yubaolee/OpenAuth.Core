/*!
 * B-JUI  v1.2 (http://b-jui.com)
 * Git@OSC (http://git.oschina.net/xknaan/B-JUI)
 * Copyright 2014 K'naan (xknaan@163.com).
 * Licensed under Apache (http://www.apache.org/licenses/LICENSE-2.0)
 */

/* ========================================================================
 * B-JUI: bjui-lookup.js  v1.2
 * @author K'naan (xknaan@163.com)
 * -- Modified from dwz.database.js (author:ZhangHuihua@msn.com)
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
                that.$element.alertmsg('error', (options.warn || FRAG.alertPlhMsg.replace('#plhmsg#', BJUI.regional.plhmsg)))
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
        if (typeof args == 'string')
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
            this.$element.alertmsg('error', this.$element.data('warn') || FRAG.alertSelectMsg)
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
            var options = $.extend({}, Lookup.DEFAULTS, $this.data(), typeof option == 'object' && option)
            var data    = $this.data('bjui.lookup')
            
            if (!data) {
                $this.data('bjui.lookup', (data = new Lookup(this, options)))
            } else if ($this.data('newurl')) {
                data.options.url = $this.data('newurl')
                $this.data('bjui.dialog', null)
            }
            if (typeof property == 'string' && $.isFunction(data[property])) {
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