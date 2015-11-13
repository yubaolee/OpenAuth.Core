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
		/// <summary>
		/// 用户ID
		/// </summary>
		/// <returns></returns>
		public int Id { get; set; }

		/// <summary>
		/// 
		/// </summary>
		/// <returns></returns>
		public string Account { get; set; }

		/// <summary>
		/// 
		/// </summary>
		/// <returns></returns>
		public string Password { get; set; }

		/// <summary>
		/// 组织名称
		/// </summary>
		/// <returns></returns>
		public string Name { get; set; }

		/// <summary>
		/// 
		/// </summary>
		/// <returns></returns>
		public int Sex { get; set; }

		/// <summary>
		/// 当前状态
		/// </summary>
		/// <returns></returns>
		public int Status { get; set; }

		/// <summary>
		/// 组织类型
		/// </summary>
		/// <returns></returns>
		public int Type { get; set; }

		/// <summary>
		/// 业务对照码
		/// </summary>
		/// <returns></returns>
		public string BizCode { get; set; }

		/// <summary>
		/// 创建时间
		/// </summary>
		/// <returns></returns>
		public System.DateTime CreateTime { get; set; }

		/// <summary>
		/// 创建人ID
		/// </summary>
		/// <returns></returns>
		public int CreateId { get; set; }


		public User()
		{
		 	this.Id= 0;
		  	this.Account= string.Empty;
		   	this.Password= string.Empty;
		   	this.Name= string.Empty;
		   	this.Sex= 0;
		  	this.Status= 0;
		  	this.Type= 0;
		  	this.BizCode= string.Empty;
		   	this.CreateTime= DateTime.Now;
		  	this.CreateId= 0;
		  }
		
	

	}
} 