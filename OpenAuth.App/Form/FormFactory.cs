using System;

namespace OpenAuth.App
{
    public class FormFactory
    {
        public static IForm CreateForm(Repository.Domain.Form form)
        {
            if (form.FrmType == 0)
            {
                return new LeipiForm();
            }else if (form.FrmType == 1)
            {
                throw new Exception("自定义表单不需要创建数据库表");
            }
            else
            {
                return new DragForm();
            }
        }
    }
}