using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;

namespace OpenAuth.Domain
{
	/// <summary>
	/// 数据字典详情
	/// </summary>
	public partial class DicDetail
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
		public string Text { get; set; }

		/// <summary>
		/// 
		/// </summary>
		/// <returns></returns>
		public int DicId { get; set; }

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


		public DicDetail()
		{
		 	this.Id= 0;
		  	this.Value= string.Empty;
		   	this.Text= string.Empty;
		   	this.DicId= 0;
		  	this.SortNo= 0;
		  	this.Status= 0;
		  	this.Description= string.Empty;
		   }
		
	

	}
} 