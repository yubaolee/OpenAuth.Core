1. 在OpenAuth中设计表单，注意表单中的控件名称，在步骤3调用OpenAuth创建流程实例接口时，frmData参数中的属性必须严格按该命名提交。

![](http://demo.openauth.me:8887/upload_files/190730144125614.jpg "表单设计说明")


2. 在OpenAuth中设计流程，制定相关的工作流程，并在每个流程节点配置回调URL路径，如下：

![](http://119.84.146.233:8887/upload_files/190730144422114.jpg "三方URL设置")

3. 三方已有系统界面，提交表单时，调用创建流程实例接口：http://localhost:52789/api/FlowInstances/Add，在OpenAuth中创建一条新的流程实例； 接口参数如下：

```javascript
    {
        schemeId:'cdd8191e-6a99-4d66-aac0-fae52c0f2232', //流程模板中已存在的模板ID
        schemeCode:'', //与流程模板ID二者选一个即可
        frmData:'{\"TOOLS\":\"电脑\",\"NUMBERS\":\"1\"}', //严格按照第一步中表单规则
        code:'1563811467051',
        customName:'三方创建的新物品领用',
    }
```

4. 用户正常在OpenAuth中执行流程，如果当前节点设置了回调URL的节点，OpenAuth会采用WebAPI POST方式回调，回调时具体参数如下：
```javascript
{
    flowInstanceId:"0ceff0f8-f848-440c-bc26-d8605ac858cd",  //流程实例ID
    nodeName: "admin审批",      //节点名称
    nodeId: "15333321",         //节点ID
    userId: "0ceff0f8-f848-440c-bc26-d8605ac858cd",
    userName: "admin",          //审核人账号
    result: 1,                  //审核结果 1：通过;2：不通过；3驳回
    description: "做的不错",     //审核描述
    execTime: "2019-07-07 12:00:00",   //审核时间
    isFinish: true                     //是否结束
}
```