using System;
using System.Linq;
using Infrastructure;
using OpenAuth.App.ViewModel;
using OpenAuth.Domain;
using OpenAuth.Domain.Interface;

namespace OpenAuth.App
{
    public class CommonApplyApp
    {
        private IRepository<CommonApply> _repository;
        private IUnitWork _unitWork;

        public CommonApplyApp(IRepository<CommonApply> repository, IUnitWork unitWork)
        {
            _repository = repository;
            _unitWork = unitWork;
        }

        public void AddOrUpdate(CommonApply model)
        {
            if (model.Id == Guid.Empty)
            {
               model.ApplyTime = DateTime.Now;
                _repository.Add(model);
            }
            else
            {
                _repository.Update(u => u.Id == model.Id, u => new CommonApply
                {
                    UserId = model.UserId,
                    Name = model.Name,
                    Comment = model.Comment,
                    WorkflowName =  model.WorkflowName
                });
            }

        }

        /// <summary>
        /// 更改流程状态
        /// </summary>
        public void ChangeState(Guid id,string state,  string statename)
        {
            _repository.Update(u =>u.Id == id, u =>new CommonApply
            {
                State = state,
                StateName = statename
            });
        }

        public CommonApply Get(Guid value)
        {
            return _repository.FindSingle(u =>u.Id == value);
        }

        /// <summary>
        /// 加载流程处理
        /// </summary>
        /// <param name="userid">用户ID</param>
        /// <param name="type">inbox:待办事项/outbox:已办事项</param>
        public GridData Load(Guid userid, string type, int pageCurrent, int pageSize)
        {
            var result = new GridData
            {
                page = pageCurrent
            };

            if (type == "inbox")   //待办事项
            {
                var inboxes = GetInboxProcessIds(userid);
                result.total = _unitWork.Find<CommonApply>(u => inboxes.Contains(u.Id)).Count();
                result.rows = _unitWork.Find<CommonApply>(pageCurrent, pageSize, "Sort descending",u => inboxes.Contains(u.Id)).ToList();
            }
            else if (type == "outbox")  //已办事项
            {
                IQueryable<Guid> outboxes = GetOutboxProcessIds(userid);
                result.total = _unitWork.Find<CommonApply>(u => outboxes.Contains(u.Id)).Count();
                result.rows = _unitWork.Find<CommonApply>(pageCurrent, pageSize, "Sort descending", u => outboxes.Contains(u.Id)).ToList();
            }
            else  //我的流程
            {
                result.total = _unitWork.Find<CommonApply>(u => u.UserId == userid).Count();
                result.rows = _unitWork.Find<CommonApply>(pageCurrent, pageSize, "Sort descending", u => u.UserId == userid).ToList();
            }

            return result;
        }

        private IQueryable<Guid> GetOutboxProcessIds(Guid userid)
        {
            return _unitWork.Find<ApplyTransitionHistory>(u => u.UserId == userid).Select(u => u.ApplyId);
        }

        private IQueryable<Guid> GetInboxProcessIds(Guid userid)
        {
            return _unitWork.Find<Relevance>(u =>u.Key =="ProcessUser" &&(userid == Guid.Empty || u.SecondId == userid)).Select(u =>u.FirstId);
        }

        public void Del(Guid id)
        {
            _repository.Delete(u =>u.Id == id);
        }
    }
}