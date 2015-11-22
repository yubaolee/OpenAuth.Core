using System.Collections.Generic;
using Infrastructure;
using OpenAuth.Domain;

namespace OpenAuth.App.ViewModel
{
    public class ModuleView
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
        /// 主页面URL
        /// </summary>
        /// <returns></returns>
        public string Url { get; set; }

        /// <summary>
        /// 父节点流水号
        /// </summary>
        /// <returns></returns>
        public int ParentId { get; set; }

        /// <summary>
        /// 节点图标文件名称
        /// </summary>
        /// <returns></returns>
        public string IconName { get; set; }

        /// <summary>
        /// 子节点
        /// </summary>
        public List<ModuleView> Childern  = new List<ModuleView>();

        public static implicit operator ModuleView(Module module)
        {
            return AutoMapperExt.ConvertTo<Module, ModuleView>(module);
        }

        public static implicit operator Module(ModuleView view)
        {
            return AutoMapperExt.ConvertTo<ModuleView, Module>(view);
        }

    }
}
