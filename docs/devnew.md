本章节以项目自带的数据库OpenAuthDB中Stock表为基础介绍如何添加一个新模块，并对新模块进行授权等操作。

暂且为该模块命名为`仓库管理`,现在开始：

## 编写代码
 
 * 使用CodeSmith生成数据库实体访问代码，用于操作数据库

    * 使用CodeSmith Generator Studio 打开Openauth.Net项目中CodeSmith文件夹。

   ![](http://www.openauth.me/upload/180523102401201.png " ")
    
    * 右建Entity.cst，选择Execute。弹出数据库的相关配置。
    
    * 配置连接字符串SourceDatabase、绿色部分Class命名空间的及Output输出文件夹。

    * 点击`Generate`生成代码，生成后代码在`X:\~~\OpenAuth.Net\CodeSmith\CSharp`文件夹中。

    * 将生成的代码按上图红色箭头的指示复制到项目中。可以只复制`Entities\Stock.cs`、`Mapping\StockMap.cs`、`OpenAuthDBContext.cs`

 * 使用CodeSmith生成界面及逻辑代码

    * 右建WebGenerate.cst，选择Execute。弹出数据库的相关配置。
    
    * 选择数据库中Stock表，其他配置不变。

    ![](http://www.openauth.me/upload/180523105001970.jpg "")

    * 点击`Generate`生成代码，生成后代码在`X:\~~\OpenAuth.Net\CodeSmith\CSharp`文件夹中。

    ![](http://www.openauth.me/upload/180523105310484.png "")

    * 生成的代码严格按照应用层APP、控制器controllers、用户界面views、用户界面脚本userJs划分。将生成的代码按上图红色箭头的指示复制到项目中。

 * 在visual studio中根据自己的业务做简单的调整，然后编译生成。即完成了一个新模块的开发。

 `注意` 使用代码生成器适用于大批量简单逻辑的代码生成，复杂逻辑可以基于现有代码直接手动修改。

## 创建模块

 * 添加模块

 ![](http://www.openauth.me/upload/180523113510852.png)

 `注意` 模块标识必须和模块的controller一致，否则模块不能正常加载

 * 添加菜单

 ![](http://www.openauth.me/upload/180523111946327.png)

 默认的domId有`btnAdd`、`btnEdit`、`btnDel`可以参考`userJs\stocks.js`中的代码定义

 * 授权
 
 与其他板块授权方式完全一样，如果用的是System账号，退出重新登陆即可看到新加的模块：

 ![](http://www.openauth.me/upload/180523113201515.png)

 以上就是一个普通模块开发的全过程，是不是so easy🙂，快下载代码体验吧！