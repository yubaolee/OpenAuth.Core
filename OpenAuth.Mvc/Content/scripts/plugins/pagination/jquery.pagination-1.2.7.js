/*!
 * jQuery Pagination Plugin
 * http://mricle.com/JqueryPagination
 * GitHub: https://github.com/mricle/pagination
 * Version: 1.2.7
 * Date: 2015-6-12
 * 
 * Copyright 2015 Mricle
 * Released under the MIT license
 */

!function ($) {
    "use strict";

    var pageEvent = {
        pageClicked: 'pageClicked',
        jumpClicked: 'jumpClicked',
        pageSizeChanged: 'pageSizeChanged'
    }

    var Page = function (element, options) {
        var defaultOption = {
            pageSize: 10,
            pageBtnCount: 11,
            showFirstLastBtn: true,
            firstBtnText: null,
            lastBtnText: null,
            prevBtnText: "&laquo;",
            nextBtnText: "&raquo;",
            loadFirstPage: true,
            remote: {
                url: null,
                params: null,
                callback: null,
                success: null,
                beforeSend: null,
                complete: null,
                pageIndexName: 'pageIndex',
                pageSizeName: 'pageSize',
                totalName: 'total'
            },
            showInfo: false,
            infoFormat: '{start} ~ {end} of {total} entires',
            showJump: false,
            jumpBtnText: 'Go',
            showPageSizes: false,
            pageSizeItems: null,
            debug: false
        }
        this.$element = $(element);
        this.$page = $('<ul class="m-pagination-page"></ul>');
        this.$size = $('<div class="m-pagination-size"></div>');
        this.$jump = $('<div class="m-pagination-jump"></div>');
        this.$info = $('<div class="m-pagination-info"></div>');
        this.options = $.extend(true, {}, defaultOption, $.fn.page.defaults, options);
        this.total = this.options.total || 0;
        this.options.pageSizeItems = this.options.pageSizeItems || [5, 10, 15, 20],
        this.currentPageIndex = 0;
        this.currentPageSize = this.options.pageSize;
        this.pageCount = getPageCount(this.total, this.currentPageSize);

        if (this.options.remote.success == null) {
            this.options.remote.success = this.options.remote.callback;
        }

        var init = function (obj) {
            var that = obj;

            //init size module
            var html = $('<select data-page-btn="size"></select>');
            for (var i = 0; i < that.options.pageSizeItems.length; i++) {
                html.append('<option value="' + that.options.pageSizeItems[i] + '">' + that.options.pageSizeItems[i] + '</option>')
            }
            html.val(that.currentPageSize);
            that.$size.append(html);

            //init jump module
            var jumpHtml = '<div class="m-pagination-group"><input type="text"><button data-page-btn="jump" type="button">' + that.options.jumpBtnText + '</button></div>';
            that.$jump.append(jumpHtml);
            that.$jump.find('input').change(function () {
                if (!checkIsPageNumber(this.value, that.pageCount))
                    this.value = null;
            });
            that.$element.append(that.$page.hide());
            that.$element.append(that.$size.hide());
            that.$element.append(that.$jump.hide());
            that.$element.append(that.$info.hide());
            that._remoteOrRedner(0);
            that.$element
                .on('click', { page: that }, function (event) { eventHandler(event); })
                .on('change', { page: that }, function (event) { eventHandler(event); });
        }

        var eventHandler = function (event) {
            var that = event.data.page;
            var $target = $(event.target);
            if (event.type === 'click' && $target.data('pageIndex') !== undefined && !$target.parent().hasClass('active')) {
                var pageIndex = $(event.target).data("pageIndex");
                that.$element.trigger(pageEvent.pageClicked, pageIndex);
                that.debug('event[ pageClicked ] : pageIndex = ' + (pageIndex));
                that._remoteOrRedner(pageIndex);
            }
            else if (event.type === 'click' && $target.data('pageBtn') === 'jump') {
                var pageIndexStr = that.$jump.find('input').val();
                if (checkIsPageNumber(pageIndexStr, that.pageCount)) {
                    var pageIndex = pageIndexStr - 1;
                    that.$element.trigger(pageEvent.jumpClicked, pageIndex);
                    that.debug('event[ jumpClicked ] : pageIndex = ' + (pageIndex));
                    that._remoteOrRedner(pageIndex);
                }
                that.$jump.find('input').val(null);
            }
            else if (event.type === 'change' && $target.data('pageBtn') === 'size') {
                var pageSize = that.$size.find('select').val();
                that.currentPageSize = pageSize;
                that.$element.trigger(pageEvent.pageSizeChanged, pageSize);
                that.debug('event[ pageSizeChanged ] : pageSize = ' + pageSize);
                that._remoteOrRedner(0);
            }
        }

        if (typeof this.options.total === 'undefined' && this.options.remote.url === null) {
            console && console.error("[init error] : the options must have the parameter of 'remote.url' or 'total'.");
        }
        else if (typeof this.options.total === 'undefined' && !this.options.loadFirstPage) {
            console && console.error("[init error] : if you don't remote the first page. you must set the options or 'total'.");
        }
        else {
            init(this);
        }
    }

    Page.prototype = {
        _remoteOrRedner: function (pageIndex) {
            if (this.options.remote.url != null && (this.options.loadFirstPage || pageIndex > 0))
                this.remote(pageIndex);
            else
                this.renderPagination(pageIndex);
        },
        remote: function (pageIndex, params) {
            var that = this;
            if (isNaN(parseInt(pageIndex)) || typeof pageIndex === "object") {
                params = pageIndex;
                pageIndex = null;
            }
            if (isNaN(parseInt(pageIndex))) {
                pageIndex = that.currentPageIndex;
            }
            var pageParams = {};
            pageParams[this.options.remote.pageIndexName] = pageIndex;
            pageParams[this.options.remote.pageSizeName] = this.currentPageSize;
            this.options.remote.params = deserializeParams(this.options.remote.params);
            if (params) {
                params = deserializeParams(params);
                this.options.remote.params = $.extend({}, this.options.remote.params, params);
            }
            var requestParams = $.extend({}, this.options.remote.params, pageParams);
            $.ajax({
                url: this.options.remote.url,
                dataType: 'json',
                data: requestParams,
                contentType: 'application/Json',
                async: false,
                beforeSend: function (XMLHttpRequest) {
                    if (typeof that.options.remote.beforeSend === 'function') that.options.remote.beforeSend(XMLHttpRequest);
                },
                complete: function (XMLHttpRequest, textStatu) {
                    if (typeof that.options.remote.complete === 'function') that.options.remote.complete(XMLHttpRequest, textStatu);
                },
                success: function (result) {
                    that.debug("ajax request : params = " + JSON.stringify(requestParams), result);
                    var total = GetCustomTotalName(result, that.options.remote.totalName);
                    if (total == null || total == undefined) {
                        console && console.error("the response of totalName :  '" + that.options.remote.totalName + "'  not found");
                    } else {
                        that._updateTotal(total);
                        if (typeof that.options.remote.success === 'function') that.options.remote.success(result, pageIndex);
                        that.renderPagination(pageIndex);
                    }
                }
            })
        },
        renderPagination: function (pageIndex) {
            this.currentPageIndex = pageIndex;
            var pages = renderPages(this.currentPageIndex, this.currentPageSize, this.total, this.options.pageBtnCount,
                this.options.firstBtnText, this.options.lastBtnText, this.options.prevBtnText, this.options.nextBtnText, this.options.showFirstLastBtn);
            this.$page.empty().append(pages);
            this.$info.text(renderInfo(this.currentPageIndex, this.currentPageSize, this.total, this.options.infoFormat));
            if (this.pageCount > 1) {
                this.$page.show();
                if (this.options.showPageSizes) this.$size.show();
                if (this.options.showJump) this.$jump.show();
                if (this.options.showInfo) this.$info.show();
            }
            else if (this.pageCount == 1) {
                if (this.options.showInfo) this.$info.show();
            }
            else {
                this.$page.hide();
                this.$size.hide();
                this.$jump.hide();
                this.$info.hide();
            }
        },
        _updateTotal: function (total) {
            this.total = total;
            this.pageCount = getPageCount(total, this.currentPageSize);
        },
        destroy: function () {
            this.$element.unbind().data("page", null).empty();
        },
        debug: function (message, data) {
            if (this.options.debug && console) {
                message && console.info(message);
                data && console.info(data);
            }
        }
    }

    var renderInfo = function (currentPageIndex, currentPageSize, total, infoFormat) {
        var startNum = (currentPageIndex * currentPageSize) + 1;
        var endNum = (currentPageIndex + 1) * currentPageSize;
        endNum = endNum >= total ? total : endNum;
        return infoFormat.replace('{start}', startNum).replace('{end}', endNum).replace('{total}', total);
    }
    var renderPages = function (pageIndex, pageSize, total, pageBtnCount, firstBtnText, lastBtnText, prevBtnText, nextBtnText, showFirstLastBtn) {
        pageIndex = pageIndex == undefined ? 1 : parseInt(pageIndex) + 1;      //set pageIndex from 1， convenient calculation page
        var pageCount = getPageCount(total, pageSize);
        var html = [];

        if (pageCount <= pageBtnCount) {
            html = renderPage(1, pageCount, pageIndex);
        }
        else {
            var firstPage = renderPerPage(firstBtnText || 1, 0);
            var lastPage = renderPerPage(lastBtnText || pageCount, pageCount - 1);

            var prevPage = renderPerPage(prevBtnText, pageIndex - 2);
            var nextPage = renderPerPage(nextBtnText, pageIndex);
            //button count of  both sides
            var symmetryBtnCount = (pageBtnCount - 1 - 4) / 2;
            if (!showFirstLastBtn)
                symmetryBtnCount = symmetryBtnCount + 1;
            var frontBtnNum = (pageBtnCount + 1) / 2;
            var behindBtnNum = pageCount - ((pageBtnCount + 1) / 2);

            symmetryBtnCount = symmetryBtnCount.toString().indexOf('.') == -1 ? symmetryBtnCount : symmetryBtnCount + 0.5;
            frontBtnNum = frontBtnNum.toString().indexOf('.') == -1 ? frontBtnNum : frontBtnNum + 0.5;
            behindBtnNum = behindBtnNum.toString().indexOf('.') == -1 ? behindBtnNum : behindBtnNum + 0.5;
            if (pageIndex <= frontBtnNum) {
                if (showFirstLastBtn) {
                    html = renderPage(1, pageBtnCount - 2, pageIndex);
                    html.push(nextPage);
                    html.push(lastPage);
                } else {
                    html = renderPagenderPage(1, pageBtnCount - 1, pageIndex);
                    html.push(nextPage);
                }
            }
            else if (pageIndex > behindBtnNum) {
                if (showFirstLastBtn) {
                    html = renderPage(pageCount - pageBtnCount + 3, pageBtnCount - 2, pageIndex);
                    html.unshift(prevPage);
                    html.unshift(firstPage);
                } else {
                    html = renderPage(pageCount - pageBtnCount + 2, pageBtnCount - 1, pageIndex);
                    html.unshift(prevPage);
                }
            }
            else {
                if (showFirstLastBtn) {
                    html = renderPage(pageIndex - symmetryBtnCount, pageBtnCount - 4, pageIndex);
                    html.unshift(prevPage);
                    html.push(nextPage);
                    html.unshift(firstPage);
                    html.push(lastPage);
                } else {
                    html = renderPage(pageIndex - symmetryBtnCount, pageBtnCount - 2, pageIndex);
                    html.unshift(prevPage);
                    html.push(nextPage);
                }
            }
        }
        return html;
    }
    var renderPage = function (beginPageNum, count, currentPage) {
        var html = [];
        for (var i = 0; i < count; i++) {
            var page = renderPerPage(beginPageNum, beginPageNum - 1);
            if (beginPageNum == currentPage)
                page.addClass("active");
            html.push(page);
            beginPageNum++;
        }
        return html;
    }
    var renderPerPage = function (text, value) {
        return $("<li><a data-page-index='" + value + "'>" + text + "</a></li>");
    }
    var getPageCount = function (total, pageSize) {
        var pageCount = 0;
        var total = parseInt(total);
        var i = total / pageSize;
        pageCount = i.toString().indexOf('.') != -1 ? parseInt(i.toString().split('.')[0]) + 1 : i;
        return pageCount;
    }
    var deserializeParams = function (params) {
        var newParams = {};
        if (typeof params === 'string') {
            var arr = params.split('&');
            for (var i = 0; i < arr.length; i++) {
                var a = arr[i].split('=');
                newParams[a[0]] = decodeURIComponent(a[1]);
            }
        }
        else if (params instanceof Array) {
            for (var i = 0; i < params.length; i++) {
                newParams[params[i].name] = decodeURIComponent(params[i].value);
            }
        }
        else if (typeof params === 'object') {
            newParams = params;
        }
        return newParams;
    }
    var checkIsPageNumber = function (pageIndex, maxPage) {
        var reg = /^\+?[1-9][0-9]*$/;
        return reg.test(pageIndex) && parseInt(pageIndex) <= parseInt(maxPage);
    }
    var GetCustomTotalName = function (object, totalName) {
        var arr = totalName.split('.');
        var temp = object;
        var total = null;
        for (var i = 0; i < arr.length; i++) {
            temp = mapObjectName(temp, arr[i]);
            if (!isNaN(parseInt(temp))) {
                total = temp;
                break;
            }
            if (temp == null) {
                break;
            }
        }
        return total;
    }
    var mapObjectName = function (data, mapName) {
        for (var i in data) {
            if (i == mapName) {
                return data[i];
            }
        }
        return null;
    }

    $.fn.page = function (option) {
        var args = arguments;
        return this.each(function () {
            var $this = $(this);
            var data = $this.data('page');
            if (!data && (typeof option === 'object' || typeof option === 'undefined')) {
                var options = typeof option == 'object' && option;
                var data_api_options = $this.data();
                options = $.extend(options, data_api_options);
                $this.data('page', (data = new Page(this, options)));
            }
            else if (data && typeof option === 'string') {
                data[option].apply(data, Array.prototype.slice.call(args, 1));
            }
            else if (!data) {
                console && console.error("jQuery Pagination Plugin is uninitialized.");
            }
        });
    }
}(window.jQuery)