

using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;

namespace OpenAuth.Domain
{
	/// <summary>
	/// 用户ID
	/// </summary>
	public partial class UserExt
	{

		/// <summary>
		/// 用户ID
		/// </summary>
		/// <returns></returns>
		public int Id { get; set; }


		/// <summary>
		/// 电子邮件
		/// </summary>
		/// <returns></returns>
		public string Email { get; set; }


		/// <summary>
		/// 固定电话
		/// </summary>
		/// <returns></returns>
		public string Phone_ { get; set; }


		/// <summary>
		/// 移动电话
		/// </summary>
		/// <returns></returns>
		public string Mobile { get; set; }


		/// <summary>
		/// 联系地址
		/// </summary>
		/// <returns></returns>
		public string Address { get; set; }


		/// <summary>
		/// 邮编
		/// </summary>
		/// <returns></returns>
		public string Zip { get; set; }


		/// <summary>
		/// 生日
		/// </summary>
		/// <returns></returns>
		public string Birthday { get; set; }


		/// <summary>
		/// 身份证号
		/// </summary>
		/// <returns></returns>
		public string IdCard { get; set; }


		/// <summary>
		/// QQ
		/// </summary>
		/// <returns></returns>
		public string QQ { get; set; }


		/// <summary>
		/// 动态扩展字段
		/// </summary>
		/// <returns></returns>
		public string DynamicField { get; set; }


		/// <summary>
		/// 用户头像流文件ID
		/// </summary>
		/// <returns></returns>
		public int ByteArrayId { get; set; }


		/// <summary>
		/// 备注
		/// </summary>
		/// <returns></returns>
		public string Remark { get; set; }


		/// <summary>
		/// 静态扩展字段1
		/// </summary>
		/// <returns></returns>
		public string Field1 { get; set; }


		/// <summary>
		/// 静态扩展字段2
		/// </summary>
		/// <returns></returns>
		public string Field2 { get; set; }


		/// <summary>
		/// 静态扩展字段3
		/// </summary>
		/// <returns></returns>
		public string Field3 { get; set; }



		public UserExt()
		{
		 
	this.Id= 0;
		  
	this.Email= string.Empty;
		   
	this.Phone_= string.Empty;
		   
	this.Mobile= string.Empty;
		   
	this.Address= string.Empty;
		   
	this.Zip= string.Empty;
		   
	this.Birthday= string.Empty;
		   
	this.IdCard= string.Empty;
		   
	this.QQ= string.Empty;
		   
	this.DynamicField= string.Empty;
		   
	this.ByteArrayId= 0;
		  
	this.Remark= string.Empty;
		   
	this.Field1= string.Empty;
		   
	this.Field2= string.Empty;
		   
	this.Field3= string.Empty;
		   
}
		
	

	}
} 