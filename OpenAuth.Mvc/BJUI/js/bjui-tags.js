/*!
 * B-JUI  v1.2 (http://b-jui.com)
 * Git@OSC (http://git.oschina.net/xknaan/B-JUI)
 * Copyright 2014 K'naan (xknaan@163.com).
 * Licensed under Apache (http://www.apache.org/licenses/LICENSE-2.0)
 */

/* ========================================================================
 * B-JUI: bjui-tags.js  v1.2
 * @author K'naan (xknaan@163.com)
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
                    if ($.trim(that.$element.val()).length == 0) {
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
                if (term.length == 0) return
                
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
                $element.alertmsg('error', (options.warn || FRAG.alertPlhMsg.replace('#plhmsg#', BJUI.regional.plhmsg)))
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
            var options = $.extend({}, Tags.DEFAULTS, $this.data(), typeof option == 'object' && option)
            var data    = $this.data('bjui.tags')
            
            if (!data) $this.data('bjui.tags', (data = new Tags(this, options)))
            if (typeof property == 'string' && $.isFunction(data[property])) {
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