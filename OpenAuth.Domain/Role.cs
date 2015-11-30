using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;

namespace OpenAuth.Domain
{
	/// <summary>
	/// 用户ID
	/// </summary>
	public partial class Role
	{
		/// <summary>
		/// 用户ID
		/// </summary>
		/// <returns></returns>
		public int Id { get; set; }

		/// <summary>
		/// 组织名称
		/// </summary>
		/// <returns></returns>
		public string Name { get; set; }

		/// <summary>
		/// 状态
		/// </summary>
		/// <returns></returns>
		public int Status { get; set; }

		/// <summary>
		/// 组织类型
		/// </summary>
		/// <returns></returns>
		public int Type { get; set; }

		/// <summary>
		/// 创建时间
		/// </summary>
		/// <returns></returns>
		public System.DateTime CreateTime { get; set; }

		/// <summary>
		/// 创建人ID
		/// </summary>
		/// <returns></returns>
		public string CreateId { get; set; }

		/// <summary>
		/// 所属部门流水号
		/// </summary>
		/// <returns></returns>
		public int OrgId { get; set; }

		/// <summary>
		/// 所属部门节点语义ID
		/// </summary>
		/// <returns></returns>
		public string OrgCascadeId { get; set; }

		/// <summary>
		/// 所属部门名称
		/// </summary>
		/// <returns></returns>
		public string OrgName { get; set; }


		public Role()
		{
		 	this.Id= 0;
		  	this.Name= string.Empty;
		   	this.Status= 0;
		  	this.Type= 0;
		  	this.CreateTime= DateTime.Now;
		  	this.CreateId= string.Empty;
		   	this.OrgId= 0;
		  	this.OrgCascadeId= string.Empty;
		   	this.OrgName= string.Empty;
		   }
		
	

	}
} 