# 登录信息

框架在应用层任意业务逻辑中，均可以通过`IAuth`接口判断是否登录和获取登录信息。所有继承BaseApp的业务逻辑可以直接使用`_auth`成员变量直接获取登录用户信息。


```csharp

public class RoleApp : BaseApp<Role,OpenAuthDBContext>
    {
        /// <summary>
        /// 加载当前登录用户可访问的全部角色
        /// </summary>
        public List<Role> Load(QueryRoleListReq request)
        {
            var loginUser = _auth.GetCurrentUser();
             if (loginUser == null)
            {
                throw new CommonException("登录已过期", Define.INVALID_TOKEN);
            }
           
            //其他代码略
        }

        public RoleApp(IUnitWork<OpenAuthDBContext> unitWork, IRepository<Role,OpenAuthDBContext> repository,IAuth auth) : base(unitWork, repository, auth)
        {
        }
    }
```

