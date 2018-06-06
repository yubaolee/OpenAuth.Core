/*
 *  打印预览或另存为PDF功能，需要依赖:
 * ../plugin/printThis.js
 */
;(function ( global, factory ) {
	'use strict';
	if ( typeof define !== 'undefined' && define.amd ) { // export as AMD...
		define( ['jquery','GooFlow'], factory );
	}
	else if ( typeof module !== 'undefined' && module.exports ) { // ...or as browserify
		factory( require('jquery'), require('GooFlow') );
	}else
		factory( global.$, global.GooFlow );

}( typeof window !== 'undefined' ? window : this, function ( $,GooFlow ) {
	if(GooFlow.prototype.print && typeof GooFlow.prototype.print==='function'){
		return;//防止多次载入
	}
/*
 * printThis v1.12.2
 * @desc Printing plug-in for jQuery
 * @author Jason Day
 * 精简版 only for GooFlow
 */
    (function($) {

        function appendContent($el, content) {
            if (!content) return;

            // Simple test for a jQuery element
            $el.append(content.jquery ? content.clone() : content);
        }

        function appendBody($body, $element, opt) {
            // Clone for safety and convenience
            // Calls clone(withDataAndEvents = true) to copy form values.
            var $content = $element.clone();

            if (opt.printContainer) {
                // grab $.selector as container
                $content.appendTo($body);
            } else {
                // otherwise just print interior elements of container
                $content.each(function() {
                    $(this).children().appendTo($body)
                });
            }
        }

        var opt;
        $.fn.printThis = function(options) {
            opt = $.extend({}, $.fn.printThis.defaults, options);
            var $element = this instanceof jQuery ? this : $(this);

            var strFrameName = "printThis-" + (new Date()).getTime();

            if (window.location.hostname !== document.domain && navigator.userAgent.match(/msie/i)) {
                // Ugly IE hacks due to IE not inheriting document.domain from parent
                // checks if document.domain is set by comparing the host name against document.domain
                var iframeSrc = 'javascript:document.write("<head><script>document.domain="' + document.domain + '";</script></head><body></body>")';
                var printI = document.createElement('iframe');
                printI.name = "printIframe";
                printI.id = strFrameName;
                printI.className = "MSIE";
                document.body.appendChild(printI);
                printI.src = iframeSrc;

            } else {
                // other browsers inherit document.domain, and IE works if document.domain is not explicitly set
                var $frame = $("<iframe id='" + strFrameName + "' name='printIframe' />");
                $frame.appendTo("body");
            }

            var $iframe = $("#" + strFrameName);

            // show frame if in debug mode
            if (!opt.debug) $iframe.css({
                position: "absolute",
                width: "0px",
                height: "0px",
                left: "-600px",
                top: "-600px"
            });

            // $iframe.ready() and $iframe.load were inconsistent between browsers
            setTimeout(function() {

                // Add doctype to fix the style difference between printing and render
                function setDocType($iframe, doctype){
                    var win, doc;
                    win = $iframe.get(0);
                    win = win.contentWindow || win.contentDocument || win;
                    doc = win.document || win.contentDocument || win;
                    doc.open();
                    doc.write(doctype);
                    doc.close();
                }

                if (opt.doctypeString){
                    setDocType($iframe, opt.doctypeString);
                }

                var $doc = $iframe.contents(),
                    $head = $doc.find("head"),
                    $body = $doc.find("body"),
                    $base = $('base'),
                    baseURL;
				$body.css({height:'auto',margin:'0',padding:'0',background:'#fff'});
                // add base tag to ensure elements use the parent domain
                if (opt.base === true && $base.length > 0) {
                    // take the base tag from the original page
                    baseURL = $base.attr('href');
                } else if (typeof opt.base === 'string') {
                    // An exact base string is provided
                    baseURL = opt.base;
                } else {
                    // Use the page URL as the base
                    baseURL = document.location.protocol + '//' + document.location.host;
                }

                $head.append('<base href="' + baseURL + '">');

                $("link[rel=stylesheet]").each(function() {
                    var href = $(this).attr("href");
                    if (href) {
                        var media = $(this).attr("media") || "all";
                        $head.append("<link type='text/css' rel='stylesheet' href='" + href + "' media='" + media + "'>");
                    }
                });

                // add title of the page
                if (opt.pageTitle) $head.append("<title>" + opt.pageTitle + "</title>");

                // print header
                appendContent($body, opt.header);

                appendBody($body, $element, opt);

                // print "footer"
                appendContent($body, opt.footer);

                setTimeout(function() {
                    if ($iframe.hasClass("MSIE")) {
                        // check if the iframe was created with the ugly hack
                        // and perform another ugly hack out of neccessity
                        window.frames["printIframe"].focus();
                        $head.append("<script>  window.print(); </s" + "cript>");
                    } else {
                        // proper method
                        if (document.queryCommandSupported("print")) {
                            $iframe[0].contentWindow.document.execCommand("print", false, null);
                        } else {
                            $iframe[0].contentWindow.focus();
                            $iframe[0].contentWindow.print();
                        }
                    }

                    // remove iframe after print
                    if (!opt.debug) {
                        setTimeout(function() {
                            $iframe.remove();
                        }, 1000);
                    }

                }, opt.printDelay);

            }, 333);

        };

        // defaults
        $.fn.printThis.defaults = {
            debug: false,           // show the iframe for debugging
            printContainer: true,   // print outer container/$.selector
            pageTitle: "",          // add title to print page
            printDelay: 333,        // variable print delay
            header: null,           // prefix to html
            footer: null,           // postfix to html
            base: false,            // preserve the BASE tag, or accept a string for the URL
            doctypeString: '<!DOCTYPE html>' // html doctype
        };
    })($);
    ////////////////printThis.js END!

	//扩展定义打印预览或另存为PDF功能的方法
	GooFlow.prototype.print=function(scale){
		var max=this._suitSize();
		if(!scale)  scale=1.0;
		max.width+=100;max.height+=100;
		var printDiv=this.$workArea.clone();
		printDiv.css({
			width:max.width+"px",height:max.height+"px"
		});
		printDiv.children(".GooFlow_work_group").css({width:max.width+"px",height:max.height+"px"});
		printDiv.children("svg").css({width:max.width+"px",height:max.height+"px"});
		printDiv.children(".GooFlow_work_vml").css({width:max.width+"px",height:max.height+"px"});
		printDiv=printDiv.wrap('<div class="GooFlow GooFlow_work" style="width:'
			+max.width+'px;height:'+max.height+'px; overflow:hidden"></div>').parent();
		if(GooFlow.color.font){
			printDiv.css("color",GooFlow.color.font);
		}
		printDiv.css({"transform-origin": "top left", transform:"scale("+scale+")"}).printThis({
			base:document.URL, pageTitle:this.$title
		});
	};
	return GooFlow;
}));
