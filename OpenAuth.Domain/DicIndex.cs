using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;

namespace OpenAuth.Domain
{
	/// <summary>
	/// 数据字典
	/// </summary>
	public partial class DicIndex
	{
		/// <summary>
		/// ID
		/// </summary>
		/// <returns></returns>
		public int Id { get; set; }

		/// <summary>
		/// 组织名称
		/// </summary>
		/// <returns></returns>
		public string Name { get; set; }

		/// <summary>
		/// 
		/// </summary>
		/// <returns></returns>
		public string Key { get; set; }

		/// <summary>
		/// 排序号
		/// </summary>
		/// <returns></returns>
		public int SortNo { get; set; }

		/// <summary>
		/// 资源分类标识
		/// </summary>
		/// <returns></returns>
		public int CategoryId { get; set; }

		/// <summary>
		/// 描述
		/// </summary>
		/// <returns></returns>
		public string Description { get; set; }


		public DicIndex()
		{
		 	this.Id= 0;
		  	this.Name= string.Empty;
		   	this.Key= string.Empty;
		   	this.SortNo= 0;
		  	this.CategoryId= 0;
		  	this.Description= string.Empty;
		   }
		
	

	}
} 