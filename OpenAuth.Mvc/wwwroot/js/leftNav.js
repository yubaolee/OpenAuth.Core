function navBar(strData){
	var data;
	if(typeof(strData) == "string"){
		var data = JSON.parse(strData); //部分用户解析出来的是字符串，转换一下
	}else{
		data = strData;
	}	
	var ulHtml = '<ul class="layui-nav layui-nav-tree">';
    for (var i = 0; i < data.length; i++){
        if(data[i].Item.Status === -1) continue;
		if(data[i].spread){
			ulHtml += '<li class="layui-nav-item layui-nav-itemed">';
		}else{
			ulHtml += '<li class="layui-nav-item">';
		}
		if(data[i].Children != undefined && data[i].Children.length > 0){
			ulHtml += '<a href="javascript:;">';
			if(data[i].Item.IconName != undefined && data[i].Item.IconName != ''){
				ulHtml += '<i class="layui-icon '+ data[i].Item.IconName +'"></i>'
			}
			ulHtml += '<cite>'+data[i].Item.Name+'</cite>';
			ulHtml += '<span class="layui-nav-more"></span>';
			ulHtml += '</a>';
			ulHtml += '<dl class="layui-nav-child">';
            for (var j = 0; j < data[i].Children.length; j++){
                if (data[i].Children[j].Item.Status === -1) continue;
				if(data[i].Children[j].target == "_blank"){
					ulHtml += '<dd><a href="javascript:;" data-url="'+data[i].Children[j].Item.Url+'" target="'+data[i].Children[j].target+'">';
				}else{
					ulHtml += '<dd><a href="javascript:;" data-url="'+data[i].Children[j].Item.Url+'">';
				}
				if(data[i].Children[j].Item.IconName != undefined && data[i].Children[j].Item.IconName != ''){
					ulHtml += '<i class="layui-icon '+ data[i].Children[j].Item.IconName +'"></i>'
				}
				ulHtml += '<cite>' + data[i].Children[j].Item.Name + '</cite></a>';

				if (data[i].Children[j].Children != undefined && data[i].Children[j].Children.length > 0) {

					let idx = 0;
					for (var k = 0; k < data[i].Children[j].Children.length; k++) {

						if (data[i].Children[j].Children[k].Item.Status === -1) continue;

						idx++;

						if (idx == 1) {
							ulHtml += '<ol class="layui-nav-child">';
						}

						if (data[i].Children[j].Children[k].target == "_blank") {
							ulHtml += '<li><a href="javascript:;" data-url="' + data[i].Children[j].Children[k].Item.Url + '" target="' + data[i].Children[j].Children[k].target + '">';
							
						} else {
							ulHtml += '<li><a href="javascript:;" data-url="' + data[i].Children[j].Children[k].Item.Url + '">';
						}
						if (data[i].Children[j].Children[k].Item.IconName != undefined && data[i].Children[j].Children[k].Item.IconName != '') {
							ulHtml += '&nbsp;&nbsp;&nbsp;&nbsp;<i class="layui-icon ' + data[i].Children[j].Children[k].Item.IconName + '"></i>'
						}
						ulHtml += '<cite>' + data[i].Children[j].Children[k].Item.Name + '</cite></a ></li > ';
					}

					if (idx > 0) {
						ulHtml += '</ol>';
					}
				}
			}
			ulHtml += "</dl>";
		}else{
			if(data[i].target == "_blank"){
				ulHtml += '<a href="javascript:;" data-url="'+data[i].Item.Url+'" target="'+data[i].target+'">';
			}else{
				ulHtml += '<a href="javascript:;" data-url="'+data[i].Item.Url+'">';
			}
			if(data[i].Item.IconName != undefined && data[i].Item.IconName != ''){
				ulHtml += '<i class="layui-icon '+ data[i].Item.IconName +'"></i>'
			}
			ulHtml += '<cite>'+data[i].Item.Name+'</cite></a>';
		}
		ulHtml += '</li>';
	}
	ulHtml += '</ul>';
	return ulHtml;
}
