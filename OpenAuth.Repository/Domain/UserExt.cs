using System;

namespace OpenAuth.Domain
{
	/// <summary>
	/// 用户ID
	/// </summary>
	public static class UserExt
	{
	    public static void  CheckPassword(this User user, string password)
	    {
	        if (user.Password != password)
	        {
	            throw  new Exception("密码错误");
	        }
	    }

	}
} 