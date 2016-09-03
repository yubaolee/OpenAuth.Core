using System;
using System.Collections.Generic;
using OpenAuth.App.ViewModel;
using OpenAuth.Domain;
using OpenAuth.Domain.Interface;

namespace OpenAuth.App
{
    public class GoodsApplyApp
    {
        private IRepository<GoodsApply> _repository;

        public GoodsApplyApp(IRepository<GoodsApply> repository)
        {
            _repository = repository;
        }

        public void AddOrUpdate(GoodsApply model)
        {
            if (model.Id == Guid.Empty)
            {
                _repository.Add(model);
            }
            else
            {
                _repository.Update(u => u.Id == model.Id, u => new GoodsApply
                {
                    UserId = model.UserId,
                    Name = model.Name,
                    Number = model.Number
                });
            }

        }

        /// <summary>
        /// 更改流程状态
        /// </summary>
        public void ChangeState(Guid id,string state,  string statename)
        {
            _repository.Update(u =>u.Id == id, u =>new GoodsApply
            {
                State = state,
                StateName = statename
            });
        }

        public GoodsApply Get(Guid value)
        {
            return _repository.FindSingle(u =>u.Id == value);
        }

        public GridData Load(Guid userid, Guid parentId, int pageCurrent, int pageSize)
        {
            var result = new GridData
            {
                pageCurrent = pageCurrent
            };

            result.list= _repository.Find( pageCurrent, pageSize);
            result.total = _repository.GetCount(null);

            return result;
        }
    }
}