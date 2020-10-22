/**
 * Gooflow在线流程图设计器
 * Version: 1.3.2
 * Copyright: foolegg126(sdlddr)
 */

layui.define("jquery",
    function(exports) {

        var jQuery = layui.jquery;
        var $ = layui.jquery;

	//预先定义几个公用方法
	//获取一个DIV的绝对坐标的功能函数,即使是非绝对定位,一样能获取到
	function _elCsys(dom) {
		var t = dom.offsetTop;
		var l = dom.offsetLeft;
		dom=dom.offsetParent;
		while (dom) {
			t += dom.offsetTop;
			l += dom.offsetLeft;
			dom=dom.offsetParent;
		}
		return { top: t, left: l };
	}
	//兼容各种浏览器的,获取鼠标真实位置
	function _mouseP(ev){
		if(!ev) ev=window.event;
		if(ev.pageX || ev.pageY){
			return {x:ev.pageX, y:ev.pageY};
		}
		return {
			x:ev.clientX + document.documentElement.scrollLeft - document.body.clientLeft,
			y:ev.clientY + document.documentElement.scrollTop  - document.body.clientTop
		};
	}
	//计算两个结点间要连折线的话，连线的所有坐标
	function calcPolyPoints(n1,n2,type,M,scale){
		if(!scale)	scale=1.0;
		var N1={left:n1.left*scale, top:n1.top*scale, width:n1.width*scale, height:n1.height*scale};
		var N2={left:n2.left*scale, top:n2.top*scale, width:n2.width*scale, height:n2.height*scale};
		M=M*scale;
		//开始/结束两个结点的中心
		var SP={x:N1.left+N1.width/2,y:N1.top+N1.height/2};
		var EP={x:N2.left+N2.width/2,y:N2.top+N2.height/2};
		var m1=[],m2=[],sp,ep;
		//如果是允许中段可左右移动的折线,则参数M为可移动中段线的X坐标
		//粗略计算起始点
		sp=[SP.x,SP.y];
		ep=[EP.x,EP.y];
		if(type==="lr"){
			//粗略计算2个中点
			m1=[M,SP.y];
			m2=[M,EP.y];
			//再具体分析修改开始点和中点1
			if(m1[0]>N1.left&&m1[0]<N1.left+N1.width){
				m1[1]=(SP.y>EP.y? N1.top:N1.top+N1.height);
				sp[0]=m1[0];sp[1]=m1[1];
			}
			else{
				sp[0]=(m1[0]<N1.left? N1.left:N1.left+N1.width)
			}
			//再具体分析中点2和结束点
			if(m2[0]>N2.left&&m2[0]<N2.left+N2.width){
				m2[1]=(SP.y>EP.y? N2.top+N2.height:N2.top);
				ep[0]=m2[0];ep[1]=m2[1];
			}
			else{
				ep[0]=(m2[0]<N2.left? N2.left:N2.left+N2.width)
			}
		}
		//如果是允许中段可上下移动的折线,则参数M为可移动中段线的Y坐标
		else if(type==="tb"){
			//粗略计算2个中点
			m1=[SP.x,M];
			m2=[EP.x,M];
			//再具体分析修改开始点和中点1
			if(m1[1]>N1.top&&m1[1]<N1.top+N1.height){
				m1[0]=(SP.x>EP.x? N1.left:N1.left+N1.width);
				sp[0]=m1[0];sp[1]=m1[1];
			}
			else{
				sp[1]=(m1[1]<N1.top? N1.top:N1.top+N1.height)
			}
			//再具体分析中点2和结束点
			if(m2[1]>N2.top&&m2[1]<N2.top+N2.height){
				m2[0]=(SP.x>EP.x? N2.left+N2.width:N2.left);
				ep[0]=m2[0];ep[1]=m2[1];
			}
			else{
				ep[1]=(m2[1]<N2.top? N2.top:N2.top+N2.height);
			}
		}
		return {start:sp,m1:m1,m2:m2,end:ep};
	}
	//计算两个结点间要连直线的话，连线的开始坐标和结束坐标
	function calcStartEnd(n1,n2,scale){
		if(!scale)	scale=1.0;
		var X_1,Y_1,X_2,Y_2;
		//X判断：
		var x11=n1.left*scale ,x12=n1.left*scale +n1.width*scale ,x21=n2.left*scale ,x22=n2.left*scale +n2.width*scale ;
		//结点2在结点1左边
		if(x11>=x22){
			X_1=x11;X_2=x22;
		}
		//结点2在结点1右边
		else if(x12<=x21){
			X_1=x12;X_2=x21;
		}
		//结点2在结点1水平部分重合
		else if(x11<=x21&&x12>=x21&&x12<=x22){
			X_1=(x12+x21)/2;X_2=X_1;
		}
		else if(x11>=x21&&x12<=x22){
			X_1=(x11+x12)/2;X_2=X_1;
		}
		else if(x21>=x11&&x22<=x12){
			X_1=(x21+x22)/2;X_2=X_1;
		}
		else if(x11<=x22&&x12>=x22){
			X_1=(x11+x22)/2;X_2=X_1;
		}

		//Y判断：
		var y11=n1.top*scale ,y12=n1.top*scale +n1.height*scale ,y21=n2.top*scale ,y22=n2.top*scale +n2.height*scale ;
		//结点2在结点1上边
		if(y11>=y22){
			Y_1=y11;Y_2=y22;
		}
		//结点2在结点1下边
		else if(y12<=y21){
			Y_1=y12;Y_2=y21;
		}
		//结点2在结点1垂直部分重合
		else if(y11<=y21&&y12>=y21&&y12<=y22){
			Y_1=(y12+y21)/2;Y_2=Y_1;
		}
		else if(y11>=y21&&y12<=y22){
			Y_1=(y11+y12)/2;Y_2=Y_1;
		}
		else if(y21>=y11&&y22<=y12){
			Y_1=(y21+y22)/2;Y_2=Y_1;
		}
		else if(y11<=y22&&y12>=y22){
			Y_1=(y11+y22)/2;Y_2=Y_1;
		}
		return {"start":[X_1,Y_1],"end":[X_2,Y_2]};
	}
	//初始化折线中段的X/Y坐标,mType='rb'时为X坐标,mType='tb'时为Y坐标
	function getMValue(n1,n2,mType,scale){
		if(!scale)	scale=1.0;
		if(mType==="lr"){
			return (n1.left*scale + n1.width*scale/2 + n2.left*scale + n2.width*scale/2 )/2;
		}
		else if(mType==="tb"){
			return (n1.top*scale + n1.height*scale/2 + n2.top*scale + n2.height*scale/2 )/2;
		}
	}
//构造类：
var GooFlow = function(selector,property){
	console.log('Your browser\'s navigator.userAgent is:',navigator.userAgent);
	if (navigator.userAgent.indexOf("MSIE 8.0")>0||navigator.userAgent.indexOf("MSIE 7.0")>0||navigator.userAgent.indexOf("MSIE 6.0")>0)
		GooFlow.prototype.useSVG="";
	else	GooFlow.prototype.useSVG="1";
//初始化区域图的对象
	this.$bgDiv=$(selector);//最父框架的DIV
	this.$bgDiv.addClass("GooFlow");
	this.$id=this.$bgDiv.attr("id")||'GooFlow_'+new Date().getTime();
	if(property.colors && typeof property.colors ==='object'){
		$.extend(GooFlow.color, property.colors);
	}
	this.$bgDiv.css("color",GooFlow.color.font);
	if(GooFlow.color.main){
		this.$bgDiv.append('<style>.GooFlow_tool_btndown{background-color:'+GooFlow.color.main+'}</style>');
	}
	var width=(property.width||this.$bgDiv.width());
	var height=(property.height||this.$bgDiv.height());
	this.$bgDiv.css({width:width+"px",height:height+"px"});
	this.$tool=null;//左侧工具栏对象
	this.$head=null;//顶部标签及工具栏按钮
	this.$title="newFlow_1";//流程图的名称
	this.$nowType="cursor";//当前要绘制的对象类型
	this.$lineData={};
	this.$lineCount=0;
	this.$nodeData={};
	this.$nodeCount=0;
	this.$areaData={};
	this.$areaCount=0;
	this.$lineDom={};
	this.$nodeDom={};
	this.$areaDom={};
	this.$max=property.initNum||1;//计算默认ID值的起始SEQUENCE
	this.$focus="";//当前被选定的结点/转换线ID,如果没选中或者工作区被清空,则为""
	//this.$cursor="default";//鼠标指针在工作区内的样式
	this.$editable=false;//工作区是否可编辑
	this.$deletedItem={};//在流程图的编辑操作中被删除掉的元素ID集合,元素ID为KEY,元素类型(node,line.area)为VALUE
	this.$workExtendStep=200;//在自动/手动扩展可编辑区时，一次扩展后宽/高增加多少像素
	this.$scale=1.00;//工作区内容的缩放比例，从0.1至无穷大，初始默认为1
	var headHeight=0;
	var tmp="",titleText;
	if(property.haveHead){
		tmp="<div class='GooFlow_head' "+(GooFlow.color.main? "style='border-bottom-color:"+GooFlow.color.main+"'" : "") +">";
		if(property.headLabel){
      		tmp+="<label title='"+(property.initLabelText||"newFlow_1")+"' "
        		+(GooFlow.color.main? "style='background:"+GooFlow.color.main+"'" : "")+">"
				+(property.initLabelText||"newFlow_1")+"</label>";
		}
		if(property.headBtns)
		for(var x=0;x<property.headBtns.length;++x){
			if(!property.useOperStack&&(property.headBtns[x]==='undo'||property.headBtns[x]==='redo'))	continue;
			titleText=GooFlow.remarks.headBtns[property.headBtns[x]]? " title='"+GooFlow.remarks.headBtns[property.headBtns[x]]+"'":"";
			tmp+="<a href='javascript:void(0)' class='GooFlow_head_btn'"+titleText+"><i class='ico_"+property.headBtns[x]+"'></i></a>"
		}
		tmp+="</div>";
		this.$head=$(tmp);
		this.$bgDiv.append(this.$head);
		if(property.headBtns){
			this.$head.find(".ico_undo").parent().addClass("a_disabled");
			this.$head.find(".ico_redo").parent().addClass("a_disabled");
			//以下是当工具栏按钮被点击时触发的事件自定义(虚函数),格式为function(),因为可直接用THIS操作对象本身,不用传参；用户可自行重定义:
			this.onBtnNewClick=null;//新建流程图按钮被点中
			this.onBtnOpenClick=null;//打开流程图按钮定义
			this.onBtnSaveClick=null;//保存流程图按钮定义
			this.onFreshClick=null;//重载流程图按钮定义
			this.onPrintClick=null;//打印流程图按钮定义
			this.$headBtnEvents=property.headBtnEvents;//用户对头部栏另行自定义类型按钮的事件绑定json集合,key为按钮类型名，value为方法定义
			this.$head.on("click",{inthis:this},function(e){
				if(!e)e=window.event;
				var tar=e.target;
				if(tar.tagName==="DIV"||tar.tagName==="SPAN")	return;
				else if(tar.tagName==="A")	tar=tar.childNodes[0];
				var This=e.data.inthis, Class=$(tar).attr("class");
				//定义顶部操作栏按钮的事件
				switch(Class){
					case "ico_new":		if(This.onBtnNewClick!==null)	This.onBtnNewClick();break;
					case "ico_open":	if(This.onBtnOpenClick!==null)	This.onBtnOpenClick();break;
					case "ico_save":	if(This.onBtnSaveClick!==null)	This.onBtnSaveClick();break;
					case "ico_undo":	This.undo();break;
					case "ico_redo":	This.redo();break;
					case "ico_reload":  if(This.onFreshClick!==null)	This.onFreshClick();break;
					case "ico_print":   if(This.onPrintClick!==null)	This.onPrintClick();break;
					default:
						if(typeof This.$headBtnEvents!=='undefined' && typeof This.$headBtnEvents[Class]==='function'){
							This.$headBtnEvents[Class]();
						}
				}
			});
		}
		headHeight=28;
	}
	var toolWidth=0;
	if(property.haveTool){
		this.$bgDiv.append("<div class='GooFlow_tool'"+(property.haveHead? "":" style='margin-top:3px'")+"><div style='height:"+(height-headHeight-(property.haveHead? 5:8))+"px' class='GooFlow_tool_div'></div></div>");
		this.$tool=this.$bgDiv.find(".GooFlow_tool div");
		//未加代码：加入绘图工具按钮
		var titleCursor=GooFlow.remarks.toolBtns["cursor"]? " title='"+GooFlow.remarks.toolBtns["cursor"]+"'":"";
        var titleDirect=GooFlow.remarks.toolBtns["direct"]? " title='"+GooFlow.remarks.toolBtns["direct"]+"'":"";
        var titleDashed=GooFlow.remarks.toolBtns["dashed"]? " title='"+GooFlow.remarks.toolBtns["dashed"]+"'":"";
		this.$tool.append("<div style='margin-bottom:4px'><span/><span/><span/></div>"
	  		+"<a href='javascript:void(0)'"+titleCursor+" type='cursor' class='GooFlow_tool_btndown' id='"+this.$id+"_btn_cursor'><i class='ico_cursor'/></a>"
     		+"<a href='javascript:void(0)'"+titleDirect+" type='direct' class='GooFlow_tool_btn' id='"+this.$id+"_btn_direct'><i class='ico_direct'/></a>"
			+(property.haveDashed? "<a href='javascript:void(0)'"+titleDashed+" type='dashed' class='GooFlow_tool_btn' id='"+this.$id+"_btn_dashed'><i class='ico_dashed'/></a>":"")
    	);
		if(property.toolBtns&&property.toolBtns.length>0){
			tmp="<span/>";
			for(var i=0;i<property.toolBtns.length;++i){
                var tmpType=property.toolBtns[i].split(" ")[0];
                titleText=GooFlow.remarks.toolBtns[tmpType]? " title='"+GooFlow.remarks.toolBtns[tmpType]+"'":'';
				tmp+="<a href='javascript:void(0)'"+titleText+" type='"+property.toolBtns[i]+"' id='"+this.$id+"_btn_"+tmpType+"' class='GooFlow_tool_btn'><i class='ico_"+property.toolBtns[i]+"'/></a>";//加入自定义按钮
			}
			this.$tool.append(tmp);
		}
		//加入区域划分框工具开关按钮
		if(property.haveGroup){
            var titleGroup=GooFlow.remarks.toolBtns["group"]? " title='"+GooFlow.remarks.toolBtns["group"]+"'":"";
            this.$tool.append("<span/><a href='javascript:void(0)'"+titleGroup+" type='group' class='GooFlow_tool_btn' id='"+this.$id+"_btn_group'><i class='ico_group'/></a>");
		}
		toolWidth=31;
		this.$nowType="cursor";
		//绑定各个按钮的点击事件
		this.$tool.on("click",{inthis:this},function(e){
			if(!e)e=window.event;
			var tar;
			switch(e.target.tagName){
				case "SPAN":return false;
				case "DIV":return false;
				case "I":	tar=e.target.parentNode;break;
				case "A":	tar=e.target;
			}
			var type=$(tar).attr("type");
			e.data.inthis.switchToolBtn(type);
			return false;
		});
		this.$editable=true;//只有具有工具栏时可编辑
	}

	//确定工作区在设计器中的位置、宽高
	width=width-toolWidth-9;
	height=height-headHeight-(property.haveHead? 5:8);
	this.$bgDiv.append("<div class='GooFlow_work' style='"+(property.haveHead? "top:28px;":"")+(property.haveTool? "left:34px":"")+"'></div>");
	this.$workArea=$("<div class='GooFlow_work_inner' style='width:"+width+"px;height:"+height+"px'></div>")
		.attr({"unselectable":"on","onselectstart":'return false',"onselect":'document.selection.empty()'});
	this.$bgDiv.children(".GooFlow_work").append(this.$workArea);
	//计算工作区相对GooFlow父框架的绝对定位运算值，并保存
	this.t={top:property.haveHead? 28:3,left:property.haveTool?34:3};

    //绑定工作区事件
    this.$workArea.on("click",{inthis:this},function(e){
        if(!e)e=window.event;
        var This=e.data.inthis;
        var type=This.$nowType;
        if(type==="cursor"){
            var tar=$(e.target);
            var n=tar.prop("tagName");
            if(n==="svg"||(n==="DIV"&&tar.prop("class").indexOf("GooFlow_work")>-1)||n==="LABEL"){
            	console.log(n);
                if(This.$lineOper && This.$lineOper.data("tid")){
                    This.focusItem(This.$lineOper.data("tid"),false);
                }
                else{This.blurItem();}
            }
            return;
        }
        else if(type==="direct"||type==="dashed"||type==="group")return;
        if(!This.$editable)return;
        var X,Y;
        var ev=_mouseP(e),t=_elCsys(this);
        X=ev.x-t.left+this.parentNode.scrollLeft;
        Y=ev.y-t.top+this.parentNode.scrollTop;
        This.addNode(new Date().getTime().toString(),{name:"node_"+This.$max,left:X,top:Y,type:This.$nowType});
        This.$max++;
    });

	this.$draw=null;//画矢量线条的容器
	this._initDraw("draw_"+this.$id,width,height);
	this.$group=null;//画区域块（泳道）的容器
	if(property.haveGroup)
		this._initGroup(width,height);
	//为了节点而增加的一些集体绑定
	this._initWorkForNode();

	//一些基本的元素事件，这些事件可直接通过this访问对象本身
	//当操作某个单元（结点/线）被由不选中变成选中时，触发的方法，返回FALSE可阻止选中事件的发生
	//格式function(id,type)：id是单元的唯一标识ID,type是单元的种类,有"node","line"两种取值,"area"不支持被选中
	this.onItemFocus=null;
	//当操作某个单元（结点/线）被由选中变成不选中时，触发的方法，返回FALSE可阻止取消选中事件的发生
	//格式function(id，type)：id是单元的唯一标识ID,type是单元的种类,有"node","line"两种取值,"area"不支持被取消选中
	this.onItemBlur=null;
	//当用重色标注某个结点/转换线时触发的方法，返回FALSE可阻止重定大小/造型事件的发生
	//格式function(id，type，mark)：id是单元的唯一标识ID,type是单元类型（"node"结点,"line"转换线），mark为布尔值,表示是要标注TRUE还是取消标注FALSE
	this.onItemMark=null;
	//当操作某个单元（结点/线/区域块）被双击时，触发的方法，返回FALSE可阻止取消原来双击事件（双击后直接编辑）的发生
	//格式function(id，type)：id是单元的唯一标识ID,type是单元的种类,有"node","line","area"三种取值
	this.onItemDbClick=null;
	//当操作某个单元（结点/线/区域块）被右键点击时，触发的方法，返回FALSE可阻止取消原来右击事件（一般是浏览器默认的右键菜单）的发生
	//格式function(id，type)：id是单元的唯一标识ID,type是单元的种类,有"node","line","area"三种取值
	this.onItemRightClick=null;

	if(this.$editable){
		//绑定当结点/线/分组块的一些操作事件,这些事件可直接通过this访问对象本身
		//当操作某个单元（结点/线/分组块）被添加时，触发的方法，返回FALSE可阻止添加事件的发生
		//格式function(id，type,json)：id是单元的唯一标识ID,type是单元的种类,有"node","line","area"三种取值,json即addNode,addLine或addArea方法的第二个传参json.
		this.onItemAdd=null;
		//当操作某个单元（结点/线/分组块）被删除时，触发的方法，返回FALSE可阻止删除事件的发生
		//格式function(id，type)：id是单元的唯一标识ID,type是单元的种类,有"node","line","area"三种取值
		this.onItemDel=null;
		//当操作某个单元（结点/分组块）被移动时，触发的方法，返回FALSE可阻止移动事件的发生
		//格式function(id，type,left,top)：id是单元的唯一标识ID,type是单元的种类,有"node","area"两种取值，线line不支持移动,left是新的左边距坐标，top是新的顶边距坐标
		this.onItemMove=null;
		//当操作某个单元（结点/线/分组块）被重命名时，触发的方法，返回FALSE可阻止重命名事件的发生
		//格式function(id,name,type)：id是单元的唯一标识ID,type是单元的种类,有"node","line","area"三种取值,name是新的名称
		this.onItemRename=null;
		//当操作某个单元（结点/分组块）被重定义大小或造型时，触发的方法，返回FALSE可阻止重定大小/造型事件的发生
		//格式function(id，type,width,height)：id是单元的唯一标识ID,type是单元的种类,有"node","line","area"三种取值;width是新的宽度,height是新的高度
		this.onItemResize=null;
		//当移动某条折线中段的位置，触发的方法，返回FALSE可阻止重定大小/造型事件的发生
		//格式function(id，M)：id是单元的唯一标识ID,M是中段的新X(或Y)的坐标
		this.onLineMove=null;
		//当变换某条连接线的类型，触发的方法，返回FALSE可阻止重定大小/造型事件的发生
		//格式function(id，type)：id是单元的唯一标识ID,type是连接线的新类型,"sl":直线,"lr":中段可左右移动的折线,"tb":中段可上下移动的折线
		this.onLineSetType=null;
		//当变换某条连接线的端点变更连接的结点时，触发的方法，返回FALSE可阻止重定大小/造型事件的发生
		//格式function(id，newStart,newEnd)：id是连线单元的唯一标识ID,newStart,newEnd分别是起始结点的ID和到达结点的ID
		this.onLinePointMove=null;
		this._initExpendFunc();//初始化手动扩展工作区宽高的功能
		//对节点、区域块进行移动或者RESIZE时用来显示的遮罩层
		this.$ghost=$("<div class='rs_ghost'></div>").attr({"unselectable":"on","onselectstart":'return false',"onselect":'document.selection.empty()'});
		this.$bgDiv.append(this.$ghost);
		this._initEditFunc(property.useOperStack);
	}
};

GooFlow.prototype={
	useSVG:"", //浏览器是否能用SVG？
	_getSvgMarker:function(id,color){
		var m=document.createElementNS("http://www.w3.org/2000/svg","marker");
		m.setAttribute("id",id);
		m.setAttribute("viewBox","0 0 6 6");
		m.setAttribute("refX",'5');
		m.setAttribute("refY",'3');
		m.setAttribute("markerUnits","strokeWidth");
		m.setAttribute("markerWidth",'6');
		m.setAttribute("markerHeight",'6');
		m.setAttribute("orient","auto");
		var path=document.createElementNS("http://www.w3.org/2000/svg","path");
		path.setAttribute("d","M 0 0 L 6 3 L 0 6 z");
		path.setAttribute("fill",color);
		path.setAttribute("stroke-width",'0');
		m.appendChild(path);
		return m;
	},
	//初始化连线层
	_initDraw:function(id,width,height){
		if(GooFlow.prototype.useSVG!==""){
			this.$draw=document.createElementNS("http://www.w3.org/2000/svg","svg");//可创建带有指定命名空间的元素节点
			this.$workArea.prepend(this.$draw);
			var defs=document.createElementNS("http://www.w3.org/2000/svg","defs");
			this.$draw.appendChild(defs);
			defs.appendChild(GooFlow.prototype._getSvgMarker("arrow1",GooFlow.color.line));
			defs.appendChild(GooFlow.prototype._getSvgMarker("arrow2",GooFlow.color.mark));
			defs.appendChild(GooFlow.prototype._getSvgMarker("arrow3",GooFlow.color.mark));
		}
		else{
			this.$draw = document.createElement("v:group");
			this.$draw.coordsize = width+","+height;
			this.$workArea.prepend("<div class='GooFlow_work_vml' style='position:relative;width:"+width+"px;height:"+height+"px'></div>");
			this.$workArea.children("div")[0].insertBefore(this.$draw,null);
		}
		this.$draw.id = id;
		this.$draw.style.width = width + "px";
		this.$draw.style.height = height + "px";
	
		//绑定连线的点击选中以及双击编辑事件
		var tmpClk=null;
		if(GooFlow.prototype.useSVG!=="")  tmpClk="g";
		else  tmpClk="PolyLine";
		//绑定选中事件
		$(this.$draw).on("click",tmpClk,{inthis:this},function(e){
			e.data.inthis.focusItem(this.id,true);
		});
		if(!this.$editable)	return;

        //绑定右键事件
        $(this.$draw).on("contextmenu",tmpClk,{inthis:this},function(e){
        	var This=e.data.inthis;
            if(typeof This.onItemRightClick==='function' && This.onItemRightClick(this.id,"line")===false){
                window.event? window.event.returnValue=false : e.preventDefault();
                return false;
            }
        });
		$(this.$draw).on("dblclick",tmpClk,{inthis:this},function(e){
			var This=e.data.inthis;
            if(typeof This.onItemDbClick==='function' && This.onItemDbClick(this.id,"line")===false)	return;
			var oldTxt,x,y,from,to;
			if(GooFlow.prototype.useSVG!==""){
				oldTxt=this.childNodes[2].textContent;
				from=this.getAttribute("from").split(",");
				to=this.getAttribute("to").split(",");
			}else{
				oldTxt=this.childNodes[1].innerHTML;
				var n=this.getAttribute("fromTo").split(",");
				from=[n[0],n[1]];
				to=[n[2],n[3]];
			}
			if(This.$lineData[this.id].type==="lr"){
				from[0]=This.$lineData[this.id].M*This.$scale;
				to[0]=from[0];
			}
			else if(This.$lineData[this.id].type==="tb"){
				from[1]=This.$lineData[this.id].M*This.$scale;
				to[1]=from[1];
			}
			x=(parseInt(from[0],10)+parseInt(to[0],10))/2-64;
			y=(parseInt(from[1],10)+parseInt(to[1],10))/2-18;
			var t=This.t;//t=_elCsys(This.$workArea[0]);
			This.$textArea.val(oldTxt).css({display:"block",width:130,height:26,
				left:t.left+x-This.$workArea[0].parentNode.scrollLeft,
				top:t.top+y-This.$workArea[0].parentNode.scrollTop}).data("id",This.$focus).focus();
			This.$workArea.parent().one("mousedown",function(e){
				if(e.button===2)return false;
				This.setName(This.$textArea.data("id"),This.$textArea.val(),"line");
				This.$textArea.val("").removeData("id").hide();
			});
		});
	},
	//初始化区域块（泳道）层
	_initGroup:function(width,height){
		this.$group=$("<div class='GooFlow_work_group' style='width:"+width+"px;height:"+height+"px'></div>");//存放背景区域的容器
		this.$workArea.prepend(this.$group);
		if(!this.$editable)	return;

        //绑定右键事件
        this.$group.on("contextmenu",".GooFlow_area",{inthis:this},function(e){
			var This=e.data.inthis;
            if(typeof This.onItemRightClick==='function' && This.onItemRightClick(this.id,"area")===false){
                window.event? window.event.returnValue=false : e.preventDefault();
                return false;
            }
        });
		//区域划分框操作区的事件绑定
		this.$group.on("mousedown",{inthis:this},function(e){//绑定RESIZE功能以及移动功能
			if(e.button===2)return false;
			var This=e.data.inthis;
			if(This.$nowType!=="group")	return;
			if(!e)e=window.event;
			var cursor=$(e.target).css("cursor");
			var id=e.target.parentNode;
			switch(cursor){
				case "nw-resize":id=id.parentNode;break;
				case "w-resize":id=id.parentNode;break;
				case "n-resize":id=id.parentNode;break;
				case "move":break;
				default:return;
			}
			id=id.id;

			var ev=_mouseP(e),t=This.t;//t=_elCsys(This.$workArea[0]);

			var X,Y,vX,vY;
			X=ev.x-t.left+This.$workArea[0].parentNode.scrollLeft;
			Y=ev.y-t.top+This.$workArea[0].parentNode.scrollTop;
			if (cursor !== "move") {
				This.$ghost.css({
					display: "block",
					width: This.$areaData[id].width * This.$scale + "px",
					height: This.$areaData[id].height * This.$scale + "px",
					top: This.$areaData[id].top * This.$scale + t.top - This.$workArea[0].parentNode.scrollTop + "px",
					left: This.$areaData[id].left * This.$scale + t.left - This.$workArea[0].parentNode.scrollLeft + "px",
					cursor: cursor
				});
				vX = (This.$areaData[id].left * This.$scale + This.$areaData[id].width * This.$scale) - X;
				vY = (This.$areaData[id].top * This.$scale + This.$areaData[id].height * This.$scale) - Y;
			}
			else {
				vX = X - This.$areaData[id].left * This.$scale;
				vY = Y - This.$areaData[id].top * This.$scale;
			}
			var isMove=false;
			This.$ghost.css("cursor",cursor);
			document.onmousemove=function(e){
				if(!e)e=window.event;
				var ev=_mouseP(e);
				if(cursor!=="move"){
					X=ev.x-t.left+This.$workArea[0].parentNode.scrollLeft-This.$areaData[id].left*This.$scale+vX;
					Y=ev.y-t.top+This.$workArea[0].parentNode.scrollTop-This.$areaData[id].top*This.$scale+vY;
					if(X<200*This.$scale)	X=200*This.$scale;
					if(Y<100*This.$scale)	Y=100*This.$scale;
					switch(cursor){
						case "nw-resize":This.$ghost.css({width:X+"px",height:Y+"px"});break;
						case "w-resize":This.$ghost.css({width:X+"px"});break;
						case "n-resize":This.$ghost.css({height:Y+"px"});break;
					}
				}
				else{
					if(This.$ghost.css("display")==="none"){
						This.$ghost.css({display:"block",
							width:This.$areaData[id].width*This.$scale+"px", height:This.$areaData[id].height*This.$scale+"px",
							top:This.$areaData[id].top*This.$scale+t.top-This.$workArea[0].parentNode.scrollTop+"px",
							left:This.$areaData[id].left*This.$scale+t.left-This.$workArea[0].parentNode.scrollLeft+"px",cursor:cursor});
					}
					X=ev.x-vX;Y=ev.y-vY;
					if(X<t.left-This.$workArea[0].parentNode.scrollLeft)
						X=t.left-This.$workArea[0].parentNode.scrollLeft;
					else if(X+This.$workArea[0].parentNode.scrollLeft+This.$areaData[id].width*This.$scale>t.left+This.$workArea.width())
						X=t.left+This.$workArea.width()-This.$workArea[0].parentNode.scrollLeft-This.$areaData[id].width*This.$scale;
					if(Y<t.top-This.$workArea[0].parentNode.scrollTop)
						Y=t.top-This.$workArea[0].parentNode.scrollTop;
					else if(Y+This.$workArea[0].parentNode.scrollTop+This.$areaData[id].height*This.$scale>t.top+This.$workArea.height())
						Y=t.top+This.$workArea.height()-This.$workArea[0].parentNode.scrollTop-This.$areaData[id].height*This.$scale;
					This.$ghost.css({left:X+"px",top:Y+"px"});
				}
				isMove=true;
			};
			document.onmouseup=function(){
				This.$ghost.empty().hide();
				document.onmousemove=null;
				document.onmouseup=null;
				if(!isMove)return;
				if(cursor!=="move")
					This.resizeArea(id,This.$ghost.outerWidth()/This.$scale,This.$ghost.outerHeight()/This.$scale);
				else
					This.moveArea(id,(X+This.$workArea[0].parentNode.scrollLeft-t.left)/This.$scale, (Y+This.$workArea[0].parentNode.scrollTop-t.top)/This.$scale);
				return false;
			}
		});
		//绑定修改文字说明功能
		this.$group.on("dblclick",{inthis:this},function(e){
			var This=e.data.inthis;
			if(This.$nowType!=="group")	return;
			if(!e)e=window.event;
			if(e.target.tagName!=="LABEL")	return false;
			var p=e.target.parentNode;
			if(typeof This.onItemDbClick==='function' && This.onItemDbClick(p.id,"area")===false)	return;

			var oldTxt=e.target.innerHTML;
			var x=parseInt(p.style.left,10)+18,y=parseInt(p.style.top,10)+1;
			var t=This.t;//t=_elCsys(This.$workArea[0]);
			This.$textArea.val(oldTxt).css({display:"block",width:130,height:26,
				left:t.left+x-This.$workArea[0].parentNode.scrollLeft,
				top:t.top+y-This.$workArea[0].parentNode.scrollTop}).data("id",p.id).focus();
			This.$workArea.parent().one("mouseup",function(e){
				if(e.button===2)return false;
				if(This.$textArea.css("display")==="block"){
					This.setName(This.$textArea.data("id"),This.$textArea.val(),"area");
					This.$textArea.val("").removeData("id").hide();
				}
				return false;
			});
			return false;
		});
		//绑定点击事件
		this.$group.mouseup({inthis:this},function(e){
			var This=e.data.inthis;
			if(This.$textArea.css("display")==="block"){
				This.setName(This.$textArea.data("id"),This.$textArea.val(),"area");
				This.$textArea.val("").removeData("id").hide();
				return false;
			}

			if(This.$nowType!=="group")	return;
			if(!e)e=window.event;
			switch($(e.target).attr("class")){
				case "rs_close":	This.delArea(e.target.parentNode.parentNode.id);return false;//删除该分组区域
				case "bg":	return;
			}
			switch(e.target.tagName){
				case "LABEL":	return false;
				case "I"://绑定变色功能
					var id=e.target.parentNode.id;
					switch(This.$areaData[id].color){
						case "red":	This.setAreaColor(id,"yellow");break;
						case "yellow":	This.setAreaColor(id,"blue");break;
						case "blue":	This.setAreaColor(id,"green");break;
						case "green":	This.setAreaColor(id,"red");break;
					}
					return false;
			}
			if(e.data.inthis.$ghost.css("display")==="none"){
				var X,Y;
				var ev=_mouseP(e),t=_elCsys(this);
				X=ev.x-t.left+this.parentNode.parentNode.scrollLeft;
				Y=ev.y-t.top+this.parentNode.parentNode.scrollTop;
				var color=["red","yellow","blue","green"];
				e.data.inthis.addArea(new Date().getTime(),
					{name:"area_"+e.data.inthis.$max,left:X/This.$scale,top:Y/This.$scale,color:color[e.data.inthis.$max%4],width:200,height:100}
				);
				e.data.inthis.$max++;
				return false;
			}
		});
	},
	//初始化节点绘制层
	_initWorkForNode:function(){
		//绑定点击事件
		this.$workArea.on("click",".GooFlow_item",{inthis:this},function(e){
			e.data.inthis.focusItem(this.id,true);
			$(this).removeClass("item_mark");
		});
		//绑定右键事件
		this.$workArea.on("contextmenu",".GooFlow_item",{inthis:this},function(e){
			var This=e.data.inthis;
			if(typeof This.onItemRightClick==='function' && This.onItemRightClick(this.id,"node")===false){
				window.event? window.event.returnValue=false : e.preventDefault();
				return false;
			}
		});

		//绑定双击功能
		var tmpDbClickFunc=function(This){
			This.$workArea.parent().one("mousedown",function(e){
				if(e.button===2)return false;
				This.setName(This.$textArea.data("id"),This.$textArea.val(),"node");
				This.$textArea.val("").removeData("id").hide();
			});
		};
		this.$workArea.on("dblclick",".ico",{inthis:this},function(e){
			var id=$(this).parents(".GooFlow_item").attr("id");
			var This=e.data.inthis;
			if(typeof This.onItemDbClick==='function' && This.onItemDbClick(id,"node")===false)	return false;
		});
		//绑定双击(包括双击编辑)事件
		this.$workArea.on("dblclick",".GooFlow_item > .span",{inthis:this},function(e){
			var id=this.parentNode.id;
			var This=e.data.inthis;
			if(typeof This.onItemDbClick==='function' && This.onItemDbClick(id,"node")===false)	return false;
			if(!This.$editable)	return;
			var oldTxt=this.innerHTML;
			var t=This.t;//t=_elCsys(This.$workArea[0]);
			This.$textArea.val(oldTxt).css({display:"block",height:$(this).height()+6,width:100,
				left:t.left+This.$nodeData[id].left*This.$scale-This.$workArea[0].parentNode.scrollLeft-26,
				top:t.top+This.$nodeData[id].top*This.$scale-This.$workArea[0].parentNode.scrollTop+26})
			.data("id",This.$focus).focus();
			tmpDbClickFunc(This);
		});
		this.$workArea.on("dblclick",".ico + td",{inthis:this},function(e){
			var id=$(this).parents(".GooFlow_item").attr("id");
			var This=e.data.inthis;
			if(typeof This.onItemDbClick==='function' && This.onItemDbClick(id,"node")===false)	return false;
			if(!This.$editable)	return;
			var oldTxt=this.childNodes[0].innerHTML;
			var t=This.t;//t=_elCsys(This.$workArea[0]);
			This.$textArea.val(oldTxt).css({display:"block",width:$(this).width()+26,height:$(this).height()+6,
				left:t.left+26+This.$nodeData[id].left*This.$scale-This.$workArea[0].parentNode.scrollLeft,
				top:t.top+2+This.$nodeData[id].top*This.$scale-This.$workArea[0].parentNode.scrollTop})
			.data("id",This.$focus).focus();
			tmpDbClickFunc(This);
		});
		if(!this.$editable)	return;

		//以下是工作区为编辑模式时才绑定的事件
		//绑定用鼠标移动事件
		this.$workArea.on("mousedown",".ico",{inthis:this},function(e){
			if(!e)e=window.event;
			if(e.button===2)return false;
			var This=e.data.inthis;
			if(This.$nowType==="direct"||This.$nowType==="dashed")	return;
			var Dom=$(this).parents(".GooFlow_item");
			var id=Dom.attr("id");
			This.focusItem(id,true);

			var ev=_mouseP(e),t=This.t;//t=_elCsys(This.$workArea[0]);

			Dom.children("table").clone().prependTo(This.$ghost);
			var X,Y;
			X=ev.x-t.left+This.$workArea[0].parentNode.scrollLeft;
			Y=ev.y-t.top+This.$workArea[0].parentNode.scrollTop;
			var vX=X-This.$nodeData[id].left*This.$scale,vY=Y-This.$nodeData[id].top*This.$scale;
			var isMove=false;
			document.onmousemove=function(e){
				if(!e)e=window.event;
				var ev=_mouseP(e);
				if(X===ev.x-vX&&Y===ev.y-vY)	return false;
				X=ev.x-vX;Y=ev.y-vY;

				if(isMove&&This.$ghost.css("display")==="none"){
					This.$ghost.css({display:"block",
						width:This.$nodeData[id].width*This.$scale+"px", height:This.$nodeData[id].height*This.$scale+"px",
						top:This.$nodeData[id].top*This.$scale+t.top-This.$workArea[0].parentNode.scrollTop+"px",
						left:This.$nodeData[id].left*This.$scale+t.left-This.$workArea[0].parentNode.scrollLeft+"px",
						cursor:"move"
					});
				}

				if(X<t.left-This.$workArea[0].parentNode.scrollLeft)
					X=t.left-This.$workArea[0].parentNode.scrollLeft;
				else if(X+This.$workArea[0].parentNode.scrollLeft+This.$nodeData[id].width*This.$scale>t.left+This.$workArea.width())
					X=t.left+This.$workArea.width()-This.$workArea[0].parentNode.scrollLeft-This.$nodeData[id].width*This.$scale;
				if(Y<t.top-This.$workArea[0].parentNode.scrollTop)
					Y=t.top-This.$workArea[0].parentNode.scrollTop;
				else if(Y+This.$workArea[0].parentNode.scrollTop+This.$nodeData[id].height*This.$scale>t.top+This.$workArea.height())
					Y=t.top+This.$workArea.height()-This.$workArea[0].parentNode.scrollTop-This.$nodeData[id].height*This.$scale;
				This.$ghost.css({left:X+"px",top:Y+"px"});
				isMove=true;
			};
			document.onmouseup=function(){
				if(isMove)This.moveNode(id,(X+This.$workArea[0].parentNode.scrollLeft-t.left)/This.$scale,(Y+This.$workArea[0].parentNode.scrollTop-t.top)/This.$scale);
				This.$ghost.empty().hide();
				document.onmousemove=null;
				document.onmouseup=null;
			}
		});
		//绑定鼠标覆盖/移出事件
		this.$workArea.on("mouseenter",".GooFlow_item",{inthis:this},function(e){
			if((e.data.inthis.$nowType!=="direct"&&e.data.inthis.$nowType!=="dashed")&&!document.getElementById("GooFlow_tmp_line"))	return;
			$(this).addClass("item_mark").addClass("crosshair").css("border-color",GooFlow.color.mark);
		});
		this.$workArea.on("mouseleave",".GooFlow_item",{inthis:this},function(e){
			if((e.data.inthis.$nowType!=="direct"&&e.data.inthis.$nowType!=="dashed")&&!document.getElementById("GooFlow_tmp_line"))	return;
			$(this).removeClass("item_mark").removeClass("crosshair");
			if(this.id===e.data.inthis.$focus){
				$(this).css("border-color",GooFlow.color.line);
			}else{
				$(this).css("border-color",GooFlow.color.node);
			}
		});
		//绑定连线时确定初始点
		this.$workArea.on("mousedown",".GooFlow_item",{inthis:this},function(e){
			if(e.button===2)return false;
			var This=e.data.inthis;
			if(This.$nowType!=="direct"&&This.$nowType!=="dashed")	return;
			var ev=_mouseP(e),t=_elCsys(This.$workArea[0]);
			var X,Y;
			X=ev.x-t.left+This.$workArea[0].parentNode.scrollLeft;
			Y=ev.y-t.top+This.$workArea[0].parentNode.scrollTop;
			This.$workArea.data("lineStart",{"x":X,"y":Y,"id":this.id}).css("cursor","crosshair");
			var line=GooFlow.prototype.drawLine("GooFlow_tmp_line",[X,Y],[X,Y],true,true,1);
			This.$draw.appendChild(line);
		});
		//绑定连线时确定结束点
		this.$workArea.on("mouseup",".GooFlow_item",{inthis:this},function(e){
			var This=e.data.inthis;
			if((This.$nowType!=="direct"&&This.$nowType!=="dashed")&&!This.$mpTo.data("p"))	return;
			var lineStart=This.$workArea.data("lineStart");
			var lineEnd=This.$workArea.data("lineEnd");
			if(lineStart&&!This.$mpTo.data("p")){
				var tmp={from:lineStart.id,to:this.id,name:""};
				if(This.$nowType==="dashed"){
					tmp.dash=true;
				}
				This.addLine(new Date().getTime().toString(),tmp);
				This.$max++;
			}
			else{
				if(lineStart){
					This.moveLinePoints(This.$focus,lineStart.id,this.id);
				}else if(lineEnd){
					This.moveLinePoints(This.$focus,this.id,lineEnd.id);
				}
				if(!This.$nodeData[this.id].marked){
					$(this).removeClass("item_mark");
					if(this.id!==This.$focus){
						$(this).css("border-color",GooFlow.color.node);
					}
					else{
						$(this).css("border-color",GooFlow.color.line);
					}
				}
			}
		});

		//绑定结点的删除功能
		this.$workArea.on("click",".rs_close",{inthis:this},function(e){
			if(!e)e=window.event;
			e.data.inthis.delNode(e.data.inthis.$focus);
			return false;
		});
		//绑定结点的RESIZE功能
		this.$workArea.on("mousedown",".GooFlow_item > div > div[class!=rs_close]",{inthis:this},function(e){
			if(!e)e=window.event;
			if(e.button===2)return false;
			var cursor=$(this).css("cursor");
			if(cursor==="pointer"){return;}
			var This=e.data.inthis;
			var id=This.$focus;
			This.switchToolBtn("cursor");
			e.cancelBubble = true;
			e.stopPropagation();

			var ev=_mouseP(e),t=This.t;//t=_elCsys(This.$workArea[0]);
			This.$ghost.css({display:"block",
				width:This.$nodeData[id].width*This.$scale+"px", height:This.$nodeData[id].height*This.$scale+"px",
				top:This.$nodeData[id].top*This.$scale+t.top-This.$workArea[0].parentNode.scrollTop+"px",
				left:This.$nodeData[id].left*This.$scale+t.left-This.$workArea[0].parentNode.scrollLeft+"px",
				cursor:cursor
			});
			var X,Y;
			X=ev.x-t.left+This.$workArea[0].parentNode.scrollLeft;
			Y=ev.y-t.top+This.$workArea[0].parentNode.scrollTop;
			var vX=(This.$nodeData[id].left*This.$scale+This.$nodeData[id].width*This.$scale)-X;
			var vY=(This.$nodeData[id].top*This.$scale+This.$nodeData[id].height*This.$scale)-Y;
			var isMove=false;
			This.$ghost.css("cursor",cursor);
			document.onmousemove=function(e){
				if(!e)e=window.event;
				var ev=_mouseP(e);
				X=ev.x-t.left+This.$workArea[0].parentNode.scrollLeft-This.$nodeData[id].left*This.$scale+vX;
				Y=ev.y-t.top+This.$workArea[0].parentNode.scrollTop-This.$nodeData[id].top*This.$scale+vY;
				if(X<104*This.$scale)	X=104*This.$scale;
				if(Y<28*This.$scale)	Y=28*This.$scale;
				isMove=true;
				switch(cursor){
					case "nw-resize":This.$ghost.css({width:X+"px",height:Y+"px"});break;
					case "w-resize":This.$ghost.css({width:X+"px"});break;
					case "n-resize":This.$ghost.css({height:Y+"px"});break;
				}
			};
			document.onmouseup=function(){
				document.onmousemove=null;
				document.onmouseup=null;
				This.$ghost.hide();
				if(!isMove)return;
				//if(!e)e=window.event;
				This.resizeNode(id,This.$ghost.outerWidth()/This.$scale,This.$ghost.outerHeight()/This.$scale);
			};
		});
	},
	//加入手动扩展编辑区功能，一次扩展200px
	_initExpendFunc:function(){
		var titleExendRight=GooFlow.remarks.extendRight? ' title="'+GooFlow.remarks.extendRight+'"':'';
        var titleExendBottom=GooFlow.remarks.extendBottom? ' title="'+GooFlow.remarks.extendBottom+'"':'';
		this.$workArea.append('<div class="Gooflow_extend_right"'+titleExendRight+'></div><div class="Gooflow_extend_bottom"'+titleExendBottom+'></div>');
	    this.$workArea.children(".Gooflow_extend_right").on("click",{inthis:this},function(e){
			var This=e.data.inthis;
			var w = This.$workArea.width()+This.$workExtendStep;
			var h = This.$workArea.height();
			This.$workArea.css({width:w+"px"});
			if(GooFlow.prototype.useSVG===""){
				This.$draw.coordsize = w+","+h;
			}
			This.$draw.style.width = w + "px";
			if(This.$group!=null){
				This.$group.css({width:w+"px"});
			}
			var parentDiv = This.$workArea.parent()[0];
			parentDiv.scrollLeft = parentDiv.scrollWidth;
            This.$workArea.parent().css("overflow","scroll");
			return false;
	    });
	    this.$workArea.children(".Gooflow_extend_bottom").on("click",{inthis:this},function(e){
			var This=e.data.inthis;
			var w = This.$workArea.width();
			var h = This.$workArea.height()+This.$workExtendStep;
			This.$workArea.css({height:h+"px"});
			if(GooFlow.prototype.useSVG===""){
				This.$draw.coordsize = w+","+h;
			}
			This.$draw.style.height = h + "px";
			if(This.$group!=null){
				This.$group.css({height:h+"px"});
			}
			var parentDiv = This.$workArea.parent()[0];
			parentDiv.scrollTop = parentDiv.scrollHeight;
            This.$workArea.parent().css("overflow","scroll");
			return false;
	    });
	},
	//初始化用来改变连线的连接端点的两个小方块的操作事件
	_initLinePointsChg:function(){
		this.$mpFrom.on("mousedown",{inthis:this},function(e){
			var This=e.data.inthis;
			This.switchToolBtn("cursor");
			var ps=This.$mpFrom.data("p").split(",");
			var pe=This.$mpTo.data("p").split(",");
			$(this).hide();
			This.$workArea.data("lineEnd",{"x":pe[0],"y":pe[1],"id":This.$lineData[This.$lineOper.data("tid")].to}).css("cursor","crosshair");
			var line=GooFlow.prototype.drawLine("GooFlow_tmp_line",[ps[0],ps[1]],[pe[0],pe[1]],true,true,1);
			This.$draw.appendChild(line);
			return false;
	    });
		this.$mpTo.on("mousedown",{inthis:this},function(e){
			var This=e.data.inthis;
			This.switchToolBtn("cursor");
			var ps=This.$mpFrom.data("p").split(",");
			var pe=This.$mpTo.data("p").split(",");
			$(this).hide();
			This.$workArea.data("lineStart",{"x":ps[0],"y":ps[1],"id":This.$lineData[This.$lineOper.data("tid")].from}).css("cursor","crosshair");
			var line=GooFlow.prototype.drawLine("GooFlow_tmp_line",[ps[0],ps[1]],[pe[0],pe[1]],true,true,1);
			This.$draw.appendChild(line);
			return false;
	    });
	},
	//初始化设计器的编辑功能
	_initEditFunc:function(useOperStack){
		//划线或改线时用的绑定
		this.$workArea.mousemove({inthis:this},function(e){
			var This=e.data.inthis;
			if((This.$nowType!=="direct"&&This.$nowType!=="dashed")&&!This.$mpTo.data("p"))	return;
			var lineStart=$(this).data("lineStart");
			var lineEnd=$(this).data("lineEnd");
			if(!lineStart&&!lineEnd)return;

			var ev=_mouseP(e),t=_elCsys(this);
			var X,Y;
			X=ev.x-t.left+this.parentNode.scrollLeft;
			Y=ev.y-t.top+this.parentNode.scrollTop;
			var line=document.getElementById("GooFlow_tmp_line");
			if(lineStart){
				if(GooFlow.prototype.useSVG!==""){
					line.childNodes[0].setAttribute("d","M "+lineStart.x+" "+lineStart.y+" L "+X+" "+Y);
					line.childNodes[1].setAttribute("d","M "+lineStart.x+" "+lineStart.y+" L "+X+" "+Y);
					if(line.childNodes[1].getAttribute("marker-end")==='url("#arrow2")')
						line.childNodes[1].setAttribute("marker-end","url(#arrow3)");
					else	line.childNodes[1].setAttribute("marker-end","url(#arrow2)");
				}
				else	line.points.value=lineStart.x+","+lineStart.y+" "+X+","+Y;
			}else if(lineEnd){
				if(GooFlow.prototype.useSVG!==""){
					line.childNodes[0].setAttribute("d","M "+X+" "+Y+" L "+lineEnd.x+" "+lineEnd.y);
					line.childNodes[1].setAttribute("d","M "+X+" "+Y+" L "+lineEnd.x+" "+lineEnd.y);
					if(line.childNodes[1].getAttribute("marker-end")==='url("#arrow2")')
						line.childNodes[1].setAttribute("marker-end","url(#arrow3)");
					else	line.childNodes[1].setAttribute("marker-end","url(#arrow2)");
				}
				else	line.points.value=X+","+Y+" "+lineEnd.x+","+lineEnd.y;
			}
		});
		this.$workArea.mouseup({inthis:this},function(e){
			var This=e.data.inthis;
			if((This.$nowType!=="direct"&&This.$nowType!=="dashed")&&!This.$mpTo.data("p"))	return;
			var tmp=document.getElementById("GooFlow_tmp_line");
			if(tmp){
				$(this).css("cursor","auto").removeData("lineStart").removeData("lineEnd");
				This.$mpTo.hide().removeData("p");
				This.$mpFrom.hide().removeData("p");
				This.$draw.removeChild(tmp);
				This.focusItem(This.$focus,false);
			}else{
				This.$lineOper.removeData("tid");
			}
		});

		this.$textArea=$("<textarea></textarea>");
		this.$bgDiv.append(this.$textArea);
		this.$lineMove=$('<div class="GooFlow_linemove" style="display:none"></div>');//操作折线时的移动框
		this.$workArea.append(this.$lineMove);
		this.$lineMove.on("mousedown",{inthis:this},function(e){
			if(e.button===2)return false;
			var lm=$(this);
			lm.css({"background-color":"#333"});
			var This=e.data.inthis;
			var ev=_mouseP(e),t=_elCsys(This.$workArea[0]);
			var X,Y;
			X=ev.x-t.left+This.$workArea[0].parentNode.scrollLeft;
			Y=ev.y-t.top+This.$workArea[0].parentNode.scrollTop;
			var p=This.$lineMove.position();
			var vX=X-p.left,vY=Y-p.top;
			var isMove=false;
			document.onmousemove=function(e){
				if(!e)e=window.event;
				var ev=_mouseP(e);
				//var ps=This.$lineMove.position();
				X=ev.x-t.left+This.$workArea[0].parentNode.scrollLeft;
				Y=ev.y-t.top+This.$workArea[0].parentNode.scrollTop;
				if(This.$lineMove.data("type")==="lr"){
					X=X-vX;
					if(X<0)	X=0;
					else if(X>This.$workArea.width())
						X=This.$workArea.width();
					This.$lineMove.css({left:X+"px"});
				}
				else if(This.$lineMove.data("type")==="tb"){
					Y=Y-vY;
					if(Y<0)	Y=0;
					else if(Y>This.$workArea.height())
						Y=This.$workArea.height();
					This.$lineMove.css({top:Y+"px"});
				}
				isMove=true;
			};
			document.onmouseup=function(){
				if(isMove){
					var p=This.$lineMove.position();
					if(This.$lineMove.data("type")==="lr")
						This.setLineM(This.$lineMove.data("tid"),(p.left+3)/This.$scale);
					else if(This.$lineMove.data("type")==="tb")
						This.setLineM(This.$lineMove.data("tid"),(p.top+3)/This.$scale);
				}
				This.$lineMove.css({"background-color":"transparent"});
				if(This.$focus===This.$lineMove.data("tid")){
					This.focusItem(This.$lineMove.data("tid"));
				}
				document.onmousemove=null;
				document.onmouseup=null;
			};
		});

		//选定一条转换线后出现的浮动操作栏，有改变线的样式和删除线等按钮。
		this.$lineOper=$("<div class='GooFlow_line_oper' style='display:none'><i class='b_l1'></i><i class='b_l2'></i><i class='b_l3'></i><i class='b_x'></i></div>");//选定线时显示的操作框
		this.$workArea.parent().append(this.$lineOper);
		this.$lineOper.on("click",{inthis:this},function(e){
			if(!e)e=window.event;
			if(e.target.tagName!=="I")	return;
			var This=e.data.inthis;
			var id=$(this).data("tid");
			switch($(e.target).attr("class")){
				case "b_x":
					This.delLine(id);
					this.style.display="none";break;
				case "b_l1":
					This.setLineType(id,"lr");break;
				case "b_l2":
					This.setLineType(id,"tb");break;
				case "b_l3":
					This.setLineType(id,"sl");break;
			}
		});
		//新增移动线两个端点至新的结点功能移动功能，这里要提供移动用的DOM
		this.$mpFrom=$("<div class='GooFlow_line_mp' style='display:none'></div>");
		this.$mpTo=$("<div class='GooFlow_line_mp' style='display:none'></div>");
		this.$workArea.append(this.$mpFrom).append(this.$mpTo);
		this._initLinePointsChg();

		if(useOperStack){//如果要使用堆栈记录操作并提供“撤销/重做”的功能,只在编辑状态下有效
			this.$undoStack=[];
			this.$redoStack=[];
			this.$isUndo=0;
			///////////////以下是构造撤销操作/重做操作的方法
			//检查撤销栈与重做栈处理好头部按钮的显示
			this._checkStack=function(type){
				if(this.$head===null)	return;
				if(!type || type==='undo'){
					if(this.$undoStack.length===0){
						this.$head.find(".ico_undo").parent().addClass("a_disabled");
					}else{
						this.$head.find(".ico_undo").parent().removeClass("a_disabled");
					}
				}
				if(!type || type==='redo'){
					if(this.$redoStack.length===0){
						this.$head.find(".ico_redo").parent().addClass("a_disabled");
					}else{
						this.$head.find(".ico_redo").parent().removeClass("a_disabled");
					}
				}
			};
			//为了节省浏览器内存空间,undo/redo中的操作缓存栈,最多只可放50步操作;超过50步时,将自动删掉最旧的一个缓存
			this.pushOper=function(funcName,paras){
				if(this.$isUndo===1){
					this.$redoStack.push([funcName,paras]);
					this.$isUndo=0;
					if(this.$redoStack.length>50)	this.$redoStack.shift();
					this._checkStack('redo');
				}else{
					this.$undoStack.push([funcName,paras]);
					if(this.$undoStack.length>50)	this.$undoStack.shift();
					if(this.$isUndo===0){
						this.$redoStack.splice(0,this.$redoStack.length);
					}
					this.$isUndo=0;
					this._checkStack();
				}
			};
			//将外部的方法加入到GooFlow对象的事务操作堆栈中,在过后的undo/redo操作中可以进行控制，一般用于对流程图以外的附加信息进行编辑的事务撤销/重做控制；
			//传参func为要执行方法对象,jsonPara为外部方法仅有的一个面向字面的JSON传参,由JSON对象带入所有要传的信息；
			//提示:为了让外部方法能够被UNDO/REDO,需要在编写这些外部方法实现时,加入对该方法执行后效果回退的另一个执行方法的pushExternalOper
			this.pushExternalOper=function(func,jsonPara){
				this.pushOper("externalFunc",[func,jsonPara]);
			};
			//撤销上一步操作
			this.undo=function(){
				if(this.$undoStack.length===0)	return;
				this.blurItem();
				var tmp=this.$undoStack.pop();
				this.$isUndo=1;
				if(tmp[0]==="externalFunc"){
					tmp[1][0](tmp[1][1]);
				}
				else{
					//传参的数量,最小0个最多12个.
					this[tmp[0]](tmp[1][0],tmp[1][1],tmp[1][2],tmp[1][3],tmp[1][4],tmp[1][5],
						tmp[1][6],tmp[1][7],tmp[1][8],tmp[1][9],tmp[1][10],tmp[1][11]);
				}
				this._checkStack();
			};
			//重做最近一次被撤销的操作
			this.redo=function(){
				if(this.$redoStack.length===0)	return;
				this.blurItem();
				var tmp=this.$redoStack.pop();
				this.$isUndo=2;
				if(tmp[0]==="externalFunc"){
					tmp[1][0](tmp[1][1]);
				}
				else{
					//传参的数量,最小0个最多12个.
					this[tmp[0]](tmp[1][0],tmp[1][1],tmp[1][2],tmp[1][3],tmp[1][4],tmp[1][5],
						tmp[1][6],tmp[1][7],tmp[1][8],tmp[1][9],tmp[1][10],tmp[1][11]);
				}
				this._checkStack();
			};
		}
		$(document).keydown({inthis:this},function(e){
			//绑定键盘操作
			var This=e.data.inthis;
			if(This.$focus==="")return;
			switch(e.keyCode){
				case 46://删除
					This.delNode(This.$focus,true);
					This.delLine(This.$focus);
					break;
			}
		});
	},

	//对头部栏自定义按钮的事件绑定，用户可用来对另行加入的头部按钮自定义功能
	//传参为json结构，key为按钮的类型名(需另行写好'ico_'+按钮类型名的样式类定义)，value为相关事件的方法实现定义
	bindHeadBtnEvent:function(funcs){
		if(this.$head!=null)
		this.$headBtnEvents=funcs;
	},
	//每一种类型结点及其按钮的说明文字
	setNodeRemarks:function(remark){
    if(this.$tool==null)  return;
		this.$tool.children("a").each(function(){
			try{
				this.title=remark[$(this).attr("id").split("btn_")[1]];
            }catch(e){}
		});
	},
    //(当有顶部工具栏按钮组时)设定顶部工具栏按钮的说明文字
    setHeadToolsRemarks:function(remark){
        if(this.$head==null)  return;
        this.$head.children("a").each(function(){
            try{
            	this.title=remark[$(this).children("i").attr("class").split('ico_')[1]];
            }catch(e){}
        });
    },
	//设定扩展工作区宽高的长条按钮的说明文字
	setExtWorkRemarks:function(remark){
		this.$workArea.children(".Gooflow_extend_right").attr("title",remark.extendRight);
		this.$workArea.children(".Gooflow_extend_bottom").attr("title",remark.extendBottom);
	},

	//切换左边工具栏按钮,传参TYPE表示切换成哪种类型的按钮
	switchToolBtn:function(type){
		if(this.$tool!=null){
			this.$tool.children("#"+this.$id+"_btn_"+this.$nowType.split(" ")[0]).attr("class","GooFlow_tool_btn");
		}
		if(this.$nowType==="group"){
			this.$workArea.prepend(this.$group);
			for(var k in this.$areaDom)	this.$areaDom[k].addClass("lock").children("div:eq(1)").css("display","none");
		}
		this.$nowType=type;
		if(this.$tool!=null){
			this.$tool.children("#"+this.$id+"_btn_"+type.split(" ")[0]).attr("class","GooFlow_tool_btndown");
		}
		if(this.$nowType==="group"){
			this.blurItem();
			this.$workArea.append(this.$group);
			for(var key in this.$areaDom)	this.$areaDom[key].removeClass("lock").children("div:eq(1)").css("display","");
		}else if(this.$nowType==="direct"||this.$nowType==="dashed"){
            this.blurItem();
		}
		if(this.$textArea&&this.$textArea.css("display")==="none")	this.$textArea.removeData("id").val("").hide();
	},

	//获取结点/连线/分组区域的详细信息
	getItemInfo:function(id,type){
		switch(type){
			case "node":	return this.$nodeData[id]||null;
			case "line":	return this.$lineData[id]||null;
			case "area":	return this.$areaData[id]||null;
		}
	},
	//取消所有结点/连线被选定的状态
	blurItem:function(){
		if(this.$focus!==""){
			var jq=$("#"+this.$focus);
			if(jq.prop("tagName")==="DIV"){
				if(typeof this.onItemBlur==='function' && this.onItemBlur(this.$focus,"node")===false)	return false;
				jq.removeClass("item_focus").children("div:eq(0)").css("display","none");
				if(this.$nodeData[this.$focus].marked){
					jq.addClass("item_mark").css("border-color",GooFlow.color.mark);
				}
			}
			else{
				if(typeof this.onItemBlur==='function' && this.onItemBlur(this.$focus,"line")===false)	return false;
				if(GooFlow.prototype.useSVG!==""){
					if(!this.$lineData[this.$focus].marked){
						jq[0].childNodes[1].setAttribute("stroke",GooFlow.color.line);
						jq[0].childNodes[1].setAttribute("marker-end","url(#arrow1)");
					}
				}
				else{
					if(!this.$lineData[this.$focus].marked){
                        jq[0].strokeColor=GooFlow.color.line;
					}
				}
				if(this.$editable){
                    	this.$lineMove.hide().removeData("type").removeData("tid");
						this.$lineOper.hide().removeData("tid");
						this.$mpFrom.hide().removeData("p");
						this.$mpTo.hide().removeData("p");
				}
			}
		}
		this.$focus="";
		return true;
	},
	//选定某个结点/转换线 bool:TRUE决定了要触发选中事件，FALSE则不触发选中事件，多用在程序内部调用。
	focusItem:function(id,bool){
		var jq=$("#"+id);
		if(jq.length===0)	return;
		if(!this.blurItem())	return;//先执行"取消选中",如果返回FLASE,则也会阻止选定事件继续进行.
		if(bool&& typeof this.onItemFocus==='function' && this.onItemFocus(id,"node")===false)	return;
        this.$focus=id;
		if(jq.prop("tagName")==="DIV"){
			jq.addClass("item_focus");
			if(GooFlow.color.line){
        		jq.css("border-color",GooFlow.color.line);
			}
			if(this.$editable)jq.children("div:eq(0)").css("display","block");
			//this.$workArea.append(jq);
		}else{//如果是连接线
			if(GooFlow.prototype.useSVG!==""){
				jq[0].childNodes[1].setAttribute("stroke",GooFlow.color.mark);
				jq[0].childNodes[1].setAttribute("marker-end","url(#arrow2)");
			}
			else{
                jq[0].strokeColor=GooFlow.color.mark;
			}
			if(!this.$editable)	return;
			var x,y,from,to,n;
			if(GooFlow.prototype.useSVG!==""){
				from=jq.attr("from").split(",");
				to=jq.attr("to").split(",");
				n=[from[0],from[1],to[0],to[1]];
			}else{
				n=jq[0].getAttribute("fromTo").split(",");
				from=[n[0],n[1]];
				to=[n[2],n[3]];
			}
			from[0]=parseInt(from[0],10);
			from[1]=parseInt(from[1],10);
			to[0]=parseInt(to[0],10);
			to[1]=parseInt(to[1],10);
			//var t=_elCsys(this.$workArea[0]);
			if(this.$lineData[id].type==="lr"){
				from[0]=this.$lineData[id].M*this.$scale;
				to[0]=from[0];

				this.$lineMove.css({
					width:"5px",height:(to[1]-from[1])*(to[1]>from[1]? 1:-1)+"px",
					left:from[0]-3+"px",
					top:(to[1]>from[1]? from[1]:to[1])+1+"px",
					cursor:"e-resize",display:"block"
				}).data({"type":"lr","tid":id});
			}
			else if(this.$lineData[id].type==="tb"){
				from[1]=this.$lineData[id].M*this.$scale;
				to[1]=from[1];
				this.$lineMove.css({
					width:(to[0]-from[0])*(to[0]>from[0]? 1:-1)+"px",height:"5px",
					left:(to[0]>from[0]? from[0]:to[0])+1+"px",
					top:from[1]-3+"px",
					cursor:"s-resize",display:"block"
				}).data({"type":"tb","tid":id});
			}
			x=(from[0]+to[0])/2-40;
			y=(from[1]+to[1])/2+4;
			this.$lineOper.css({display:"block",left:x+"px",top:y+"px"}).data("tid",id);
			if(this.$editable){
				this.$mpFrom.css({display:"block",left:n[0]-4+"px",top:n[1]-4+"px"}).data("p",n[0]+","+n[1]);
				this.$mpTo.css({display:"block",left:n[2]-4+"px",top:n[3]-4+"px"}).data("p",n[2]+","+n[3]);
			}
			this.$draw.appendChild(jq[0]);
		}

		this.switchToolBtn("cursor");
	},
	//传入一个节点的ID，判断在图中的哪个区域组(泳道)的范围内
	_node2Area:function(nodeId){
		if(this.$group===null)	return;
		var node=this.$nodeData[nodeId];
		var lane=false;
		for(var key in this.$areaData){
			var area = this.$areaData[key];
			if( node.left>=area.left&&node.left<area.left+area.width &&
				node.top>=area.top&&node.top<area.top+area.height
			){
				node.areaId=key;
				lane=true;
				break;
			}
		}
		if(!lane){	delete node.areaId;	} //不属于任何区域组(泳道)的情况
	},
	//增加一个流程结点,传参为一个JSON,有id,name,top,left,width,height,type(结点类型)等属性
	addNode: function (id, json) {
        if (json.id == undefined) {
            $.extend(json,{id:id});
        }
		if(typeof this.onItemAdd==='function' && this.onItemAdd(id,"node",json)===false)return;
		if(this.$undoStack&&this.$editable){
			this.pushOper("delNode",[id]);
		}
		var mark=json.marked? " item_mark":"";
		if(json.type.indexOf(" round")<0){
			if(!json.width||json.width<104)json.width=104;
			if(!json.height||json.height<26)json.height=26;
			if(!json.top||json.top<0)json.top=0;
			if(!json.left||json.left<0)json.left=0;

			this.$nodeDom[id]=$("<div class='GooFlow_item"+mark+"' id='"+id+"' style='top:"+json.top*this.$scale+"px;left:"+json.left*this.$scale+"px'><table cellspacing='1' style='width:"+(json.width*this.$scale-2)+"px;height:"+(json.height*this.$scale-2)+"px;'><tr><td class='ico'><i class='ico_"+json.type+"'></i></td><td><div>"+json.name+"</div></td></tr></table><div style='display:none'><div class='rs_bottom'></div><div class='rs_right'></div><div class='rs_rb'></div><div class='rs_close'></div></div></div>");
		}
		else{
			json.width=26;json.height=26;
			this.$nodeDom[id]=$("<div class='GooFlow_item item_round"+mark+"' id='"+id+"' style='top:"+json.top*this.$scale+"px;left:"+json.left*this.$scale+"px'><table cellspacing='0' style='width:"+(json.width*this.$scale-2)+"px;height:"+(json.height*this.$scale-2)+"px;'><tr><td class='ico'><i class='ico_"+json.type+"'></i></td></tr></table><div  style='display:none'><div class='rs_close'></div></div><div class='span'>"+json.name+"</div></div>");
		}
		if(GooFlow.color.node){
			if(json.type.indexOf(" mix")>-1){
				this.$nodeDom[id].css({"background-color":GooFlow.color.mix,"border-color":GooFlow.color.mix});
				if(GooFlow.color.mixFont){
					this.$nodeDom[id].find("td:eq(1)").css("color",GooFlow.color.mixFont);
					this.$nodeDom[id].find(".span").css("color",GooFlow.color.mixFont);
				}
			}else{
				this.$nodeDom[id].css({"background-color":GooFlow.color.node,"border-color":GooFlow.color.node});
			}
			if(mark&&GooFlow.color.mark){
				this.$nodeDom[id].css({"border-color":GooFlow.color.mark});
			}
		}
		if(json.type.indexOf(" mix")>-1){
			this.$nodeDom[id].addClass("item_mix");
		}

		var ua=navigator.userAgent.toLowerCase();
		if(ua.indexOf('msie')!==-1 && ua.indexOf('8.0')!==-1)
			this.$nodeDom[id].css("filter","progid:DXImageTransform.Microsoft.Shadow(color=#94AAC2,direction=135,strength=2)");
		this.$workArea.append(this.$nodeDom[id]);
		this.$nodeData[id]=json;
		++this.$nodeCount;
		if(this.$editable){
			this.$nodeData[id].alt=true;
			this._node2Area(id);
			if(this.$deletedItem[id])	delete this.$deletedItem[id];//在回退删除操作时,去掉该元素的删除记录
		}
	},
	//移动结点到一个新的位置
	moveNode:function(id,left,top){
		if(!this.$nodeData[id])	return;
		if(typeof this.onItemMove==='function' && this.onItemMove(id,"node",left,top)===false)	return;
		if(this.$undoStack){
			var paras=[id,this.$nodeData[id].left,this.$nodeData[id].top];
			this.pushOper("moveNode",paras);
		}
		if(left<0)	left=0;
		if(top<0)	top=0;
		$("#"+id).css({left:left*this.$scale+"px",top:top*this.$scale+"px"});
		this.$nodeData[id].left=left;
		this.$nodeData[id].top=top;
		//重画转换线
		this.resetLines(id,this.$nodeData[id]);
		if(this.$editable){
			this.$nodeData[id].alt=true;
			this._node2Area(id);
		}
	},
	//设置结点/连线/分组区域的文字信息
	setName:function(id,name,type, setInfo){
		var oldName;
		if (type === "node") {//如果是结点
		    this.$nodeData[id].setInfo = setInfo;
			if(!this.$nodeData[id])	return;
			if(this.$nodeData[id].name===name)	return;
			if(typeof this.onItemRename==='function' && this.onItemRename(id,name,"node")===false)	return;
			oldName=this.$nodeData[id].name;
			this.$nodeData[id].name=name;
			if(this.$nodeData[id].type.indexOf("round")>1){
				this.$nodeDom[id].children(".span").text(name);
			}
			else{
				this.$nodeDom[id].find("td:eq(1)").children("div").text(name);

				var width=this.$nodeDom[id].outerWidth();
				var height=this.$nodeDom[id].outerHeight();
				if(this.$nodeData[id].width!==width || this.$nodeData[id].height!==height){
					this.$nodeDom[id].children("table").css({width:width-2+"px",height:height-2+"px"});
					if(this.$undoStack){
						var para=[id,this.$nodeData[id].width,this.$nodeData[id].height];
						this.pushOper("resizeNode",para);
					}
					this.$nodeData[id].width=width;
					this.$nodeData[id].height=height;
				}
			}
			if(this.$editable){
				this.$nodeData[id].alt=true;
			}
			//重画转换线
			this.resetLines(id,this.$nodeData[id]);
		}
		else if (type === "line") {//如果是线
		    this.$lineData[id].setInfo = setInfo;
			if(!this.$lineData[id])	return;
			if(this.$lineData[id].name===name)	return;
			if(typeof this.onItemRename==='function' && this.onItemRename(id,name,"node")===false)	return;
			oldName=this.$lineData[id].name;
			this.$lineData[id].name=name;
			if(GooFlow.prototype.useSVG!==""){
				this.$lineDom[id].childNodes[2].textContent=name;
			}
			else{
				this.$lineDom[id].childNodes[1].innerHTML=name;
				var n=this.$lineDom[id].getAttribute("fromTo").split(",");
				var x;
				if(this.$lineData[id].type!=="lr"){
					x=(n[2]-n[0])/2;
				}
				else{
					var Min=n[2]>n[0]? n[0]:n[2];
					if(Min>this.$lineData[id].M) Min=this.$lineData[id].M;
					x=this.$lineData[id].M-Min;
				}
				if(x<0) x=x*-1;
				this.$lineDom[id].childNodes[1].style.left=x-this.$lineDom[id].childNodes[1].offsetWidth/2+4+"px";
			}
			if(this.$editable){
				this.$lineData[id].alt=true;
			}
		}
		else if(type==="area"){//如果是分组区域
			if(!this.$areaData[id])	return;
			if(this.$areaData[id].name===name)	return;
			if(typeof this.onItemRename==='function' && this.onItemRename(id,name,"node")===false)	return;
			oldName=this.$areaData[id].name;
			this.$areaData[id].name=name;
			this.$areaDom[id].children("label").text(name);
			if(this.$editable){
				this.$areaData[id].alt=true;
			}
		}
		if(this.$undoStack){
			var paras=[id,oldName,type];
			this.pushOper("setName",paras);
		}
	},
	//设置结点的尺寸,仅支持非开始/结束结点
	resizeNode:function(id,width,height){
		if(!this.$nodeData[id])	return;
		if(typeof this.onItemResize==='function' && this.onItemResize(id,"node",width,height)===false)	return;
		if(this.$nodeData[id].type==="start"||this.$nodeData[id].type==="end")return;
		if(this.$undoStack){
			var paras=[id,this.$nodeData[id].width,this.$nodeData[id].height];
			this.pushOper("resizeNode",paras);
		}

		this.$nodeDom[id].children("table").css({width:(width-2)*this.$scale+"px",height:(height-2)*this.$scale+"px"});
		//确保因内部文字太多而撑大时，宽高尺寸仍然是精确的
		width=this.$nodeDom[id].outerWidth();
		height=this.$nodeDom[id].outerHeight();
		this.$nodeDom[id].children("table").css({width:width-2+"px",height:height-2+"px"});
        //确保因内部文字太多而撑大时，宽高尺寸仍然是精确的 END
		this.$nodeData[id].width=width;
		this.$nodeData[id].height=height;
		if(this.$editable){
			this.$nodeData[id].alt=true;
		}
		//重画转换线
		this.resetLines(id,this.$nodeData[id]);
		this._node2Area(id);
	},
	//删除结点
	delNode:function(id,trigger){
		if(!this.$nodeData[id])	return;
		if(false!==trigger && typeof this.onItemDel==='function' && this.onItemDel(id,"node")===false)	return;
		//先删除可能的连线
		for(var k in this.$lineData){
			if(this.$lineData[k].from===id||this.$lineData[k].to===id){
				//this.$draw.removeChild(this.$lineDom[k]);
				//delete this.$lineData[k];
				//delete this.$lineDom[k];
				this.delLine(k,false);
			}
		}
		//再删除结点本身
		if(this.$undoStack){
			var paras=[id,this.$nodeData[id]];
			this.pushOper("addNode",paras);
		}
		delete this.$nodeData[id];
		this.$nodeDom[id].remove();
		delete this.$nodeDom[id];
		--this.$nodeCount;
		if(this.$focus===id)	this.$focus="";

		if(this.$editable){
			//在回退新增操作时,如果节点ID以this.$id+"_node_"开头,则表示为本次编辑时新加入的节点,这些节点的删除不用加入到$deletedItem中
			//if(id.indexOf(this.$id+"_node_")<0)
				this.$deletedItem[id]="node";
		}
	},
	//设置流程图的名称
	setTitle:function(text){
		this.$title=text;
		if(this.$head)	this.$head.children("label").attr("title",text).text(text);
	},
    //仅供内部使用：计算流程图的实际宽高（单位像素）
	_suitSize:function(){
        var maxW=0,maxH=0;
        for(var k1 in this.$nodeData){
            var node = this.$nodeData[k1];
            if(maxW < node.width+node.left){
                maxW = node.width+node.left;
            }
            if(maxH < node.height+node.top){
                maxH = node.height+node.top;
            }
        }
        for(var k2 in this.$areaData){
            var area = this.$areaData[k2];
            if(maxW < area.width+area.left){
                maxW = area.width+area.left;
            }
            if(maxH < area.height+area.top){
                maxH = area.height+area.top;
            }
        }
        for(var k3 in this.$lineData){
            var line = this.$lineData[k3];
            if(line.M && line.type==="lt" && maxW < line.M ){
                maxW = M+4;
            }
            if(line.M && line.type==="tb" && maxH < line.M ){
                maxH = M+4;
            }
        }
        return {width:maxW,height:maxH}

	},
	//载入一组数据
	loadData: function (data) {
	    this.clearData();  //载入之前先清空数据 yubaolee
		var t=this.$editable;
		this.$editable=false;
		if(data.title)	this.setTitle(data.title);
		if (data.initNum) this.$max = data.initNum;

		if (data != "") {
		    var length,k;
		    for (k = 0, length = data.nodes.length; k < length; k++) {
		        this.addNode(data.nodes[k].id, data.nodes[k]);
		    }
		    for (k = 0, length = data.lines.length; k < length; k++) {
		        this.addLine(data.lines[k].id, data.lines[k]);
		    }
		    for (k = 0,length = data.areas.length; k < length; k++) {
		        this.addArea(data.areas[k].id, data.areas[k]);
		    }
        }
		

		this.$editable=t;
		this.$deletedItem={};
		//自行重构工作区，使之大小自适应
        var width=this.$workArea.width();
        var height=this.$workArea.height();
        var max=this._suitSize();
        while(max.width>width){
            width+=this.$workExtendStep;
        }
        while(max.height>height){
            height+=this.$workExtendStep;
        }
        this.$workArea.css({height:height+"px",width:width+"px"});
        if(GooFlow.prototype.useSVG===""){
            this.$draw.coordsize = width+","+height;
        }
        this.$draw.style.width = width + "px";
        this.$draw.style.height = height + "px";
        if(this.$group!=null){
            this.$group.css({height:height+"px",width:width+"px"});
        }
	},
	//用AJAX方式，远程读取一组数据
	//参数para为JSON结构，与JQUERY中$.ajax()方法的传参一样
	loadDataAjax:function(para){
		var This=this;
		$.ajax({
			type:para.type,
			url:para.url,
			dataType:"json",
			data:para.data,
			success: function(msg){
				if(para['dataFilter'])	para['dataFilter'](msg,"json");
     			This.loadData(msg);
				if(para.success)	para.success(msg);
   			},
			error: function(XMLHttpRequest, textStatus, errorThrown){
				if(para.error)	para.error(textStatus,errorThrown);
			}
		})
	},
	//把画好的整个流程图导出到一个变量中(其实也可以直接访问GooFlow对象的$nodeData,$lineData,$areaData这三个JSON属性)
	exportData:function(){
		var ret={};
		ret.title=this.$title;
		ret.nodes=[];
		ret.lines=[];
		ret.areas=[];
		ret.initNum=this.$max;
		for(var k1 in this.$nodeData){
			if(!this.$nodeData[k1].marked){
				delete this.$nodeData[k1]["marked"];
			}
			ret.nodes.push(JSON.parse(JSON.stringify(this.$nodeData[k1])));
			//ret.nodes[k1]=JSON.parse(JSON.stringify(this.$nodeData[k1]));
        }
		for(var k2 in this.$lineData){
			if(!this.$lineData[k2].marked){
				delete this.$lineData[k2]["marked"];
			}
			ret.lines.push(JSON.parse(JSON.stringify(this.$lineData[k2])));
           // ret.lines[k2]=JSON.parse(JSON.stringify(this.$lineData[k2]));
		}
        for(var k3 in this.$areaData){
            if(!this.$areaData[k3].marked){
                delete this.$areaData[k3]["marked"];
            }

            ret.areas.push(JSON.parse(JSON.stringify(this.$areaData[k3])));
            // ret.areas[k3]=JSON.parse(JSON.stringify(this.$areaData[k3]));
        }
		return ret;
	},
	//只把本次编辑流程图中作了变更(包括增删改)的元素导出到一个变量中,以方便用户每次编辑载入的流程图后只获取变更过的数据
	exportAlter:function(){
		var ret={nodes:{},lines:{},areas:{}};
		for(var k1 in this.$nodeData){
			if(this.$nodeData[k1].alt){
				ret.nodes[k1]=this.$nodeData[k1];
			}
		}
		for(var k2 in this.$lineData){
			if(this.$lineData[k2].alt){
				ret.lines[k2]=this.$lineData[k2];
			}
		}
		for(var k3 in this.$areaData){
			if(this.$areaData[k3].alt){
				ret.areas[k3]=this.$areaData[k3];
			}
		}
		ret.deletedItem=this.$deletedItem;
		return ret;
	},
	//变更元素的ID,一般用于快速保存后,将后台返回新元素的ID更新到页面中;type为元素类型(节点,连线,区块)
	transNewId:function(oldId,newId,type){
		var tmp;
		switch(type){
			case "node":
			if(this.$nodeData[oldId]){
				tmp=this.$nodeData[oldId];
				delete this.$nodeData[oldId];
				this.$nodeData[newId]=tmp;
				tmp=this.$nodeDom[oldId].attr("id",newId);
				delete this.$nodeDom[oldId];
				this.$nodeDom[newId]=tmp;
			}
			break;
			case "line":
			if(this.$lineData[oldId]){
				tmp=this.$lineData[oldId];
				delete this.$lineData[oldId];
				this.$lineData[newId]=tmp;
				tmp=this.$lineDom[oldId].attr("id",newId);
				delete this.$lineDom[oldId];
				this.$lineDom[newId]=tmp;
			}
			break;
			case "area":
			if(this.$areaData[oldId]){
				tmp=this.$areaData[oldId];
				delete this.$areaData[oldId];
				this.$areaData[newId]=tmp;
				tmp=this.$areaDom[oldId].attr("id",newId);
				delete this.$areaDom[oldId];
				this.$areaDom[newId]=tmp;
			}
			break;
		}
	},
	//清空工作区及已载入的数据
	clearData:function(){
		for(var k1 in this.$nodeData){
			this.delNode(k1);
		}
		for(var k2 in this.$lineData){
			this.delLine(k2);
		}
		for(var k3 in this.$areaData){
			this.delArea(k3);
		}
		this.$deletedItem={};
	},
	//销毁自己
	destrory:function(){
		this.$bgDiv.empty();
		this.$lineData=null;
		this.$nodeData=null;
		this.$lineDom=null;
		this.$nodeDom=null;
		this.$areaDom=null;
		this.$areaData=null;
		this.$nodeCount=0;
		this.$areaCount=0;
		this.$areaCount=0;
		this.$deletedItem={};
	},
///////////以下为有关画线的方法
	//绘制一条箭头线，并返回线的DOM
	drawLine:function(id,sp,ep,mark,dash,$scale){
		var line,text;
        var x=(ep[0]+sp[0])/2, y=(ep[1]+sp[1])/2;
		if(GooFlow.prototype.useSVG!==""){
			line=document.createElementNS("http://www.w3.org/2000/svg","g");
			var hi=document.createElementNS("http://www.w3.org/2000/svg","path");
			var path=document.createElementNS("http://www.w3.org/2000/svg","path");

			if(id!=="")	line.setAttribute("id",id);
			line.setAttribute("from",sp[0]+","+sp[1]);
			line.setAttribute("to",ep[0]+","+ep[1]);
			hi.setAttribute("visibility","hidden");
			hi.setAttribute("stroke-width",'9');
			hi.setAttribute("fill","none");
			hi.setAttribute("stroke","white");
			hi.setAttribute("d","M "+sp[0]+" "+sp[1]+" L "+ep[0]+" "+ep[1]);
			hi.setAttribute("pointer-events","stroke");
			path.setAttribute("d","M "+sp[0]+" "+sp[1]+" L "+ep[0]+" "+ep[1]);
			path.setAttribute("stroke-width",mark? '2.4':'1.4');
			path.setAttribute("stroke-linecap","round");
			path.setAttribute("fill","none");
			if(dash)	path.setAttribute("style", "stroke-dasharray:6,5");
			if(mark){
				path.setAttribute("stroke",GooFlow.color.mark);
				path.setAttribute("marker-end","url(#arrow2)");
			}
			else{
				path.setAttribute("stroke",GooFlow.color.line);
				path.setAttribute("marker-end","url(#arrow1)");
			}
			line.appendChild(hi);
			line.appendChild(path);
			line.style.cursor="crosshair";
			if(id!==""&&id!=="GooFlow_tmp_line"){
				text=document.createElementNS("http://www.w3.org/2000/svg","text");
				text.setAttribute("fill",GooFlow.color.lineFont);
				line.appendChild(text);

				text.setAttribute("text-anchor","middle");
				text.setAttribute("x",x+'');
				text.setAttribute("y",y+'');
				text.style.cursor="text";
                text.style.fontSize=14*$scale+"px";
                line.style.cursor="pointer";
			}
		}else{
			line=document.createElement("v:polyline");
			if(id!=="")	line.id=id;
			//line.style.position="absolute";
			line.points.value=sp[0]+","+sp[1]+" "+ep[0]+","+ep[1];
			line.setAttribute("fromTo",sp[0]+","+sp[1]+","+ep[0]+","+ep[1]);
			line.strokeWeight="1.2";
			line.stroke.EndArrow="Block";
			line.style.cursor="crosshair";
			if(id!==""&&id!=="GooFlow_tmp_line"){
				text=document.createElement("div");
				//text.innerHTML=id;
				line.appendChild(text);
				if(x<0) x=x*-1;
				if(y<0) y=y*-1;
				text.style.left=x+"px";
				text.style.top=y-6+"px";
                text.style.color=GooFlow.color.lineFont;
                text.style.fontSize=14*$scale+"px";
				line.style.cursor="pointer";
			}
			if(dash)	line.stroke.dashStyle="Dash";
			if(mark)	line.strokeColor=GooFlow.color.mark;
			else	line.strokeColor=GooFlow.color.line;
			line.fillColor=GooFlow.color.line;
		}
		return line;
	},
	//画一条只有两个中点的折线
	drawPoly:function(id,sp,m1,m2,ep,mark,dash,$scale){
		var poly,strPath, text;
		var x=(m2[0]+m1[0])/2, y=(m2[1]+m1[1])/2;
		if(GooFlow.prototype.useSVG!==""){
			poly=document.createElementNS("http://www.w3.org/2000/svg","g");
			var hi=document.createElementNS("http://www.w3.org/2000/svg","path");
			var path=document.createElementNS("http://www.w3.org/2000/svg","path");
			if(id!=="")	poly.setAttribute("id",id);
			poly.setAttribute("from",sp[0]+","+sp[1]);
			poly.setAttribute("to",ep[0]+","+ep[1]);
			hi.setAttribute("visibility","hidden");
			hi.setAttribute("stroke-width",'9');
			hi.setAttribute("fill","none");
			hi.setAttribute("stroke","white");
			strPath="M "+sp[0]+" "+sp[1];
			if(m1[0]!==sp[0]||m1[1]!==sp[1])
				strPath+=" L "+m1[0]+" "+m1[1];
			if(m2[0]!==ep[0]||m2[1]!==ep[1])
				strPath+=" L "+m2[0]+" "+m2[1];
			strPath+=" L "+ep[0]+" "+ep[1];
			hi.setAttribute("d",strPath);
			hi.setAttribute("pointer-events","stroke");
			path.setAttribute("d",strPath);
			path.setAttribute("stroke-width",mark? '2.4':'1.4');
			path.setAttribute("stroke-linecap","round");
			path.setAttribute("fill","none");
            if(dash)	path.setAttribute("style", "stroke-dasharray:6,5");
			if(mark){
				path.setAttribute("stroke",GooFlow.color.mark);
				path.setAttribute("marker-end","url(#arrow2)");
			}
			else{
				path.setAttribute("stroke",GooFlow.color.line);
				path.setAttribute("marker-end","url(#arrow1)");
			}
			poly.appendChild(hi);
			poly.appendChild(path);
			text=document.createElementNS("http://www.w3.org/2000/svg","text");
			text.setAttribute("fill",GooFlow.color.lineFont);
			poly.appendChild(text);
			text.setAttribute("text-anchor","middle");
			text.setAttribute("x",x+'');
			text.setAttribute("y",y+'');
			text.style.cursor="text";
		}
		else{
			poly=document.createElement("v:Polyline");
			if(id!=="")	poly.id=id;
			poly.filled="false";
			strPath=sp[0]+","+sp[1];
			if(m1[0]!==sp[0]||m1[1]!==sp[1])
				strPath+=" "+m1[0]+","+m1[1];
			if(m2[0]!==ep[0]||m2[1]!==ep[1])
				strPath+=" "+m2[0]+","+m2[1];
			strPath+=" "+ep[0]+","+ep[1];
			poly.points.value=strPath;
			poly.setAttribute("fromTo",sp[0]+","+sp[1]+","+ep[0]+","+ep[1]);
			poly.strokeWeight=mark? "2.4":"1.2";
			poly.stroke.EndArrow="Block";
			text=document.createElement("div");
			//text.innerHTML=id;
			poly.appendChild(text);
			if(x<0) x=x*-1;
			if(y<0) y=y*-1;
			text.style.left=x+"px";
			text.style.top=y-4+"px";
            text.style.color=GooFlow.color.lineFont;
            if(dash)	poly.stroke.dashStyle="Dash";
			if(mark)	poly.strokeColor=GooFlow.color.mark;
			else	poly.strokeColor=GooFlow.color.line;
		}
        poly.style.cursor="pointer";
        text.style.fontSize=14*$scale+"px";
		return poly;
	},
	//原lineData已经设定好的情况下，只在绘图工作区画一条线的页面元素
	addLineDom:function(id,lineData){
		var n1=this.$nodeData[lineData.from],n2=this.$nodeData[lineData.to];//获取开始/结束结点的数据
		if(!n1||!n2)	return;
		//开始计算线端点坐标
		var res;
		if(lineData.type&&lineData.type!=="sl")
			res=calcPolyPoints(n1,n2,lineData.type,lineData.M, this.$scale);
		else
			res=calcStartEnd(n1,n2, this.$scale);
		if(!res)	return;

		if(lineData.type==="sl")
			this.$lineDom[id]=GooFlow.prototype.drawLine(id,res.start,res.end,lineData.marked,lineData.dash, this.$scale);
		else
			this.$lineDom[id]=GooFlow.prototype.drawPoly(id,res.start,res.m1,res.m2,res.end,lineData.marked,lineData.dash, this.$scale);
		this.$draw.appendChild(this.$lineDom[id]);
		if(GooFlow.prototype.useSVG===""){
			this.$lineDom[id].childNodes[1].innerHTML=lineData.name;
			if(lineData.type!=="sl"){
				var Min=(res.start[0]>res.end[0]? res.end[0]:res.start[0]);
				if(Min>res.m2[0])	Min=res.m2[0];
				if(Min>res.m1[0])	Min=res.m1[0];
				this.$lineDom[id].childNodes[1].style.left = (res.m2[0]+res.m1[0])/2-Min-this.$lineDom[id].childNodes[1].offsetWidth/2+4;
				Min=(res.start[1]>res.end[1]? res.end[1]:res.start[1]);
				if(Min>res.m2[1])	Min=res.m2[1];
				if(Min>res.m1[1])	Min=res.m1[1];
				this.$lineDom[id].childNodes[1].style.top = (res.m2[1]+res.m1[1])/2-Min-this.$lineDom[id].childNodes[1].offsetHeight/2;
			}else
				this.$lineDom[id].childNodes[1].style.left=
				((res.end[0]-res.start[0])*(res.end[0]>res.start[0]? 1:-1)-this.$lineDom[id].childNodes[1].offsetWidth)/2+4;
		}
		else{
            this.$lineDom[id].childNodes[2].textContent=lineData.name;
        }
	},
	//增加一条线
	addLine: function (id, json) {
	    if (json.id == undefined) {
	        $.extend(json, { id: id });
	    }
		if(typeof this.onItemAdd==='function' && this.onItemAdd(id,"line",json)===false)return;
		if(this.$undoStack&&this.$editable){
			this.pushOper("delLine",[id]);
		}
		if(json.from===json.to)	return;
		var n1=this.$nodeData[json.from],n2=this.$nodeData[json.to];//获取开始/结束结点的数据
		if(!n1||!n2)	return;
		//避免两个节点间不能有一条以上同向接连线
		for(var k in this.$lineData){
			if((json.from===this.$lineData[k].from&&json.to===this.$lineData[k].to&&json.dash===this.$lineData[k].dash))
				return;
		}
		//设置$lineData[id]
		this.$lineData[id]={};
		if(json.type){
			this.$lineData[id].type=json.type;
			this.$lineData[id].M=json.M;
		}
		else	this.$lineData[id].type="sl";//默认为直线
		this.$lineData[id].from=json.from;
		this.$lineData[id].to = json.to;
		this.$lineData[id].id = json.id;  //赋值ID
		this.$lineData[id].setInfo = json.setInfo;
		this.$lineData[id].name=json.name;
		if(json.marked)	this.$lineData[id].marked=json.marked;
		else	this.$lineData[id].marked=false;
        if(json.dash)	this.$lineData[id].dash=json.dash;
        else	this.$lineData[id].dash=false;
		//设置$lineData[id]完毕

		this.addLineDom(id,this.$lineData[id]);

		++this.$lineCount;
		if(this.$editable){
			this.$lineData[id].alt=true;
			if(this.$deletedItem[id])	delete this.$deletedItem[id];//在回退删除操作时,去掉该元素的删除记录
		}
	},
	//重构所有连向某个结点的线的显示，传参结构为$nodeData数组的一个单元结构
	resetLines:function(id,node){
		for(var i in this.$lineData){
		  var other=null;//获取结束/开始结点的数据
		  var res;
		  if(this.$lineData[i].from===id){//找结束点
			other=this.$nodeData[this.$lineData[i].to]||null;
			if(other==null)	continue;
			if(this.$lineData[i].type==="sl")
				res=calcStartEnd(node,other, this.$scale);
			else
				res=calcPolyPoints(node,other,this.$lineData[i].type,this.$lineData[i].M, this.$scale);
			if(!res)	break;
		  }
		  else if(this.$lineData[i].to===id){//找开始点
			other=this.$nodeData[this.$lineData[i].from]||null;
			if(other==null)	continue;
			if(this.$lineData[i].type==="sl")
				res=calcStartEnd(other,node, this.$scale);
			else
				res=calcPolyPoints(other,node,this.$lineData[i].type,this.$lineData[i].M, this.$scale);
			if(!res)	break;
		  }
		  if(other==null)	continue;
		  this.$draw.removeChild(this.$lineDom[i]);
		  if(this.$lineData[i].type==="sl"){
		  	this.$lineDom[i]=GooFlow.prototype.drawLine(i,res.start,res.end,this.$lineData[i].marked,this.$lineData[i].dash, this.$scale);
		  }
		  else{
			this.$lineDom[i]=GooFlow.prototype.drawPoly(i,res.start,res.m1,res.m2,res.end,this.$lineData[i].marked,this.$lineData[i].dash, this.$scale);
		  }
		  this.$draw.appendChild(this.$lineDom[i]);
		  if(GooFlow.prototype.useSVG===""){
			this.$lineDom[i].childNodes[1].innerHTML=this.$lineData[i].name;
			if(this.$lineData[i].type!=="sl"){
				var Min=(res.start[0]>res.end[0]? res.end[0]:res.start[0]);
				if(Min>res.m2[0])	Min=res.m2[0];
				if(Min>res.m1[0])	Min=res.m1[0];
				this.$lineDom[i].childNodes[1].style.left = (res.m2[0]+res.m1[0])/2-Min-this.$lineDom[i].childNodes[1].offsetWidth/2+4;
				Min=(res.start[1]>res.end[1]? res.end[1]:res.start[1]);
				if(Min>res.m2[1])	Min=res.m2[1];
				if(Min>res.m1[1])	Min=res.m1[1];
				this.$lineDom[i].childNodes[1].style.top = (res.m2[1]+res.m1[1])/2-Min-this.$lineDom[i].childNodes[1].offsetHeight/2-4;
			}else
				this.$lineDom[i].childNodes[1].style.left=
				((res.end[0]-res.start[0])*(res.end[0]>res.start[0]? 1:-1)-this.$lineDom[i].childNodes[1].offsetWidth)/2+4;
		  }
		  else	this.$lineDom[i].childNodes[2].textContent=this.$lineData[i].name;
		}
	},
	//重新设置连线的样式 newType= "sl":直线, "lr":中段可左右移动型折线, "tb":中段可上下移动型折线
	setLineType:function(id,newType,M){
		if(!newType||newType==null||newType===""||newType===this.$lineData[id].type)	return false;
		if(typeof this.onLineSetType==='function' && this.onLineSetType(id,newType)===false)	return;
		if(this.$undoStack){
			var paras=[id,this.$lineData[id].type,this.$lineData[id].M];
			this.pushOper("setLineType",paras);
		}
		var from=this.$lineData[id].from;
		var to=this.$lineData[id].to;
		this.$lineData[id].type=newType;
		var res;
		//如果是变成折线
		if(newType!=="sl"){
		  //res=calcPolyPoints(this.$nodeData[from],this.$nodeData[to],this.$lineData[id].type,this.$lineData[id].M, this.$scale);
		  if(M){
		  	this.setLineM(id,M,true);
		  }else{
		  	this.setLineM(id,getMValue(this.$nodeData[from],this.$nodeData[to],newType),true);
		  }
		}
		//如果是变回直线
		else{
		  delete this.$lineData[id].M;
		  this.$lineMove.hide().removeData("type").removeData("tid");
		  res=calcStartEnd(this.$nodeData[from],this.$nodeData[to], this.$scale);
		  if(!res)	return;
		  this.$draw.removeChild(this.$lineDom[id]);
		  this.$lineDom[id]=GooFlow.prototype.drawLine(id,res.start,res.end,this.$lineData[id].marked,this.$lineData[id].dash, this.$scale);
		  this.$draw.appendChild(this.$lineDom[id]);
		  if(GooFlow.prototype.useSVG===""){
		  	this.$lineDom[id].childNodes[1].innerHTML=this.$lineData[id].name;
			this.$lineDom[id].childNodes[1].style.left=
			((res.end[0]-res.start[0])*(res.end[0]>res.start[0]? 1:-1)-this.$lineDom[id].childNodes[1].offsetWidth)/2+4;
		  }
		  else
			this.$lineDom[id].childNodes[2].textContent=this.$lineData[id].name;
		}
		if(this.$focus===id){
			this.focusItem(id);
		}
		if(this.$editable){
			this.$lineData[id].alt=true;
		}
	},
	//设置折线中段的X坐标值（可左右移动时）或Y坐标值（可上下移动时）
	setLineM:function(id,M,noStack){
		if(!this.$lineData[id]||M<0||!this.$lineData[id].type||this.$lineData[id].type==="sl")	return false;
		if(typeof this.onLineMove==='function' && this.onLineMove(id,M)===false)	return false;
		if(this.$undoStack&&!noStack){
			var paras=[id,this.$lineData[id].M];
			this.pushOper("setLineM",paras);
		}
		var from=this.$lineData[id].from;
		var to=this.$lineData[id].to;
		this.$lineData[id].M=M;
		var ps=calcPolyPoints(this.$nodeData[from],this.$nodeData[to],this.$lineData[id].type,this.$lineData[id].M, this.$scale);
		this.$draw.removeChild(this.$lineDom[id]);
		this.$lineDom[id]=GooFlow.prototype.drawPoly(id,ps.start,ps.m1,ps.m2,ps.end,this.$lineData[id].marked,this.$lineData[id].dash, this.$scale);
		this.$draw.appendChild(this.$lineDom[id]);
		if(GooFlow.prototype.useSVG===""){
			this.$lineDom[id].childNodes[1].innerHTML=this.$lineData[id].name;
			var Min=(ps.start[0]>ps.end[0]? ps.end[0]:ps.start[0]);
			if(Min>ps.m2[0])	Min=ps.m2[0];
			if(Min>ps.m1[0])	Min=ps.m1[0];
			this.$lineDom[id].childNodes[1].style.left = (ps.m2[0]+ps.m1[0])/2-Min-this.$lineDom[id].childNodes[1].offsetWidth/2+4;
			Min=(ps.start[1]>ps.end[1]? ps.end[1]:ps.start[1]);
			if(Min>ps.m2[1])	Min=ps.m2[1];
			if(Min>ps.m1[1])	Min=ps.m1[1];
			this.$lineDom[id].childNodes[1].style.top = (ps.m2[1]+ps.m1[1])/2-Min-this.$lineDom[id].childNodes[1].offsetHeight/2-4;
		}
		else	this.$lineDom[id].childNodes[2].textContent=this.$lineData[id].name;
		if(this.$editable){
			this.$lineData[id].alt=true;
		}
	},
	//删除转换线
	delLine:function(id,trigger){
		if(!this.$lineData[id])	return;
		if(false!==trigger && typeof this.onItemDel==='function' && this.onItemDel(id,"node")===false)	return;
		if(this.$undoStack){
			var paras=[id,this.$lineData[id]];
			this.pushOper("addLine",paras);
		}
		this.$draw.removeChild(this.$lineDom[id]);
		delete this.$lineData[id];
		delete this.$lineDom[id];
		if(this.$focus===id)	this.$focus="";
		--this.$lineCount;
		if(this.$editable){
			//在回退新增操作时,如果节点ID以this.$id+"_line_"开头,则表示为本次编辑时新加入的节点,这些节点的删除不用加入到$deletedItem中
			// if(id.indexOf(this.$id+"_line_")<0)
			this.$deletedItem[id]="line";
			this.$mpFrom.hide().removeData("p");
			this.$mpTo.hide().removeData("p");
		}
		if(this.$lineOper){
			this.$lineOper.hide().removeData("tid");
		}
	},
	//变更连线两个端点所连的结点
	//参数：要变更端点的连线ID，新的开始结点ID、新的结束结点ID；如果开始/结束结点ID是传入null或者""，则表示原端点不变
	moveLinePoints:function(lineId, newStart, newEnd, noStack){
		if(newStart===newEnd)	return;
		if(!lineId||!this.$lineData[lineId])	return;
		if(newStart==null||newStart==="")
			newStart=this.$lineData[lineId].from;
		if(newEnd==null||newEnd==="")
			newEnd=this.$lineData[lineId].to;

		//避免两个节点间不能有一条以上同向接连线
		for(var k in this.$lineData){
			if((newStart===this.$lineData[k].from&&newEnd===this.$lineData[k].to))
				return;
		}
		if(typeof this.onLinePointMove==='function' && this.onLinePointMove(lineId,newStart,newEnd)===false)	return;
		if(this.$undoStack&&!noStack){
			var paras=[lineId,this.$lineData[lineId].from,this.$lineData[lineId].to];
			this.pushOper("moveLinePoints",paras);
		}
		if(newStart!=null&&newStart!==""){
			this.$lineData[lineId].from=newStart;
		}
		if(newEnd!=null&&newEnd!==""){
			this.$lineData[lineId].to=newEnd;
		}
		//重建转换线
		this.$draw.removeChild(this.$lineDom[lineId]);
		this.addLineDom(lineId,this.$lineData[lineId]);
		if(this.$editable){
			this.$lineData[lineId].alt=true;
		}
	},

	//用颜色标注/取消标注一个结点或转换线，常用于显示重点或流程的进度。
	//这是一个在编辑模式中无用,但是在纯浏览模式中非常有用的方法，实际运用中可用于跟踪流程的进度。
	markItem:function(id,type,mark){
		if(type==="node"){
			if(!this.$nodeData[id])	return;
			if(typeof this.onItemMark==='function' && this.onItemMark(id,"node",mark)===false)	return;
				this.$nodeData[id].marked=mark||false;
			if(mark){
				this.$nodeDom[id].addClass("item_mark").css("border-color",GooFlow.color.mark);
			}
			else{
				this.$nodeDom[id].removeClass("item_mark");
				if(id!==this.$focus) this.$nodeDom[id].css("border-color","transparent");
			}

		}else if(type==="line"){
			if(!this.$lineData[id])	return;
			if(this.onItemMark!=null&&!this.onItemMark(id,"line",mark))	return;
			this.$lineData[id].marked=mark||false;
			if(GooFlow.prototype.useSVG!==""){
				if(mark){
					this.$lineDom[id].childNodes[1].setAttribute("stroke",GooFlow.color.mark);
					this.$lineDom[id].childNodes[1].setAttribute("marker-end","url(#arrow2)");
                    this.$lineDom[id].childNodes[1].setAttribute("stroke-width",2.4);
				}else{
					this.$lineDom[id].childNodes[1].setAttribute("stroke",GooFlow.color.line);
					this.$lineDom[id].childNodes[1].setAttribute("marker-end","url(#arrow1)");
                    this.$lineDom[id].childNodes[1].setAttribute("stroke-width",1.4);
				}
			}else{
				if(mark){
                    this.$lineDom[id].strokeColor=GooFlow.color.mark;
                    this.$lineDom[id].strokeWeight="2.4";
				}
				else{
                    this.$lineDom[id].strokeColor=GooFlow.color.line;
                    this.$lineDom[id].strokeWeight="1.2";
				}
			}
		}
		if(this.$undoStack){
			var paras=[id,type,!mark];
			this.pushOper("markItem",paras);
		}
	},
	////////////////////////以下为区域分组块操作
	//传入一个区域组(泳道)的ID，判断图中所有结点在此区域组(泳道)的范围内
	_areaFixNodes:function(areaId){
		var area=this.$areaData[areaId];
		for(var key in this.$nodeData){
			var node = this.$nodeData[key];
			if( node.left>=area.left&&node.left<area.left+area.width &&
				node.top>=area.top&&node.top<area.top+area.height
			){
				node.areaId=areaId;
			}else if(node.areaId && node.areaId===areaId){
				this._node2Area(key);
			}
		}
	},
	moveArea:function(id,left,top){
		if(!this.$areaData[id])	return;
		if(this.onItemMove!=null&&!this.onItemMove(id,"area",left,top))	return;
		if(this.$undoStack){
			var paras=[id,this.$areaData[id].left,this.$areaData[id].top];
			this.pushOper("moveArea",paras);
		}
		if(left<0)	left=0;
		if(top<0)	top=0;
		$("#"+id).css({left:left*this.$scale+"px",top:top*this.$scale+"px"});
		this.$areaData[id].left=left;
		this.$areaData[id].top=top;
		if(this.$editable){
			this.$areaData[id].alt=true;
			this._areaFixNodes(id);
		}
	},
	//删除区域分组
	delArea:function(id, trigger){
		if(!this.$areaData[id])	return;
		if(this.$undoStack){
			var paras=[id,this.$areaData[id]];
			this.pushOper("addArea",paras);
		}
		if(false!==trigger && typeof this.onItemDel==='function' && this.onItemDel(id,"node")===false)	return;
		delete this.$areaData[id];
		this.$areaDom[id].remove();
		delete this.$areaDom[id];
		--this.$areaCount;
		if(this.$editable){
			//在回退新增操作时,如果节点ID以this.$id+"_area_"开头,则表示为本次编辑时新加入的节点,这些节点的删除不用加入到$deletedItem中
			//if(id.indexOf(this.$id+"_area_")<0)
			for(var key in this.$nodeData){
				var node = this.$nodeData[key];
				if(node.areaId===id){
					delete node.areaId
				}
			}
			this.$deletedItem[id]="area";
		}
	},
	//设置区域分组的颜色
	setAreaColor:function(id,color){
		if(!this.$areaData[id])	return;
		if(this.$undoStack){
			var paras=[id,this.$areaData[id].color];
			this.pushOper("setAreaColor",paras);
		}
		if(color==="red"||color==="yellow"||color==="blue"||color==="green"){
			this.$areaDom[id].removeClass("area_"+this.$areaData[id].color).addClass("area_"+color);
			this.$areaData[id].color=color;
		}
		if(this.$editable){
			this.$areaData[id].alt=true;
		}
	},
	//设置区域分块的尺寸
	resizeArea:function(id,width,height){
		if(!this.$areaData[id])	return;
		if(typeof this.onItemResize==='function' && this.onItemResize(id,"area",width,height)===false)	return;
		if(this.$undoStack){
			var paras=[id,this.$areaData[id].width,this.$areaData[id].height];
			this.pushOper("resizeArea",paras);
		}

		this.$areaDom[id].children(".bg").css({width:width*this.$scale+"px",height:height*this.$scale+"px"});

		width=this.$areaDom[id].outerWidth();
		height=this.$areaDom[id].outerHeight();
		this.$areaDom[id].children("bg").css({width:width+"px",height:height+"px"});

		this.$areaData[id].width=width;
		this.$areaData[id].height=height;
		if(this.$editable){
			this.$areaData[id].alt=true;
			this._areaFixNodes(id);
		}
	},
	addArea:function(id,json){
		if(typeof this.onItemAdd==='function' && this.onItemAdd(id,"area",json)===false)return;
		if(this.$undoStack&&this.$editable){
			this.pushOper("delArea",[id]);
		}
		this.$areaDom[id]=$("<div id='"+id+"' class='GooFlow_area area_"+json.color
			+"' style='top:"+json.top*this.$scale+"px;left:"+json.left*this.$scale+"px'><div class='bg' style='width:"+(json.width*this.$scale)+"px;height:"+(json.height*this.$scale)+"px'></div>"
			+"<label>"+json.name+"</label><i></i><div><div class='rs_bottom'></div><div class='rs_right'></div><div class='rs_rb'></div><div class='rs_close'></div></div></div>");
		this.$areaData[id]=json;
		this.$group.append(this.$areaDom[id]);
		if(this.$nowType!=="group")	this.$areaDom[id].children("div:eq(1)").css("display","none");
		++this.$areaCount;
		if(this.$editable){
			this.$areaData[id].alt=true;
			this._areaFixNodes(id);
			if(this.$deletedItem[id])	delete this.$deletedItem[id];//在回退删除操作时,去掉该元素的删除记录
		}
	},
	//重构整个流程图设计器的宽高
	reinitSize:function(width,height){
		var w=(width||this.$bgDiv.width());
		var h=(height||this.$bgDiv.height());
		this.$bgDiv.css({height:h+"px",width:w+"px"});
		var headHeight=0,hack=8;
		if(this.$head!=null){
			headHeight=26;
			hack=5;
		}
		if(this.$tool!=null){
			this.$tool.css({height:h-headHeight-hack+"px"});
			w-=31;
		}
		w-=9;
		h=h-headHeight-(this.$head!=null? 5:8);
		//this.$workArea.parent().css({height:h+"px",width:w+"px"});
		
		if(this.$workArea.width()>w){
			w=this.$workArea.width();
		}
		if(this.$workArea.height()>h){
			h=this.$workArea.height();
		}
		
		this.$workArea.css({height:h+"px",width:w+"px"});
		if(GooFlow.prototype.useSVG===""){
			this.$draw.coordsize = w+","+h;
		}
		this.$draw.style.width = w + "px";
		this.$draw.style.height = h + "px";
		if(this.$group!=null){
			this.$group.css({height:h+"px",width:w+"px"});
		}
	},
	//重设整个工作区内容的显示缩放比例，从0.5至4倍
	resetScale:function(scale){
		if(!scale)	scale=1.0;
		else if(scale<0.5)	scale=0.5;
		else if(scale>4)	scale=4;
		//以上是固定死取值范围：不让用户缩放过大或过小，已免无意中影响的显示效果
		if(this.$scale===scale)	return;
		var oldS=this.$scale;
		this.$scale=scale;
		var factor = oldS/scale;//因数（旧缩放比例除以新缩放比例）,元素的现有值除以该因子，就能得到新的缩放后的值
        var W=0,H=0,P={};//宽、高、左及上的临时变量
		//开始正式的缩放（节点、连线、泳道块有宽高和定位，其它编辑工具元素则只有定位）（全部以左上角为原点）
        this.blurItem();
		//先缩放工作区
        W=this.$workArea.width()/factor;
        H=this.$workArea.height()/factor;
        this.$workArea.css({"height":H+"px","width":W+"px"});
        if(GooFlow.prototype.useSVG!==""){

        }else{
            this.$draw.coordsize = W+","+H;
		}
        this.$draw.style.width = W + "px";
        this.$draw.style.height = H + "px";
        if(this.$group!=null){
            this.$group.css({height:H+"px",width:W+"px"});
        }
        //缩放节点
        var isWebkit = navigator.userAgent.toLowerCase().indexOf('webkit') > -1;
        this.$workArea.children(".GooFlow_item").each(function(){
            var This=$(this);
            P=This.position();
            This.css({ "left":P.left/factor+"px", "top":P.top/factor+"px" });
            This=This.children("table");
            W=This.outerWidth()/factor;
            H=This.outerHeight()/factor;
            This.css({ "width":W+"px", "height":H+"px" });
            var tmp=18*scale;
            This.find("td[class='ico']").css({width:tmp+"px"});
            var newSize= {};
            if(tmp<12&&isWebkit){
                newSize["width"]="18px";newSize["height"]="18px";
                newSize["font-size"]="18px";
                newSize["transform"]="scale("+(tmp/18)+")";
                newSize["margin"]=-((18-tmp)/2)+"px";
            }else{
                newSize["width"]=tmp+"px"; newSize["height"]=tmp+"px";
                newSize["font-size"]=tmp+"px";
                newSize["transform"]="none";
                newSize["margin"]="0px auto";
            }
            This.find("td[class='ico']").children("i").css(newSize);

            tmp=14*scale;
            if(This.parent().find(".span").length===1){
                This.parent().css("border-radius",W/2+"px");
                This=This.parent().find(".span");
                This.css({"font-size":tmp+"px"});
            }else{
                This=This.find("td:eq(1) div");
                newSize={};
                if(tmp<12&&isWebkit){
                    newSize["font-size"]="14px";
                    newSize["transform"]="scale("+(tmp/14)+")";
                    var mW=(W/scale-18-(W-18*scale))/2;
                    var mH=(H/scale-H)/2;
                    newSize["margin"]=-mH+"px "+(-mW)+"px";
                }else{
                    newSize["transform"]="none";
                    newSize["font-size"]=tmp+"px";
                    newSize["margin"]="0px";
                }
                This.css(newSize);
            }
		});
        //缩放区域图
		var ifs=16*scale+2;
		this.$group.children(".GooFlow_area").each(function(){
            var This=$(this);
            P=This.position();
            This.css({ "left":P.left/factor+"px", "top":P.top/factor+"px" });
            This=This.children("div:eq(0)");
            W=This.outerWidth()/factor;
            H=This.outerHeight()/factor;
            This.css({ "width":W+"px", "height":H+"px" });
            This.next("label").css({
				"font-size": 14*scale+"px",
				"left": ifs+3+"px"
            }).next("i").css({
				"font-size": ifs-2+"px",
				width:ifs+"px",
				height:ifs+"px",
				"line-height":ifs+"px"
            });
		});
		//缩放连线
		for(var id in this.$lineDom){
            this.$draw.removeChild(this.$lineDom[id]);
            delete this.$lineDom[id];
		}
        for (var key in this.$lineData) {
            this.addLineDom(key, this.$lineData[key]);
        }
	}
};
//默认的颜色样式
GooFlow.color={
	//main:"#20A0FF",
	font:"#15428B",
	node:"#C0CCDA",
	line:"#1D8CE0",
	lineFont:"#777",
	mark:"#ff8800",
	mix:"#B6F700",
	mixFont:"#777"
};
	//默认的文字说明注释内容
GooFlow.remarks={
    headBtns:{},
	toolBtns:{},
    extendRight:undefined,
    extendBottom:undefined
};
//当不想使用jquery插件式初始化方法时，另一种通过直接调用GooFlow内部构造方法进行的初始化
GooFlow.init=function(selector,property){
	return new GooFlow(selector,property);
};
//在初始化出一个对象前的公用方法：覆盖设定GooFlow默认的颜色定义
GooFlow.setColors=function(colors){
	$.extend(GooFlow.color,colors);
};
//扩展GooFlow方法的扩展用接口，一般用在CMD,AMD
GooFlow.extend=function(json){
	for(var funcName in json){
		GooFlow.prototype[funcName]=json[funcName];
	}
};
//将此类的构造函数加入至JQUERY对象中
$.extend({
	createGooFlow:function(selector,property){
		return new GooFlow(selector,property);
	}
});

        exports('flow/gooflow');
    });
