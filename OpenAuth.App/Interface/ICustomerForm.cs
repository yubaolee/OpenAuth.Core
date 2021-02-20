namespace OpenAuth.App.Interface
{
    /// <summary>
    /// 开发者自定义表单的统一接口
    /// <para>例如：FrmLeaveReqApp为请假表单对应的应用层，实现该接口，可以自动向数据库中插入对应的记录</para>
    /// </summary>
    public interface  ICustomerForm
    {
        /// <summary>
        /// 该接口定义自定义表单模式时需实现向数据库写入表单数据
        /// </summary>
        /// <param name="flowInstanceId">表单对应的流程实例ID</param>
        /// <param name="frmData">表单数据</param>
        void Add(string flowInstanceId, string frmData);
    }
}
