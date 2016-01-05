using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;

namespace OpenAuth.Domain
{
	/// <summary>
	/// 分类列表
	/// </summary>
	public partial class Category
	{
		/// <summary>
		/// 分类ID
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
		/// 父节点流水号
		/// </summary>
		/// <returns></returns>
		public int ParentId { get; set; }

		/// <summary>
		/// 资源分类标识
		/// </summary>
		/// <returns></returns>
		public int Status { get; set; }

		/// <summary>
		/// 排序号
		/// </summary>
		/// <returns></returns>
		public int SortNo { get; set; }

		/// <summary>
		/// 资源分类标识
		/// </summary>
		/// <returns></returns>
		public string RootKey { get; set; }

		/// <summary>
		/// 资源分类
		/// </summary>
		/// <returns></returns>
		public string RootName { get; set; }


		public Category()
		{
		 	this.Id= 0;
		  	this.CascadeId= string.Empty;
		   	this.Name= string.Empty;
		   	this.ParentId= 0;
		  	this.Status= 0;
		  	this.SortNo= 0;
		  	this.RootKey= string.Empty;
		   	this.RootName= string.Empty;
		   }
		
	

	}
} 