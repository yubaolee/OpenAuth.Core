using System;
using OpenAuth.App.ViewModel;
using OpenAuth.Domain;
using OpenAuth.Domain.Interface;

namespace OpenAuth.App
{
    public class WorkflowInboxApp
    {
        private IRepository<WorkflowInbox> _repository;

        public WorkflowInboxApp(IRepository<WorkflowInbox> repository)
        {
            _repository = repository;
        }


        public void DeleteAllByProcess(Guid processId)
        {
            _repository.Delete(u =>u.ProcessId == processId);
        }

        public void Add(WorkflowInbox newInboxItem)
        {
            _repository.Add(newInboxItem);
        }
    }
}