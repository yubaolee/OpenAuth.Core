namespace OpenAuth.Domain
{
    public partial class Department
    {
        public string DepartmentId { get; set; }
        public string ParentId { get; set; }
        public string FullName { get; set; }
        public string Description { get; set; }
        public bool Enabled { get; set; }
        public int SortCode { get; set; }
        public bool DeleteMark { get; set; }
    }
}
