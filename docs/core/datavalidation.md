# WebApi请求验证

框架提供灵活的实体模型验证功能。可以方便地对实体进行验证。只需两步即可：

## 增加注解

在请求参数中添加验证注解

```csharp
namespace OpenAuth.App.Request
{
    public  class UpdateUserReq
    {
        /// <summary>
        /// </summary>
        /// <returns></returns>
        [Required(ErrorMessage = "账号肯定不能为空啊~~")]
        public string Account { get; set; }

        /// <summary>
        /// 用户姓名
        /// </summary>
        /// <returns></returns>
        [Required(ErrorMessage="姓名不能为空")]
        public string Name { get; set; }


        /// <summary>
        /// 所属组织Id，多个可用，分隔
        /// </summary>
        /// <value>The organizations.</value>
        [Required(ErrorMessage = "请为用户分配机构")]
        public string OrganizationIds { get; set; }

        ...
    }
}
```

## 业务代码中验证

在OpenAuth.App中调用验证

```csharp
namespace OpenAuth.App
{
    public class UserManagerApp : BaseApp<User>
    {
        public void AddOrUpdate(UpdateUserReq request)
        {
            //验证Account/Name/OrganizationIds
            request.ValidationEntity(u => new {u.Account,u.Name, u.OrganizationIds});

            ...//其他代码略
        }
    }
}
```
