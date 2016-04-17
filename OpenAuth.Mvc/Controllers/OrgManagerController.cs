using Infrastructure;
using OpenAuth.App;
using OpenAuth.Domain;
using OpenAuth.Mvc.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using Infrastructure.Helper;
using OpenAuth.App.ViewModel;

namespace OpenAuth.Mvc.Controllers
{
    public class OrgManagerController : BaseController
    {
        private OrgManagerApp _orgApp;

        public OrgManagerController()
        {
            _orgApp = AutofacExt.GetFromFac<OrgManagerApp>();
        }

        //
        // GET: /OrgManager/
        public ActionResult Index()
        {
            return View();
        }

        //用于选择模块时使用
        public ActionResult LookUpMultiForUser(int userId)
        {
            ViewBag.UserId = userId;
            return View();
        }

        //为角色分配模块
        public ActionResult LookupMultiForRole(int roleId)
        {
            ViewBag.RoleId = roleId;
            return View();
        }

        public ActionResult AddOrg()
        {
            return View();
        }

        /// <summary>
        /// 返回当前登录用户可访问到的部门
        /// </summary>
        /// <returns>System.String.</returns>
        public string LoadForTree()
        {
            var orgs = SessionHelper.GetSessionUser<LoginUserVM>().AccessedOrgs;
            return JsonHelper.Instance.Serialize(orgs);
        }
        /// <summary>
        /// 返回带有根节点的全部部门，不受用户权限影响
        /// <para>可以匿名访问</para>
        /// </summary>
        /// <returns>System.String.</returns>
        [Anonymous]
        public string LoadOrg()
        {
            var orgs = SessionHelper.GetSessionUser<LoginUserVM>().AccessedOrgs.MapToList<Org>();
            //添加根节点
            orgs.Add(new Org
            {
                Id = 0,
                ParentId = -1,
                Name = "根结点",
                CascadeId = "0"
            });
            return JsonHelper.Instance.Serialize(orgs);
        }

        public string LoadForUser(int userId)
        {
            var orgs = _orgApp.LoadForUser(userId);
            //添加根节点
            orgs.Add(new Org
            {
                Id = 0,
                ParentId = -1,
                Name = "用户及角色可访问的部门",
                CascadeId = "0"
            });
            return JsonHelper.Instance.Serialize(orgs);
        }

        public string LoadForRole(int roleId)
        {
            var orgs = _orgApp.LoadForRole(roleId);
            //添加根节点
            orgs.Add(new Org
            {
                Id = 0,
                ParentId = -1,
                Name = "已为角色分配的可访问部门",
                CascadeId = "0"
            });
            return JsonHelper.Instance.Serialize(orgs);
        }

        public string AssignOrgForRole(int roleId, string moduleIds)
        {
            try
            {
                var ids = moduleIds.Split(',').Select(id => int.Parse(id)).ToArray();
                _orgApp.AssignModuleForRole(roleId, ids);
            }
            catch (Exception e)
            {
                BjuiResponse.message = e.Message;
                BjuiResponse.statusCode = "300";
            }

            return JsonHelper.Instance.Serialize(BjuiResponse);
        }

        public string AssignOrgForUser(int userId, string moduleIds)
        {
            try
            {
                var ids = moduleIds.Split(',').Select(id => int.Parse(id)).ToArray();
                _orgApp.AssignModuleForUser(userId, ids);
            }
            catch (Exception e)
            {
                BjuiResponse.message = e.Message;
                BjuiResponse.statusCode = "300";
            }

            return JsonHelper.Instance.Serialize(BjuiResponse);
        }

        //添加组织提交
        [HttpPost]
        public string AddOrg(Org org)
        {
            try
            {
                _orgApp.AddOrUpdate(org);
            }
            catch (Exception ex)
            {
                BjuiResponse.statusCode = "300";
                BjuiResponse.message = ex.Message;
            }
            return JsonHelper.Instance.Serialize(BjuiResponse);
        }
        
        public string LoadChildren(int id)
        {
            return JsonHelper.Instance.Serialize(_orgApp.LoadAllChildren(id));
        }

        /// <summary>
        /// 删除指定ID的组织
        /// <para>Id为逗号分开的字符串</para>
        /// </summary>
        /// <returns>System.String.</returns>
        public string DelOrg(int Id)
        {
            try
            {
                _orgApp.DelOrg(Id);
            }
            catch (Exception e)
            {
                BjuiResponse.statusCode = "300";
                BjuiResponse.message = e.Message;
            }

            return JsonHelper.Instance.Serialize(BjuiResponse);
        }
    }
}