using System;
using System.Collections.Generic;
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

        public GoodsApply Get(Guid value)
        {
            return _repository.FindSingle(u =>u.Id == value);
        }

        public IEnumerable<GoodsApply> Load(Guid userid, Guid parentId, int pageCurrent, int pageSize)
        {
            return _repository.Find( pageCurrent, pageSize);
        }
    }
}