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
<auth-select :default-props="{label:'name', value:'id'}" :isEdit="isEdit" @change="change" :type="'dynamic'" :data-source="'/CategoryTypes/Load'" v-model="val" size="mini"></auth-select>
```

该组件有以下几个参数：

isEdit:是否编辑，如果为false则展示为label形式，如果为true则为编辑状态；

type：选择类型。'dynamic'表示动态加载，空或'static'则从系统Category表中获取；

data-source：数据源。当type=='dynamic'时，该值为一个Url地址，该地址返回一个id/name结构的数组。当type=='static'或空时，该值为【字典分类】模块的`分类标识`；

default-props: 数据源提供的数据类型。默认情况下为id/name的数组。如果设置该值，则需要提供对应结构的数据，如：:default-props="{label:'tableName', value:'id'}"，则提供的数据格式如下：

```javascript
[
    {id:'1',tableName:'category'},
    {id:'2',tableName:'user'},
    {id:'3',tableName:'module'},
    ....
]
```

## 表格组件 auth-table

用于渲染给定列定义，给定数据的表格，简单用法如下：
```html
<auth-table ref="tableName" :table-fields="tableFields" :data="dataList" ></auth-table>
```

支持的事件：row-click selection-change

支持的方法：exportExcel clearSelection

## 表单组件 auth-form

根据定义动态渲染表单项，减少表单的开发。用法如下:
```html
<auth-form ref="dataForm" :edit-model="editModel" :form-fields="firstHeaderList" :data="firstTemp" :col-num="3"></auth-form>
```

当父组件需要使用表单里面的数据，进行提交操作时，参考以下代码：

```javascript
submit() {
    // 保存提交
    this.$refs['dataForm'].validate(() => {
    let tempData = Object.assign({}, this.firstTemp)
    api.add(tempData).then((resp) => {
        ...
        this.$notify({
        title: '成功',
        message: '提交成功',
        type: 'success'
        })
    })
    })
}
```

该组件有以下几个参数：

form-fields：表单属性定义。为一个`ColumnDefine`的数组。典型的值如下：

```javascript
    this.firstHeaderList = [
    new ColumnDefine('id', 'id', false, false, 'text', '', 'string', 'varchar', ''),
    new ColumnDefine('tableName', '表名', true, true, 'text', '', 'string', 'varchar', ''),
    new ColumnDefine('parentTableId', '父表', true, true, 'selectDynamic', '/BuilderTables/AllMain', 'string', 'varchar', ''),
    ]
```



