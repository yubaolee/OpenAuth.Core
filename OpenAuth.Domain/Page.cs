

using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;

namespace OpenAuth.Domain
{
	/// <summary>
	/// 用户ID
	/// </summary>
	public partial class Page
	{

		/// <summary>
		/// 用户ID
		/// </summary>
		/// <returns></returns>
		public int Id { get; set; }


		/// <summary>
		/// 所属功能模块流水号
		/// </summary>
		/// <returns></returns>
		public int ModuleId { get; set; }


		/// <summary>
		/// 组织名称
		/// </summary>
		/// <returns></returns>
		public string Name { get; set; }


		/// <summary>
		/// 主页面URL
		/// </summary>
		/// <returns></returns>
		public string Url { get; set; }


		/// <summary>
		/// 组织类型
		/// </summary>
		/// <returns></returns>
		public int Type { get; set; }


		/// <summary>
		/// 使能状态
		/// </summary>
		/// <returns></returns>
		public bool Enabled { get; set; }


		/// <summary>
		/// 是否缺省子页面
		/// </summary>
		/// <returns></returns>
		public bool IsDefault { get; set; }


		/// <summary>
		/// 小图标
		/// </summary>
		/// <returns></returns>
		public string Icon { get; set; }


		/// <summary>
		/// 大图标
		/// </summary>
		/// <returns></returns>
		public string IconBig { get; set; }


		/// <summary>
		/// 矢量图标
		/// </summary>
		/// <returns></returns>
		public string Vector { get; set; }


		/// <summary>
		/// 排序号
		/// </summary>
		/// <returns></returns>
		public int SortNo { get; set; }



		public Page()
		{
		 
	this.Id= 0;
		  
	this.ModuleId= 0;
		  
	this.Name= string.Empty;
		   
	this.Url= string.Empty;
		   
	this.Type= 0;
		  
	this.Enabled= false;
		  
	this.IsDefault= false;
		  
	this.Icon= string.Empty;
		   
	this.IconBig= string.Empty;
		   
	this.Vector= string.Empty;
		   
	this.SortNo= 0;
		  
}
		
	

	}
} 