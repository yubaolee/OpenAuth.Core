using System;

namespace OpenAuth.App
{
    public static class Define
    {
        public static string USERROLE = "UserRole";       //用户角色关联KEY
        public const string ROLERESOURCE= "RoleResource";  //角色资源关联KEY
        public const string USERORG = "UserOrg";  //用户机构关联KEY
        public const string ROLEELEMENT = "RoleElement"; //角色菜单关联KEY
        public const string ROLEMODULE = "RoleModule";   //角色模块关联KEY
        public const string ROLEDATAPROPERTY = "RoleDataProperty";   //角色数据字段权限

        public const string DBTYPE_SQLSERVER = "SqlServer";    //sql server


        public const int INVALID_TOKEN = 50014;     //token无效

        public const string TOKEN_NAME = "X-Token";


        public const string SYSTEM_USERNAME = "System";
        public const string SYSTEM_USERPWD = "123456";

        public const string DATAPRIVILEGE_LOGINUSER = "{loginUser}";  //数据权限配置中，当前登录用户的key
        public const string DATAPRIVILEGE_LOGINROLE = "{loginRole}";  //数据权限配置中，当前登录用户角色的key
        public const string DATAPRIVILEGE_LOGINORG = "{loginOrg}";  //数据权限配置中，当前登录用户部门的key

        public const string JOBMAPKEY = "OpenJob";
    }
}
