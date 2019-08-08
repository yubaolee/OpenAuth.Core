以控制台方式部署：

* 站点OpenAuth.Mvc部署：

直接在解决方案资源管理器中，选中OpenAuth.Mvc右键【发布】，出现下面的配置框，使用文件系统即可：

![说明](http://pj.openauth.me/zentao/file-read-8.png "说明")

发布完成后可以在输出目录看到发布详情（红色框内即为发布的文件夹）：

![说明](http://pj.openauth.me/zentao/file-read-69.png "说明")

发布【OpenAuth.Mvc】完成后进入文件目录【netcoreapp2.1\publish】，直接使用`dotnet  openauth.mvc.dll` 命令启动。启动成功后使用浏览器打开http://localhost:1802 即可访问，如下图所示：

![说明](https://gitee.com/uploads/images/2018/0328/150659_6900820e_362401.png "说明")

* 接口OpenAuth.WebApi部署请查看[企业版](http://openauth.me/question/detail.html?id=a2be2d61-7fcb-4df8-8be2-9f296c22a89c)内部文档


