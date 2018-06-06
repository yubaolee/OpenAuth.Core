/** 该文件仅供参考，不随其它JS文件一起打包发布 **/
/**
 * 全局的控件颜色自定义设置
 */
GooFlow.color={
  main:"#20A0FF",
  font:"#15428B",
  node:"#C0CCDA",
  line:"#1D8CE0",
  lineFont:"#ff6600",
  mark:"#ff8800",
  mix:"#B6F700",
  mixFont:"#777"
};
/**
 * 1.3版本新增的控件操作按钮的title提示设置
 * 取代setNodeRemarks方法，采用更灵活的注释配置
 */
//左边工具栏按钮的title提示设置，每个key名与初始化配置中相应按钮的类型名相同
GooFlow.remarks.toolBtns={
    cursor:"选择指针",
    direct:"结点连线",
    dashed:"关联虚线",
    start:"入口结点",
    "end":"结束结点",
    "task":"任务结点",
    node:"自动结点",
    chat:"决策结点",
    state:"状态结点",
    plug:"附加插件",
    fork:"分支结点",
    join:"联合结点",
    complex:"复合结点",
    group:"组织划分框编辑开关"
};
//顶部标题栏按钮的title提示设置，每个key名与初始化配置中相应按钮的类型名相同
GooFlow.remarks.headBtns={
    'new':"新建流程",
    open:"打开流程",
    save:"保存结果",
    undo:"撤销",
    redo:"重做",
    reload:"刷新流程",
    print:"打印流程图"
};
//工作区域面积扩展按钮的title提示设置
GooFlow.remarks.extendRight="工作区向右扩展";
GooFlow.remarks.extendBottom="工作区向下扩展";