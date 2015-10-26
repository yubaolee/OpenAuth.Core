using System.Collections.Generic;
using OpenAuth.Domain;
using OpenAuth.Domain.Interface;

namespace OpenAuth.App
{
    public class OrgManagerApp
    {
        private IOrgRepository _repository;

        public OrgManagerApp(IOrgRepository repository)
        {
            _repository = repository;
        }


        public IEnumerable<Org> GetAll()
        {
            return _repository.LoadOrgs();
        }
    }
}
