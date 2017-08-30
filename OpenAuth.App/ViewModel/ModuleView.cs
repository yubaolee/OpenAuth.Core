using System;
using Infrastructure;
using OpenAuth.Domain;
using System.Collections.Generic;

namespace OpenAuth.App.ViewModel
{
    public class ModuleView
    {
        /// <summary>
        /// ID
        /// </summary>
        /// <returns></returns>
        public Guid Id { get; set; }

        /// <summary>
        /// 名称
        /// </summary>
        /// <returns></returns>
        public string Name { get; set; }

        /// <summary>
        /// 主页面URL
        /// </summary>
        /// <returns></returns>
        public string Url { get; set; }

        /// <summary>
        /// 父节点流水号
        /// </summary>
        /// <returns></returns>
        public Guid? ParentId { get; set; }

        /// <summary>
        /// 节点图标文件名称
        /// </summary>
        /// <returns></returns>
        public string IconName { get; set; }


        public bool Checked { get; set; }

        /// <summary>
        /// 模块中的元素
        /// </summary>
        public List<ModuleElement> Elements = new List<ModuleElement>();

        public static implicit operator ModuleView(Module module)
        {
            return module.MapTo<ModuleView>();
        }

        public static implicit operator Module(ModuleView view)
        {
            return view.MapTo<Module>();
        }
    }
}