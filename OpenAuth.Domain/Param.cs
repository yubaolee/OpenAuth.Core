using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;

namespace OpenAuth.Domain
{
	/// <summary>
	/// 键值
	/// </summary>
	public partial class Param
	{
		/// <summary>
		/// ID
		/// </summary>
		/// <returns></returns>
		public int Id { get; set; }

		/// <summary>
		/// 名称
		/// </summary>
		/// <returns></returns>
		public string Value { get; set; }

		/// <summary>
		/// 
		/// </summary>
		/// <returns></returns>
		public string Key { get; set; }

		/// <summary>
		/// 资源分类标识
		/// </summary>
		/// <returns></returns>
		public int CategoryId { get; set; }

		/// <summary>
		/// 排序号
		/// </summary>
		/// <returns></returns>
		public int SortNo { get; set; }

		/// <summary>
		/// 资源分类标识
		/// </summary>
		/// <returns></returns>
		public int Status { get; set; }

		/// <summary>
		/// 描述
		/// </summary>
		/// <returns></returns>
		public string Description { get; set; }


		public Param()
		{
		 	this.Id= 0;
		  	this.Value= string.Empty;
		   	this.Key= string.Empty;
		   	this.CategoryId= 0;
		  	this.SortNo= 0;
		  	this.Status= 0;
		  	this.Description= string.Empty;
		   }
		
	

	}
} 