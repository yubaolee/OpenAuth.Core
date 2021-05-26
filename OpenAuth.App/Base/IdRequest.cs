namespace OpenAuth.App.Request
{
    /// <summary>
    /// 请求参数中只有Id
    /// </summary>
    /// <typeparam name="T"></typeparam>
    public class IdRequest<T>
    {
        /// <summary>
        /// 操作Id
        /// </summary>
        public T Id { get; set; }
    }
}
