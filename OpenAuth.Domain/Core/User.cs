using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;

namespace OpenAuth.Domain
{
	/// <summary>
	/// 用户ID
	/// </summary>
	public partial class User
	{
	    public void CheckPassword(string password)
	    {
	        if (Password != password)
	        {
	            throw  new Exception("密码错误");
	        }
	    }

	}
} 