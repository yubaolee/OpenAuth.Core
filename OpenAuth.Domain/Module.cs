using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;

namespace OpenAuth.Domain
{
	/// <summary>
	/// 模块
	/// </summary>
	public partial class Module
	{
		/// <summary>
        /// 模块ID
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
		/// 主页面URL
		/// </summary>
		/// <returns></returns>
		public string Url { get; set; }

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
		/// 资源分类标识
		/// </summary>
		/// <returns></returns>
		public int Status { get; set; }

		/// <summary>
		/// 父节点名称
		/// </summary>
		/// <returns></returns>
		public string ParentName { get; set; }

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


		public Module()
		{
		 	this.Id= 0;
		  	this.CascadeId= string.Empty;
		   	this.Name= string.Empty;
		   	this.Url= string.Empty;
		   	this.HotKey= string.Empty;
		   	this.ParentId= 0;
		  	this.IsLeaf= false;
		  	this.IsAutoExpand= false;
		  	this.IconName= string.Empty;
		   	this.Status= 0;
		  	this.ParentName= string.Empty;
		   	this.Vector= string.Empty;
		   	this.SortNo= 0;
		  }
		
	

	}
} 