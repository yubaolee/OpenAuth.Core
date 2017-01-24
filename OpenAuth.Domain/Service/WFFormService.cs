using System;
using System.Collections.Generic;
using System.Linq;
using OpenAuth.Domain.Interface;

namespace OpenAuth.Domain.Service
{
    /// <summary>
    /// 表单服务
    /// <para>李玉宝新增于2017-01-13 17:48:00</para>
    /// </summary>
    public class WFFormService
    {
        protected IUnitWork _unitWork;

        public WFFormService(IUnitWork unitWork)
        {
            _unitWork = unitWork;
        }

        public List<WFFrmMain> GetAllList()
        {
            return _unitWork.Find<WFFrmMain>(null).ToList();
        }

        public WFFrmMain GetForm(Guid keyValue)
        {
            return _unitWork.FindSingle<WFFrmMain>(u => u.Id == keyValue);
        }

        public void RemoveForm(Guid[] keyValue)
        {
            _unitWork.Delete<WFFrmMain>(u =>keyValue.Contains(u.Id));
        }
    }
}
