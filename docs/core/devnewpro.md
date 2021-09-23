# 企业版代码生成器

## 术语解释

#### 动态头部

如果启用动态头部，表示前端渲染列表（或表单）时，列表的列定义是从后端返回。常见的前端代码如下：
```html
  <auth-table  ref="mainTable" :table-fields="headerList"></auth-table>
```
```javascript
getList() {
      resources.getList(this.listQuery).then((response) => {
        ...
        this.headerList = response.columnFields
        ...
      })
    },

```

否则生成的前端列为固定的头部。如下：

```html

  <auth-table  ref="mainTable" :table-fields="headerList"></auth-table>

```
```javascript
initCfg() {
      this.headerList = [
        new ColumnDefine('id', 'id', false, false, 'text', '', 'string', 'varchar', ''),
        new ColumnDefine('tableName', '表名', true, true, 'text', '', 'string', 'varchar', ''),
        new ColumnDefine('moduleName', '模块名称', true, true, 'text', '', 'string', 'varchar', ''),
        new ColumnDefine('parentTableId', '父表', true, true, 'selectDynamic', '/BuilderTables/AllMain', 'string', 'varchar', ''),
        new ColumnDefine('foreignKey', '外键', true, true, 'text', '', 'string', 'varchar', ''),
      ]

```

## 单表添加

代码生成界面，点击`添加`按钮，输入想添加的模块信息。
![2021923224934](http://img.openauth.net.cn/2021923224934.png)

录入基础信息，点击`确认`保存后，系统会添加一条记录，并自动加载对应的字段信息。

![2021923225040](http://img.openauth.net.cn/2021923225040.png)

这时，编辑字段具体的属性。如是否【可显示】【可编辑】等。



