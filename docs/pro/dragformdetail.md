# 可拖拽表单常规设置

企业版可拖拽表单使用的是VForm Pro版本，详细的配置可参考:[https://www.vform666.com/](https://www.vform666.com/) 本节只做常用的配置说明。

## 后端加载下拉列表值

官网推荐通过数据源的方式给下拉列表赋值，简单点的方式是使用组件的`onCreated`事件。新建一个下拉先选框，唯一名称改为：`SelectVals`，在组件的`onCreated`事件中添加以下代码：

```javascript
var selectVals = this.getWidgetRef('SelectVals');
var addressAPI= 'http://localhost:52789/api/SelectVals/'
axios.get(addressAPI).then(function(res) {  
 if (res.data.code==200) {
    selectVals.loadOptions(res.data.result); 
 } 
}).catch(function(error) {
  console.error(error)
})
```

基于OpenAuth.WebApi返回的数据格式：
```javascript
{
	"result": [{
		"label": "选项值1",
		"value": "1"
	}, {
		"label": "选项值2",
		"value": "2"
	}],
	"message": "操作成功",
	"code": 200
}
```