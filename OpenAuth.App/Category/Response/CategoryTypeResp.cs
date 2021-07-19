using OpenAuth.Repository.Domain;

namespace OpenAuth.App.Response
{
    public class CategoryTypeResp : CategoryType
    {
        public string ParentId { get; set; }
        
    }
}