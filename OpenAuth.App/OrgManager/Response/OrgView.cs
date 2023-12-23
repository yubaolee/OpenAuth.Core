using System.ComponentModel;
using OpenAuth.Repository.Domain;

namespace OpenAuth.App.Response;

public class OrgView: SysOrg
{
    /// <summary>
    /// 负责人
    /// </summary>
    [Description("负责人")]
    public string ChairmanName { get; set; }
}