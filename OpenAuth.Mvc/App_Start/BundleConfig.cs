using System.Web;
using System.Web.Optimization;

namespace OpenAuth.Mvc
{
    public class BundleConfig
    {
        // 有关绑定的详细信息，请访问 http://go.microsoft.com/fwlink/?LinkId=301862
        public static void RegisterBundles(BundleCollection bundles)
        {
            //树形组件
            bundles.Add(new StyleBundle("~/Content/scripts/plugins/tree/css").Include(
                        "~/Content/scripts/plugins/tree/tree.css"));
            bundles.Add(new ScriptBundle("~/Content/scripts/plugins/tree/js").Include(
                       "~/Content/scripts/plugins/tree/tree.js"));
            //表单验证
            bundles.Add(new ScriptBundle("~/Content/scripts/plugins/validator/js").Include(
                      "~/Content/scripts/plugins/validator/validator.js"));
            //日期控件
            bundles.Add(new StyleBundle("~/Content/scripts/plugins/datetime/css").Include(
                        "~/Content/scripts/plugins/datetime/pikaday.css"));
            bundles.Add(new ScriptBundle("~/Content/scripts/plugins/datepicker/js").Include(
                       "~/Content/scripts/plugins/datetime/pikaday.js"));
            //导向组件
            bundles.Add(new StyleBundle("~/Content/scripts/plugins/wizard/css").Include(
                        "~/Content/scripts/plugins/wizard/wizard.css"));
            bundles.Add(new ScriptBundle("~/Content/scripts/plugins/wizard/js").Include(
                       "~/Content/scripts/plugins/wizard/wizard.js"));
            //
            bundles.Add(new StyleBundle("~/Content/styles/ui.css").Include(
                        "~/Content/styles/ui.css"));
            bundles.Add(new ScriptBundle("~/Content/scripts/utils/js").Include(
                       "~/Content/scripts/utils/ui.js",
                       "~/Content/scripts/utils/form.js"));

            //工作流
            bundles.Add(new StyleBundle("~/Content/styles/flowall.css").Include(
            "~/Content/styles/ckbox-radio.css",
            "~/Content/styles/applayout.css",
            "~/Content/styles/flow.css"));
            bundles.Add(new ScriptBundle("~/Content/scripts/flow/js").Include(
              "~/Content/scripts/utils/applayout.js",
              "~/Content/scripts/plugins/flow-ui/flow.js",
              "~/Content/scripts/utils/flowlayout.js"));
        }
    }
}
