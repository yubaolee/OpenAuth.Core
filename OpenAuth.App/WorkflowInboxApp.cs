using System;
using OpenAuth.App.ViewModel;
using OpenAuth.Domain;
using OpenAuth.Domain.Interface;

namespace OpenAuth.App
{
    public class WorkflowInboxApp
    {
        private IRepository<Relevance> _repository;

        public WorkflowInboxApp(IRepository<Relevance> repository)
        {
            _repository = repository;
        }


        public void DeleteAllByProcess(Guid processId)
        {
            _repository.Delete(u =>u.FirstId == processId && u.Key=="ProcessUser");
        }

        public void Add(Relevance newInboxItem)
        {
            _repository.Add(newInboxItem);
        }
    }
}