# 内置组件

OpenAuth.Pro封装了一些组件，方便开发使用，组件全部在`src\components`中定义。

## 通用下拉选择 auth-select

通用下拉选择`auth-select`组件是用于渲染和编辑字典结构和动态列表返回key-valuel数据的组件。用法如下：

静态字典。根据【字典分类】模块的`分类标识`关键字获取，如：
```html
<auth-select :isEdit="isEdit" @change="change" :data-source="'SYS_STATUS'" v-model="val" size="mini"></auth-select>
```
动态列表。从指定Url获取value/label结构的数据进行渲染，如：
```html
<auth-select :isEdit="isEdit" @change="change" :type="'dynamic'" :data-source="'/CategoryTypes/Load'" v-model="val" size="mini"></auth-select>
```

该组件有以下几个参数：

isEdit:是否编辑，如果为false则展示为label形式，如果为true则为编辑状态；

type：选择类型。'dynamic'表示动态加载，空或'static'则从系统Category表中获取；

data-source：数据源。当type=='dynamic'时，该值为一个Url地址，该地址返回一个value/label结构的数组。当type=='static'或空时，该值为【字典分类】模块的`分类标识`；


## 表格组件 auth-table

用于渲染给定列定义，给定数据的表格，简单用法如下：
<auth-table ref="tableName" :table-fields="tableFields" :data="dataList" ></auth-table>

支持的事件：row-click selection-change
支持的方法：exportExcel clearSelection