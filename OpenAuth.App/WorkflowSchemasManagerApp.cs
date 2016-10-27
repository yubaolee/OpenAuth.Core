using System.Linq;
using System.Web.Mvc;
using Infrastructure;
using OpenAuth.App.ViewModel;
using OpenAuth.Domain;
using OpenAuth.Domain.Interface;

namespace OpenAuth.App
{
    /// <summary>
    /// 工作流模板
    /// </summary>
    public class WorkflowSchemasManagerApp
    {
        private IWorkflowSchemeRepository _repository;

        public WorkflowSchemasManagerApp(IWorkflowSchemeRepository repository)
        {
            _repository = repository;
        }
        public GridData Load(int pageCurrent, int pageSize)
        {
            var result = new GridData
            {
                page = pageCurrent,
                total = _repository.GetCount(),
                rows = _repository.Find(pageCurrent, pageSize, "Code", null).ToList()
            };

            return result;
        }
        [HttpPost]
        public void Del(string[] codes)
        {
            _repository.Delete(u =>codes.Contains(u.Code));
        }
    }
}