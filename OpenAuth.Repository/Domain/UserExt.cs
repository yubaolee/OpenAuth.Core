using System;

namespace OpenAuth.Repository.Domain
{
	/// <summary>
	/// 用户ID
	/// </summary>
	public static class UserExt
	{
	    public static void  CheckPassword(this SysUser sysUser, string password)
	    {
	        if (sysUser.Password != password)
	        {
	            throw  new Exception("密码错误");
	        }
	    }

	}
} 