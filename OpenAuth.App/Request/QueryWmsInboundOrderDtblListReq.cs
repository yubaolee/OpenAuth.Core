namespace OpenAuth.App.Request
{
    public class QueryWmsInboundOrderDtblListReq : PageReq
    {
        //todo:添加自己的请求字段
        /// <summary>
        /// 入库订单号
        /// </summary>
        public string InboundOrderId { get; set; }
    }
}