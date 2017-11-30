using System.Collections.Generic;
using System.Linq;
using OpenAuth.App.Response;
using OpenAuth.Repository.Domain;
using OpenAuth.Repository.Interface;

namespace OpenAuth.App
{
    /// <summary>
    /// 表单服务
    /// <para>李玉宝新增于2017-01-13 17:48:00</para>
    /// </summary>
    public class WFFormService
    {
        public IUnitWork _unitWork { get; set; }

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

        public TableData Load(int pageCurrent, int pageSize)
        {
            var result = new TableData
            {
                count = _unitWork.Find<WFFrmMain>(null).Count(),
                data = _unitWork.Find<WFFrmMain>(pageCurrent, pageSize, "ModifyDate descending", null).ToList()
            };


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
