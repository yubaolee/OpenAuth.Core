/*!
 * B-JUI  v1.2 (http://b-jui.com)
 * Git@OSC (http://git.oschina.net/xknaan/B-JUI)
 * Copyright 2014 K'naan (xknaan@163.com).
 * Licensed under Apache (http://www.apache.org/licenses/LICENSE-2.0)
 */

/* ========================================================================
 * B-JUI: bjui-taskbar.js  v1.2
 * reference: bjui-dialog.js
 * @author K'naan (xknaan@163.com)
 * -- Modified from dwz.taskBar.js (author:Roger Wu)
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
        var $task = $taskList.find('#'+ this.options.id)
        
        this.show()
        if (!$task.length) {
            var taskFrag = '<li id="#taskid#"><div class="taskbutton"><span><i class="fa fa-th-large"></i></span> <span class="title">#title#</span></div><div class="close"><i class="fa fa-times-circle"></i></div></li>';
            
            $task = $(taskFrag.replace('#taskid#', this.options.id).replace('#title#', this.options.title))
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
                var $dialog = $('body').data(that.options.id)
                
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
        var $task = (typeof task == 'string') ? this.getTask(task) : task
        
        if (!$task || !$task.length) return
        
        $task.remove()
        if (this.tools.getTasks().size() == 0) {
            this.hide()
        }
        this.tools.scrollCurrent()
        this.$element.removeData('bjui.taskbar')
    }
    
    Taskbar.prototype.minimize = function(dialog) {
        var that   = this
        var $dialog = (typeof dialog == 'string') ? $('body').data('dialog') : dialog
        var $task   = this.getTask($dialog.data('options').id)
        
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
                $dialog.show()
            })
        
        this.switchTask($task)
    }
    
    /**
     * @param {Object} id
     */
    Taskbar.prototype.inactive = function(task) {
        var $task = (typeof task == 'string') ? this.getTask(task) : task
        
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
        var $task = (typeof task == 'string') ? this.getTask(task) : task
        
        $task.addClass(taskSelected)
    }
    
    Taskbar.prototype.getTask = function(id) {
        return $taskList.find('#'+ id)
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
            var options = $.extend({}, Taskbar.DEFAULTS, $this.data(), typeof option == 'object' && option)
            var data    = $this.data('bjui.taskbar')
            
            if (!data) $this.data('bjui.taskbar', (data = new Taskbar(this, options)))
            else if (data.options.id != options.id) $this.data('bjui.taskbar', (data = new Taskbar(this, options)))
            
            if (typeof property == 'string' && $.isFunction(data[property])) {
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