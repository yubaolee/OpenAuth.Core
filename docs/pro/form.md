# 工作流添加自定义表单

OpenAuth.Pro使用的动态表单可以满足日常普通的审批功能，但如果想`对用户提交的表单数据进行统计分析`、需要用户提交附件、需要`复杂的表单交互`，这时就需要开发者开发自己的表单页面。实现更加丰富的功能，效果如下：

![20211228212712](http://img.openauth.net.cn/20211228212712.png)

本文以如何添加一个请假流程为例：

## 添加数据库表结构

先在数据库中添加记录表单数据的表，即请假条中的内容。

![20211228212800](http://img.openauth.net.cn/20211228212800.png)

## 编写后端代码

自定义表单后台数据库读写需要继承`ICustomerForm`接口。并且名称需要和数据库表名+App的形式，如：`FrmLeaveReqApp`。参考代码如下：

```csharp
    public class FrmLeaveReqApp : BaseStringApp<FrmLeaveReq,OpenAuthDBContext>, ICustomerForm
    {
        //其他逻辑代码略
        public void Add(FrmLeaveReq obj)
        {
            Repository.Add(obj);
        }
        
        public FrmLeaveReqApp(IUnitWork<OpenAuthDBContext> unitWork, IRepository<FrmLeaveReq,OpenAuthDBContext> repository,
            IAuth auth) : base(unitWork, repository, auth)
        {
        }

        public void Add(string flowInstanceId, string frmData)
        {
            var req = JsonHelper.Instance.Deserialize<FrmLeaveReq>(frmData);
            req.FlowInstanceId = flowInstanceId;
            Add(req);
        }

        public void Update(string flowInstanceId, string frmData)
        {
            var req = JsonHelper.Instance.Deserialize<FrmLeaveReq>(frmData);
            UnitWork.Update<FrmLeaveReq>(u => u.FlowInstanceId == flowInstanceId, u => new FrmLeaveReq
            {
                UserName = req.UserName,
                RequestComment = req.RequestComment,
                RequestType = req.RequestType
                //补充其他需要更新的字段
            });
        }
    }
```


## 编写请假条前端表单代码

系统约定，所有开发人员自己开发的表单，全部放在views/forms文件夹下。并且以下图的文件结构进行放置。

![20240223135542](http://img.openauth.net.cn/20240223135542.png)

其中：

FrmLeaveReq：为业务表单的文件夹名称，必须与数据库表名保持一致。

* add.vue：为业务表单页面，负责编写业务输入逻辑。内部methods必须包含方法：

```javascript
getData() {
  return this.temp
}
```

上层框架会调用该方法来获取表单中的数据，用于后续逻辑处理。

* detail.vue：为业务表单的展示页面。

## 注册表单

在表单添加的下拉框里添加：
![20211228213129](http://img.openauth.net.cn/20211228213129.png)

::: warning 注意
企业Vue2 5.2或以前版本需要在项目main.js中注入：

```javascript
// 请假条表单和详情
import FrmLeaveReqAdd from '@/views/forms/userDefine/frmLeaveReq/add'
import FrmLeaveReqDetail from '@/views/forms/userDefine/frmLeaveReq/detail'
Vue.component('FrmLeaveReqAdd', FrmLeaveReqAdd)
Vue.component('FrmLeaveReqDetail', FrmLeaveReqDetail)
```

:::

## 配置表单

编写完上面代码后，运行企业版。使用【基础配置】--【表单设计】--【添加】功能添加刚刚的表单：

![20211228213154](http://img.openauth.net.cn/20211228213154.png)

这样就可以在流程设计里面，选择使用刚刚添加的表单了。