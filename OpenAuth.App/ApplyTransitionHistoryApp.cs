using System;
using OpenAuth.Domain;
using OpenAuth.Domain.Interface;

namespace OpenAuth.App
{
    public class ApplyTransitionHistoryApp
    {
        private IRepository<ApplyTransitionHistory> _repository;

        public ApplyTransitionHistoryApp(IRepository<ApplyTransitionHistory> repository)
        {
            _repository = repository;
        }

        public ApplyTransitionHistory Get(Guid processId, string currentstate, string nextState)
        {
            return _repository.FindSingle(h => h.ApplyId == processId && !h.TransitionTime.HasValue &&
                                               h.InitialState == currentstate && h.DestinationState == nextState);
        }

        public void Add(ApplyTransitionHistory historyItem)
        {
            _repository.Add(historyItem);
        }

        public void Update(ApplyTransitionHistory historyItem)
        {
            _repository.Update(u =>u.Id, historyItem);
        }

        public void DeleteByProcess(Guid processId)
        {
            _repository.Delete(dth =>
                        dth.ApplyId == processId && !dth.TransitionTime.HasValue);
        }
    }
}