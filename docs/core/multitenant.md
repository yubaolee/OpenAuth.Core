# 多租户

目前市面上主流的多租户方案有三种：

1. **独立数据库** 即为不同的租户提供独立的数据库。

1. **共享数据库，独立Schema** 即多个或所有租户共享一个数据库实例，但是每个租户一个Schema（也可叫做一个user）。底层库比如是：DB2、ORACLE等，一个数据库下可以有多个SCHEMA。

1. **共享数据库，共享Schema，共享数据表** 即租户共享同一个数据库实例、同一个Schema，但在表中增加TenantID多租户的数据字段，在程序逻辑上进行区分。

为了兼容以前的版本，OpenAuth采用的是第一种方式，即为每个租户建一个新的数据库，然后通过客户端请求的租户Id（tenantId）来分离数据。


## 如何增加一个新租户？

#### 后端添加

后端添加新租户连接字符串即可：

```javascript
  "ConnectionStrings": {
    "new_tenantid": "server=127.0.0.1;user id=root;database=openauthpro;password=000000" //新租户id对应的连接字符串
  },
```

::: warning 注意
这里为了方便理解，租户id用的是`new_tenantid`,真实环境里，最好用类似UUID风格的无意义id
:::

#### 前端添加

比如在vue element-ui中,在登录时增加选择租户列表：

```html

  <el-select v-model="tenant" placeholder="请选择" @change="tenantChange">
    <el-option
        v-for="item in tenants"
        :key="item.value"
        :label="item.label"
        :value="item.value">
    </el-option>
 </el-select>


export default {
    name: 'login',
    data() {
        return {
        tenant: this.tenantid || 'OpenAuthDBContext',  //当前选择的租户
        tenants:[{
          value: 'OpenAuthDBContext',
          label: '默认租户'
        },{   //添加的新租户
          value: 'new_tenantid',
          label: '新租户'
        }]
        }
    }
}
```

前端在所有http请求的时候，在请求头中增加`tenantId`信息,保证每次请求带上租户信息。比如用axios请求时：

```javascript

// 创建axios实例
const service = axios.create({
  baseURL: process.env.VUE_APP_BASE_API, // api的base_url
  timeout: 50000 // 请求超时时间
})

// request拦截器
service.interceptors.request.use(config => {
  config.headers['tenantId'] = store.getters.tenantid
  //其他代码略...
})

```

