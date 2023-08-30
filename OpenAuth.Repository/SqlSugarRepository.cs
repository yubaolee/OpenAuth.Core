using SqlSugar;

namespace OpenAuth.Repository
{
    /// <summary>
    /// SqlSugar仓储
    /// <para>具体用法参考：https://www.donet5.com/Home/Doc?typeId=1228</para>
    /// </summary>
    public class SqlSugarRepository<T> : SimpleClient<T> where T : class, new()
    {
        public SqlSugarRepository(ISqlSugarClient client)
        {
            base.Context = client;
        }
    }
}

