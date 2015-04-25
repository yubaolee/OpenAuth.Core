namespace OpenAuth.Domain.Model
{
    public partial class DataPermission
    {
        public string Id { get; set; }
        public string RoleId { get; set; }
        public string ResourceId { get; set; }
        public string ObjectId { get; set; }
        public virtual Role Role { get; set; }
    }
}
