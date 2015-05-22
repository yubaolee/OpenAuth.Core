using System.Collections.Generic;

namespace OpenAuth.Domain.Utility
{
    public interface IReadOnlyRepository<T, TId> where T : IAggregateRoot
    {
        T FindBy(TId id);
        IEnumerable<T> FindAll();

    }
}
