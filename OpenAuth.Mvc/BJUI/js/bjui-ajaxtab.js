/*!
 * B-JUI  v1.2 (http://b-jui.com)
 * Git@OSC (http://git.oschina.net/xknaan/B-JUI)
 * Copyright 2014 K'naan (xknaan@163.com).
 * Licensed under Apache (http://www.apache.org/licenses/LICENSE-2.0)
 */

/* ========================================================================
 * B-JUI: bjui-ajaxtab.js  v1.2
 * @author K'naan (xknaan@163.com)
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
                this.$element.alertmsg('error', (options.warn || FRAG.alertPlhMsg.replace('#plhmsg#', BJUI.regional.plhmsg)))
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
            var options = $.extend({}, Ajaxtab.DEFAULTS, $this.data(), typeof option == 'object' && option)
            var data    = $this.data('bjui.ajaxtab')
            
            if (!data) $this.data('bjui.ajaxtab', (data = new Ajaxtab(this, options)))
            if (typeof property == 'string' && $.isFunction(data[property])) {
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