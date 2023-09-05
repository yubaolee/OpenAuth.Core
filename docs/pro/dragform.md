# 可拖拽表单

适用场景和普通的动态表单一样。但该表单操作方便，与系统界面风格匹配度高，缺点是排版没有普通的动态表单灵活，只能做简单的行排列。

## 设计表单

功能【基础配置】-【表单设计】中，点击`新增`按钮，拖拽设计自己想要的表单，然后点击右上角`保存`按钮即可完成添加表单。

![20221130142201](http://img.openauth.net.cn/20221130142201.png)

#### `关联数据库表`选项

在设计表单时，如果在`关联数据库表`中新增一个表名，并对拖拽的控件进行标准化命名，如：

![20221130142549](http://img.openauth.net.cn/20221130142549.png)

这时保存后，会自动在数据库生成该表单对应的表：

![20220223001508](http://img.openauth.net.cn/20220223001508.png)

在后面进行流程流转时，流程使用的表单数据会自动存放在该表中，方便统计及其他程序开发应用。


::: warning 注意

如果表单不配置关联数据库表，流程使用的表单数据只能以json格式存放在`flowinstance`表的`FrmData`字段中，不利于后期数据分析和扩展。至于是否需要关联数据库表，可以根据自己需要进行选择

:::


## 上传组件

在vform设计表单时，【图片】【文件】两个组件需要和后端上传交互，需要做些特殊的处理。

![20230905112347](http://img.openauth.net.cn/20230905112347.png)

1、调整上传地址，如：

```
http://localhost:52789/api/Files/UploadWithFormData
```

2、修改回调:

```javascript
var imgServerIp ="http://localhost:52789";  //图片服务器IP
return {
  name: result.result[0].fileName,
  url:  new URL(result.result[0].filePath,imgServerIp).href
}
```
配置完成后，在流程实例中即可正常使用上传功能。

![20230905112824](http://img.openauth.net.cn/20230905112824.png)