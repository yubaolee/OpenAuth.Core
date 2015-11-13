using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;

namespace OpenAuth.Domain
{
	/// <summary>
	/// 用户ID
	/// </summary>
	public partial class ModuleElement
	{
		/// <summary>
		/// 用户ID
		/// </summary>
		/// <returns></returns>
		public int Id { get; set; }

		/// <summary>
		/// DOM ID
		/// </summary>
		/// <returns></returns>
		public string DomId { get; set; }

		/// <summary>
		/// 组织名称
		/// </summary>
		/// <returns></returns>
		public string Name { get; set; }

		/// <summary>
		/// 组织类型
		/// </summary>
		/// <returns></returns>
		public int Type { get; set; }

		/// <summary>
		/// 所属功能模块流水号
		/// </summary>
		/// <returns></returns>
		public int ModuleId { get; set; }

		/// <summary>
		/// 备注
		/// </summary>
		/// <returns></returns>
		public string Remark { get; set; }


		public ModuleElement()
		{
		 	this.Id= 0;
		  	this.DomId= string.Empty;
		   	this.Name= string.Empty;
		   	this.Type= 0;
		  	this.ModuleId= 0;
		  	this.Remark= string.Empty;
		   }
		
	

	}
} 