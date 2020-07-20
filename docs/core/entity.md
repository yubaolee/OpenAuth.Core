# 数据库实体

## 跟换主键名称

系统默认的主键是以`Id`命名，如果数据库主键是其他名称，可以直接用注解进行更改：

```csharp
 [Column("CustomerId")]
 public string Id { get; set; }
```


## 添加非统一主键

系统默认的主键是以`Id`命名，如果数据库表中存在其他类型或名称的主键，可以通过继承`BaseEntity`实现

```csharp
/// <summary>
/// 模拟一个实体IntEntity，主键名称为IdName，类型为Int
/// </summary>
public class IntEntity : BaseEntity
{
    [Browsable(false)]
    public int IdName { get; set; }
    
    //其他字段略
    
    /// <summary>
    /// 判断主键是否为空，常用做判定操作是【添加】还是【编辑】
    /// </summary>
    /// <returns></returns>
    public override bool KeyIsNull()
    {
        return IdName == 0;
    }

    /// <summary>
    /// 创建默认的主键值
    /// </summary>
    public override void GenerateDefaultKeyVal()
    {
        Id = RandomInt();
    }
}
```

::: warning 注意
最新版才支持，以前的版本（2.0或以前的版本）可以参考BaseEntity进行改造

:::


