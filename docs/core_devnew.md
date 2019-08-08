1. 前言

     OpenAuth.Mvc添加新模块的方式非常简单，完全可以参考系统已有的资源管理模块编写相应的代码。涉及的代码文件如下：

     ![](http://pj.openauth.me/zentao/file-read-55.png)

     红色即为要添加的代码文件（其中OpenAuthDBContext为修改）。当然全部手撸这些代码还是会疯的。[企业版](http://openauth.me/question/detail.html?id=a2be2d61-7fcb-4df8-8be2-9f296c22a89c)用户可以直接使用OpenAuth.Pro/CodeSmith代码生成器一键生成上述代码。而且CodeSmith本身也是全部源码，可以根据自己需求调整生成的内容。

1. 工具准备

    CodeSmith Generator Studio 7.0或以上

    数据库OpenAuthDB中添加仓储表【Stock】，本文以该数据表为例

1. 在OpenAuth.Mvc项目中添加实体

    如下图，使用OpenAuth.Pro文件夹中的CodeSmith模板，右击【ApiGenerate.cst】--【Execute】，选择需要生成的表（本文以Stock为例）及相关的上下文命名空间，点击【Generate】

    ![](http://pj.openauth.me/zentao/file-read-26.jpg)

    生成成功后，在CodeSmith/Csharp文件夹下面会有Stock实体相关文档，如下图：

    ![](http://pj.openauth.me/zentao/file-read-53.png)

    把CSharp\OpenAuth.App覆盖到自己项目对应目录

    把CSharp\OpenAuth.Repository\Domain覆盖到自己项目对应目录

    **把CSharp\OpenAuth.Repository\OpenAuthDBContext.cs中的内容添加到自己项目的文件中，千万不要直接覆盖文件！！！**

    **其他文件夹的内容为WebAPI项目使用，可以不管。**

1. 在OpenAuth.Mvc中添加界面

    如下图，使用OpenAuth.Pro文件夹中的CodeSmith模板，右击【WebGenerate.cst】--【Execute】，选择需要生成的表（本文以Stock为例）及相关的上下文命名空间，点击【Generate】

    ![](http://pj.openauth.me/zentao/file-read-47.png)

    生成成功后，在CodeSmith/Csharp文件夹下面会有相关的界面代码，如下图：

    ![](http://pj.openauth.me/zentao/file-read-50.png)

    Controllers、Views直接覆盖到OpenAuth.Mvc项目中对应的文件夹即可

    userJs直接覆盖到OpenAuth.Mvc/wwwroot中

1. 添加模块

    编写完上面代码后，运行系统，使用System账号登录系统，在【模块管理】中，添加`仓储管理`模块，并为它添加菜单，这里我只添加一个菜单【btnAdd】，如下图：

    ![](http://pj.openauth.me/zentao/file-read-51.png)

    重新登录系统，即可看到新加的仓储管理模块。

    ![](http://pj.openauth.me/zentao/file-read-52.png)

    