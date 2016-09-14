using System.Linq;
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
                pageCurrent = pageCurrent,
                total = _repository.GetCount(),
                list = _repository.Find(pageCurrent, pageSize, "Code", null).ToList()
            };

            return result;
        }

        public void Del(string code)
        {
            _repository.Delete(u =>u.Code == code);
        }
    }
}