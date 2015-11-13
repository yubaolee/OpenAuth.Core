

using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;

namespace OpenAuth.Domain
{
	/// <summary>
	/// 用户ID
	/// </summary>
	public partial class Org
	{

		/// <summary>
		/// 用户ID
		/// </summary>
		/// <returns></returns>
		public int Id { get; set; }


		/// <summary>
		/// 节点语义ID
		/// </summary>
		/// <returns></returns>
		public string CascadeId { get; set; }


		/// <summary>
		/// 组织名称
		/// </summary>
		/// <returns></returns>
		public string Name { get; set; }


		/// <summary>
		/// 热键
		/// </summary>
		/// <returns></returns>
		public string HotKey { get; set; }


		/// <summary>
		/// 父节点流水号
		/// </summary>
		/// <returns></returns>
		public int ParentId { get; set; }


		/// <summary>
		/// 父节点名称
		/// </summary>
		/// <returns></returns>
		public string ParentName { get; set; }


		/// <summary>
		/// 是否叶子节点
		/// </summary>
		/// <returns></returns>
		public bool IsLeaf { get; set; }


		/// <summary>
		/// 是否自动展开
		/// </summary>
		/// <returns></returns>
		public bool IsAutoExpand { get; set; }


		/// <summary>
		/// 节点图标文件名称
		/// </summary>
		/// <returns></returns>
		public string IconName { get; set; }


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
		/// 自定义扩展码
		/// </summary>
		/// <returns></returns>
		public string CustomCode { get; set; }


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


		/// <summary>
		/// 排序号
		/// </summary>
		/// <returns></returns>
		public int SortNo { get; set; }



		public Org()
		{
		 
	this.Id= 0;
		  
	this.CascadeId= string.Empty;
		   
	this.Name= string.Empty;
		   
	this.HotKey= string.Empty;
		   
	this.ParentId= 0;
		  
	this.ParentName= string.Empty;
		   
	this.IsLeaf= false;
		  
	this.IsAutoExpand= false;
		  
	this.IconName= string.Empty;
		   
	this.Status= 0;
		  
	this.Type= 0;
		  
	this.BizCode= string.Empty;
		   
	this.CustomCode= string.Empty;
		   
	this.CreateTime= DateTime.Now;
		  
	this.CreateId= 0;
		  
	this.SortNo= 0;
		  
}
		
	

	}
} 