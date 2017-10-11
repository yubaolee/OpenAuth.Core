using System;
using System.Collections.Generic;
using System.Linq;
using OpenAuth.App.ViewModel;
using OpenAuth.Domain;
using OpenAuth.Domain.Interface;

namespace OpenAuth.App
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

        public WFFrmMain GetForm(string keyValue)
        {
            return _unitWork.FindSingle<WFFrmMain>(u => u.Id == keyValue);
        }

        public void RemoveForm(string[] keyValue)
        {
            _unitWork.Delete<WFFrmMain>(u =>keyValue.Contains(u.Id));
        }

        public GridData Load(int pageCurrent, int pageSize)
        {
            var result = new GridData
            {
                page = pageCurrent
            };

            int cnt = _unitWork.Find<WFFrmMain>(null).Count();
            result.total = cnt % pageSize == 0 ? cnt / pageSize : cnt / pageSize + 1;
            result.data = _unitWork.Find<WFFrmMain>(pageCurrent, pageSize, "ModifyDate descending", null).ToList();

            return result;
        }

        public void SaveForm(string keyValue, WFFrmMain entity)
        {
         
                if (string.IsNullOrEmpty(keyValue))
                {
                    _unitWork.Add(entity);
                }
                else
                {
                    entity.Id = keyValue;
                    _unitWork.Update(u =>u.Id, entity);
                }
                _unitWork.Save();
        }
    }
}
