using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;

namespace OpenAuth.Domain
{
	/// <summary>
	/// 用户ID
	/// </summary>
	public partial class Relevance
	{
		/// <summary>
		/// 用户ID
		/// </summary>
		/// <returns></returns>
		public int Id { get; set; }

		/// <summary>
		/// 第一个表主键ID
		/// </summary>
		/// <returns></returns>
		public int FirstId { get; set; }

		/// <summary>
		/// 第二个表主键ID
		/// </summary>
		/// <returns></returns>
		public int SecondId { get; set; }

		/// <summary>
		/// 描述
		/// </summary>
		/// <returns></returns>
		public string Description { get; set; }

		/// <summary>
		/// 
		/// </summary>
		/// <returns></returns>
		public string Key { get; set; }

		/// <summary>
		/// 状态
		/// </summary>
		/// <returns></returns>
		public int Status { get; set; }

		/// <summary>
		/// 授权时间
		/// </summary>
		/// <returns></returns>
		public System.DateTime OperateTime { get; set; }

		/// <summary>
		/// 授权人
		/// </summary>
		/// <returns></returns>
		public int OperatorId { get; set; }


		public Relevance()
		{
		 	this.Id= 0;
		  	this.FirstId= 0;
		  	this.SecondId= 0;
		  	this.Description= string.Empty;
		   	this.Key= string.Empty;
		   	this.Status= 0;
		  	this.OperateTime= DateTime.Now;
		  	this.OperatorId= 0;
		  }
		
	

	}
} 