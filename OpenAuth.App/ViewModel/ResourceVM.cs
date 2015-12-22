namespace OpenAuth.App.ViewModel
{
    public  class ResourceVM
    {
        /// <summary>
        /// 资源表ID
        /// </summary>
        /// <returns></returns>
        public int Id { get; set; }


        /// <summary>
        ///
        /// </summary>
        /// <returns></returns>
        public string Key { get; set; }

        /// <summary>
        /// 组织名称
        /// </summary>
        /// <returns></returns>
        public string Name { get; set; }

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

        public bool IsBelongUser { get; set; }
    }
}