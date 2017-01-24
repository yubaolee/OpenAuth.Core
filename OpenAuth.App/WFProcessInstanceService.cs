using System;
using System.Linq;
using OpenAuth.App.Extention;
using OpenAuth.App.ViewModel;
using OpenAuth.Domain;
using OpenAuth.Domain.Interface;

namespace OpenAuth.App
{
    /// <summary>
    /// 工作流实例表操作
    /// <para>李玉宝新增于2017-01-16 20:33:48</para>
    /// </summary>
    public class WFProcessInstanceService 
    {
        protected IUnitWork _unitWork;

        public WFProcessInstanceService(IUnitWork unitWork)
        {
            _unitWork = unitWork;
        }

        #region 获取数据
        /// <summary>
        /// 获取实例进程信息实体
        /// </summary>
        /// <param name="keyVlaue"></param>
        /// <returns></returns>
        public WFProcessInstance GetEntity(Guid keyVlaue)
        {
            try
            {
                return _unitWork.FindSingle<WFProcessInstance>(u =>u.Id == keyVlaue);
            }
            catch
            {
                throw;
            }
        }
        #endregion

        #region 提交数据
        /// <summary>
        /// 存储工作流实例进程(编辑草稿用)
        /// </summary>
        /// <param name="processInstanceEntity"></param>
        /// <param name="processSchemeEntity"></param>
        /// <param name="wfOperationHistoryEntity"></param>
        /// <returns></returns>
        public int SaveProcess(Guid processId, WFProcessInstance processInstanceEntity, WFProcessScheme processSchemeEntity, WFProcessOperationHistory wfOperationHistoryEntity = null)
        {
            try
            {
                if (Guid.Empty ==(processInstanceEntity.Id))
                {
                    _unitWork.Add(processSchemeEntity);

                    processInstanceEntity.Create();
                    processInstanceEntity.Id = processId;
                    processInstanceEntity.ProcessSchemeId = processSchemeEntity.Id;
                    _unitWork.Add(processInstanceEntity);
                }
                else
                {
                    processInstanceEntity.Modify(processId);
                    _unitWork.Update(processInstanceEntity);

                    processSchemeEntity.Modify(processInstanceEntity.ProcessSchemeId);
                    _unitWork.Update(processSchemeEntity);
                }
                if (wfOperationHistoryEntity != null)
                {
                    wfOperationHistoryEntity.ProcessId = processId;
                    _unitWork.Add(wfOperationHistoryEntity);
                }
                _unitWork.Save();
                return 1;
            }
            catch
            {
                throw;
            }
        }
        /// <summary>
        /// 存储工作流实例进程(创建实例进程)
        /// </summary>
        /// <param name="wfRuntimeModel"></param>
        /// <param name="processInstanceEntity"></param>
        /// <param name="processSchemeEntity"></param>
        /// <param name="processOperationHistoryEntity"></param>
        /// <param name="delegateRecordEntity"></param>
        /// <returns></returns>
        public int SaveProcess(WF_RuntimeModel wfRuntimeModel, WFProcessInstance processInstanceEntity, WFProcessScheme processSchemeEntity, WFProcessOperationHistory processOperationHistoryEntity, WFProcessTransitionHistory processTransitionHistoryEntity)
        {
            try
            {
                if (Guid.Empty == (processInstanceEntity.Id))
                {
                    processSchemeEntity.Create();
                    _unitWork.Add(processSchemeEntity);

                    processInstanceEntity.Create();
                    processInstanceEntity.Id = Guid.Parse(wfRuntimeModel.processId);
                    processInstanceEntity.ProcessSchemeId = processSchemeEntity.Id;
                    _unitWork.Add(processInstanceEntity);
                }
                else
                {
                    processInstanceEntity.Modify(processInstanceEntity.Id);
                    _unitWork.Update(processSchemeEntity);
                    _unitWork.Update(processInstanceEntity);
                }
                processOperationHistoryEntity.ProcessId = processInstanceEntity.Id;
                _unitWork.Add(processOperationHistoryEntity);

                if (processTransitionHistoryEntity != null)
                {
                    processTransitionHistoryEntity.ProcessId = processInstanceEntity.Id;
                    _unitWork.Add(processTransitionHistoryEntity);
                }
              
                _unitWork.Save();
                return 1;
            }
            catch
            {
                throw;
            }
        }
        /// <summary>
        /// 存储工作流实例进程（审核驳回重新提交）
        /// </summary>
        /// <param name="processInstanceEntity"></param>
        /// <param name="processSchemeEntity"></param>
        /// <param name="processOperationHistoryEntity"></param>
        /// <param name="processTransitionHistoryEntity"></param>
        /// <returns></returns>
        public int SaveProcess(WFProcessInstance processInstanceEntity, WFProcessScheme processSchemeEntity, 
            WFProcessOperationHistory processOperationHistoryEntity,  WFProcessTransitionHistory processTransitionHistoryEntity = null)
        {
            try
            {
                processInstanceEntity.Modify(processInstanceEntity.Id);
                _unitWork.Update(processSchemeEntity);
                _unitWork.Update(processInstanceEntity);

                processOperationHistoryEntity.ProcessId = processInstanceEntity.Id;
                _unitWork.Add(processOperationHistoryEntity);

                if (processTransitionHistoryEntity != null)
                {
                    processTransitionHistoryEntity.ProcessId = processInstanceEntity.Id;
                    _unitWork.Add(processTransitionHistoryEntity);
                }
               
                _unitWork.Save();
                return 1;
            }
            catch
            {
                throw;
            }
        }
        /// <summary>
        ///  更新流程实例 审核节点用
        /// </summary>
        /// <param name="sql"></param>
        /// <param name="dbbaseId"></param>
        /// <param name="processInstanceEntity"></param>
        /// <param name="processSchemeEntity"></param>
        /// <param name="processOperationHistoryEntity"></param>
        /// <param name="delegateRecordEntityList"></param>
        /// <param name="processTransitionHistoryEntity"></param>
        /// <returns></returns>
        public int SaveProcess(string sql,string dbbaseId, WFProcessInstance processInstanceEntity, WFProcessScheme processSchemeEntity, WFProcessOperationHistory processOperationHistoryEntity, WFProcessTransitionHistory processTransitionHistoryEntity = null)
        {
            try
            {
                processInstanceEntity.Modify(processInstanceEntity.Id);
                _unitWork.Update(processSchemeEntity);
                _unitWork.Update(processInstanceEntity);

                processOperationHistoryEntity.ProcessId = processInstanceEntity.Id;
                _unitWork.Add(processOperationHistoryEntity);

                if (processTransitionHistoryEntity != null)
                {
                    processTransitionHistoryEntity.ProcessId = processInstanceEntity.Id;
                    _unitWork.Add(processTransitionHistoryEntity);
                }
               
                //if (!string.IsNullOrEmpty(dbbaseId) && !string.IsNullOrEmpty(sql))//测试环境不允许执行sql语句
                //{
                //    DataBaseLinkEntity dataBaseLinkEntity = dataBaseLinkService.GetEntity(dbbaseId);//获取
                //    this.BaseRepository(dataBaseLinkEntity.DbConnection).ExecuteBySql(sql.Replace("{0}", processInstanceEntity.Id));
                //}
                _unitWork.Save();
                return 1;
            }
            catch
            {
                throw;
            }
        }
        /// <summary>
        /// 保存工作流进程实例
        /// </summary>
        /// <param name="processInstanceEntity"></param>
        /// <returns></returns>
        public int SaveProcess(WFProcessInstance processInstanceEntity)
        {
            try
            {
                WFProcessInstance isExistEntity = _unitWork.FindSingle<WFProcessInstance>(u =>u.Id ==processInstanceEntity.Id);
                if (isExistEntity == null)
                {
                    processInstanceEntity.Create();
                    _unitWork.Add(processInstanceEntity);
                }
                else
                {
                    processInstanceEntity.Modify(processInstanceEntity.Id);
                    _unitWork.Update(processInstanceEntity);
                }
                return 1;
            }
            catch
            {
                throw;
            }
        }
        /// <summary>
        /// 删除工作流实例进程(删除草稿使用)
        /// </summary>
        /// <param name="keyValue">主键</param>
        /// <returns></returns>
        public int DeleteProcess(Guid keyValue)
        {
            try
            {
                WFProcessInstance entity = _unitWork.FindSingle<WFProcessInstance>(u =>u.Id ==keyValue);

                _unitWork.Delete<WFProcessInstance>(u =>u.Id == keyValue);
                _unitWork.Delete<WFProcessScheme>(u =>u.Id == entity.ProcessSchemeId);
                _unitWork.Save();
                return 1;
            }
            catch {
                throw;
            }
        }
        /// <summary>
        /// 虚拟操作实例
        /// </summary>
        /// <param name="keyValue"></param>
        /// <param name="state">0暂停,1启用,2取消（召回）</param>
        /// <returns></returns>
        public int OperateVirtualProcess(Guid keyValue,int state)
        {
            try
            {
                WFProcessInstance entity = _unitWork.FindSingle<WFProcessInstance>(u =>u.Id ==keyValue);
                if (entity.IsFinish == 1)
                {
                    throw new Exception("实例已经审核完成,操作失败");
                }
                else if (entity.IsFinish == 2)
                {
                    throw new Exception("实例已经取消,操作失败");
                }
                /// 流程是否完成(0运行中,1运行结束,2被召回,3不同意,4表示被驳回)
                string content = "";
                switch (state)
                {
                    case 0:
                        if (entity.EnabledMark == 0)
                        {
                            return 1;
                        }
                        entity.EnabledMark = 0;
                        content = "【暂停】暂停了一个流程进程【" + entity.Code + "/" + entity.CustomName + "】";
                        break;
                    case 1:
                        if (entity.EnabledMark == 1)
                        {
                            return 1;
                        }
                        entity.EnabledMark = 1;
                        content = "【启用】启用了一个流程进程【" + entity.Code + "/" + entity.CustomName + "】";
                        break;
                    case 2:
                        entity.IsFinish = 2;
                        content = "【召回】召回了一个流程进程【" + entity.Code + "/" + entity.CustomName + "】";
                        break;
                }
                _unitWork.Update(entity);
                WFProcessOperationHistory processOperationHistoryEntity = new WFProcessOperationHistory();
                processOperationHistoryEntity.ProcessId = entity.Id;
                processOperationHistoryEntity.Content = content;
                _unitWork.Add(processOperationHistoryEntity);
                _unitWork.Save();
                return 1;
            }
            catch
            {
                throw;
            }
        }
        /// <summary>
        /// 流程指派
        /// </summary>
        /// <param name="processId"></param>
        /// <param name="makeLists"></param>
        public void DesignateProcess(Guid processId, string makeLists)
        {
            try
            {
                WFProcessInstance entity = new WFProcessInstance();
                entity.Id = processId;
                entity.MakerList = makeLists;
                _unitWork.Update(entity);
            }
            catch {
                throw;
            }
        }
        #endregion

        public GridData Load(string userid, string type, int pageCurrent, int pageSize)
        {
            var result = new GridData
            {
                page = pageCurrent
            };

            var cnt = _unitWork.Find<WFProcessInstance>(u => u.CreateUserId == userid).Count();
            if (type == "inbox")   //待办事项
            {
                result.total = cnt%pageSize == 0? cnt/pageSize : cnt/pageSize + 1;
                result.rows = _unitWork.Find<WFProcessInstance>(pageCurrent, pageSize, "CreateDate descending", null).ToList();

            }
            else if (type == "outbox")  //已办事项
            {
                result.total = cnt % pageSize == 0 ? cnt / pageSize : cnt / pageSize + 1;
                result.rows = _unitWork.Find<WFProcessInstance>(pageCurrent, pageSize, "CreateDate descending", null).ToList();

            }
            else  //我的流程
            {
                result.total = cnt % pageSize == 0 ? cnt / pageSize : cnt / pageSize + 1;
                result.rows = _unitWork.Find<WFProcessInstance>(pageCurrent, pageSize, "CreateDate descending", null).ToList();
            }

            return result;
        }

    }
}
