namespace OpenAuth.Domain
{
    public partial class Menu
    {
        public string MenuId { get; set; }
        public string ParentId { get; set; }
        public string FullName { get; set; }
        public string Description { get; set; }
        public string Img { get; set; }
        public int Category { get; set; }
        public string NavigateUrl { get; set; }
        public string FormName { get; set; }
        public string Target { get; set; }
        public bool IsUnfold { get; set; }
        public bool Enabled { get; set; }
        public int SortCode { get; set; }
    }
}
