using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;

namespace OpenAuth.Domain
{
	/// <summary>
	/// 用户ID
	/// </summary>
	public partial class UserCfg
	{
		/// <summary>
		/// 用户ID
		/// </summary>
		/// <returns></returns>
		public int Id { get; set; }

		/// <summary>
		/// 用户界面主题
		/// </summary>
		/// <returns></returns>
		public string Theme { get; set; }

		/// <summary>
		/// 用户界面皮肤
		/// </summary>
		/// <returns></returns>
		public string Skin { get; set; }

		/// <summary>
		/// 导航条按钮风格
		/// </summary>
		/// <returns></returns>
		public string NavBarStyle { get; set; }

		/// <summary>
		/// Tab高亮颜色
		/// </summary>
		/// <returns></returns>
		public string TabFocusColor { get; set; }

		/// <summary>
		/// 导航缺省活动页
		/// </summary>
		/// <returns></returns>
		public int NavTabIndex { get; set; }


		public UserCfg()
		{
		 	this.Id= 0;
		  	this.Theme= string.Empty;
		   	this.Skin= string.Empty;
		   	this.NavBarStyle= string.Empty;
		   	this.TabFocusColor= string.Empty;
		   	this.NavTabIndex= 0;
		  }
		
	

	}
} 