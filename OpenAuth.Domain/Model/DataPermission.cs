using OpenAuth.Domain.Utility;

namespace OpenAuth.Domain.Model
{
    public partial class DataPermission :EntityBase<string>, IAggregateRoot
    {
        public string RoleId { get; set; }
        public string ResourceId { get; set; }
        public string ObjectId { get; set; }
        public virtual Role Role { get; set; }
        protected override void Validate()
        {
            throw new System.NotImplementedException();
        }
    }
}
