using System;
using System.Linq;
using Infrastructure;
using OpenAuth.App.Interface;
using OpenAuth.App.Request;
using OpenAuth.App.Response;
using OpenAuth.Repository.Domain;
using OpenAuth.Repository.Interface;


namespace OpenAuth.App
{
    public class WmsInboundOrderTblApp : BaseApp<WmsInboundOrderTbl>
    {
        private RevelanceManagerApp _revelanceApp;
        private WmsInboundOrderDtblApp _wmsInboundOrderDtblApp;

        /// <summary>
        /// 加载列表
        /// </summary>
        public TableData Load(QueryWmsInboundOrderTblListReq request)
        {
            var loginContext = _auth.GetCurrentUser();
            if (loginContext == null)
            {
                throw new CommonException("登录已过期", Define.INVALID_TOKEN);
            }

            var properties = loginContext.GetProperties("WmsInboundOrderTbl");

            if (properties == null || properties.Count == 0)
            {
                throw new Exception("当前登录用户没有访问该模块字段的权限，请联系管理员配置");
            }


            var result = new TableData();
            var objs = GetDataPrivilege("u");
            if (!string.IsNullOrEmpty(request.key))
            {
                objs = objs.Where(u => u.Id.Contains(request.key));
            }

            var propertyStr = string.Join(',', properties.Select(u => u.Key));
            result.columnHeaders = properties;
            result.data = objs.OrderBy(u => u.Id)
                .Skip((request.page - 1) * request.limit)
                .Take(request.limit).Select($"new ({propertyStr})");
            result.count = objs.Count();
            return result;
        }

        public void Add(AddOrUpdateWmsInboundOrderTblReq req)
        {
            var obj = req.MapTo<WmsInboundOrderTbl>();
            //todo:补充或调整自己需要的字段
            obj.CreateTime = DateTime.Now;
            var user = _auth.GetCurrentUser().User;
            obj.CreateUserId = user.Id;
            obj.CreateUserName = user.Name;
            UnitWork.Add(obj);
            if (req.WmsInboundOrderDtblReqs != null && req.WmsInboundOrderDtblReqs.Any())
            {
                foreach (var detail in req.WmsInboundOrderDtblReqs)
                {
                    detail.OrderId = obj.Id;
                    _wmsInboundOrderDtblApp.AddNoSave(detail);
                }
            }
            
            UnitWork.Save();
        }

         public void Update(AddOrUpdateWmsInboundOrderTblReq obj)
        {
            var user = _auth.GetCurrentUser().User;
            
            if (obj.WmsInboundOrderDtblReqs != null && obj.WmsInboundOrderDtblReqs.Any())
            {
                //id为空的添加
                foreach (var detail in obj.WmsInboundOrderDtblReqs.Where(u =>string.IsNullOrEmpty(u.Id)))
                {
                    detail.OrderId = obj.Id;
                    _wmsInboundOrderDtblApp.AddNoSave(detail);
                }
                
                //id比数据库少的，删除
                var containids = obj.WmsInboundOrderDtblReqs.Select(u => u.Id)
                    .Where(u =>!string.IsNullOrEmpty(u)).ToList();
                if (containids.Any())
                {
                    UnitWork.Delete<WmsInboundOrderDtbl>(u =>(!containids.Contains(u.Id)) && u.OrderId == obj.Id);
                }
                
                
                //更新id相同的
                foreach (var detail in obj.WmsInboundOrderDtblReqs.Where(u =>!string.IsNullOrEmpty(u.Id)))
                {
                    _wmsInboundOrderDtblApp.Update(detail);
                }
            }
            
            UnitWork.Update<WmsInboundOrderTbl>(u => u.Id == obj.Id, u => new WmsInboundOrderTbl
            {
                ExternalNo = obj.ExternalNo,
                ExternalType = obj.ExternalType,
                Status = obj.Status,
                OrderType = obj.OrderType,
                GoodsType = obj.GoodsType,
                PurchaseNo = obj.PurchaseNo,
                StockId = obj.StockId,
                OwnerId = obj.OwnerId,
                ShipperId = obj.ShipperId,
                SupplierId = obj.SupplierId,
                ScheduledInboundTime = obj.ScheduledInboundTime,
                Remark = obj.Remark,
                Enable = obj.Enable,
                TransferType = obj.TransferType,
                InBondedArea = obj.InBondedArea,
                ReturnBoxNum = obj.ReturnBoxNum,
                UpdateTime = DateTime.Now,
                UpdateUserId = user.Id,
                UpdateUserName = user.Name
                //todo:补充或调整自己需要的字段
            });
            
            UnitWork.Save();

        }

        public WmsInboundOrderTblApp(IUnitWork unitWork, IRepository<WmsInboundOrderTbl> repository,
            RevelanceManagerApp app, IAuth auth, WmsInboundOrderDtblApp wmsInboundOrderDtblApp) : base(unitWork, repository,auth)
        {
            _revelanceApp = app;
            _wmsInboundOrderDtblApp = wmsInboundOrderDtblApp;
        }
    }
}