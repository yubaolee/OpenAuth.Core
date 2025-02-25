# 添加新模块

## 前言

OpenAuth.Mvc添加新模块的方式非常简单，完全可以参考系统已有的`资源管理`模块编写相应的代码。参考的`资源管理`功能对应的代码如下：

![](http://pj.openauth.net.cn/zentao/file-read-55.png)

如果我们想新加一个仓储管理的模块，模块标识为`Stock`。那么需要添加的文件如下：


    ├─OpenAuth.Mvc
    │    ├─ Controllers
    │    │    └─ StocksController.cs
    │    ├─ Views
    │    │    └─ Stocks
    │    │        └─ index.cshtml
    │    ├─ wwwroot
    │    │    └─ userJs
    │    │        └─ stock.js
    ├─OpenAuth.App
    │    ├─ StockApp.cs
    │    ├─ Request
    │    │    └─ QueryStockReq.cs
    ├─ OpenAuth.Repository
    │    ├─ OpenAuthDBContext.cs
    │    ├─ Domain
    │         └─ Stock.cs

当然全部手撸这些代码还是会疯的。用户可以直接使用项目`CodeSmith`文件夹里面的模板一键生成上述代码。而且CodeSmith模板本身也是全部源码，可以根据自己需求调整生成的内容。

## 工具准备

CodeSmith Generator Studio 8.0或以上

数据库OpenAuthDB中添加仓储表【Stock】，本文以该数据表为例

## 添加实体

如下图，使用CodeSmith文件夹中的模板，右击【ApiGenerate.cst】--【Execute】，选择需要生成的表（本文以Stock为例）及相关的上下文命名空间，点击【Generate】

![20240613220037](http://img.openauth.net.cn/20240613220037.png)

注意，有两个配置项：

* WholeDb: 如果选中，则按数据库中所有表生成实体及逻辑；否则，按选择的表生成
  
* HeaderModel：会生成主、从表结构，类似 WmsInboundOrderTbl / WmsInboundOrderDtbl


生成成功后，在CodeSmith/Csharp文件夹下面会有Stock实体相关文档，如下图：

![20240613220224](http://img.openauth.net.cn/20240613220224.png)

把CSharp\OpenAuth.App覆盖到自己项目对应目录

把CSharp\OpenAuth.Repository\Domain覆盖到自己项目对应目录

**把CSharp\OpenAuth.Repository\OpenAuthDBContext.cs中的内容添加到自己项目的文件中，千万不要直接覆盖文件！！！**


## 添加界面

如下图，使用CodeSmith文件夹中的模板，右击【WebGenerate.cst】--【Execute】，选择需要生成的表（本文以Stock为例）及相关的上下文命名空间，点击【Generate】

![](http://img.openauth.net.cn/2025-02-25-10-56-08.png)

生成成功后，在CodeSmith/Csharp文件夹下面会有相关的界面代码，如下图：

![](http://img.openauth.net.cn/2025-02-25-10-57-44.png)

Controllers、Views直接覆盖到OpenAuth.Mvc项目中对应的文件夹即可

userJs直接覆盖到OpenAuth.Mvc/wwwroot中

## 添加模块

编写完上面代码后，运行系统，使用System账号登录系统，在【模块管理】中，添加`仓储管理`模块，

![20240613220434](http://img.openauth.net.cn/20240613220434.png)

::: warning 注意
因为生成的Controller名称类似XXXsController，所以模块的Url地址应该是XXXs/Index 
:::

添加模块时，系统会自动添加三个默认菜单【添加】【编辑】【删除】。可根据需要调整。这里我再添加一个菜单【btnCancel】，如下图：

![](http://img.openauth.net.cn/2025-02-25-11-05-08.png)

重新登录系统，即可看到新加的仓储管理模块。

![](http://img.openauth.net.cn/2025-02-25-11-08-26.png)

    