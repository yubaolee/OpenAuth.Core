/*!
 * cxColor 1.1
 * http://code.ciaoca.com/
 * https://github.com/ciaoca/cxColor
 * E-mail: ciaoca@gmail.com
 * Released under the MIT license
 * Date: 2013-07-04
 */
(function($){
	$.fn.cxColor=function(settings){
		if(this.length<1){return;};
		settings=$.extend({},$.cxColor.defaults,settings);

		var theColorPanel={
			jqObj:this,
			fn:{}
		};
		var reportColorPanel;

		if(theColorPanel.jqObj.val().length>0){
			settings.color=theColorPanel.jqObj.val();
		};

		// 创建选择器
		var color_now,color_pane,color_table,lock_bg,temp_html;
		color_pane=$("<div></div>",{"class":"cxcolor"}).appendTo("body");

		// 初始化选择器面板
		var color_hex=["00","33","66","99","cc","ff"];
		var spcolor_hex=["ff0000","00ff00","0000ff","ffff00","00ffff","ff00ff"];
		

		temp_html="<div class='panel_hd'><a class='reset' href='javascript://' rel='reset'>默认颜色</a><a class='clear' href='javascript://' rel='clear'>清除</a></div>";
		color_pane.html(temp_html);

		temp_html="";
		for(var i=0;i<2;i++){
			for(var j=0;j<6;j++){
				temp_html+="<tr>";
				temp_html+="<td title='#000000' style='background-color:#000000'>";
				if(i==0){
					temp_html+="<td title='#"+color_hex[j]+color_hex[j]+color_hex[j]+"' style='background-color:#"+color_hex[j]+color_hex[j]+color_hex[j]+"'>";
				}else{
					temp_html+="<td title='#"+spcolor_hex[j]+"' style='background-color:#"+spcolor_hex[j]+"'>";
				};
				temp_html+="<td title='#000000' style='background-color:#000000'>";
				for(var k=0;k<3;k++){
					for(var l=0;l<6;l++){
						temp_html+="<td title='#"+color_hex[k+i*3]+color_hex[l]+color_hex[j]+"' style='background-color:#"+color_hex[k+i*3]+color_hex[l]+color_hex[j]+"'>";
					};
				};
			};
		};
		color_table=$("<table></table>").html(temp_html).appendTo(color_pane);
		
		// 背景遮挡层
		lock_bg=$("<div></div>",{"class":"cxcolor_lock"}).appendTo("body");

		theColorPanel.fn.show=function(){
			var doc_w=document.body.clientWidth;
			var doc_h=document.body.clientHeight;
			var pane_w=color_pane.outerWidth();
			var pane_h=color_pane.outerHeight();
			var pane_top=theColorPanel.jqObj.offset().top;
			var pane_left=theColorPanel.jqObj.offset().left;
			var obj_w=theColorPanel.jqObj.outerWidth();
			var obj_h=theColorPanel.jqObj.outerHeight();
			
			pane_top=((pane_top+pane_h+obj_h)>doc_h) ? pane_top-pane_h : pane_top+obj_h;
			pane_left=((pane_left+pane_w)>doc_w) ? pane_left-(pane_w-obj_w) : pane_left;

			color_pane.css({"top":pane_top,"left":pane_left}).show();
			lock_bg.css({width:doc_w,height:doc_h}).show();
		};

		// 关闭日期函数
		theColorPanel.fn.hide=function(){
			color_pane.hide();
			lock_bg.hide();
		};

		// 更改颜色函数
		theColorPanel.fn.change=function(c){
			color_now=c;
			theColorPanel.jqObj.val(color_now).css("backgroundColor",color_now);
			theColorPanel.jqObj.trigger("change");
			theColorPanel.fn.hide();
		};

		// 设置或获取颜色
		theColorPanel.fn.setColor=function(c){
			if(!c){
				return color_now;
			}else{
				theColorPanel.fn.change(c);
			};
		};

		// 还原颜色
		theColorPanel.fn.reset=function(){
			theColorPanel.fn.change(settings.color);
		};

		// 清除颜色
		theColorPanel.fn.clear=function(){
			theColorPanel.fn.change("");
		};

		// 面板 <a> 事件
		color_pane.delegate("a","click",function(){
			if(!this.rel){return};

			var _rel=this.rel;
			switch(_rel){
				case "reset":
					theColorPanel.fn.reset()
					return false;
					break
				case "clear":
					theColorPanel.fn.clear()
					return false;
					break
			};
		});

		// 选择颜色事件
		color_table.delegate("td","click",function(){
			var color_val=this.title;
			theColorPanel.fn.change(color_val);
		});

		// 显示面板事件
		theColorPanel.jqObj.bind("click",function(){
			theColorPanel.fn.show();
		});

		// 关闭面板事件
		lock_bg.bind("click",function(){
			theColorPanel.fn.hide();
		});

		// 第一次初始化
		theColorPanel.fn.change(settings.color);

		reportColorPanel={
			jqobj:theColorPanel.jqobj,
			show:theColorPanel.fn.show,
			hide:theColorPanel.fn.hide,
			color:theColorPanel.fn.setColor,
			reset:theColorPanel.fn.reset,
			clear:theColorPanel.fn.clear
		}
		return reportColorPanel;
	};
	
	// 默认值
	$.cxColor={defaults:{
		color:"#000000"		// 默认颜色
	}};
})(jQuery);