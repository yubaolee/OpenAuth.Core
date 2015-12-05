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
		/// 元素的类型(如：button/a）
		/// </summary>
		/// <returns></returns>
		public string Type { get; set; }

		/// <summary>
		/// 功能模块Id
		/// </summary>
		/// <returns></returns>
		public int ModuleId { get; set; }

		/// <summary>
		/// 元素附加属性
		/// </summary>
		/// <returns></returns>
		public string Attr { get; set; }

		/// <summary>
		/// 元素调用脚本
		/// </summary>
		/// <returns></returns>
		public string Script { get; set; }

		/// <summary>
		/// 元素图标
		/// </summary>
		/// <returns></returns>
		public string Icon { get; set; }

		/// <summary>
		/// 元素样式
		/// </summary>
		/// <returns></returns>
		public string Class { get; set; }

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
		    this.Type = string.Empty;
		  	this.ModuleId= 0;
		  	this.Attr= string.Empty;
		   	this.Script= string.Empty;
		   	this.Icon= string.Empty;
		   	this.Class= string.Empty;
		   	this.Remark= string.Empty;
		   }
		
	

	}
} 