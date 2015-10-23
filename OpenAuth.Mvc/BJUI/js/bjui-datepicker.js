/*!
 * B-JUI  v1.2 (http://b-jui.com)
 * Git@OSC (http://git.oschina.net/xknaan/B-JUI)
 * Copyright 2014 K'naan (xknaan@163.com).
 * Licensed under Apache (http://www.apache.org/licenses/LICENSE-2.0)
 */

/* ========================================================================
 * B-JUI: bjui-datepicker.js  v1.2
 * reference: util.date.js
 * @author K'naan (xknaan@163.com)
 * -- Modified from dwz.datepicker.js (author:ZhangHuihua@msn.com)
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
                
        //动态minDate、maxDate
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
                else if (_count == 0) _format = 'y'
                
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
                    if (_count == 0)//format:y
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
                
                if (month == 0) {
                    if (yearIndex == 0) {
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
                that.$element.trigger(Datepicker.EVENTS.afterChange, {value:date})
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
            var options = $.extend({}, Datepicker.DEFAULTS, $this.data(), typeof option == 'object' && option)
            var data    = $this.data('bjui.datepicker')
            
            if (!data) $this.data('bjui.datepicker', (data = new Datepicker(this, options)))
            if (typeof property == 'string' && $.isFunction(data[property])) {
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