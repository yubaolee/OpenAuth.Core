# 流程实例

流程实例指正在运行的一个流程。数据存放在FlowInstance表中，该表核心字段如下：

#### IsFinish：流程的当前状态

- -1 草稿/召回：流程发起人主动撤销流程；【新增】

- 0 正在运行；

- 1 完成：流程结束，同时所有的审批都通过；

- 3 不同意：即流程结束，同时审批人员没有通过；

- 4 驳回：流程结束，可能发起的流程内容有问题，要求被驳回重新提交；


#### ActivityType：当前节点的类型

- -1 无法运行,

- 0 会签开始,

- 1 会签结束,

- 2 一般节点,

- 3 开始节点，

- 4 流程运行结束

#### SchemeContent：流程实例的具体内容

该字段存储的是一个JSON对象，具体内容如下所示：

```javascript
{
 
    "title":"newFlow_1",
    "nodes":[
        {
            "name":"node_1",
            "left":75,
            "top":90,
            "type":"start round mix",
            "id":1521797877921,
            "width":26,
            "height":26,
            "alt":true
        },
        {
            "name":"审核",
            "left":235,
            "top":97,
            "type":"node",
            "id":1521797879744,
            "width":104,
            "height":26,
            "alt":true,
            "setInfo":{
                "NodeDesignateData":{
                    "users":[
                        "49df1602-f5f3-4d52-afb7-3802da619558",
                        "6ba79766-faa0-4259-8139-a4a6d35784e0"
                    ],
                    "role":{
                    },
                    "org":{
                    }
                },
                "NodeCode":"FIRST",
                "NodeName":"审核"
            }
        },
        {
            "name":"node_3",
            "left":268,
            "top":209,
            "type":"end round",
            "id":1521797881216,
            "width":26,
            "height":26,
            "alt":true
        }
    ],
    "lines":[
        {
            "type":"sl",
            "from":"1521797877921",
            "to":"1521797879744",
            "id":1521797883552,
            "name":"",
            "dash":false
        },
        {
            "type":"sl",
            "from":"1521797879744",
            "to":"1521797881216",
            "id":1521797884536,
            "name":"",
            "dash":false
        }
    ],
    "areas":{
    },
    "initNum":7
 
}

```
其中：nodes为流程实例的所有节点。lines为流程实例的所有连线。节点的type属性为节点的类型属性，对应上面提到的ActivityType：

- -1：无法运行；

- 0：会签开始，即type为：‘fork’；

- 1：会签结束,即type为：’join’；

- 2：一般节点,即type为：’node’；

- 3：开始节点,即type为：‘start’；

- 4：流程运行结束，即type为’end’；
