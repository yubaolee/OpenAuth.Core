using OpenAuth.Domain.Model;

namespace OpenAuth.Domain.Interface
{
    public interface IUserRepository
    {
        User FindBy(string username);
    }
}