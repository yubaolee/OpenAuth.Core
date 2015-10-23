/*!
 * B-JUI  v1.2 (http://b-jui.com)
 * Git@OSC (http://git.oschina.net/xknaan/B-JUI)
 * Copyright 2014 K'naan (xknaan@163.com).
 * Licensed under Apache (http://www.apache.org/licenses/LICENSE-2.0)
 */

/* ========================================================================
 * B-JUI: bjui-datagrid.js  v1.2 - beta
 * @author K'naan (xknaan@163.com)
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
            tr_edit       : 'datagrid-edit-tr',
            tr_add        : 'datagrid-add-tr',
            tr_selected   : 'datagrid-selected-tr',
            td_edit       : 'datagrid-edit-td',
            td_changed    : 'datagrid-changed',
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
        dataUrl         : null,     // Request data source url, for processing (filtering / sorting / paging) results
        loadType        : 'POST',   // Ajax load request type
        dataType        : 'json',   // Data type of data source
        local           : 'remote', // Optional 'local' | 'remote'
        fieldSortable   : true,     // Click the field to sort
        filterThead     : true,     // Filter in the thead
        sortAll         : false,    // Sort scope, false = this page, true = all
        filterAll       : false,    // Filter scope, false = this page, true = all
        filterMult      : true,     // Filter multiple fileds, false = single, true = multiple
        linenumberAll   : false,    // All data together numbers
        showLinenumber  : true,     // Display linenumber column, Optional 'true' | 'false' | 'lock', (Optional 'true, false' is a boolean)
        showCheckboxcol : false,    // Display checkbox column, Optional 'true' | 'false' | 'lock', (Optional 'true, false' is a boolean)
        showEditbtnscol : false,    // Display edit buttons column
        showTfoot       : false,    // Display the tfoot, Optional 'true' | 'false' | 'lock', (Optional 'true, false' is a boolean)
        showToolbar     : false,    // Display datagrid toolbar
        toolbarItem     : '',       // Displayed on the toolbar elements, Optional 'all, add, edit, cancel, save, del, import, export, |'
        toolbarCustom   : '',       // Html code || function || jQuery dom object, custom elements, displayed on the toolbar
        columnResize    : true,     // Allow adjust the column width
        columnMenu      : true,     // Display the menu button on the column
        columnShowhide  : true,     // On the menu display (show / hide columns)
        columnFilter    : true,     // On the menu display (filter form)
        columnLock      : true,     // On the menu display (lock / unlock columns)
        paging          : true,     // Display pagination component
        pagingAlign     : 'center', // The pagination component alignment
        editUrl         : null,     // An action URL, for processing (update / save), return results (json)
        editCallback    : null,     // Callback for save
        editMode        : 'inline', // Editing mode, Optional 'false' | 'inline' | 'dialog', (Optional 'false' is a boolean)
        editDialogOp    : null,     // For dialog edit, the dialog init options
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
        afterSave       : null,     // Function - after save method, arguments($trs, datas)
        afterDelete     : null      // Function - after delete method
    }
    
    Datagrid.renderItem = function(value, items) {
        if (!items || !items.length) return ''
        var label = ''
        
        $.each(items, function(i, n) {
            if (typeof n[value] != 'undefined') {
                label = n[value]
                return false
            }
        })
        
        return label
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
                    if (typeof beforeEdit == 'string') beforeEdit = beforeEdit.toFunc()
                    if (typeof beforeEdit == 'function') {
                        return beforeEdit.call(that, $trs, datas)
                    }
                }
                
                return true
            },
            afterSave: function($trs, data) {
                var afterSave = options.afterSave
                
                if (afterSave) {
                    if (typeof afterSave == 'string') afterSave = afterSave.toFunc()
                    if (typeof afterSave == 'function') {
                        afterSave.call(that, $trs, data)
                    }
                }
            },
            afterDelete: function() {
                var afterDelete = options.afterDelete
                
                if (afterDelete) {
                    if (typeof afterDelete == 'string') afterDelete = afterDelete.toFunc()
                    if (typeof afterDelete == 'function') {
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
            // transform columns to array
            columns2Arr: function(columns, rowArr, index, parent) {
                var tools = this
                
                if (!rowArr) rowArr = []
                if (!index)   index = 0
                if (!rowArr[index]) rowArr[index] = []
                
                $.each(columns, function(i, n) {
                    var len = rowArr[index].length, colspan
                    
                    if (parent) n.parent = parent
                    if (n.columns) {
                        colspan = n.columns.length
                        if (index && n.parent) {
                            tools.setColspan(n.parent, colspan)
                        }
                        
                        n.index     = that.columnModel.length + colspan - 1
                        n.colspan   = colspan
                        n.quicksort = false
                        rowArr[index][len++] = n
                        
                        return tools.columns2Arr(n.columns, rowArr, index + 1, n)
                    } else {
                        n.rowspan   = index
                        n.index     = that.columnModel.length
                        n.menu      = (typeof n.menu == 'undefined')      ? true  : n.menu
                        n.lock      = (typeof n.lock == 'undefined')      ? true  : n.lock
                        n.hide      = (typeof n.hide == 'undefined')      ? false : n.hide
                        n.edit      = (typeof n.edit == 'undefined')      ? true  : n.edit
                        n.add       = (typeof n.add       == 'undefined') ? true  : n.add
                        n.quicksort = (typeof n.quicksort == 'undefined') ? true  : n.quicksort
                        
                        rowArr[index][len++] = n
                        that.columnModel.push(n)
                    }
                })
                
                return rowArr
            },
            // create trs by data source
            createTrsByData: function(data, refreshFlag) {
                var list
                
                if (!that.$tbody) that.$tbody = $('<tbody></tbody>')
                if (data) {
                    if (data.list) list = data.list
                    else list = data
                    
                    that.paging.total = list.length
                    
                    if (typeof data == 'object') {
                        if (data[BJUI.pageInfo.total]) that.paging.total = parseInt(data[BJUI.pageInfo.total])
                        if (data[BJUI.pageInfo.pageSize]) {
                            if (refreshFlag && that.paging.pageSize != data[BJUI.pageInfo.pageSize]) {
                                that.$selectpage.trigger('bjui.datagrid.paging.pageSize', data[BJUI.pageInfo.pageSize])
                            }
                            that.paging.pageSize = parseInt(data[BJUI.pageInfo.pageSize])
                        }
                    }
                    
                    that.paging.pageCount = tools.getPageCount(that.paging.pageSize, that.paging.total)
                    if (that.paging.pageCurrent > that.paging.pageCount) that.paging.pageCurrent = that.paging.pageCount
                    
                    this.initTbody(list, refreshFlag)
                }
                
                if (!that.init_tbody) that.$tbody.appendTo(that.$element)
                if (!that.init_thead) that.initThead()
            },
            // initTbody
            initTbody: function(data, refreshFlag) {
                var tools = this, allData = that.allData, type = options.dataType || 'json', model = that.columnModel, hiddenFields = that.hiddenFields, regional = that.regional, newData = [], attach = that.attach, json
                var paging  = that.paging, start = 0, end = paging.pageSize
                var doInit  = function() {
                    type = type.toLowerCase()
                    if (data) allData = that.allData = data
                    if (!allData.length) {
                        end = 0
                    } else {
                        if (options.local == 'local') {
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
                    if (type == 'array' && data && data.length && $.type(data[0]) == 'array') {
                        var a1 = start, a2 = end, arrData = [], _index
                        
                        if (options.local == 'local') {
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
                                if (typeof val == 'string') val = '"'+ val +'"'
                                
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
                }
                
                if (refreshFlag && that.$boxM) {
                    that.$boxM.show().trigger('bjui.ajaxEnd').trigger('bjui.ajaxStart', [50, doInit])
                } else {
                    doInit()
                }
            },
            // create tbody - tr
            createTrs: function(datas, refreshFlag) {
                var tools = this, model = that.columnModel, paging = that.paging, editFrag = BJUI.doRegional(FRAG.gridEditBtn, that.regional), lockedCols = []
                
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
                
                $.each(datas, function(i, trData) {
                    var $tr = $('<tr></tr>'), $td, linenumber = options.linenumberAll ? ((paging.pageCurrent - 1) * paging.pageSize + (i + 1)) : (i + 1)
                    
                    $.extend(trData, {gridNumber:linenumber, gridIndex:i})
                    
                    $.each(model, function(j, n) {
                        var name = n.name || 'datagrid-noname', label = trData[name], align = '', cls = '', _label
                        
                        if (typeof label == 'undefined') label = ''
                        _label = label
                        
                        if (n.align) align = ' align="'+ n.align +'"'
                        if (n.gridCheckbox) label = '<div><input type="checkbox" data-toggle="icheck" name="datagrid.checkbox" value="true"></div>'
                        if (n.gridEdit) {
                            label = editFrag
                            cls   = ' class="'+ that.classnames.s_edit +'"'
                        }
                        
                        /* for tfoot */
                        if (n.calc) {
                            if (!n.calc_count) n.calc_count = datas.length
                            
                            var number = label ? (String(label).isNumber() ? label * 1 : 0) : 0
                            
                            if (n.calc == 'sum' || n.calc == 'avg') n.calc_sum = (n.calc_sum || 0) + number
                            else if (n.calc == 'max') n.calc_max = n.calc_max ? (n.calc_max < number ? number : n.calc_max) : number
                            else if (n.calc == 'min') n.calc_min = n.calc_min ? (n.calc_min > number ? number : n.calc_min) : number
                        }
                        
                        /* append */
                        $td = $('<td'+ align + cls +'><div>'+ label +'</div></td>')
                        $td.data('val', label).appendTo($tr)
                        if (n.gridNumber)   $td.addClass(that.classnames.td_linenumber)
                        if (n.gridCheckbox) $td.addClass(that.classnames.td_checkbox)
                        if (refreshFlag && n.hidden) $td.css('display', 'none')
                        
                        /* render */
                        if (n.items && !n.render) n.render = $.datagrid.renderItem
                        if (n.render && typeof n.render == 'string')  n.render = n.render.toFunc()
                        if (n.render && typeof n.render == 'function') {
                            var render_label = '', render_items = false
                            
                            if (n.items) {
                                if (typeof n.items == 'string') {
                                    if (n.render.trim().startsWith('[')) n.render = n.render.toObj()
                                    else n.render = n.render.toFunc()
                                }
                                
                                if (!n.renderTds) n.renderTds = []
                                
                                var delayRender = function($td, label) {
                                    $.when(n.items.call(that)).then(function(item) {
                                        n.items = item
                                        render_label = n.render.call(that, label, item)
                                        $td.html(render_label)
                                        
                                        $.each(n.renderTds, function(ii, nn) {
                                            render_label = n.render.call(that, nn.text(), item)
                                            nn.html(render_label)
                                            
                                            if (ii == n.renderTds.length - 1) n.renderTds = null
                                        })
                                        
                                        that.delayRender --
                                    })
                                }
                                
                                if (typeof n.items == 'function') {
                                    if (i == 0) {
                                        if (!that.delayRender) that.delayRender = 0
                                        that.delayRender ++
                                        delayRender($td, _label)
                                    } else {
                                        n.renderTds.push($td)
                                    }
                                } else {
                                    render_label = n.render.call(that, _label, n.items)
                                    $td.html(render_label)
                                }
                            } else {
                                render_label = n.render.call(that, _label)
                                $td.html(render_label)
                            }
                        }
                    })
                    
                    $tr.appendTo(that.$tbody)
                    
                    if (refreshFlag) $tr.initui()
                })
                
                if (refreshFlag) {
                    that.initEvents()
                    if (options.editMode) that.edit()
                    
                    that.$paging && that.$paging.trigger('bjui.datagrid.paging.jump')
                    
                    // locked
                    $.each(model, function(i, n) {
                        if (n.lock_refresh) {
                            that.colLock(n.th, true)
                            delete n.lock_refresh
                        }
                    })
                }
                
                if (that.$boxM) {
                    that.$boxM.trigger('bjui.ajaxStop').hide()
                }
            },
            // ajax load data by url
            loadData: function(data, refreshFlag) {
                var tools = this, url = options.dataUrl, dataType = options.dataType || 'json', model = that.columnModel
                
                if (that.$tbody) {
                    that.$boxM.show().trigger('bjui.ajaxStart', [50])
                }
                
                dataType = dataType.toLowerCase()
                if (dataType == 'array') dataType = 'text'
                
                $.ajax({url:url, data:data || {}, type:options.loadType, cache:options.cache || false, dataType:dataType, success:function(response) {
                        if (dataType == 'xml') {
                            var xmlData = [], obj
                            
                            $(response).find('row').each(function() {
                                obj = {}
                                
                                $(this).find('cell').each(function(i) {
                                    var $cell = $(this), label = $cell.text(), name = $cell.attr('name')
                                    
                                    obj[name] = label
                                })
                                
                                xmlData.push(obj)
                            })
                            
                            if (xmlData) tools.createTrsByData(xmlData, refreshFlag)
                        } else if (dataType == 'json') {
                            tools.createTrsByData(response, refreshFlag)
                        } else {
                            tools.createTrsByData(response.toObj(), refreshFlag)
                        }
                    }
                })
            },
            // append columns
            appendColumns: function() {
                that.linenumberColumn = {name:'gridNumber', gridNumber:true, width:30, minWidth:30, label:'No.', align:'center', menu:false, edit:false, quicksort:false}
                that.checkboxColumn   = {name:'gridCheckbox', gridCheckbox:true, width:40, minWidth:40, label:'Checkbox', align:'center', menu:false, edit:false, quicksort:false}
                that.editBtnsColumn   = {name:'gridEdit', gridEdit:true, width:110, minWidth:110, label:'Edit', align:'center', menu:false, edit:false, hide:false, quicksort:false}
            },
            // create Thead
            createThead: function() {
                var tools  = this, columns = options.columns, rowArr = [], rows = [], label, align, width, colspan, rowspan, resize, menu
                
                tools.appendColumns()
                
                if (options.showCheckboxcol) {
                    columns.unshift(that.checkboxColumn)
                    if (options.showCheckboxcol == 'lock') that.checkboxColumn.initLock = true
                }
                if (options.showLinenumber) {
                    columns.unshift(that.linenumberColumn)
                    if (options.showLinenumber == 'lock') that.linenumberColumn.initLock = true
                }
                if (options.showEditbtnscol) columns.push(that.editBtnsColumn)
                
                rowArr = tools.columns2Arr(columns, rowArr)
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
                        $th.find('> div').css('height', (rowArr.length - n.rowspan > 1) ? (24 * (rowArr.length - n.rowspan)) +'px' : '24px')
                        
                        if (!rowspan) $th.addClass('single-row')
                        if (n.gridNumber) $th.addClass(that.classnames.td_linenumber)
                        if (options.fieldSortable && n.quicksort) $th.addClass('datagrid-quicksort-th')
                        
                        n.th = $th
                    })
                    
                    $tr.appendTo(that.$thead)
                })
                
                that.$thead.appendTo(that.$element)
            },
            // create Tbody
            createTbody: function() {
                var tools = this, data = options.data, model = that.columnModel, cols = []
                
                if (data) {
                    if (typeof data == 'string') {
                        if (data.trim().startsWith('[') || data.trim().startsWith('{')) {
                            data = data.toObj()
                        } else {
                            data = data.toFunc()
                        }
                    }
                    if (typeof data == 'function') {
                        data = data.call()
                    }
                    tools.createTrsByData(data)
                } else if (options.dataUrl) {
                    tools.loadData()
                }
            },
            // setBoxb - height
            setBoxbH: function(height) {
                var boxH = height || options.height, topM = 0, h
                
                if (boxH < 100) return
                if (isNaN(boxH)) boxH = that.$grid.height()
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
                if (that.$box_paging)
                    boxH -= that.$box_paging.outerHeight()
                if (that.$boxF)
                    boxH -= that.$boxF.outerHeight()
                
                topM += that.$tableH.outerHeight()
                boxH -= that.$boxH.outerHeight()
                
                if (boxH < 0) boxH = 0
                
                that.$boxB.height(boxH)
                that.$boxM.height(boxH).css({top:topM})
            },
            // fixed h
            fixedH: function(height) {
                this.setBoxbH(height)
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
                
                if (typeof model.hidden == 'undefined') model.hidden = false
                if (model.hidden == !showFlag) return
                
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
            },
            // jump to page
            jumpPage: function(pageCurrent, pageSize) {
                var allData = that.allData, filterDatas
                
                if (pageCurrent) that.paging.pageCurrent = pageCurrent
                if (pageSize) {
                    that.paging.pageSize  = pageSize
                    that.paging.pageCount = this.getPageCount(pageSize, that.paging.total)
                    
                    if (that.paging.pageCurrent > that.paging.pageCount)
                        that.paging.pageCurrent = that.paging.pageCount
                }
                
                if (options.local == 'remote') {
                    filterDatas = this.getRemoteFilterData(true)
                    this.loadData(filterDatas, true)
                } else {
                    this.initTbody(allData, true)
                }
            },
            // column - quicksort
            quickSort: function(model) {
                if (that.isDom) {
                    if (options.local == 'local') return
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
                        
                        if (type == 'boolean' || type == 'number' || (typeA = typeB == 'number') || (typeA = typeB == 'boolean')) {
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
                //that.$menu && that.$menu.trigger('bjui.datagrid.th.sort', [model.sortAsc])
                
                if (options.sortAll) {
                    if (options.local == 'remote') {
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
                var switchOperator = function(operator, val1, val2) {
                    var compare = false
                    
                    switch (operator) {
                    case '=':
                        compare = String(val1) == String(val2)
                        break
                    case '!=':
                        compare = String(val1) != String(val2)
                        break
                    case '>':
                        compare = parseFloat(val2) > parseFloat(val1)
                        break
                    case '<':
                        compare = parseFloat(val2) < parseFloat(val1)
                        break
                    case 'like':
                        if (model.type == 'select') {
                            compare = String(val1) == String(val2)
                        } else {
                            compare = (String(val2).indexOf(String(val1)) >= 0)
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
                                if (v.model.quickfilter) v.model.quickfilter.trigger('bjui.datagrid.thead.clearfilter')
                                return true
                            }
                            
                            v.model.isFiltered = true
                            v.model.th.trigger('bjui.datagrid.th.filter', [true])
                            
                            if (op.andor) {
                                if (op.andor == 'and') {
                                    if (switchOperator(op.operatorA, op.valA, n[name]) && switchOperator(op.operatorB, op.valB, n[name])) {
                                        count --
                                    }
                                } else if (op.andor == 'or') {
                                    if (switchOperator(op.operatorA, op.valA, n[name]) || switchOperator(op.operatorB, op.valB, n[name])) {
                                        count --
                                    }
                                }
                            } else {
                                if (op.operatorB) {
                                    if (switchOperator(op.operatorB, op.valB, n[name])) {
                                        count --
                                    }
                                } else {
                                    if (switchOperator(op.operatorA, op.valA, n[name])) {
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
                
                if (options.local != 'remote' && allData) {
                    if (!that.oldAllData) that.oldAllData = allData.concat()
                    else allData = that.oldAllData.concat()
                }
                
                if (options.filterAll) {
                    if (options.local == 'remote') {
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
                        fDatas = filterData(data, that.filterDatas)
                        this.createTrs(fDatas, true)
                    }
                }
            },
            getRemoteFilterData: function(isPaging) {
                var filterDatas = []
                
                if (that.filterDatas && !$.isEmptyObject(that.filterDatas)) {
                    $.each(that.filterDatas, function(name, v) {
                        if (!v.datas) {
                            v.model.isFiltered = false
                            v.model.th.trigger('bjui.datagrid.th.filter', [false])
                            if (v.model.quickfilter) v.model.quickfilter.trigger('bjui.datagrid.thead.clearfilter')
                            return true
                        }
                        
                        v.model.isFiltered = true
                        v.model.th.trigger('bjui.datagrid.th.filter', [true])
                        
                        if (options.jsonPrefix)
                            name = options.jsonPrefix +'.'+ name
                        
                        if (v.datas.andor)
                            filterDatas.push({name:'andor', value:v.datas.andor})
                        if (v.datas.operatorA) {
                            filterDatas.push({name:name, value:v.datas.valA})
                            filterDatas.push({name:name +'.operator', value:v.datas.operatorA})
                        }
                        if (v.datas.operatorB) {
                            filterDatas.push({name:name, value:v.datas.valB})
                            filterDatas.push({name:name +'.operator', value:v.datas.operatorB})
                        }
                    })
                    
                    if (!isPaging) that.paging.pageCurrent = 1
                }
                
                // paging
                filterDatas.push({name:BJUI.pageInfo.pageSize, value:that.paging.pageSize})
                filterDatas.push({name:BJUI.pageInfo.pageCurrent, value:that.paging.pageCurrent})
                
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
                    if (op.attrs && typeof op.attrs == 'object') {
                        $.each(op.attrs, function(i, n) {
                            attrs += ' '+ i +'='+ n
                        })
                    }
                    
                    if (op == that.linenumberColumn || op == that.checkboxColumn || op == that.editBtnsColumn) {
                        that.inputs.push('')
                    } else if (name) {
                        if (op.rule) rule = ' data-rule="'+ op.label +'：'+ op.rule +'"'
                        else if (op.type == 'date') rule = ' data-rule="pattern('+ (op.pattern || 'yyyy-MM-dd') +')"';
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
                
                that.$tableH.on('contextmenu', function(e) {
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
    
    Datagrid.prototype.createTable = function() {
        var that = this, options = that.options, tools = that.tools
        
        if (options.columns) tools.createThead()
        if (options.data || options.dataUrl) tools.createTbody()
    }
    
    // DOM to datagrid - setColumnModel
    Datagrid.prototype.setColumnModel = function() {
        var that = this, options = that.options, $trs = that.$thead.find('> tr'), rows = [], ths = [], trLen = $trs.length
        
        if (!that.isDom) {
            that.tools.appendColumns()
            
            var $th, _rowspan = trLen > 1 ? ' rowspan="'+ trLen +'"' : ''
            
            if (options.showCheckboxcol) {
                that.columnModel.push(that.checkboxColumn)
                if (options.showCheckboxcol == 'lock') that.checkboxColumn.initLock = true
                
                $th = $('<th'+ _rowspan +'><input type="checkbox" data-toggle="icheck"></th>')
                $th.prependTo($trs.first())
                if (_rowspan) $th.data('datagrid.column', that.checkboxColumn)
            }
            if (options.showLinenumber) {
                that.columnModel.unshift(that.linenumberColumn)
                if (options.showLinenumber == 'lock') that.linenumberColumn.initLock = true
                
                $th = $('<th class="datagrid-linenumber-td"'+ _rowspan +'>No.</th>')
                $th.prependTo($trs.first())
                if (_rowspan) $th.data('datagrid.column', that.linenumberColumn)
            }
            if (options.showEditbtnscol) {
                that.columnModel[$th.index()] = that.editBtnsColumn
                
                $th = $('<th'+ _rowspan +'>Edit</th>')
                $th.appendTo($trs.first())
                if (_rowspan) $th.data('datagrid.column', that.editBtnsColumn)
            }
        }
        
        if ($trs.length && trLen == 1) {
            $trs.height(25)
            $trs.find('> th').each(function(i) {
                var $th = $(this).addClass('single-row'), op = $th.data('options'), oW = $th.attr('width') || $th.outerWidth(), label = $th.html()
                
                if (that.columnModel.length && that.columnModel[i]) {
                    op = that.columnModel[i]
                } else {
                    if (op && typeof op == 'string') op = op.toObj()
                    if (typeof op != 'object') op = {}
                    
                    op.index = i
                    op.label = label
                    
                    op.width     = (typeof op.width     == 'undefined') ? oW    : op.width
                    op.menu      = (typeof op.menu      == 'undefined') ? true  : op.menu
                    op.lock      = (typeof op.lock      == 'undefined') ? true  : op.lock
                    op.hide      = (typeof op.hide      == 'undefined') ? false : op.hide
                    op.edit      = (typeof op.edit      == 'undefined') ? true  : op.edit
                    op.add       = (typeof op.add       == 'undefined') ? true  : op.add
                    op.quicksort = (typeof op.quicksort == 'undefined') ? true  : op.quicksort
                    
                    that.columnModel[i] = op
                }
                
                op.th = $th
                
                $th.html('<div><div class="datagrid-space"></div><div class="datagrid-label">'+ label +'</div><div class="'+ that.classnames.th_cell +'"><div class="'+ that.classnames.th_resizemark +'"></div></div></div>')
                if (op.menu && options.columnMenu) $th.addClass(that.classnames.th_menu)
                if (options.fieldSortable && op.quicksort) $th.addClass('datagrid-quicksort-th')
                if (op.align) $th.attr('align', op.align)
                $th.data('index', i).find('> div').css('height', '24px')
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
                
                $(this).height(25).find('> th').each(function(i) {
                    var $th = $(this), op = $th.data('options') || $th.data('datagrid.column') || {}, colspan = parseInt($th.attr('colspan') || 0), rowspan = parseInt($th.attr('rowspan') || 0), oW = $th.attr('width') || $th.outerWidth(), label = $th.html()
                    
                    if (op && typeof op == 'string') op = op.toObj()
                    if (typeof op != 'object') op = {}
                    if ( !-[1,] && colspan == 1) colspan = 0 
                    
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
                        op.width     = (typeof op.width     == 'undefined') ? oW    : op.width
                        op.menu      = (typeof op.menu      == 'undefined') ? true  : op.menu
                        op.lock      = (typeof op.lock      == 'undefined') ? true  : op.lock
                        op.hide      = (typeof op.hide      == 'undefined') ? false : op.hide
                        op.edit      = (typeof op.edit      == 'undefined') ? true  : op.edit
                        op.add       = (typeof op.add       == 'undefined') ? true  : op.add
                        op.quicksort = (typeof op.quicksort == 'undefined') ? true  : op.quicksort
                        
                        $th.html('<div style="height:'+ (rowspan ? rowspan * 24 : 24) +'px;"><div class="datagrid-space"></div><div class="datagrid-label">'+ label +'</div><div class="'+ that.classnames.th_cell +'"><div class="'+ that.classnames.th_resizemark +'"></div></div></div>')
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
                        $th.html('<div style="height:'+ (rowspan ? rowspan * 24 : 24) +'px;"><div class="datagrid-space"></div><div class="datagrid-label">'+ label +'</div><div class="'+ that.classnames.th_cell +'"><div class="'+ that.classnames.th_resizemark +'"></div></div></div>')
                    }
                })
            })
        }
    }
    
    Datagrid.prototype.init = function() {
        if (!this.$element.isTag('table')) return
        if (this.$element.data('bjui.datagrid.init')) return
        
        var that = this, options, tools = that.tools, $parent = that.$element.parent(), boxWidth
        
        if (that.options.options) {
            if (typeof that.options.options == 'string') that.options.options = that.options.options.toObj()
            $.extend(that.options, typeof that.options.options == 'object' && that.options.options)
        }
        
        that.parentH = $parent.height()
        
        options = that.options
        that.$element.data('bjui.datagrid.init', true)
        if (!options.width) boxWidth = $parent.width()
        if (String(options.width).endsWith('%')) boxWidth = Math.round($parent.width() * parseInt(String(options.width).replace('%', '')) / 100)
        
        options.height    = options.height || 300
        that.isDom        = false
        that.columnModel  = []
        that.inputs       = []
        that.$grid        = $('<div class="bjui-datagrid"></div>').width(options.width).height(options.height)
        that.$boxH        = $('<div class="datagrid-box-h"></div>')
        that.$boxB        = $('<div class="datagrid-box-b"></div>')
        that.$boxM        = $('<div class="datagrid-box-m"></div>').appendTo(that.$grid)
        that.regional     = BJUI.regional.datagrid
        
        that.$element.before(that.$grid)
        
        if (typeof options.paging == 'string') options.paging = options.paging.toObj()
        that.paging = $.extend({}, {pageSize:30, selectPageSize:'30,60,90', pageCurrent:1, total:0, showPagenum:5}, (typeof options.paging == 'object') && options.paging)
        that.attach = {gridNumber:0, gridCheckbox:'#checkbox#', gridEdit:'#edit#'}
        
        that.$thead = that.$element.find('> thead')
        that.$tbody = that.$element.find('> tbody')
        
        if (that.$tbody && that.$tbody.find('> tr').length)
            that.isDom = true
        
        if (options.columns) {
            if (typeof options.columns == 'string') {
                if (options.columns.trim().startsWith('[')) {
                    options.columns = options.columns.toObj()
                } else {
                    options.columns = options.columns.toFunc()
                }
            }
            if (typeof options.columns == 'function') {
                options.columns = options.columns.call()
            }
            
            that.$thead = null
            tools.createThead()
        } else {
            if (that.$thead && that.$thead.length && that.$thead.find('> tr').length) {
                that.setColumnModel()
            }
        }
        
        that.initTop()
        
        that.$grid.data('bjui.datagrid.table', that.$element.clone())
        
        if (that.isDom) {
            tools.appendColumns()
            
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
            if (options.data || options.dataUrl) tools.createTbody()
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
        
        postData[pageInfo.pageSize]    = paging.pageSize
        postData[pageInfo.pageCurrent] = paging.pageCurrent
        tools.loadData(postData, true)
        
        // clear fiter
        that.filterDatas = null
        $.each(that.columnModel, function(i, n) {
            n.th.trigger('bjui.datagrid.th.filter', [false])
            n.isFiltered = false
            if (n.quickfilter) n.quickfilter.trigger('bjui.datagrid.thead.clearfilter')
        })
        // clear sort
        that.$thead.find('> tr > th.datagrid-quicksort-th').find('> div > .datagrid-label > i').remove()
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
        
        if (options.gridTitle) {
            that.$boxT = $('<div class="datagrid-title">'+ options.gridTitle +'</div>')
            
            that.$boxT.appendTo(that.$grid)
        }
        if (options.showToolbar) {
            if (options.toolbarItem || options.toolbarCustom) {
                that.$toolbar = $('<div class="datagrid-toolbar"></div')
                if (options.toolbarItem) {
                    hastoolbaritem = true
                    if (options.toolbarItem.indexOf('all') >= 0) options.toolbarItem = 'add, edit, cancel, save, |, del, |, refresh, |, import, export'
                    $.each(options.toolbarItem.split(','), function(i, n) {
                        n = n.trim().toLocaleLowerCase()
                        if (!$group || n == '|') {
                            $group = $(groupHtml).appendTo(that.$toolbar)
                            if (n == '|') return true
                        }
                        
                        if (n == 'add') {
                            that.$toolbar_add = $(btnHtml).attr('data-icon', 'plus').addClass('btn-blue').text(BJUI.getRegional('datagrid.add'))
                                .appendTo($group)
                                .on('click', function(e) {
                                    that.add()
                                })
                        } else if (n == 'edit') {
                            that.$toolbar_edit = $(btnHtml).attr('data-icon', 'edit').addClass('btn-green').text(BJUI.getRegional('datagrid.edit'))
                                .appendTo($group)
                                .on('click', function(e) {
                                    var $selectTrs = that.$tbody.find('> tr.'+ that.classnames.tr_selected)
                                    
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
                        } else if (n == 'cancel') {
                            that.$toolbar_calcel = $(btnHtml).attr('data-icon', 'undo').addClass('btn-orange').text(BJUI.getRegional('datagrid.cancel'))
                                .appendTo($group)
                                .on('click', function(e) {
                                    that.doCancelEditRow(that.$tbody.find('> tr.'+ that.classnames.tr_edit))
                                })
                        } else if (n == 'save') {
                            that.$toolbar_save = $(btnHtml).attr('data-icon', 'save').addClass('btn-default').text(BJUI.getRegional('datagrid.save'))
                                .appendTo($group)
                                .on('click', function(e) {
                                    that.doSaveEditRow()
                                })
                        } else if (n == 'del') {
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
                        } else if (n == 'refresh') {
                            that.$toolbar_refresh = $(btnHtml).attr('data-icon', 'refresh').addClass('btn-green').text(BJUI.getRegional('datagrid.refresh'))
                                .appendTo($group)
                                .on('click', function(e) {
                                    that.refresh()
                                })
                        } else if (n == 'import') {
                            that.$toolbar_add = $(btnHtml).attr('data-icon', 'sign-in').addClass('btn-blue').text(BJUI.getRegional('datagrid.import'))
                                .appendTo($group)
                                .on('click', function(e) {
                                    if (options.importOption) {
                                        var opts = options.importOption
                                        
                                        if (typeof opts == 'string')
                                            opts = opts.toObj()
                                        
                                        if (opts.options && opts.options.url) {
                                            if (opts.type == 'dialog') {
                                                that.$grid.dialog(opts.options)
                                            } else if (opts.type == 'navtab') {
                                                that.$grid.navtab(opts.options)
                                            } else {
                                                that.$grid.bjuiajax('doAjax', opts.options)
                                            }
                                        }
                                    }
                                })
                        } else if (n == 'export') {
                            that.$toolbar_add = $(btnHtml).attr('data-icon', 'sign-out').addClass('btn-green').text(BJUI.getRegional('datagrid.export'))
                                .appendTo($group)
                                .on('click', function(e) {
                                    if (options.exportOption) {
                                        var opts = options.exportOption
                                        
                                        if (typeof opts == 'string')
                                            opts = opts.toObj()
                                        
                                        if (opts.options && opts.options.url) {
                                            if (opts.type == 'dialog') {
                                                that.$grid.dialog(opts.options)
                                            } else if (opts.type == 'navtab') {
                                                that.$grid.navtab(opts.options)
                                            } else if (opts.type == 'file') {
                                                $.fileDownload(opts.options.url, {
                                                    failCallback: function(responseHtml, url) {
                                                        if (responseHtml.trim().startsWith('{')) responseHtml = responseHtml.toObj()
                                                        that.$grid.bjuiajax('ajaxDone', responseHtml)
                                                    }
                                                })
                                            } else {
                                                that.$grid.bjuiajax('doAjax', opts.options)
                                            }
                                        }
                                    }
                                })
                        }
                    })
                }
                
                if (options.toolbarCustom) {
                    var $custom, $custombox = $('<div style="display:inline-block;"></div>')
                    
                    if (typeof options.toolbarCustom == 'string') {
                        var custom = $(options.toolbarCustom)
                        
                        if (custom && custom.length) {
                            $custom = custom
                        } else {
                            custom = custom.toFunc()
                            if (custom) {
                                $custom = custom.call(that)
                                if (typeof $custom == 'string') $custom = $($custom)
                            }
                        }
                    } else if (typeof options.toolbarCustom == 'function') {
                        $custom = options.toolbarCustom.call(that)
                        if (typeof $custom == 'string') $custom = $($custom)
                    } else {
                        $custom = options.toolbarCustom
                    }
                    
                    if ($custom && $custom.length && typeof $custom != 'string') {
                        if (hastoolbaritem) {
                            $custombox.css('margin-left', '5px')
                        }
                        $custombox.appendTo(that.$toolbar)
                        $custom.appendTo($custombox)
                    }
                }
                
                that.$toolbar.appendTo(that.$grid)
            }
        }
    }
    
    Datagrid.prototype.initThead = function() {
        var that = this, options = that.options, tools = that.tools, columnModel = that.columnModel, width, cols = [], $firstTds = that.$tbody.find('> tr:first-child > td')
        
        that.init_thead  = true
        that.$colgroupH  = $('<colgroup></colgroup>')
        that.$tableH     = $('<table class="table table-bordered"></table>').append(that.$thead)
        that.$trsH       = that.$thead.find('> tr')
        that.table_width = 0
        
        $.each(that.columnModel, function(i, n) {
            width = n.width ? n.width : ($firstTds.eq(i).outerWidth() || 50)
            cols.push('<col style="width:'+ width +'px;">')
            n.width = width
            that.table_width += width
        })
        
        that.$thead.before(that.$colgroupH.append(cols.join('')))
        that.$grid.append(that.$boxH.append($('<div class="datagrid-wrap-h"></div>').append(that.$tableH)))
        
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
        that.resizeGrid()
        
        var delayFunc = function() {
            if (options.showTfoot) that.initTfoot()
            that.initLock()
            that.$grid.initui()
            if (options.height) tools.fixedH()
            setTimeout(function() {
                that.fixedWidth('init')
            }, 500)
            that.initEvents()
        }
        
        if (options.filterThead) {
            if (that.delayRender) {
                that.delayFilterTimeout = setInterval(function() {
                    if (!that.delayRender) {
                        clearInterval(that.delayFilterTimeout)
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
        var that = this, options = that.options, bW, excludeW = 0, fixedW, width, columnModel = that.columnModel, length = columnModel.length
        
        if (isInit && that.initFixedW) return
        that.initFixedW = true
        
        var setNewWidth = function() {
            that.$boxH.find('> div').css('width', '')
            that.$boxB.find('> div').css('width', '')
            that.$boxF && that.$boxF.find('> div').css('width', '')
            that.$pagingCon && that.$pagingCon.css('width', '')
            
            bW = that.$boxB.find('> div').width()
            
            if (bW) {
                that.$boxB.find('> div').width(bW)
                that.$boxH.find('> div').width(bW)
                that.$boxF && that.$boxF.find('> div').width(bW)
                
                if (that.table_width > bW)
                    that.$pagingCon && that.$pagingCon.width(bW)
                else
                    that.$pagingCon && that.$pagingCon.width(that.table_width)
            }
        }
        
        var doFixedW = function() {
            if (bW && bW < that.table_width) {
                if (columnModel[length - 1] == that.editBtnsColumn) {
                    excludeW += that.editBtnsColumn.width
                    length --
                }
                if (columnModel[0] == that.linenumberColumn) {
                    excludeW += that.linenumberColumn.width
                    length --
                }
                if (columnModel[0] == that.checkboxColumn || columnModel[1] == that.checkboxColumn) {
                    excludeW += that.checkboxColumn.width
                    length --
                }
                
                fixedW = parseInt((bW - that.table_width - excludeW) / length)
                
                if (!fixedW) fixedW = -1
                else fixedW --
                
                $.each(columnModel, function(i, n) {
                    if (n == that.linenumberColumn || n == that.checkboxColumn || n == that.editBtnsColumn) return true
                    
                    width = n.width + fixedW
                    if (width <= 0) width = 1
                    that.$colgroupH.find('> col:eq('+ n.index +')').width(width)
                    that.$colgroupB.find('> col:eq('+ n.index +')').width(width)
                    that.$colgroupF && that.$colgroupF.find('> col:eq('+ n.index +')').width(width)
                    n.new_width = width
                })
            }
        }
        
        if (options.fullGrid) {
            setNewWidth()
            doFixedW()
        } else {
            setNewWidth()
        }
    }
    
    Datagrid.prototype.initTbody = function() {
        var that = this, options = that.options, tools = that.tools, $trs = that.$tbody.find('> tr'), $tds = $trs.find('> td'), width = '0'
        
        that.init_tbody = true
        that.$colgroupB = that.$colgroupH.clone()
        that.$tableB    = that.$element
        that.$tableB.removeAttr('data-toggle width').empty().append(that.$tbody)
        that.$tbody.before(that.$colgroupB)
        that.$grid.append(that.$boxB.append($('<div class="datagrid-wrap-b"></div>').append(that.$tableB)))
        
        if ( !-[1,] ) width = 'auto' //for ie8
        if (options.fullGrid) width = '100%'
        
        that.$tableH.width(width)
        that.$tableB.width(width)
        
        // add class
        that.$tableB.addClass('table table-bordered').removeClass('table-hover')
        
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
        $trs
            .on('click.bjui.datagrid.tr', function(e, checkbox) {
                var $tr = $(this), index = $tr.index(), $selectedTrs = that.$tbody.find('> tr.'+ that.classnames.tr_selected), $last = that.$lastSelect, checked, $lockTrs = that.$lockTbody && that.$lockTbody.find('> tr')
                
                if (checkbox) {
                    checked = checkbox.is(':checked')
                    if (!checked) that.$lastSelect = $tr
                    that.selectedRows($tr, !checked)
                } else {
                    if ($tr.hasClass(that.classnames.tr_edit)) return
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
                var $tr = $(this), index = $tr.index(), data = that.data, gridIndex, allData = that.allData, $lockTrs = that.$lockTbody && that.$lockTbody.find('> tr')
                
                if (!that.isDom) {
                    gridIndex    = data[index].gridIndex
                    that.data    = data.remove(index)        // remove data in the current page data
                    that.allData = allData.remove(gridIndex) // remove data in allData
                }
                
                /* update gridNumber */
                if (that.columnModel[0] == that.linenumberColumn) {
                    $tr.nextAll().each(function() {
                        var $td = $(this).find('> td:eq(0)'), num = parseInt($td.text())
                        
                        $td.text(num - 1)
                    })
                    
                    $lockTrs && $lockTrs.eq(index).trigger('bjui.datagrid.tr.delete', [index])
                }
                $tr.remove() // remove dom
            })
        
        //contextmenu
        if (options.contextMenuB) {
            $trs.each(function() {
                that.tools.contextmenuB($(this))
            })
        }
        
        // checkbox
        $trs.each(function() {
            var $tr = $(this)
            
            $tr.find('> td.'+ that.classnames.td_checkbox).find('input').on('ifClicked', function() {
                $tr.trigger('click.bjui.datagrid.tr', [$(this)])
            })
        })
        
        // checkall || deselect all
        if (that.checkboxColumn && that.checkboxColumn.th) {
            that.checkboxColumn.th.find('input').on('ifChanged', function() {
                var checked = $(this).is(':checked'), $trs = that.$tbody.find('> tr')
                
                that.selectedRows($trs, checked)
            })
        }
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
                
                if (n.calc == 'avg')
                    $th.html(calc_html.replace('#tit#', (n.calcTit || 'AVG')).replace('#number#', (n.calc_sum / n.calc_count).toFixed(n.calcDecimal || 2)))
                else if (n.calc == 'count')
                    $th.html(calc_html.replace('#tit#', (n.calcTit || 'COUNT')).replace('#number#', (n.calc_count)))
                else if (n.calc == 'sum')
                    $th.html(calc_html.replace('#tit#', (n.calcTit || 'SUM')).replace('#number#', (n.calc_sum)))
                else if (n.calc == 'max')
                    $th.html(calc_html.replace('#tit#', (n.calcTit || 'MAX')).replace('#number#', (n.calc_max)))
                else if (n.calc == 'min')
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
        var that = this, $lockTrs = that.$lockTbody && that.$lockTbody.find('> tr'), $trs = that.$tbody.find('> tr'), n
        var selectedTr = function(n) {
            if (typeof selected == 'undefined') selected = true
            
            $trs.eq(n)
                .toggleClass(that.classnames.tr_selected, selected)
                .find('> td.'+ that.classnames.td_checkbox +' input').iCheck(selected ? 'check' : 'uncheck')
            
            $lockTrs && $lockTrs.eq(n)
                .toggleClass(that.classnames.tr_selected, selected)
                .find('> td.'+ that.classnames.td_checkbox +' input').iCheck(selected ? 'check' : 'uncheck')
        }
        
        if (rows == null) {
            $trs.removeClass(that.classnames.tr_selected)
                .find('> td.'+ that.classnames.td_checkbox +' input').iCheck('uncheck')
                
            $lockTrs && $lockTrs.removeClass(that.classnames.tr_selected)
                .find('> td.'+ that.classnames.td_checkbox +' input').iCheck('uncheck')
        } else if (typeof rows == 'object') {
            rows.each(function() {
                var $row = $(this), index = $row.index()
                
                if (typeof selected != 'undefined') {
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
                selectedTr(parseInt(n.trim()))
            })
        } else if (!isNaN(rows)) {
            selectedTr(parseInt(rows))
        }
        
        if (that.$lastSelect && !that.$lastSelect.hasClass(that.classnames.tr_selected)) {
            that.$lastSelect = null
        }
        
        // selectedTrs
        that.$element.data('selectedTrs', that.$tbody.find('> tr.'+ that.classnames.tr_selected))
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
        
        if ($.type(column) == 'number') {
            index = parseInt(column)
            if (index < 0 || index > that.columnModel.length - 1) return
            columnModel = that.columnModel[index]
            $th         = columnModel.th
        } else {
            $th         = column
            index       = $th.data('index')
            columnModel = that.columnModel[index]
        }
        
        if (columnModel == that.editBtnsColumn) return // edit btn column
        else if (columnModel.index == that.columnModel.length - 1) return // last column
        if (typeof columnModel.locked == 'undefined') columnModel.locked = false
        if (columnModel.locked == lockFlag) return
        
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
            // filterThead
            if ($filterThs && $filterThs.length) {
                that.$lockThead && that.$lockThead.find('> tr.datagrid-filter > th:visible').each(function() {
                    var $lockTh = $(this), index = $lockTh.index(), $th = $filterThs.eq(index)
                    
                    $lockTh.clone().insertAfter($lockTh)
                    $lockTh.hide().insertAfter($th)
                    $th.remove()
                })
            }
            
            // inline edit
            if ($lockTrs && $lockTrs.length) {
                $lockTrs.filter('.'+ that.classnames.tr_edit).each(function() {
                    var $lockTr = $(this), $lockTd = $lockTr.find('> td:eq('+ columnModel.lockIndex +')'), tr_index = $lockTr.index(), $tr, $td
                    
                    if ($lockTd.hasClass(that.classnames.td_edit)) {
                        $tr = that.$tbody.find('> tr:eq('+ tr_index +')'), $td = $tr.find('> td:eq('+ index +')')
                        $lockTd.clone().insertAfter($lockTd)
                        $lockTd.hide().insertAfter($td)
                        $td.remove()
                    }
                })
            }
        } else { //in
            // filterThead
            if ($filterThs && $filterThs.length) {
                that.$lockThead.find('> tr.datagrid-filter > th:visible').each(function() {
                    var $lockTh = $(this), index = $lockTh.index(), $th = $filterThs.eq(index)
                    
                    $th.clone().html('').insertAfter($th)
                    $th.show().insertAfter($lockTh)
                    $lockTh.remove()
                })
            }
            
            // inline edit
            if ($lockTrs && $lockTrs.length) {
                $lockTrs.filter('.'+ that.classnames.tr_edit).each(function() {
                    var $lockTr = $(this), tr_index = $lockTr.index()
                    
                    $lockTr.find('> td.'+ that.classnames.td_edit +':visible').each(function() {
                        var $lockTd = $(this), td_index = $lockTd.index(), model = columnModel[td_index], $tr, $td
                        
                        if (model.locked) {
                            $tr = that.$tbody.find('> tr:eq('+ tr_index +')')
                            $td = $tr.find('> td:eq('+ td_index +')')
                            $td.clone().insertAfter($td)
                            $td.show().insertAfter($lockTd)
                            $lockTd.remove()
                        }
                    })
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
        
        if (that.col_lock_count == 0) that.$lockBox.hide()
        else that.$lockBox.show()
        
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
            .on('click.bjui.datagrid.tr', function() {
                var index = $(this).index()
                
                that.$tbody.find('> tr:eq('+ index +')').trigger('click.bjui.datagrid.tr')
            })
            .on('bjui.datagrid.tr.delete', function(e, index) {
                var $tr = $(this)
                
                if (that.linenumberColumn && that.linenumberColumn.locked) {
                    $tr.nextAll().each(function() {
                        var $td = $(this).find('> td:eq(0)'), num = parseInt($td.text())
                        
                        $td.text(num - 1)
                    })
                }
                
                $tr.remove()
            })
            
            .find('> td.'+ that.classnames.td_checkbox +' input')
                .on('ifChanged', function() {
                    var $this = $(this), $tr = $this.closest('tr'), index = $tr.index()
                    
                    if ($this.is(':checked')) {
                        $tr.addClass(that.classnames.tr_selected)
                        $trs.eq(index).addClass(that.classnames.tr_selected)
                    } else {
                        $tr.removeClass(that.classnames.tr_selected)
                        $trs.eq(index).removeClass(that.classnames.tr_selected)
                    }
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
            
            if (type == 'date') {
                $input
                    .on('afterchange.bjui.datepicker', function(e, data) {
                        doFilter(model, $input.val())
                    })
                    .change(function() {
                        doFilter(model, $input.val())
                    })
            } else if (type == 'lookup'){
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
            var $input = $(that.inputs[i]), $th = $('<th></th>')
            
            if (n.type == 'spinner') $input = $('<input type="text" name="'+ n.name +'">')
            else if (n.type == 'boolean') $input = $(BJUI.doRegional('<select name="'+ n.name +'" data-toggle="selectpicker"><option value="">#all#</option><option value="true">#true#</option><option value="false">#false#</option></select>', regional))
            else if (n.type == 'select') {
                if ($input.find('> option:first-child').val()) {
                    $input = $('<select name="'+ n.name +'" data-toggle="selectpicker"></select>')
                        .append(BJUI.doRegional('<option value="">#all#</option>', regional))
                        .append($input.html())
                }
            }
            
            $th.append($input)
            
            if (n.hidden) $th.hide()
            if (n.type == 'boolean') $th.attr('align', 'center')
            $th.appendTo($tr)
            
            $input.data('clearFilter', false)
            
            onFilter($input, n, $th)
            
            // events - clear filter
            $input.on('bjui.datagrid.thead.clearfilter', function() {
                $input.val('')
                if (n.type == 'boolean' || n.type == 'select') $input.selectpicker('refresh')
            })
            
            n.quickfilter = $input
        })
        
        $tr.appendTo(that.$thead).initui()
    }
    
    //api - showhide linenumber column
    Datagrid.prototype.showLinenumber = function(flag) {
        var that = this, options = that.options, model = that.columnModel, numberModel = model[0], data = that.data
        
        if (numberModel == that.linenumberColumn) {
            if (typeof flag === 'string' && (flag == 'lock' || flag == 'unlock')) {
                that.colLock(numberModel.th, flag == 'lock' ? true : false)
            } else {
                that.showhideColumn(numberModel.th, flag ? true : false)
            }
        } else if (flag) {
            var $trsH = that.$thead.find('> tr'), col = '<col style="width:30px;">', $th, $filterTr = $trsH.filter('.datagrid-filter'), rowspan = $trsH.length - $filterTr.length
            
            numberModel = that.linenumberColumn
            model.unshift(numberModel)
            that.$colgroupH.prepend(col)
            that.$colgroupB.prepend(col)
            that.$colgroupF && that.$colgroupF.prepend(col)
            $th = $('<th align="center" rowspan="'+ rowspan +'" class="'+ that.classnames.td_linenumber +'">'+ that.linenumberColumn.label +'</th>')
            $trsH.first().prepend($th)
            $filterTr.length && $filterTr.prepend('<th></th>')
            numberModel.th    = $th
            numberModel.index = 0
            numberModel.width = 30
            
            that.$tbody.find('> tr').each(function(i) {
                $(this).prepend('<td align="center" class="'+ that.classnames.td_linenumber +'">'+ (i + 1) +'</td>')
            })
            
            that.$tableF && that.$tableF.find('> thead > tr').prepend('<th></th>')
            
            $.each(model, function(i, n) {
                n.index = i
                if (n.th) n.th.data('index', i)
            })
            
            if (flag == 'lock') {
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
        var that = this, options = that.options, model = that.columnModel, numberModel = model[0], checkModel, data = that.data
        
        if (model[0] == that.checkboxColumn) checkModel = model[0]
        if (model[1] == that.checkboxColumn) checkModel = model[1]
        
        if (checkModel) {
            if (typeof flag === 'string' && (flag == 'lock' || flag == 'unlock')) {
                that.colLock(checkModel.th, flag == 'lock' ? true : false)
            } else {
                that.showhideColumn(checkModel.th, flag)
            }
        } else if (flag) {
            var $trsH = that.$thead.find('> tr'), col = '<col style="width:26px;">', $th, $td, $filterTr = $trsH.filter('.datagrid-filter'), rowspan = $trsH.length - $filterTr.length
            
            checkModel = that.checkboxColumn
            
            $th = $('<th align="center" rowspan="'+ rowspan +'" class="'+ that.classnames.td_checkbox +'"><div><input type="checkbox" data-toggle="icheck"></div></th>')
            
            if (numberModel == that.linenumberColumn) {
                model.splice(1, 0, checkModel)
                data && data.splice(1, 0, {name:checkModel.name})
                checkModel.index = 1
                
                that.$colgroupH.find('> col:first').after(col)
                that.$colgroupB.find('> col:first').after(col)
                that.$colgroupF && that.$colgroupF.find('> col:first').after(col)
                $filterTr.length && $filterTr.find('> th:first').after('<th></th>')
                $trsH.first().find('> th:first').after($th)
                that.$tableF && that.$tableF.find('> thead > tr > th:first').after('<th></th>')
            } else {
                model.unshift(checkModel)
                data && data.unshift({name:checkModel.name})
                checkModel.index = 0
                
                that.$colgroupH.prepend(col)
                that.$colgroupB.prepend(col)
                that.$colgroupF && that.$colgroupF.prepend(col)
                $filterTr.length && $filterTr.prepend('<th></th>')
                $trsH.first().prepend($th)
                that.$tableF && that.$tableF.find('> thead > tr').prepend('<th></th>')
            }
            
            $th.initui()
            checkModel.th    = $th
            checkModel.width = 26
            
            that.$tbody.find('> tr').each(function(i) {
                $td = $('<td align="center" class="'+ that.classnames.td_checkbox +'"><input type="checkbox" data-toggle="icheck" name="datagrid.checkbox"></td>')
                
                if (checkModel.index == 0) $(this).prepend($td)
                else $(this).find('> td:first').after($td)
                $td.initui()
            })
            
            $.each(model, function(i, n) {
                n.index = i
                if (n.th) n.th.data('index', i)
            })
            
            if (flag == 'lock') {
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
        
        if (editModel == that.editBtnsColumn) {
            that.showhideColumn(editModel.th, flag ? true : false)
        } else if (flag) {
            var $trsH = that.$thead.find('> tr'), col = '<col style="width:110px;">', $th, $td, $filterTr = $trsH.filter('.datagrid-filter'), rowspan = $trsH.length - $filterTr.length
            
            editModel = that.editBtnsColumn
            model.push(editModel)
            
            that.$colgroupH.append(col)
            that.$colgroupB.append(col)
            that.$colgroupF && that.$colgroupF.append(col)
            $th = $('<th align="center" rowspan="'+ rowspan +'">Edit</th>')
            $trsH.first().append($th)
            $filterTr.length && $filterTr.append('<th></th>')
            $th.initui().data('index', model.length - 1)
            editModel.th    = $th
            editModel.width = 110
            editModel.index = model.length - 1
            
            that.$tbody.find('> tr').each(function(i) {
                $td = $('<td align="center" class="'+ that.classnames.s_edit +'">'+ BJUI.doRegional(FRAG.gridEditBtn, that.regional) +'</td>')
                $(this).append($td)
                $td.initui()
                
                
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
                var ofLeft = that.$boxH.scrollLeft(), marginLeft = parseInt(that.$boxH.css('marginLeft') || 0), left = tools.getRight($th) - ofLeft + marginLeft, index = $th.data('index'), model = columnModel[index], width = model.th.width(),
                    $trs = that.$tbody.find('> tr'), $lockTrs = that.$lockTbody && that.$lockTbody.find('> tr'), lockH = that.$lockTableB && that.$lockTableB.height(), H = that.$tableB.height(), lockH_new, H_new
                
                that.isResize = true
                
                if (model.locked) {
                    left = tools.getRight4Lock(model.lockIndex)
                    if (model.lockWidth) width = model.lockWidth
                }
                
                $resizeMark
                    .show()
                    .css({
                        left   : left,
                        bottom : (that.$box_paging ? that.$box_paging.outerHeight() : 0),
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
                $btn    = $('<button class="btn btn-default"><i class="fa fa-bars"></button>'),
                $btnBox = $('<div class="'+ that.classnames.btn_menu +'"></div>').append($btn)
                
                $btnBox.appendTo($cell)
                
                $btn.click(function() {
                    var $tr = $th.closest('tr'), rowspan = parseInt($th.attr('rowspan') || 1), left = $(this).offset().left - that.$grid.offset().left - 1, top = (that.$trsH.length - rowspan) * 25 + (13 * rowspan) + 11, $showhide = $menu.find('> ul > li.datagrid-li-showhide'), menu_width, submenu_width 
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
                    that.colFilter($th, true)
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
        
        if ($.type(column) == 'number') {
            index = parseInt(column)
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
        var that = this, options = that.options, tools = that.tools, regional = that.regional, $filter = $th.data('bjui.datagrid.filter'), $menu = that.$menu, $filterli = $menu.find('> ul > li.'+ that.classnames.li_filter)
        
        if (!that.inputs || !that.inputs.length) tools.initEditInputs()
        if (filterFlag) {
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
                
                if (type == 'string' || type == 'lookup') {
                    if (!operator.length) operator = ['=', '!=', 'like']
                } else if (type == 'number' || type == 'int' || type == 'spinner') {
                    if (type == 'spinner') $input.removeAttr('data-toggle')
                    if (!operator.length) operator = ['=', '!=', '>', '<', '>=', '<=']
                } else if (type == 'date') {
                    if (!operator.length) operator = ['=', '!=']
                } else if (type == 'boolean') {
                    if (!operator.length) operator = ['=', '!=']
                    $input = $(BJUI.doRegional('<select name="'+ model.name +'" data-toggle="selectpicker"><option value="">#all#</option><option value="true">#true#</option><option value="false">#false#</option></select>', regional))
                } else if (type == 'select') {
                    if (!operator.length) operator = ['=', '!=']
                    $input.attr('data-width', '80')
                    if ($input.find('> option:first-child').val()) {
                        $input = $('<select name="'+ model.name +'" data-toggle="selectpicker" data-width="80"></select>')
                            .append(BJUI.doRegional('<option value="">#all#</option>', regional))
                            .append($input.html())
                    }
                }
                
                for (var i = 0; i < operator.length; i++) {
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
        var that = this, tools = that.tools, options = that.options, paging = that.paging, pr = BJUI.regional.pagination, btnpaging = FRAG.gridPaging, pageNums = [], pageCount = paging.pageCount, interval, selectPages = []
        
        if (paging.total == 0) return
        interval    = tools.getPageInterval(pageCount, paging.pageCurrent, paging.showPagenum)
        
        for (var i = interval.start; i < interval.end; i++) {
            pageNums.push(FRAG.gridPageNum.replace('#num#', i).replace('#active#', (paging.pageCurrent == i ? ' active' : '')))
        }
        
        btnpaging = BJUI.doRegional(btnpaging.replaceAll('#pageCurrent#', paging.pageCurrent).replaceAll('#count#', paging.total +'/'+ parseInt(pageCount || 0)), pr)
        
        that.$box_paging = $('<div class="datagrid-paging-box"></div>')
        that.$pagingCon  = $('<div class="paging-content"></div>').width(that.$boxB.width())
        that.$refreshBtn = $('<button class="btn-default btn-refresh" title="'+ pr.refresh +'" data-icon="refresh"></button>')
        that.$paging     = $('<div class="datagrid-paging"></div>')
        that.$btnpaging  = $(btnpaging)
        that.$pagenum    = $(pageNums.join(''))
        that.$pagesize   = $('<div class="datagrid-pagesize"><span></span></div>')
        that.$selectpage = $('<select data-toggle="selectpicker"></select>')
        
        that.$pagingCon.appendTo(that.$box_paging)
        that.$box_paging.appendTo(that.$grid)
        that.$pagesize.appendTo(that.$pagingCon)
        that.$refreshBtn.appendTo(that.$pagesize)
        that.$selectpage.appendTo(that.$pagesize)
        that.$paging.appendTo(that.$pagingCon)
        that.$btnpaging.appendTo(that.$paging)
        that.$pagenum.insertAfter(that.$btnpaging.find('> li.page-prev'))
        
        that.$box_paging.initui()
        
        //events
        var $jumpto = that.$btnpaging.find('> li.page-jumpto'),
            $first  = $jumpto.next(),
            $prev   = $first.next(),
            $next   = that.$btnpaging.find('> li.page-next'),
            $last   = $next.next()
        
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
            that.$selectpage.empty()
            
            if (!pageSize) pageSize = that.paging.pageSize
            
            selectPages = paging.selectPageSize.split(',')
            selectPages.push(String(pageSize))
            $.unique(selectPages).sort(function(a, b) { return a - b })
            $.each(selectPages, function(i, n) {
                var $option = $('<option value="'+ n +'">'+ n +'/'+ pr.page +'</option>')
                
                if (n == paging.pageSize) $option.prop('selected', true)
                
                that.$selectpage.append($option)
            })
            
            that.$selectpage.selectpicker('refresh')
        }
        
        if (paging.pageCurrent == 1) pageFirst()
        if (paging.pageCurrent == paging.pageCount) {
            pageLast()
            if (paging.pageCurrent == 1) disablePrev()
        }
        setPageSize()
        
        that.$paging.on('click', '.page-num', function(e) {
            var $num = $(this)
            
            if (!$num.hasClass('active')) {
                that.jumpPage($num.text())
            }
            
            e.preventDefault()
        }).on('bjui.datagrid.paging.jump', function(e) {
            var pageCurrent = that.paging.pageCurrent, interval = tools.getPageInterval(that.paging.pageCount, pageCurrent, paging.showPagenum), pageNums = []
            
            for (var i = interval.start; i < interval.end; i++) {
                pageNums.push(FRAG.gridPageNum.replace('#num#', i).replace('#active#', (pageCurrent == i ? ' active' : '')))
            }
            
            that.$pagenum.empty()
            that.$pagenum = $(pageNums.join(''))
            that.$pagenum.insertAfter($prev)
            
            if (pageCurrent == 1) {
                pageFirst()
                if (pageCurrent == that.paging.pageCount) disableNext()
            } else if (pageCurrent == that.paging.pageCount) {
                pageLast()
            } else {
                enablePrev()
                enableNext()
            }
            
            $jumpto.find('input').val(pageCurrent)
            that.$btnpaging.find('> li.page-total > span').html(that.paging.total +'/'+ that.paging.pageCount)
        })
        
        that.$selectpage.on('bjui.datagrid.paging.pageSize', function(e, pageSize) {
            setPageSize(pageSize)
        })
        
        $jumpto.find('input').on('keyup', function(e) {
            if (e.which == BJUI.keyCode.ENTER) {
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
        
        that.$refreshBtn.on('click', function() {
            that.refresh()
        })
        
        that.$selectpage.on('change', function() {
            var pageSize = $(this).val()
            
            that.jumpPage(null, pageSize)
        })
    }
    
    Datagrid.prototype.jumpPage = function(pageCurrent, pageSize) {
        var that = this, paging = that.paging, pageCount = paging.pageCount
        
        if (pageCurrent && isNaN(pageCurrent)) return
        if (pageSize && isNaN(pageSize))       return
        
        if (pageCurrent) {
            pageCurrent = parseInt(pageCurrent)
            
            if (pageCurrent < 1)         pageCurrent = 1
            if (pageCurrent > pageCount) pageCurrent = pageCount
            if (pageCurrent == paging.pageCurrent) return
        }
        if (pageSize) {
            pageSize = parseInt(pageSize)
            if (pageSize > paging.total) return
        }
        
        that.tools.jumpPage(pageCurrent, pageSize)
    }
    
    // api - add
    Datagrid.prototype.add = function(addLocation) {
        if (!this.tools.beforeEdit()) return
        
        if (!this.options.editUrl) {
            BJUI.debug('Datagrid Plugin: Edit url is not set!')
            return
        }
        
        if (!this.options.editMode) return
        if (!this.options.inlineEditMult) {
            this.doCancelEditRow(this.$tbody.find('> tr.'+ this.classnames.tr_edit))
        }
        
        var that = this, options = that.options, tools = that.tools, paging = that.paging, trs, obj = {}, data = [], addObj, startNumber = (paging.pageCurrent - 1) * paging.pageSize, linenumber
        
        var addTr = function(linenumber) {
            var $tr = $('<tr></tr>').addClass(that.classnames.tr_add), $lockTr = $tr.clone()
            
            $.each(that.columnModel, function(i, n) {
                var label = '', $td = $('<td></td>')
                
                if (n.gridNumber)
                    $td.addClass(that.classnames.td_linenumber).text(0)
                else if (n.gridCheckbox)
                    $td.addClass(that.classnames.td_checkbox).html('<div><input type="checkbox" data-toggle="icheck" name="datagrid.checkbox" value="true"></div>')
                else if (n.gridEdit)
                    $td.addClass(that.classnames.s_edit).data('isAdd', true).html(BJUI.doRegional(FRAG.gridEditBtn, that.regional))
                else $td.text('')
                
                if (n.hidden) $td.css('display', 'none')
                if (n.align)  $td.attr('align', n.align)
                
                obj[n.name] = ''
                
                if (n.locked) {
                    $td.clone().show().appendTo($lockTr)
                    $td.hide().appendTo($tr)
                } else {
                    $td.appendTo($tr)
                }
            })
            
            obj = $.extend({}, that.attach, obj)
            if (!that.emptyData) that.emptyData = obj
            
            return {tr:$tr, lockTr:$lockTr.find('> td').length ? $lockTr : null}
        }
        
        if (!addLocation) addLocation = options.addLocation || 'first'
        
        if (!that.$lastSelect) {
            if (addLocation == 'prev') addLocation = 'first'
            else if (addLocation == 'next') addLocation = 'last'
        }
        
        if (addLocation == 'first') {
            linenumber = 0
            trs = addTr(linenumber)
            trs.tr.prependTo(that.$tbody)
            if (trs.lockTr) trs.lockTr.prependTo(that.$lockTbody)
        } else if (addLocation == 'last') {
            linenumber = that.data ? that.data.length : 0
            trs = addTr(linenumber)
            trs.tr.appendTo(that.$tbody)
            if (trs.lockTr) trs.lockTr.appendTo(that.$lockTbody)
        } else if (addLocation == 'prev') {
            linenumber = that.$lastSelect.index()
            trs = addTr(linenumber)
            trs.tr.insertBefore(that.$lastSelect)
            if (trs.lockTr) trs.lockTr.insertBefore(that.$lockTbody.find('> tr:eq('+ that.$lastSelect.index() +')'))
        } else if (addLocation == 'next') {
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
        
        setTimeout(function() {
            that.initEvents(trs.tr)
        }, 20)
        
        if (trs.lockTr) that.initLockEvents(trs.lockTr)
        that.edit(trs.tr)
        
        if (options.editMode != 'dialog') {
            that.doEditRow(trs.tr, 'inline', true)
        } else {
            that.dialogEdit(trs.tr, true)
        }
    }
    
    // edit
    Datagrid.prototype.edit = function($trs) {
        var that = this, options = that.options, tools = that.tools, type = options.editMode, columnModel = that.columnModel, $editTd
        
        if (type != 'dialog') type = 'inline'
        if (!$trs) $trs = that.$tbody.find('> tr')
        
        $editTd = $trs.find('> td.'+ that.classnames.s_edit)
        
        /* events */
        $editTd.each(function() {
            var $td = $(this), $btns = $td.find('button'), $edit = $btns.first(), $update = $edit.next(), $save = $update.next(), $cancel = $save.next(), $delete = $cancel.next()
            
            $edit.on('click', function(e, data) {
                var $btn = $(this), $tr = $btn.closest('tr'), isAdd = $td.data('isAdd')
                
                if (!data) {
                    if (that.isDom) data = $tr.data('initData') || tools.setDomData($tr)
                    else data = that.data[$tr.index()]
                }
                
                if (!tools.beforeEdit($tr, data)) {
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
    
    // Api - inline edit tr
    Datagrid.prototype.doEditRow = function(rows, type, isAdd) {
        var that = this, $trs, $editBtn, datas = []
        
        type = type || that.options.editMode
        
        if (typeof rows == 'object') {
            $trs = rows
        } else if (isNaN(rows)) {
            var $myTrs = that.$tbody.find('> tr'), $editTrs, rows = rows.split(',')
            
            rows = rows.unique()
            rows.sort(function(a, b) {return a.trim() - b.trim()})
            
            $.each(rows, function(i, n) {
                var tr = $myTrs.eq(parseInt(n.trim()))
                
                if (tr && tr.length) {
                    if (!$editTrs) $editTrs = tr
                    else $editTrs = $editTrs.add(tr)
                }
            })
            
            $trs = $editTrs
        } else if (!isNaN(rows)) {
            $trs = that.$tbody.find('> tr').eq(rows)
        }
        
        if (!$trs.length) return
        
        $trs.each(function() {
            var $tr = $(this), tr_index = $tr.index(), data
            
            if (that.isDom) data = $tr.data('initData') || tools.setDomData($tr)
            else data = that.data[tr_index]
            
            datas.push(data)
        })
        
        if (!that.tools.beforeEdit($trs, datas)) {
            return
        }
        
        if (!that.options.editUrl) {
            BJUI.debug('Datagrid Plugin: Edit url is not set!')
            return
        }
        
        $trs.each(function(i) {
            var $tr = $(this)
            
            $editBtn = $tr.find('> td.'+ that.classnames.s_edit +' > button.edit')
            
            if (type != 'dialog') {
                if ($editBtn.length) $editBtn.trigger('click', [datas[i]])
                else that.inlineEdit($tr, isAdd, datas[i])
            } else {
                that.dialogEdit($tr, isAdd, datas[i])
            }
        })
    }
    
    // Api - cancel edit
    Datagrid.prototype.doCancelEditRow = function(row) {
        var that = this, $trs
        
        if ($.type(row) == 'number') {
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
        
        if ($.type(row) == 'number') {
            $tr = this.$tbody.find('> tr').eq(row)
        } else if (row) {
            $tr = row
        } else {
            $tr = that.$tbody.find('> tr.'+ that.classnames.tr_edit)
        }
        
        if (!$tr.length) {
            that.$grid.alertmsg('info', BJUI.getRegional('datagrid.saveMsg'))
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
            if (typeof beforeDelete == 'string') beforeDelete = beforeDelete.toFunc()
            if (typeof beforeDelete == 'function') {
                if (!beforeDelete.call(this)) {
                    return
                }
            }
        }
        
        if (typeof rows == 'object') {
            $trs = rows
        } else if (isNaN(rows)) {
            var $myTrs = that.$tbody.find('> tr'), $delTrs, rows = rows.split(',')
            
            rows = rows.unique()
            rows.sort(function(a, b) {return a.trim() - b.trim()})
            
            $.each(rows, function(i, n) {
                var tr = $myTrs.eq(parseInt(n.trim()))
                
                if (tr && tr.length) {
                    if (!$delTrs) $delTrs = tr
                    else $delTrs = $delTrs.add(tr)
                }
            })
            
            $trs = $delTrs
        } else if (!isNaN(rows)) {
            $trs = this.$tbody.find('> tr').eq(rows)
        }
        
        if (!$trs || !$trs.length) return
        
        var delEnd = function() {
            $trs.each(function() {
                $(this).trigger('bjui.datagrid.tr.delete')
            })
            
            that.tools.afterDelete()
        }
        
        var doDel = function() {
            var $addTrs = $trs.filter('.'+ that.classnames.tr_add)
            
            if ($addTrs.length) {
                $addTrs.remove()
                if ($addTrs.length == $trs.length) return
            }
            
            // remote delete
            if (options.delUrl) {
                var postData = [], callback = options.delCallback
                
                $trs.each(function() {
                    var $tr = $(this), index = $tr.index(), data, delData
                    
                    if (that.isDom) data = $tr.data('initData') || tools.setDomData($tr)
                    else data = that.data[index]
                    
                    if (options.delPK) {
                        postData.push(data[options.delPK])
                    } else {
                        if (options.jsonPrefix) {
                            delData = {}
                            $.each(data, function(name, value) {
                                if (name == 'gridCheckbox' || name == 'gridEdit') return true
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
                
                if (typeof callback == 'string') callback = callback.toFunc() 
                that.$grid.bjuiajax('doAjax', {
                    url      : options.delUrl,
                    data     : options.delPK ? [{ name:options.delPK, value:postData.join(',') }] : {json : JSON.stringify(postData)},
                    type     : options.delType,
                    callback : callback || function(json) {
                        if (json[BJUI.keys.statusCode] == BJUI.statusCode.ok) {
                            delEnd()
                        } else {
                            that.$grid.bjuiajax('ajaxDone', json)
                        }
                    }
                })
            } else { // local delete
                delEnd()
            }
        }
        
        if (confirmMsg) {
            if (typeof confirmMsg != 'string') confirmMsg = $trs.length == 1 ? BJUI.getRegional('datagrid.delMsg') : BJUI.getRegional('datagrid.delMsgM')
            
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
        
        var that = this, options = that.options, tools = that.tools, columnModel = that.columnModel, $tds = $tr.find('> td'), tds_length = $tds.length, tr_index = $tr.index()
        
        if (!data) {
            if (that.isDom) data = $tr.data('initData') || tools.setDomData($tr)
            else data = that.data[tr_index]
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
                var changeData = $tr.data(that.datanames.changeData)
                
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
                        $td.addClass(that.classnames.td_changed)
                        if ($el.val() == String(val)) $td.removeClass(that.classnames.td_changed)
                        changeData[op.name] = $el.val()
                    })
                    
                    break
                case 'boolean':
                    $el.on('ifChanged', function() {
                        $td.toggleClass(that.classnames.td_changed)
                        var checked = $(this).is(':checked') ? true : false
                                
                        if (checked == val) $td.removeClass(that.classnames.td_changed)
                        changeData[op.name] = checked
                    })
                    
                    break
                case 'lookup':
                    $td.on('customEvent.bjui.lookup', '[data-toggle="lookupbtn"]', function(e, args) {
                        $td.toggleClass(that.classnames.td_changed)
                        for (var key in args) {
                            if (typeof data[key] != 'undefined') {
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
                            changeData[op.name] = $el.val()
                        })
                        .change(function() {
                            $td.addClass(that.classnames.td_changed)
                            if ($el.val() == val) $td.removeClass(that.classnames.td_changed)
                            changeData[op.name] = $el.val()
                        })
                    
                    
                    break
                default:
                    $el.change(function() {
                        $td.addClass(that.classnames.td_changed)
                        if ($el.val() == val) $td.removeClass(that.classnames.td_changed)
                        changeData[op.name] = $el.val()
                    })
                    break
                }
            }
            
            $td.data(that.datanames.td_html, html)
            
            if (isAdd) {
                if (!op.add) input = ''
            } else {
                if (!op.edit) input = ''
            }
            
            if (input) {
                $input = $(input)
                
                if (op.type == 'boolean') $input.prop('checked', val)
                else {
                    if (!val || val == 'null') val = ''
                    $input.val(String(val))
                }
                
                if (isAdd) {
                    if (op.addAttrs && typeof op.addAttrs == 'object') {
                        $.each(op.addAttrs, function(i, n) {
                            $input.attr(i, n)
                        })
                    }
                } else {
                    if (op.editAttrs && typeof op.editAttrs == 'object') {
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
        var that = this, options = that.options, callback = options.editCallback, $tr, data, changeData, tempData, postData = [], len = $trs && $trs.length
        
        if (!$trs || $trs.length) {
            $trs = that.$tbody.find('> tr.'+ that.classnames.tr_edit)
            len  = $trs.length
        }
        $trs.each(function() {
            $tr = $(this), data = that.isDom ? $tr.data('initData') : that.data[$tr.index()]
            
            $tr.isValid(function(v) {
                if (v) {
                    // Update data
                    changeData = $tr.data(that.datanames.changeData)
                    $.extend(data, changeData)
                    // Specification post data
                    if (options.jsonPrefix) {
                        tempData = {}
                        $.each(data, function(name, value) {
                            if (name == 'gridCheckbox' || name == 'gridEdit') return true
                            tempData[options.jsonPrefix +'.'+ name] = value
                        })
                    } else {
                        tempData = $.extend({}, data)
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
                    var complete = false, returnData = []
                    
                    if ($.type(json) == 'array') {
                        complete   = true
                        returnData = json
                    } else if ($.type(json) == 'object') {
                        if (json[BJUI.keys.statusCode]) {
                            if (json[BJUI.keys.statusCode] == BJUI.statusCode.ok) {
                                complete = true
                            } else {
                                that.$grid.bjuiajax('ajaxDone', json)
                            }
                        } else {
                            complete = true
                            returnData.push(json)
                        }
                    }
                    
                    if (complete) {
                        $trs.each(function(i) {
                            var $tr = $(this), data = that.isDom ? $tr.data('initData') : that.data[$tr.index()]
                            
                            $.extend(data, typeof returnData[i] == 'object' && returnData[i])
                            
                            that.inlineEditComplete($tr, data)
                        })
                        
                        that.tools.afterSave($trs, postData)
                    }
                }
            }
            // Do ajax
            that.$grid.bjuiajax('doAjax', {url:options.editUrl, data:{json:JSON.stringify(postData)}, type:'POST', callback:callback})
        }
    }
    
    // update - inline edit
    Datagrid.prototype.updateEdit = function($tr, $btn) {
        var that = this, options = that.options, callback = options.editCallback, data, changeData, tempData, postData = []
        
        if (that.isDom) data = $tr.data('initData')
        else data = that.data[$tr.index()]
        
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
                            if (name == 'gridCheckbox' || name == 'gridEdit') return true
                            tempData[options.jsonPrefix +'.'+ name] = value
                        })
                    } else {
                        tempData = $.extend({}, data)
                        delete tempData.gridCheckbox
                        delete tempData.gridEdit
                    }
                    // Callback
                    if (callback) {
                        callback = callback.toFunc()
                    } else {
                        callback = function(json) {
                            var complete = false, returnData
                            
                            if ($.type(json) == 'array') {
                                complete   = true
                                returnData = json[0]
                            } else if ($.type(json) == 'object') {
                                if (json[BJUI.keys.statusCode]) {
                                    if (json[BJUI.keys.statusCode] == BJUI.statusCode.ok) {
                                        complete = true
                                    } else {
                                        that.$grid.bjuiajax('ajaxDone', json)
                                    }
                                } else {
                                    complete = true
                                    returnData = json
                                }
                            }
                            
                            if (complete) {
                                $.extend(data, typeof returnData == 'object' && returnData)
                                
                                that.inlineEditComplete($tr, data, $btn)
                                that.tools.afterSave($tr, data)
                            }
                        }
                    }
                    // Do ajax
                    $tr.bjuiajax('doAjax', {url:options.editUrl, data:{json:JSON.stringify(postData.push(tempData) && postData)}, type:'POST', callback:callback})
                }
            })
        }
    }
    
    /* cancel - inline edit */
    Datagrid.prototype.cancelEdit = function($trs) {
        var that = this, columnModel = that.columnModel
        
        $trs.each(function() {
            var $tr = $(this), tr_index = $tr.index()
            
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
                var isRemove = false, changeData = $tr.data(that.datanames.changeData)
                
                if ($.isEmptyObject(changeData)) {
                    isRemove = true
                } else {
                    for (var key in changeData) {
                        if (!changeData[key]) delete changeData[key]
                    }
                    
                    if ($.isEmptyObject(changeData))
                        isRemove = true
                }
                
                if (isRemove) {
                    var index = $tr.index()
                    
                    that.data = that.data.remove(index)
                    that.$lockTbody && that.$lockTbody.find('> tr:eq('+ index +')').remove()
                    $tr.remove()
                }
            }
        })
    }
    
    // inline editComplete
    Datagrid.prototype.inlineEditComplete = function($tr, trData, $btn) {
        var that = this, columnModel = that.columnModel, tr_index = $tr.index(), $tds = $tr.find('> td'), hasLinenumber = false, $trs = that.$tbody.find('> tr'), $addTrs = $trs.filter('.'+ that.classnames.tr_add)
        
        $.each(columnModel, function(i, n) {
            if (n.gridNumber) hasLinenumber = true
            if (!n.name) return
            if (n.gridNumber || n.gridCheckbox || n.gridEdit) return
            
            var label = trData[n.name], render_label, $td = $tds.eq(n.index)
            
            if (typeof label == 'undefined') label = ''
            
            $td.text(label).removeClass(that.classnames.td_edit).removeClass(that.classnames.td_changed)
            
            if (n.render && typeof n.render == 'function') {
                if (n.items) {
                    render_label = n.render.call(that, label, n.items)
                    $td.html(render_label)
                } else {
                    render_label = n.render.call(that, label)
                    $td.html(render_label)
                }
            } else if (n.items) {
                render_label = Datagrid.renderItem.call(that, label, n.items)
                $td.html(render_label)
            }
            
            if (n.locked) {
                var $lockTr = that.$lockTbody.find('> tr:eq('+ tr_index +')'),
                    $lockTd = $lockTr.find('> td:eq('+ n.lockIndex +')')
                
                $lockTd.removeClass(that.classnames.td_changed).html($td.html())
            }
        })
        
        $tr.removeClass(that.classnames.tr_edit)
        
        if (!$btn) $btn = $tds.filter('.'+ that.classnames.s_edit).find('button.update')
        if ($btn && $btn.length)
            $btn.trigger('bjui.datagrid.update.tr')
            
        if (hasLinenumber && $addTrs.length) {
            $addTrs.removeClass(that.classnames.tr_add)
            $trs.each(function(index) {
                $(this).find('> td.'+ that.classnames.td_linenumber).text(index + 1)
                that.$lockTbody && that.$lockTbody.find('> tr:eq('+ index +')').find('> td.'+ that.classnames.td_linenumber).text(index + 1)
            })
        }
    }
    
    // inline edit
    Datagrid.prototype.dialogEdit = function($tr, isAdd, data) {
        if (!this.tools.beforeEdit($tr, data)) {
            return false
        }
        
        var that = this, options = that.options, tools = that.tools, columnModel = that.columnModel, tr_index = $tr.index(), $dialog, $form, html = '', title
        
        if (!data) {
            if (that.isDom) data = $tr.data('initData') || tools.setDomData($tr)
            else data = that.data[tr_index]
        }
        
        if (!that.inputs || !that.inputs.length) tools.initEditInputs()
        
        title = options.gridTitle || 'datagrid'
        
        if (isAdd) {
            title += ' - '+ BJUI.getRegional('datagrid.add')
        } else {
            title += ' - '+ BJUI.getRegional('datagrid.edit')
        }
        
        $dialog = $('<div><div class="bjui-pageContent"></div><div class="bjui-pageFooter"></div></div>')
        $form   = $('<form class="datagrid-dialog-edit-form"></form>')
        
        var onChange = function($tr, $form, $el, model) {
            var changeData = $tr.data(that.datanames.changeData)
            
            switch (model.type) {
            case 'date':
                $el
                    .on('afterchange.bjui.datepicker', function(e, data) {
                        changeData[model.name] = $el.val()
                    })
                    .change(function() {
                        changeData[model.name] = $el.val()
                    })
                
                break
            case 'select':
                $el.change(function() {
                    changeData[model.name] = $el.val()
                })
                
                break
            case 'boolean':
                $el.on('ifChanged', function() {
                    var checked = $(this).is(':checked') ? true : false
                            
                    changeData[model.name] = checked
                })
                
                break
            case 'lookup':
                $form.on('customEvent.bjui.lookup', '[data-toggle="lookupbtn"]', function(e, args) {
                    for (var key in args) {
                        if (typeof data[key] != 'undefined') {
                            changeData[key] = args[key]
                        }
                        if (model.name == key) {
                            $el.val(args[key])
                        }
                    }
                })
                
                $el.change(function() {
                    changeData[model.name] = $el.val()
                })
                
                break
            case 'spinner':
                $el
                    .on('afterchange.bjui.spinner', function(e, data) {
                        changeData[model.name] = $el.val()
                    })
                    .change(function() {
                        changeData[model.name] = $el.val()
                    })
                
                
                break
            default:
                $el.change(function() {
                    changeData[model.name] = $el.val()
                })
                break
            }
        }
        
        var onLoad = function($dialog) {
            var $form   = $dialog.find('form.datagrid-dialog-edit-form'),
                $btns   = $dialog.find('div.bjui-pageFooter button'),
                $prev   = $btns.first(),
                $next   = $btns.eq(1),
                $cancel = $btns.eq(2),
                $save   = $btns.last()
            
            var createForm = function(data, $form, $tr) {
                $form.empty()
                if (!$tr.data(that.datanames.changeData)) $tr.data(that.datanames.changeData, {})
                
                if ($form.data('validator')) $form.validator('destroy')
                
                $.each(columnModel, function(i, n) {
                    if (n == that.linenumberColumn || n == that.checkboxColumn || n == that.editBtnsColumn) return true
                    
                    var $input = $(that.inputs[i]), $p = $('<p></p>'), id = 'datagrid-dialog-edit-column-'+ i
                    
                    if ($input.isTag('select')) $input.attr('data-width', 'auto')
                    else if (!$input.isTag('checkbox')) $input.attr('size', 30)
                    
                    if (n.type == 'boolean') {
                        $input.attr('checked', data[n.name])
                    } else if (n.type == 'textarea') {
                        $input.html(data[n.name])
                    } else {
                        $input.attr('value', data[n.name])
                    }
                    
                    $p
                        .append('<label class="control-label x120" for="'+ id +'">'+ n.label +'：</label>')
                        .append($('<span class="datagrid-dialog-column-span"></span>').append($input.attr('id', id)))
                        .appendTo($form)
                    
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
            if ($tr.index() == 0) $prev.addClass('disabled')
            if ($tr.index() == that.data.length - 1) $next.addClass('disabled')
            
            $prev.click(function() {
                var $tr_prev = $tr.prev(), data
                
                if ($tr_prev.length) {
                    if (that.isDom) {
                        data = $tr_prev.data('initData') || tools.setDomData($tr_prev)
                    } else {
                        data = that.data[$tr_prev.index()]
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
                var $tr_next = $tr.next(), data
                
                if ($tr_next.length) {
                    if (that.isDom) {
                        data = $tr_next.data('initData') || tools.setDomData($tr_next)
                    } else {
                        data = that.data[$tr_next.index()]
                    }
                    
                    $tr = $tr_next
                    createForm(data, $form, $tr)
                    $form.initui()
                    $prev.removeClass('disabled')
                    
                    if (!$tr_next.next().length) $next.addClass('disabled')
                } else {
                    $next.addClass('disabled')
                }
            })
            
            $save.click(function() {
                var changeData, data, postData, callback = options.editCallback
                
                if (that.isDom) data = $tr.data('initData')
                else data = that.data[$tr.index()]
                
                $form.isValid(function(v) {
                    if (v) {
                        changeData = $tr.data(that.datanames.changeData)
                        $.extend(data, changeData)
                        
                        if (options.jsonPrefix) {
                            postData = {}
                            $.each(data, function(name, value) {
                                if (name == 'gridCheckbox' || name == 'gridEdit') return true
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
                                var complete = false, returnData
                                
                                if ($.type(json) == 'array') {
                                    complete   = true
                                    returnData = json[0]
                                } else if ($.type(json) == 'object') {
                                    if (json[BJUI.keys.statusCode]) {
                                        if (json[BJUI.keys.statusCode] == BJUI.statusCode.ok) {
                                            complete = true
                                        } else {
                                            that.$grid.bjuiajax('ajaxDone', json)
                                        }
                                    } else {
                                        complete = true
                                        returnData = json
                                    }
                                }
                                
                                if (complete) {
                                    $.extend(data, typeof returnData == 'object' && returnData)
                                    
                                    that.dialogEditComplete($tr, data)
                                    that.$grid.dialog('close', 'datagrid-dialog-edit')
                                    that.tools.afterSave($tr, data)
                                }
                            }
                        }
                        // Do ajax
                        $tr.bjuiajax('doAjax', {url:options.editUrl, data:{json:JSON.stringify(postData)}, type:'POST', callback:callback})
                    }
                })
            })
            
            $cancel.click(function() {
                that.$grid.dialog('close', 'datagrid-dialog-edit')
            })
        }
        
        var onClose = function() {
            that.$tbody.find('> tr.'+ that.classnames.tr_add).each(function() {
                var isRemove = false, $tr = $(this), changeData = $tr.data(that.datanames.changeData)
                
                if ($.isEmptyObject(changeData)) {
                    isRemove = true
                } else {
                    for (var key in changeData) {
                        if (!changeData[key]) delete changeData[key]
                    }
                    
                    if ($.isEmptyObject(changeData))
                        isRemove = true
                }
                
                if (isRemove) {
                    var index = $tr.index()
                    
                    that.data = that.data.remove(index)
                    that.$lockTbody && that.$lockTbody.find('> tr:eq('+ index +')').remove()
                    $tr.remove()
                }
            })
        }
        
        $dialog.find('> div:first')
            .append($form)
            .next().append(BJUI.doRegional(FRAG.gridDialogEditBtns, that.regional))
        
        var dialog_options = $.extend({}, {id:'datagrid-dialog-edit', fresh:true, target:$dialog[0], width:520, height:400, mask:true, title:title, onLoad:onLoad, onClose:onClose}, (typeof options.editDialogOp == 'object' && options.editDialogOp))
        
        that.$grid.dialog(dialog_options)
    }
    
    // dialog editComplete
    Datagrid.prototype.dialogEditComplete = function($tr, trData) {
        var that = this, columnModel = that.columnModel, tr_index = $tr.index(), $tds = $tr.find('> td'), hasLinenumber = false, $trs = that.$tbody.find('> tr'), $addTrs = $trs.filter('.'+ that.classnames.tr_add)
        
        $.each(columnModel, function(i, n) {
            if (n.gridNumber) hasLinenumber = true
            if (!n.name) return
            if (n.gridNumber || n.gridCheckbox || n.gridEdit) return
            
            var label = trData[n.name], render_label, $td = $tds.eq(n.index)
            
            if (typeof label == 'undefined') label = ''
            
            $td.text(label).removeClass(that.classnames.td_edit).removeClass(that.classnames.td_changed)
            
            if (n.render && typeof n.render == 'function') {
                if (n.items) {
                    render_label = n.render.call(that, label, n.items)
                    $td.html(render_label)
                } else {
                    render_label = n.render.call(that, label)
                    $td.html(render_label)
                }
            } else if (n.items) {
                render_label = Datagrid.renderItem.call(that, label, n.items)
                $td.html(render_label)
            }
            
            if (n.locked) {
                var $lockTr = that.$lockTbody.find('> tr:eq('+ tr_index +')'),
                    $lockTd = $lockTr.find('> td:eq('+ n.lockIndex +')')
                
                $lockTd.removeClass(that.classnames.td_edit).removeClass(that.classnames.td_changed).html($td.html())
                $lockTr.removeClass(that.classnames.tr_edit)
            }
        })
        
        if (hasLinenumber && $addTrs.length) {
            $addTrs.removeClass(that.classnames.tr_add)
            $trs.each(function(index) {
                $(this).find('> td.'+ that.classnames.td_linenumber).text(index + 1)
                that.$lockTbody && that.$lockTbody.find('> tr:eq('+ index +')').find('> td.'+ that.classnames.td_linenumber).text(index + 1)
            })
        }
    }
    
    /* resize */
    Datagrid.prototype.resizeGrid = function() {
        var that = this, $target = that.$grid.getPageTarget(), parentW, parentH
        var _resizeGrid = function() {
            
            if (that.initFixedW && String(that.options.width).endsWith('%')) {
                parentW = that.$grid.parent().width()
                
                if ($target.is(':hidden') && $target.hasClass('navtabPage')) {
                    that.$grid.data('need.fixedW', true)
                } else {
                    that.fixedWidth()
                }
            }
            
            if (String(that.options.height).endsWith('%')) {
                parentH = that.$grid.parent().height()
                
                if ($target.is(':hidden') && $target.hasClass('navtabPage')) {
                    if ($target.hasClass('navtabPage')) {
                        that.$grid.data('need.fixedH', true)
                    }
                } else if (parentH) {
                    if (parentH != that.parentH)
                        that.tools.fixedH(parentH)
                }
            }
        }
        
        $target.on('bjui.navtab.switch', $.proxy(function() {
            if (that.$grid.data('need.fixedH')) {
                parentH = that.$grid.parent().height()
                if (parentH)
                    that.tools.fixedH(parentH)
                that.$grid.removeData('need.fixedH')
            }
            if (that.$grid.data('need.fixedW')) {
                that.fixedWidth()
                that.$grid.removeData('need.fixedW')
            }
        }, that))
        
        $(window).on(BJUI.eventType.resizeGrid, $.proxy(_resizeGrid, that))
    }
    
    
    // DATAGRID PLUGIN DEFINITION
    // =======================
    
    function Plugin(option) {
        var args     = arguments
        var property = option
        
        return this.each(function () {
            var $this   = $(this)
            var options = $.extend({}, Datagrid.DEFAULTS, $this.data(), typeof option == 'object' && option)
            var data    = $this.data('bjui.datagrid')
            
            if (!data) $this.data('bjui.datagrid', (data = new Datagrid(this, options)))
            if (typeof property == 'string' && $.isFunction(data[property])) {
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
        var $this = $(e.target).find('table[data-toggle="datagrid"]')
        
        if (!$this.length) return
        
        Plugin.call($this)
    })
    
}(jQuery);