namespace OpenAuth.Domain
{
    public partial class RoleMenuButton
    {
        public string RoleMenuButtonId { get; set; }
        public string RoleId { get; set; }
        public string MenuId { get; set; }
        public string ButtonId { get; set; }
        public virtual Button Button { get; set; }
        public virtual Menu Menu { get; set; }
        public virtual Role Role { get; set; }
    }
}
