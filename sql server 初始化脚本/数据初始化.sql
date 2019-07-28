
-- ----------------------------
-- Records of [Application]
-- ----------------------------
INSERT INTO [dbo].[Application]  VALUES (N'110', N'OpenAuth.Net', N'openauthdotnetyubaolee', N'最好用的.NET权限工作流框架', NULL, N'0', N'2018-04-14', NULL)
GO

INSERT INTO [dbo].[Application]  VALUES (N'119', N'XXX管理平台', N'manageryubaolee', N'这是一个第三的平台', NULL, N'0', N'2018-04-14', NULL)
GO



-- ----------------------------
-- Records of [Category]
-- ----------------------------
INSERT INTO [dbo].[Category]  VALUES (N'ADMINISTRATOR', N'管理员', N'0', N'0', N'', NULL, N'USERTYPE')
GO

INSERT INTO [dbo].[Category]  VALUES (N'SYSTEMADMIN', N'神', N'0', N'0', N'', NULL, N'USERTYPE')
GO

INSERT INTO [dbo].[Category]  VALUES (N'USER', N'普通用户', N'0', N'0', N'', NULL, N'USERTYPE')
GO



-- ----------------------------
-- Records of [CategoryType]
-- ----------------------------
INSERT INTO [dbo].[CategoryType]  VALUES (N'USERTYPE', N'按用户类型分类', N'2017-11-29 21:27:42.000')
GO



-- ----------------------------
-- Records of [FlowInstance]
-- ----------------------------
INSERT INTO [dbo].[FlowInstance]  VALUES (N'e735c8ab-2a8f-4554-8e7d-722ff7a6f162', N'', N'1564315496238', N'带条件分支的申请流程2019-07-28 20:04:56', N'1564314907655', N'2', N'所有人可审核', N'1564314904791', N'{"title":"newFlow_1","nodes":[{"name":"node_1","left":125,"top":232,"type":"start round mix","id":"1564314904791","width":26,"height":26,"alt":true},{"name":"所有人可审核","left":246,"top":218,"type":"node","id":"1564314907655","width":110,"height":69,"alt":true,"setInfo":{"NodeConfluenceType":"all","NodeDesignate":"ALL_USER","NodeDesignateData":{"users":[],"roles":[]}}},{"name":"申请数目大于10走这里","left":461,"top":179,"type":"node","id":"1564314909567","width":104,"height":76,"alt":true,"setInfo":{"NodeConfluenceType":"all","NodeDesignate":"SPECIAL_USER","NodeDesignateData":{"users":["49df1602-f5f3-4d52-afb7-3802da619558"],"roles":[]}}},{"name":"小于等于10走这里，test账号审核","left":476,"top":333,"type":"node","id":"1564314910199","width":104,"height":96,"alt":true,"setInfo":{"NodeConfluenceType":"all","NodeDesignate":"SPECIAL_USER","NodeDesignateData":{"users":["6ba79766-faa0-4259-8139-a4a6d35784e0"],"roles":[]}}},{"name":"管理员角色可审核","left":694,"top":245,"type":"node","id":"1564314912495","width":104,"height":56,"alt":true,"setInfo":{"NodeConfluenceType":"all","NodeDesignate":"SPECIAL_ROLE","NodeDesignateData":{"users":[],"roles":["09ee2ffa-7463-4938-ae0b-1cb4e80c7c13"]}}},{"name":"node_6","left":848,"top":271,"type":"end round","id":"1564314915487","width":26,"height":26,"alt":true}],"lines":[{"type":"sl","from":"1564314904791","to":"1564314907655","id":"1564314918063","name":"","dash":false},{"type":"sl","from":"1564314907655","to":"1564314909567","id":"1564314919111","name":"","Compares":[{"FieldName":"NUMBERS","Operation":">","Value":"10"}],"dash":false},{"type":"sl","from":"1564314907655","to":"1564314910199","id":"1564314920391","name":"","Compares":[{"FieldName":"NUMBERS","Operation":"<=","Value":"10"}],"dash":false},{"type":"sl","from":"1564314909567","to":"1564314912495","id":"1564314921759","name":"","dash":false},{"type":"sl","from":"1564314910199","to":"1564314912495","id":"1564314923574","name":"","dash":false},{"type":"sl","from":"1564314912495","to":"1564314915487","id":"1564314924822","name":"","dash":false}],"areas":[],"initNum":14}', N'b9673c3f-457a-472d-9dad-1480c5b8bcb4', N'', N'{"TOOLS":"平板","NUMBERS":"1"}', N'0', N'[{"name":"TOOLS","title":"TOOLS","leipiplugins":"select","size":"1","orgwidth":"150","style":"width: 150px;","value":"电脑,平板,手机","selected":"selected","content":"<select name=\"leipiNewField\" title=\"TOOLS\" leipiplugins=\"select\" size=\"1\" orgwidth=\"150\" style=\"width: 150px;\"><option value=\"电脑\" selected=\"selected\">电脑</option><option value=\"平板\">平板</option><option value=\"手机\">手机</option></select>"},{"type":"text","name":"NUMBERS","title":"NUMBERS","value":"1","leipiplugins":"text","orghide":"0","orgalign":"left","orgwidth":"150","orgtype":"int","style":"text-align: left; width: 150px;","content":"<input name=\"leipiNewField\" type=\"text\" title=\"NUMBERS\" value=\"1\" leipiplugins=\"text\" orghide=\"0\" orgalign=\"left\" orgwidth=\"150\" orgtype=\"int\" style=\"text-align: left; width: 150px;\"/>"}]', N'<p style="text-align: center;"><span style="font-size: 24px;">领料单</span><br/></p><p><span style="font-size: 24px;"><br/></span></p><p style="text-align: center;"><span style="font-size: 18px;">因工作需要，需领取{TOOLS}&nbsp;&nbsp;</span>{NUMBERS}<span style="font-size: 18px;">台，望批准！</span></p><p><span style="font-size: 18px;"><br/></span></p><p style="text-align: center;"><span style="font-size: 18px;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 谢谢！</span></p>', N'6dfd447d-37c9-4a59-92a5-b00df579725b', N'', N'0', N'2019-07-28 20:05:41.197', N'00000000-0000-0000-0000-000000000000', N'System', N'0', N'', N'0', N'1')
GO

INSERT INTO [dbo].[FlowInstance]  VALUES (N'48c4eafb-cbae-463c-906b-da3aab22fe1e', N'', N'1564315805743', N'MVC申请的领料单', N'1564314915487', N'4', N'node_6', N'1564314912495', N'{"title":"newFlow_1","initNum":14,"lines":[{"id":"1564314918063","type":"sl","from":"1564314904791","to":"1564314907655","name":"","dash":false,"Compares":null},{"id":"1564314919111","type":"sl","from":"1564314907655","to":"1564314909567","name":"","dash":false,"Compares":[{"Operation":">","FieldName":"NUMBERS","FieldType":null,"Value":"10"}]},{"id":"1564314920391","type":"sl","from":"1564314907655","to":"1564314910199","name":"","dash":false,"Compares":[{"Operation":"<=","FieldName":"NUMBERS","FieldType":null,"Value":"10"}]},{"id":"1564314921759","type":"sl","from":"1564314909567","to":"1564314912495","name":"","dash":false,"Compares":null},{"id":"1564314923574","type":"sl","from":"1564314910199","to":"1564314912495","name":"","dash":false,"Compares":null},{"id":"1564314924822","type":"sl","from":"1564314912495","to":"1564314915487","name":"","dash":false,"Compares":null}],"nodes":[{"id":"1564314904791","name":"node_1","type":"start round mix","left":125,"top":232,"width":26,"height":26,"alt":true,"setInfo":null},{"id":"1564314907655","name":"所有人可审核","type":"node","left":246,"top":218,"width":110,"height":69,"alt":true,"setInfo":{"NodeDesignate":"ALL_USER","NodeDesignateData":{"users":[],"roles":[],"orgs":null},"NodeCode":null,"NodeName":null,"NodeRejectType":null,"Taged":1,"UserName":"超级管理员","UserId":"00000000-0000-0000-0000-000000000000","Description":null,"TagedTime":"2019-07-28 21:04","NodeConfluenceType":"all","ConfluenceOk":null,"ConfluenceNo":null}},{"id":"1564314909567","name":"申请数目大于10走这里","type":"node","left":461,"top":179,"width":104,"height":76,"alt":true,"setInfo":{"NodeDesignate":"SPECIAL_USER","NodeDesignateData":{"users":["49df1602-f5f3-4d52-afb7-3802da619558"],"roles":[],"orgs":null},"NodeCode":null,"NodeName":null,"NodeRejectType":null,"Taged":1,"UserName":"admin","UserId":"49df1602-f5f3-4d52-afb7-3802da619558","Description":"申请这么多，下次注意","TagedTime":"2019-07-28 21:05","NodeConfluenceType":"all","ConfluenceOk":null,"ConfluenceNo":null}},{"id":"1564314910199","name":"小于等于10走这里，test账号审核","type":"node","left":476,"top":333,"width":104,"height":96,"alt":true,"setInfo":{"NodeDesignate":"SPECIAL_USER","NodeDesignateData":{"users":["6ba79766-faa0-4259-8139-a4a6d35784e0"],"roles":[],"orgs":null},"NodeCode":null,"NodeName":null,"NodeRejectType":null,"Taged":null,"UserName":null,"UserId":null,"Description":null,"TagedTime":null,"NodeConfluenceType":"all","ConfluenceOk":null,"ConfluenceNo":null}},{"id":"1564314912495","name":"管理员角色可审核","type":"node","left":694,"top":245,"width":104,"height":56,"alt":true,"setInfo":{"NodeDesignate":"SPECIAL_ROLE","NodeDesignateData":{"users":[],"roles":["09ee2ffa-7463-4938-ae0b-1cb4e80c7c13"],"orgs":null},"NodeCode":null,"NodeName":null,"NodeRejectType":null,"Taged":1,"UserName":"admin","UserId":"49df1602-f5f3-4d52-afb7-3802da619558","Description":"这个我帮你一下吧","TagedTime":"2019-07-28 21:06","NodeConfluenceType":"all","ConfluenceOk":null,"ConfluenceNo":null}},{"id":"1564314915487","name":"node_6","type":"end round","left":848,"top":271,"width":26,"height":26,"alt":true,"setInfo":null}],"areas":[]}', N'b9673c3f-457a-472d-9dad-1480c5b8bcb4', NULL, N'{"TOOLS":"电脑","NUMBERS":"11"}', N'0', N'[{"name":"TOOLS","title":"TOOLS","leipiplugins":"select","size":"1","orgwidth":"150","style":"width: 150px;","value":"电脑,平板,手机","selected":"selected","content":"<select name=\"leipiNewField\" title=\"TOOLS\" leipiplugins=\"select\" size=\"1\" orgwidth=\"150\" style=\"width: 150px;\"><option value=\"电脑\" selected=\"selected\">电脑</option><option value=\"平板\">平板</option><option value=\"手机\">手机</option></select>"},{"type":"text","name":"NUMBERS","title":"NUMBERS","value":"1","leipiplugins":"text","orghide":"0","orgalign":"left","orgwidth":"150","orgtype":"int","style":"text-align: left; width: 150px;","content":"<input name=\"leipiNewField\" type=\"text\" title=\"NUMBERS\" value=\"1\" leipiplugins=\"text\" orghide=\"0\" orgalign=\"left\" orgwidth=\"150\" orgtype=\"int\" style=\"text-align: left; width: 150px;\"/>"}]', N'<p style="text-align: center;"><span style="font-size: 24px;">领料单</span><br/></p><p><span style="font-size: 24px;"><br/></span></p><p style="text-align: center;"><span style="font-size: 18px;">因工作需要，需领取{TOOLS}&nbsp;&nbsp;</span>{NUMBERS}<span style="font-size: 18px;">台，望批准！</span></p><p><span style="font-size: 18px;"><br/></span></p><p style="text-align: center;"><span style="font-size: 18px;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 谢谢！</span></p>', N'6dfd447d-37c9-4a59-92a5-b00df579725b', N'', N'0', N'2019-07-28 20:10:40.807', N'00000000-0000-0000-0000-000000000000', N'System', N'0', NULL, N'1', N'')
GO

INSERT INTO [dbo].[FlowInstance]  VALUES (N'fb6418d5-326d-47d8-8403-dcd183c613bc', N'', N'1564320275628', N'复杂表单的流程2019-07-28 21:24:38', N'1564314754728', N'2', N'所有人可以执行', N'1564314752457', N'{"title":"newFlow_1","nodes":[{"name":"node_1","left":233,"top":115,"type":"start round mix","id":"1564314752457","width":26,"height":26,"alt":true},{"name":"所有人可以执行","left":392,"top":133,"type":"node","id":"1564314754728","width":104,"height":56,"alt":true,"setInfo":{"NodeConfluenceType":"all","NodeDesignate":"ALL_USER","NodeDesignateData":{"users":[],"roles":[]}}},{"name":"管理员和测试角色都可以执行","left":599,"top":152,"type":"node","id":"1564314756312","width":177,"height":126,"alt":true,"setInfo":{"NodeConfluenceType":"all","NodeDesignate":"SPECIAL_ROLE","NodeDesignateData":{"users":[],"roles":["09ee2ffa-7463-4938-ae0b-1cb4e80c7c13","0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d"]}}},{"name":"node_4","left":668,"top":336,"type":"end round","id":"1564314759624","width":26,"height":26,"alt":true}],"lines":[{"type":"sl","from":"1564314752457","to":"1564314754728","id":"1564314761888","name":"","dash":false},{"type":"sl","from":"1564314754728","to":"1564314756312","id":"1564314762776","name":"","dash":false},{"type":"sl","from":"1564314756312","to":"1564314759624","id":"1564314763873","name":"","dash":false}],"areas":[],"initNum":9}', N'4f8c7a8b-a61b-4802-8429-61b6a49d167d', N'FrmLeaveReq', N'{"id":"","userName":"李玉宝","requestType":"事假","startDate":"2019-07-09T16:00:00.000Z","startTime":"2019-07-28T11:24:51.000Z","endDate":"2019-07-30T16:00:00.000Z","endTime":"2019-07-28T13:24:55.000Z","requestComment":"说起来原因有很多，但是我只想说。我要写代码","attachment":"","files":[],"extendInfo":""}', N'1', N'', N'', N'ec35908a-80ec-4587-9b11-ee614934846d', N'', N'0', N'2019-07-28 21:25:41.440', N'00000000-0000-0000-0000-000000000000', N'System', N'0', N'', N'0', N'1')
GO

INSERT INTO [dbo].[FlowInstance]  VALUES (N'4d188305-14f8-42a0-9a9b-4f75bebe59fd', N'', N'1564319221349', N'admin要请假了', N'1564314382019', N'2', N'所有人可审批', N'1564314379796', N'{"title":"newFlow_1","nodes":[{"name":"node_1","left":46,"top":105,"type":"start round mix","id":"1564314379796","width":26,"height":26,"alt":true},{"name":"所有人可审批","left":167,"top":104,"type":"node","id":"1564314382019","width":104,"height":50,"alt":true,"setInfo":{"NodeName":"所有人可审批","NodeCode":"node_2","NodeRejectType":"0","NodeDesignate":"ALL_USER","NodeConfluenceType":"all","NodeDesignateData":{"users":[],"roles":[],"orgs":[]}}},{"name":"admin审批","left":177,"top":228,"type":"node","id":"1564314385315","width":104,"height":46,"alt":true,"setInfo":{"NodeName":"admin审批","NodeCode":"node_3","NodeRejectType":"0","NodeDesignate":"SPECIAL_USER","NodeConfluenceType":"all","NodeDesignateData":{"users":["49df1602-f5f3-4d52-afb7-3802da619558"],"roles":[],"orgs":[]}}},{"name":"test审批","left":364,"top":113,"type":"node","id":"1564314386675","width":104,"height":51,"alt":true,"setInfo":{"NodeName":"test审批","NodeCode":"node_4","NodeRejectType":"0","NodeDesignate":"SPECIAL_USER","NodeConfluenceType":"all","NodeDesignateData":{"users":["6ba79766-faa0-4259-8139-a4a6d35784e0"],"roles":[],"orgs":[]}}},{"name":"node_5","left":419,"top":239,"type":"end round","id":"1564314389179","width":26,"height":26,"alt":true}],"lines":[{"type":"sl","from":"1564314379796","to":"1564314382019","id":"1564314397060","name":"","dash":false,"alt":true},{"type":"sl","from":"1564314382019","to":"1564314386675","id":"1564314399066","name":"","dash":false,"alt":true},{"type":"sl","from":"1564314386675","to":"1564314385315","id":"1564314400938","name":"","dash":false,"alt":true},{"type":"sl","from":"1564314385315","to":"1564314389179","id":"1564314402522","name":"","dash":false,"alt":true}],"areas":[],"initNum":11}', N'2cfafb29-8fef-4a22-849f-e510c0f0d4bb', NULL, N'{"DAYS":"2","REASON":"主要是太累了。"}', N'0', N'[{"type":"text","name":"DAYS","title":"DAYS","value":"2","leipiplugins":"text","orghide":"0","orgalign":"left","orgwidth":"150","orgtype":"int","style":"text-align: left; width: 150px;","content":"<input name=\"leipiNewField\" type=\"text\" title=\"DAYS\" value=\"2\" leipiplugins=\"text\" orghide=\"0\" orgalign=\"left\" orgwidth=\"150\" orgtype=\"int\" style=\"text-align: left; width: 150px;\"/>"},{"name":"REASON","title":"REASON","leipiplugins":"textarea","value":"因病请假","orgrich":"0","orgfontsize":"","orgwidth":"300","orgheight":"150","style":"width:300px;height:150px;","content":"<textarea title=\"REASON\" name=\"leipiNewField\" leipiplugins=\"textarea\" value=\"因病请假\" orgrich=\"0\" orgfontsize=\"\" orgwidth=\"300\" orgheight=\"150\" style=\"width:300px;height:150px;\">因病请假</textarea>"}]', N'<p style="text-align: center;"><strong><span style="font-size: 24px;">请假条</span></strong></p><p style="text-align: center;"><br/></p><p style="text-align: center;">因身体原因，想请假{DAYS}天，望领导批准。具体请假原因如下：</p><p style="text-align: center;">{REASON}</p>', N'5d68feac-bc11-4e37-bee1-4c5610b70185', N'', N'0', N'2019-07-28 21:07:49.733', N'49df1602-f5f3-4d52-afb7-3802da619558', N'admin', N'0', N'太累了', N'0', N'1')
GO

INSERT INTO [dbo].[FlowInstance]  VALUES (N'0eacf4e4-455f-439e-945e-45c174be3815', N'', N'1564320635643', N'带会签功能的流程2019-07-28 21:30:35', N'1564320482303', N'4', N'node_7', N'1564320473223', N'{"title":"newFlow_1","initNum":15,"lines":[{"id":"1564320486639","type":"sl","from":"1564320467424","to":"1564320471304","name":"","dash":false,"Compares":null},{"id":"1564320487615","type":"sl","from":"1564320471304","to":"1564320473223","name":"","dash":false,"Compares":null},{"id":"1564320489350","type":"sl","from":"1564320473223","to":"1564320475431","name":"","dash":false,"Compares":null},{"id":"1564320490639","type":"sl","from":"1564320473223","to":"1564320475943","name":"","dash":false,"Compares":null},{"id":"1564320492038","type":"sl","from":"1564320475431","to":"1564320478447","name":"","dash":false,"Compares":null},{"id":"1564320493295","type":"sl","from":"1564320475943","to":"1564320478447","name":"","dash":false,"Compares":null},{"id":"1564320494927","type":"sl","from":"1564320478447","to":"1564320482303","name":"","dash":false,"Compares":null}],"nodes":[{"id":"1564320467424","name":"node_1","type":"start round mix","left":27,"top":46,"width":26,"height":26,"alt":true,"setInfo":null},{"id":"1564320471304","name":"所有人可审核","type":"node","left":178,"top":54,"width":104,"height":56,"alt":true,"setInfo":{"NodeDesignate":"ALL_USER","NodeDesignateData":{"users":[],"roles":[],"orgs":null},"NodeCode":null,"NodeName":null,"NodeRejectType":null,"Taged":1,"UserName":"超级管理员","UserId":"00000000-0000-0000-0000-000000000000","Description":"","TagedTime":"2019-07-28 21:31","NodeConfluenceType":"all","ConfluenceOk":null,"ConfluenceNo":null}},{"id":"1564320473223","name":"这个地方可以选会签的类型","type":"fork","left":365,"top":51,"width":104,"height":76,"alt":true,"setInfo":{"NodeDesignate":"ALL_USER","NodeDesignateData":{"users":[],"roles":[],"orgs":null},"NodeCode":null,"NodeName":null,"NodeRejectType":null,"Taged":1,"UserName":"test","UserId":"6ba79766-faa0-4259-8139-a4a6d35784e0","Description":"","TagedTime":"2019-07-28 21:33","NodeConfluenceType":"all","ConfluenceOk":1,"ConfluenceNo":null}},{"id":"1564320475431","name":"这里只能指定用户，如admin","type":"node","left":99,"top":190,"width":174,"height":74,"alt":true,"setInfo":{"NodeDesignate":"SPECIAL_USER","NodeDesignateData":{"users":["49df1602-f5f3-4d52-afb7-3802da619558"],"roles":[],"orgs":null},"NodeCode":null,"NodeName":null,"NodeRejectType":null,"Taged":1,"UserName":"admin","UserId":"49df1602-f5f3-4d52-afb7-3802da619558","Description":"admin准了","TagedTime":"2019-07-28 21:32","NodeConfluenceType":"all","ConfluenceOk":null,"ConfluenceNo":null}},{"id":"1564320475943","name":"这里只能指定用户，如test","type":"node","left":459,"top":201,"width":172,"height":61,"alt":true,"setInfo":{"NodeDesignate":"SPECIAL_USER","NodeDesignateData":{"users":["6ba79766-faa0-4259-8139-a4a6d35784e0"],"roles":[],"orgs":null},"NodeCode":null,"NodeName":null,"NodeRejectType":null,"Taged":1,"UserName":"test","UserId":"6ba79766-faa0-4259-8139-a4a6d35784e0","Description":"","TagedTime":"2019-07-28 21:33","NodeConfluenceType":"all","ConfluenceOk":null,"ConfluenceNo":null}},{"id":"1564320478447","name":"node_6","type":"join","left":294,"top":329,"width":104,"height":26,"alt":true,"setInfo":{"NodeDesignate":null,"NodeDesignateData":null,"NodeCode":null,"NodeName":null,"NodeRejectType":null,"Taged":1,"UserName":"test","UserId":"6ba79766-faa0-4259-8139-a4a6d35784e0","Description":"","TagedTime":"2019-07-28 21:33","NodeConfluenceType":null,"ConfluenceOk":null,"ConfluenceNo":null}},{"id":"1564320482303","name":"node_7","type":"end round","left":45,"top":340,"width":26,"height":26,"alt":true,"setInfo":null}],"areas":[]}', N'18593e9f-000e-4b9e-8148-9ee23a59fd56', N'', N'{"TOOLS":"电脑","NUMBERS":"1"}', N'0', N'[{"name":"TOOLS","title":"TOOLS","leipiplugins":"select","size":"1","orgwidth":"150","style":"width: 150px;","value":"电脑,平板,手机","selected":"selected","content":"<select name=\"leipiNewField\" title=\"TOOLS\" leipiplugins=\"select\" size=\"1\" orgwidth=\"150\" style=\"width: 150px;\"><option value=\"电脑\" selected=\"selected\">电脑</option><option value=\"平板\">平板</option><option value=\"手机\">手机</option></select>"},{"type":"text","name":"NUMBERS","title":"NUMBERS","value":"1","leipiplugins":"text","orghide":"0","orgalign":"left","orgwidth":"150","orgtype":"int","style":"text-align: left; width: 150px;","content":"<input name=\"leipiNewField\" type=\"text\" title=\"NUMBERS\" value=\"1\" leipiplugins=\"text\" orghide=\"0\" orgalign=\"left\" orgwidth=\"150\" orgtype=\"int\" style=\"text-align: left; width: 150px;\"/>"}]', N'<p style="text-align: center;"><span style="font-size: 24px;">领料单</span><br/></p><p><span style="font-size: 24px;"><br/></span></p><p style="text-align: center;"><span style="font-size: 18px;">因工作需要，需领取{TOOLS}&nbsp;&nbsp;</span>{NUMBERS}<span style="font-size: 18px;">台，望批准！</span></p><p><span style="font-size: 18px;"><br/></span></p><p style="text-align: center;"><span style="font-size: 18px;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 谢谢！</span></p>', N'6dfd447d-37c9-4a59-92a5-b00df579725b', N'', N'0', N'2019-07-28 21:31:00.050', N'00000000-0000-0000-0000-000000000000', N'System', N'0', N'需要admin/test同时审核通过', N'1', N'')
GO

INSERT INTO [dbo].[FlowInstance]  VALUES (N'fd0be09f-2cef-472a-ba81-de01673c5a1b', N'', N'1564319287829', N'admin申请个分支的', N'1564314907655', N'2', N'所有人可审核', N'1564314904791', N'{"title":"newFlow_1","nodes":[{"name":"node_1","left":125,"top":232,"type":"start round mix","id":"1564314904791","width":26,"height":26,"alt":true},{"name":"所有人可审核","left":246,"top":218,"type":"node","id":"1564314907655","width":110,"height":69,"alt":true,"setInfo":{"NodeConfluenceType":"all","NodeDesignate":"ALL_USER","NodeDesignateData":{"users":[],"roles":[]}}},{"name":"申请数目大于10走这里","left":461,"top":179,"type":"node","id":"1564314909567","width":104,"height":76,"alt":true,"setInfo":{"NodeConfluenceType":"all","NodeDesignate":"SPECIAL_USER","NodeDesignateData":{"users":["49df1602-f5f3-4d52-afb7-3802da619558"],"roles":[]}}},{"name":"小于等于10走这里，test账号审核","left":476,"top":333,"type":"node","id":"1564314910199","width":104,"height":96,"alt":true,"setInfo":{"NodeConfluenceType":"all","NodeDesignate":"SPECIAL_USER","NodeDesignateData":{"users":["6ba79766-faa0-4259-8139-a4a6d35784e0"],"roles":[]}}},{"name":"管理员角色可审核","left":694,"top":245,"type":"node","id":"1564314912495","width":104,"height":56,"alt":true,"setInfo":{"NodeConfluenceType":"all","NodeDesignate":"SPECIAL_ROLE","NodeDesignateData":{"users":[],"roles":["09ee2ffa-7463-4938-ae0b-1cb4e80c7c13"]}}},{"name":"node_6","left":848,"top":271,"type":"end round","id":"1564314915487","width":26,"height":26,"alt":true}],"lines":[{"type":"sl","from":"1564314904791","to":"1564314907655","id":"1564314918063","name":"","dash":false},{"type":"sl","from":"1564314907655","to":"1564314909567","id":"1564314919111","name":"","Compares":[{"FieldName":"NUMBERS","Operation":">","Value":"10"}],"dash":false},{"type":"sl","from":"1564314907655","to":"1564314910199","id":"1564314920391","name":"","Compares":[{"FieldName":"NUMBERS","Operation":"<=","Value":"10"}],"dash":false},{"type":"sl","from":"1564314909567","to":"1564314912495","id":"1564314921759","name":"","dash":false},{"type":"sl","from":"1564314910199","to":"1564314912495","id":"1564314923574","name":"","dash":false},{"type":"sl","from":"1564314912495","to":"1564314915487","id":"1564314924822","name":"","dash":false}],"areas":[],"initNum":14}', N'b9673c3f-457a-472d-9dad-1480c5b8bcb4', NULL, N'{"TOOLS":"手机","NUMBERS":"1"}', N'0', N'[{"name":"TOOLS","title":"TOOLS","leipiplugins":"select","size":"1","orgwidth":"150","style":"width: 150px;","value":"电脑,平板,手机","selected":"selected","content":"<select name=\"leipiNewField\" title=\"TOOLS\" leipiplugins=\"select\" size=\"1\" orgwidth=\"150\" style=\"width: 150px;\"><option value=\"电脑\" selected=\"selected\">电脑</option><option value=\"平板\">平板</option><option value=\"手机\">手机</option></select>"},{"type":"text","name":"NUMBERS","title":"NUMBERS","value":"1","leipiplugins":"text","orghide":"0","orgalign":"left","orgwidth":"150","orgtype":"int","style":"text-align: left; width: 150px;","content":"<input name=\"leipiNewField\" type=\"text\" title=\"NUMBERS\" value=\"1\" leipiplugins=\"text\" orghide=\"0\" orgalign=\"left\" orgwidth=\"150\" orgtype=\"int\" style=\"text-align: left; width: 150px;\"/>"}]', N'<p style="text-align: center;"><span style="font-size: 24px;">领料单</span><br/></p><p><span style="font-size: 24px;"><br/></span></p><p style="text-align: center;"><span style="font-size: 18px;">因工作需要，需领取{TOOLS}&nbsp;&nbsp;</span>{NUMBERS}<span style="font-size: 18px;">台，望批准！</span></p><p><span style="font-size: 18px;"><br/></span></p><p style="text-align: center;"><span style="font-size: 18px;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 谢谢！</span></p>', N'6dfd447d-37c9-4a59-92a5-b00df579725b', N'', N'0', N'2019-07-28 21:08:25.350', N'49df1602-f5f3-4d52-afb7-3802da619558', N'admin', N'0', NULL, N'0', N'1')
GO

INSERT INTO [dbo].[FlowInstance]  VALUES (N'05403247-63c0-4fa6-9243-89de66453390', N'', N'1564320398533', N'带条件分支领料模板2019-07-28 21:26:38', N'1564314909567', N'2', N'申请数目大于10走这里', N'1564314907655', N'{"title":"newFlow_1","initNum":14,"lines":[{"id":"1564314918063","type":"sl","from":"1564314904791","to":"1564314907655","name":"","dash":false,"Compares":null},{"id":"1564314919111","type":"sl","from":"1564314907655","to":"1564314909567","name":"","dash":false,"Compares":null},{"id":"1564314920391","type":"sl","from":"1564314907655","to":"1564314910199","name":"","dash":false,"Compares":null},{"id":"1564314921759","type":"sl","from":"1564314909567","to":"1564314912495","name":"","dash":false,"Compares":null},{"id":"1564314923574","type":"sl","from":"1564314910199","to":"1564314912495","name":"","dash":false,"Compares":null},{"id":"1564314924822","type":"sl","from":"1564314912495","to":"1564314915487","name":"","dash":false,"Compares":null}],"nodes":[{"id":"1564314904791","name":"node_1","type":"start round mix","left":125,"top":232,"width":26,"height":26,"alt":true,"setInfo":null},{"id":"1564314907655","name":"所有人可审核","type":"node","left":246,"top":218,"width":110,"height":69,"alt":true,"setInfo":{"NodeDesignate":"ALL_USER","NodeDesignateData":{"users":[],"roles":[],"orgs":null},"NodeCode":null,"NodeName":null,"NodeRejectType":null,"Taged":1,"UserName":"超级管理员","UserId":"00000000-0000-0000-0000-000000000000","Description":"","TagedTime":"2019-07-28 21:38","NodeConfluenceType":"all","ConfluenceOk":null,"ConfluenceNo":null}},{"id":"1564314909567","name":"申请数目大于10走这里","type":"node","left":461,"top":179,"width":104,"height":76,"alt":true,"setInfo":{"NodeDesignate":"SPECIAL_USER","NodeDesignateData":{"users":["49df1602-f5f3-4d52-afb7-3802da619558"],"roles":[],"orgs":null},"NodeCode":null,"NodeName":null,"NodeRejectType":null,"Taged":null,"UserName":null,"UserId":null,"Description":null,"TagedTime":null,"NodeConfluenceType":"all","ConfluenceOk":null,"ConfluenceNo":null}},{"id":"1564314910199","name":"小于等于10走这里，test账号审核","type":"node","left":476,"top":333,"width":104,"height":96,"alt":true,"setInfo":{"NodeDesignate":"SPECIAL_USER","NodeDesignateData":{"users":["6ba79766-faa0-4259-8139-a4a6d35784e0"],"roles":[],"orgs":null},"NodeCode":null,"NodeName":null,"NodeRejectType":null,"Taged":null,"UserName":null,"UserId":null,"Description":null,"TagedTime":null,"NodeConfluenceType":"all","ConfluenceOk":null,"ConfluenceNo":null}},{"id":"1564314912495","name":"管理员角色可审核","type":"node","left":694,"top":245,"width":104,"height":56,"alt":true,"setInfo":{"NodeDesignate":"SPECIAL_ROLE","NodeDesignateData":{"users":[],"roles":["09ee2ffa-7463-4938-ae0b-1cb4e80c7c13"],"orgs":null},"NodeCode":null,"NodeName":null,"NodeRejectType":null,"Taged":null,"UserName":null,"UserId":null,"Description":null,"TagedTime":null,"NodeConfluenceType":"all","ConfluenceOk":null,"ConfluenceNo":null}},{"id":"1564314915487","name":"node_6","type":"end round","left":848,"top":271,"width":26,"height":26,"alt":true,"setInfo":null}],"areas":[]}', N'b9673c3f-457a-472d-9dad-1480c5b8bcb4', N'', N'{"TOOLS":"电脑","NUMBERS":"1"}', N'0', N'[{"name":"TOOLS","title":"TOOLS","leipiplugins":"select","size":"1","orgwidth":"150","style":"width: 150px;","value":"电脑,平板,手机","selected":"selected","content":"<select name=\"leipiNewField\" title=\"TOOLS\" leipiplugins=\"select\" size=\"1\" orgwidth=\"150\" style=\"width: 150px;\"><option value=\"电脑\" selected=\"selected\">电脑</option><option value=\"平板\">平板</option><option value=\"手机\">手机</option></select>"},{"type":"text","name":"NUMBERS","title":"NUMBERS","value":"1","leipiplugins":"text","orghide":"0","orgalign":"left","orgwidth":"150","orgtype":"int","style":"text-align: left; width: 150px;","content":"<input name=\"leipiNewField\" type=\"text\" title=\"NUMBERS\" value=\"1\" leipiplugins=\"text\" orghide=\"0\" orgalign=\"left\" orgwidth=\"150\" orgtype=\"int\" style=\"text-align: left; width: 150px;\"/>"}]', N'<p style="text-align: center;"><span style="font-size: 24px;">领料单</span><br/></p><p><span style="font-size: 24px;"><br/></span></p><p style="text-align: center;"><span style="font-size: 18px;">因工作需要，需领取{TOOLS}&nbsp;&nbsp;</span>{NUMBERS}<span style="font-size: 18px;">台，望批准！</span></p><p><span style="font-size: 18px;"><br/></span></p><p style="text-align: center;"><span style="font-size: 18px;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 谢谢！</span></p>', N'6dfd447d-37c9-4a59-92a5-b00df579725b', N'', N'0', N'2019-07-28 21:26:58.117', N'00000000-0000-0000-0000-000000000000', N'System', N'0', N'再试下带分支条件的', N'0', N'49df1602-f5f3-4d52-afb7-3802da619558')
GO

INSERT INTO [dbo].[FlowInstance]  VALUES (N'0e7440b9-b3d6-4d55-bf27-dbf9d2907f09', N'', N'1564320191405', N'申请电脑', N'1564314907655', N'2', N'所有人可审核', N'1564314904791', N'{"title":"newFlow_1","nodes":[{"name":"node_1","left":125,"top":232,"type":"start round mix","id":"1564314904791","width":26,"height":26,"alt":true},{"name":"所有人可审核","left":246,"top":218,"type":"node","id":"1564314907655","width":110,"height":69,"alt":true,"setInfo":{"NodeConfluenceType":"all","NodeDesignate":"ALL_USER","NodeDesignateData":{"users":[],"roles":[]}}},{"name":"申请数目大于10走这里","left":461,"top":179,"type":"node","id":"1564314909567","width":104,"height":76,"alt":true,"setInfo":{"NodeConfluenceType":"all","NodeDesignate":"SPECIAL_USER","NodeDesignateData":{"users":["49df1602-f5f3-4d52-afb7-3802da619558"],"roles":[]}}},{"name":"小于等于10走这里，test账号审核","left":476,"top":333,"type":"node","id":"1564314910199","width":104,"height":96,"alt":true,"setInfo":{"NodeConfluenceType":"all","NodeDesignate":"SPECIAL_USER","NodeDesignateData":{"users":["6ba79766-faa0-4259-8139-a4a6d35784e0"],"roles":[]}}},{"name":"管理员角色可审核","left":694,"top":245,"type":"node","id":"1564314912495","width":104,"height":56,"alt":true,"setInfo":{"NodeConfluenceType":"all","NodeDesignate":"SPECIAL_ROLE","NodeDesignateData":{"users":[],"roles":["09ee2ffa-7463-4938-ae0b-1cb4e80c7c13"]}}},{"name":"node_6","left":848,"top":271,"type":"end round","id":"1564314915487","width":26,"height":26,"alt":true}],"lines":[{"type":"sl","from":"1564314904791","to":"1564314907655","id":"1564314918063","name":"","dash":false},{"type":"sl","from":"1564314907655","to":"1564314909567","id":"1564314919111","name":"","dash":false},{"type":"sl","from":"1564314907655","to":"1564314910199","id":"1564314920391","name":"","dash":false},{"type":"sl","from":"1564314909567","to":"1564314912495","id":"1564314921759","name":"","dash":false},{"type":"sl","from":"1564314910199","to":"1564314912495","id":"1564314923574","name":"","dash":false},{"type":"sl","from":"1564314912495","to":"1564314915487","id":"1564314924822","name":"","dash":false}],"areas":[],"initNum":14}', N'b9673c3f-457a-472d-9dad-1480c5b8bcb4', NULL, N'{"TOOLS":"电脑","NUMBERS":"1"}', N'0', N'[{"name":"TOOLS","title":"TOOLS","leipiplugins":"select","size":"1","orgwidth":"150","style":"width: 150px;","value":"电脑,平板,手机","selected":"selected","content":"<select name=\"leipiNewField\" title=\"TOOLS\" leipiplugins=\"select\" size=\"1\" orgwidth=\"150\" style=\"width: 150px;\"><option value=\"电脑\" selected=\"selected\">电脑</option><option value=\"平板\">平板</option><option value=\"手机\">手机</option></select>"},{"type":"text","name":"NUMBERS","title":"NUMBERS","value":"1","leipiplugins":"text","orghide":"0","orgalign":"left","orgwidth":"150","orgtype":"int","style":"text-align: left; width: 150px;","content":"<input name=\"leipiNewField\" type=\"text\" title=\"NUMBERS\" value=\"1\" leipiplugins=\"text\" orghide=\"0\" orgalign=\"left\" orgwidth=\"150\" orgtype=\"int\" style=\"text-align: left; width: 150px;\"/>"}]', N'<p style="text-align: center;"><span style="font-size: 24px;">领料单</span><br/></p><p><span style="font-size: 24px;"><br/></span></p><p style="text-align: center;"><span style="font-size: 18px;">因工作需要，需领取{TOOLS}&nbsp;&nbsp;</span>{NUMBERS}<span style="font-size: 18px;">台，望批准！</span></p><p><span style="font-size: 18px;"><br/></span></p><p style="text-align: center;"><span style="font-size: 18px;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 谢谢！</span></p>', N'6dfd447d-37c9-4a59-92a5-b00df579725b', N'', N'0', N'2019-07-28 21:23:29.193', N'00000000-0000-0000-0000-000000000000', N'System', N'0', NULL, N'0', N'1')
GO

INSERT INTO [dbo].[FlowInstance]  VALUES (N'd4b4f635-fd6a-4d61-99e3-8eafb09dce51', N'', N'1564320191408', N'申请很多电脑', N'1564314907655', N'2', N'所有人可审核', N'1564314904791', N'{"title":"newFlow_1","nodes":[{"name":"node_1","left":125,"top":232,"type":"start round mix","id":"1564314904791","width":26,"height":26,"alt":true},{"name":"所有人可审核","left":246,"top":218,"type":"node","id":"1564314907655","width":110,"height":69,"alt":true,"setInfo":{"NodeConfluenceType":"all","NodeDesignate":"ALL_USER","NodeDesignateData":{"users":[],"roles":[]}}},{"name":"申请数目大于10走这里","left":461,"top":179,"type":"node","id":"1564314909567","width":104,"height":76,"alt":true,"setInfo":{"NodeConfluenceType":"all","NodeDesignate":"SPECIAL_USER","NodeDesignateData":{"users":["49df1602-f5f3-4d52-afb7-3802da619558"],"roles":[]}}},{"name":"小于等于10走这里，test账号审核","left":476,"top":333,"type":"node","id":"1564314910199","width":104,"height":96,"alt":true,"setInfo":{"NodeConfluenceType":"all","NodeDesignate":"SPECIAL_USER","NodeDesignateData":{"users":["6ba79766-faa0-4259-8139-a4a6d35784e0"],"roles":[]}}},{"name":"管理员角色可审核","left":694,"top":245,"type":"node","id":"1564314912495","width":104,"height":56,"alt":true,"setInfo":{"NodeConfluenceType":"all","NodeDesignate":"SPECIAL_ROLE","NodeDesignateData":{"users":[],"roles":["09ee2ffa-7463-4938-ae0b-1cb4e80c7c13"]}}},{"name":"node_6","left":848,"top":271,"type":"end round","id":"1564314915487","width":26,"height":26,"alt":true}],"lines":[{"type":"sl","from":"1564314904791","to":"1564314907655","id":"1564314918063","name":"","dash":false},{"type":"sl","from":"1564314907655","to":"1564314909567","id":"1564314919111","name":"","dash":false},{"type":"sl","from":"1564314907655","to":"1564314910199","id":"1564314920391","name":"","dash":false},{"type":"sl","from":"1564314909567","to":"1564314912495","id":"1564314921759","name":"","dash":false},{"type":"sl","from":"1564314910199","to":"1564314912495","id":"1564314923574","name":"","dash":false},{"type":"sl","from":"1564314912495","to":"1564314915487","id":"1564314924822","name":"","dash":false}],"areas":[],"initNum":14}', N'b9673c3f-457a-472d-9dad-1480c5b8bcb4', NULL, N'{"TOOLS":"电脑","NUMBERS":"11"}', N'0', N'[{"name":"TOOLS","title":"TOOLS","leipiplugins":"select","size":"1","orgwidth":"150","style":"width: 150px;","value":"电脑,平板,手机","selected":"selected","content":"<select name=\"leipiNewField\" title=\"TOOLS\" leipiplugins=\"select\" size=\"1\" orgwidth=\"150\" style=\"width: 150px;\"><option value=\"电脑\" selected=\"selected\">电脑</option><option value=\"平板\">平板</option><option value=\"手机\">手机</option></select>"},{"type":"text","name":"NUMBERS","title":"NUMBERS","value":"1","leipiplugins":"text","orghide":"0","orgalign":"left","orgwidth":"150","orgtype":"int","style":"text-align: left; width: 150px;","content":"<input name=\"leipiNewField\" type=\"text\" title=\"NUMBERS\" value=\"1\" leipiplugins=\"text\" orghide=\"0\" orgalign=\"left\" orgwidth=\"150\" orgtype=\"int\" style=\"text-align: left; width: 150px;\"/>"}]', N'<p style="text-align: center;"><span style="font-size: 24px;">领料单</span><br/></p><p><span style="font-size: 24px;"><br/></span></p><p style="text-align: center;"><span style="font-size: 18px;">因工作需要，需领取{TOOLS}&nbsp;&nbsp;</span>{NUMBERS}<span style="font-size: 18px;">台，望批准！</span></p><p><span style="font-size: 18px;"><br/></span></p><p style="text-align: center;"><span style="font-size: 18px;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 谢谢！</span></p>', N'6dfd447d-37c9-4a59-92a5-b00df579725b', N'', N'0', N'2019-07-28 21:23:45.947', N'00000000-0000-0000-0000-000000000000', N'System', N'0', NULL, N'0', N'1')
GO

INSERT INTO [dbo].[FlowInstance]  VALUES (N'67d18244-e8cd-4bf8-b2f8-a86a375e51b9', N'', N'1564326992881', N'领取办公用品', N'1564314907655', N'2', N'所有人可审核', N'1564314904791', N'{"title":"newFlow_1","nodes":[{"name":"node_1","left":125,"top":232,"type":"start round mix","id":"1564314904791","width":26,"height":26,"alt":true},{"name":"所有人可审核","left":246,"top":218,"type":"node","id":"1564314907655","width":110,"height":69,"alt":true,"setInfo":{"NodeConfluenceType":"all","NodeDesignate":"ALL_USER","NodeDesignateData":{"users":[],"roles":[]}}},{"name":"申请数目大于10走这里","left":461,"top":179,"type":"node","id":"1564314909567","width":104,"height":76,"alt":true,"setInfo":{"NodeConfluenceType":"all","NodeDesignate":"SPECIAL_USER","NodeDesignateData":{"users":["49df1602-f5f3-4d52-afb7-3802da619558"],"roles":[]}}},{"name":"小于等于10走这里，test账号审核","left":476,"top":333,"type":"node","id":"1564314910199","width":104,"height":96,"alt":true,"setInfo":{"NodeConfluenceType":"all","NodeDesignate":"SPECIAL_USER","NodeDesignateData":{"users":["6ba79766-faa0-4259-8139-a4a6d35784e0"],"roles":[]}}},{"name":"管理员角色可审核","left":694,"top":245,"type":"node","id":"1564314912495","width":104,"height":56,"alt":true,"setInfo":{"NodeConfluenceType":"all","NodeDesignate":"SPECIAL_ROLE","NodeDesignateData":{"users":[],"roles":["09ee2ffa-7463-4938-ae0b-1cb4e80c7c13"]}}},{"name":"node_6","left":848,"top":271,"type":"end round","id":"1564314915487","width":26,"height":26,"alt":true}],"lines":[{"type":"sl","from":"1564314904791","to":"1564314907655","id":"1564314918063","name":"","dash":false},{"type":"sl","from":"1564314907655","to":"1564314909567","id":"1564314919111","name":"","dash":false},{"type":"sl","from":"1564314907655","to":"1564314910199","id":"1564314920391","name":"","dash":false},{"type":"sl","from":"1564314909567","to":"1564314912495","id":"1564314921759","name":"","dash":false},{"type":"sl","from":"1564314910199","to":"1564314912495","id":"1564314923574","name":"","dash":false},{"type":"sl","from":"1564314912495","to":"1564314915487","id":"1564314924822","name":"","dash":false}],"areas":[],"initNum":14}', N'b9673c3f-457a-472d-9dad-1480c5b8bcb4', NULL, N'{"TOOLS":"手机","NUMBERS":"1"}', N'0', N'[{"name":"TOOLS","title":"TOOLS","leipiplugins":"select","size":"1","orgwidth":"150","style":"width: 150px;","value":"电脑,平板,手机","selected":"selected","content":"<select name=\"leipiNewField\" title=\"TOOLS\" leipiplugins=\"select\" size=\"1\" orgwidth=\"150\" style=\"width: 150px;\"><option value=\"电脑\" selected=\"selected\">电脑</option><option value=\"平板\">平板</option><option value=\"手机\">手机</option></select>"},{"type":"text","name":"NUMBERS","title":"NUMBERS","value":"1","leipiplugins":"text","orghide":"0","orgalign":"left","orgwidth":"150","orgtype":"int","style":"text-align: left; width: 150px;","content":"<input name=\"leipiNewField\" type=\"text\" title=\"NUMBERS\" value=\"1\" leipiplugins=\"text\" orghide=\"0\" orgalign=\"left\" orgwidth=\"150\" orgtype=\"int\" style=\"text-align: left; width: 150px;\"/>"}]', N'<p style="text-align: center;"><span style="font-size: 24px;">领料单</span><br/></p><p><span style="font-size: 24px;"><br/></span></p><p style="text-align: center;"><span style="font-size: 18px;">因工作需要，需领取{TOOLS}&nbsp;&nbsp;</span>{NUMBERS}<span style="font-size: 18px;">台，望批准！</span></p><p><span style="font-size: 18px;"><br/></span></p><p style="text-align: center;"><span style="font-size: 18px;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 谢谢！</span></p>', N'6dfd447d-37c9-4a59-92a5-b00df579725b', N'', N'0', N'2019-07-28 23:17:29.770', N'00000000-0000-0000-0000-000000000000', N'System', N'0', N'与甲方客户沟通，需要单独一部手机', N'0', N'1')
GO


-- ----------------------------
-- Records of [FlowInstanceOperationHistory]
-- ----------------------------
INSERT INTO [dbo].[FlowInstanceOperationHistory]  VALUES (N'5e9b8ede-db9f-435f-a12b-14e29a35c819', N'e735c8ab-2a8f-4554-8e7d-722ff7a6f162', N'【创建】超级管理员创建了一个流程进程【1564315496238/带条件分支的申请流程2019-07-28 20:04:56】', N'2019-07-28 20:05:41.207', N'00000000-0000-0000-0000-000000000000', N'超级管理员')
GO

INSERT INTO [dbo].[FlowInstanceOperationHistory]  VALUES (N'bb8e89f1-97be-41b6-b9a8-b866c14397b1', N'48c4eafb-cbae-463c-906b-da3aab22fe1e', N'【创建】超级管理员创建了一个流程进程【1564315805743/MVC申请的领料单】', N'2019-07-28 20:10:41.253', N'00000000-0000-0000-0000-000000000000', N'超级管理员')
GO

INSERT INTO [dbo].[FlowInstanceOperationHistory]  VALUES (N'9331d184-716d-4d6a-9d21-5dff51790685', N'48c4eafb-cbae-463c-906b-da3aab22fe1e', N'【所有人可审核】【2019-07-28 21:04】同意,备注：', N'2019-07-28 21:04:49.573', N'00000000-0000-0000-0000-000000000000', N'超级管理员')
GO

INSERT INTO [dbo].[FlowInstanceOperationHistory]  VALUES (N'09120eb0-5fe7-40af-a651-13110abfe8fc', N'48c4eafb-cbae-463c-906b-da3aab22fe1e', N'【申请数目大于10走这里】【2019-07-28 21:05】同意,备注：申请这么多，下次注意', N'2019-07-28 21:05:50.193', N'49df1602-f5f3-4d52-afb7-3802da619558', N'admin')
GO

INSERT INTO [dbo].[FlowInstanceOperationHistory]  VALUES (N'c4d6d43b-477a-4d93-a411-7fe6547b4e0c', N'4d188305-14f8-42a0-9a9b-4f75bebe59fd', N'【创建】admin创建了一个流程进程【1564319221349/admin要请假了】', N'2019-07-28 21:07:49.740', N'49df1602-f5f3-4d52-afb7-3802da619558', N'admin')
GO

INSERT INTO [dbo].[FlowInstanceOperationHistory]  VALUES (N'c7b01818-d604-4430-84de-007417628702', N'fd0be09f-2cef-472a-ba81-de01673c5a1b', N'【创建】admin创建了一个流程进程【1564319287829/admin申请个分支的】', N'2019-07-28 21:08:25.357', N'49df1602-f5f3-4d52-afb7-3802da619558', N'admin')
GO

INSERT INTO [dbo].[FlowInstanceOperationHistory]  VALUES (N'42b29508-49ae-43ac-b426-5479a6250873', N'fb6418d5-326d-47d8-8403-dcd183c613bc', N'【创建】超级管理员创建了一个流程进程【1564320275628/复杂表单的流程2019-07-28 21:24:38】', N'2019-07-28 21:25:41.957', N'00000000-0000-0000-0000-000000000000', N'超级管理员')
GO

INSERT INTO [dbo].[FlowInstanceOperationHistory]  VALUES (N'0bbf90a2-300d-469f-983e-cfa71b388f3b', N'05403247-63c0-4fa6-9243-89de66453390', N'【创建】超级管理员创建了一个流程进程【1564320398533/带条件分支领料模板2019-07-28 21:26:38】', N'2019-07-28 21:26:58.117', N'00000000-0000-0000-0000-000000000000', N'超级管理员')
GO

INSERT INTO [dbo].[FlowInstanceOperationHistory]  VALUES (N'12a417f7-e66a-483e-8bcd-5bd2f9f3da43', N'0eacf4e4-455f-439e-945e-45c174be3815', N'【创建】超级管理员创建了一个流程进程【1564320635643/带会签功能的流程2019-07-28 21:30:35】', N'2019-07-28 21:31:00.050', N'00000000-0000-0000-0000-000000000000', N'超级管理员')
GO

INSERT INTO [dbo].[FlowInstanceOperationHistory]  VALUES (N'5d38d317-06d1-4112-a0f1-83949e8cc0ea', N'0eacf4e4-455f-439e-945e-45c174be3815', N'【所有人可审核】【2019-07-28 21:31】同意,备注：', N'2019-07-28 21:31:20.343', N'00000000-0000-0000-0000-000000000000', N'超级管理员')
GO

INSERT INTO [dbo].[FlowInstanceOperationHistory]  VALUES (N'2bf3713f-6bfb-4f30-8a6d-314b56011167', N'0eacf4e4-455f-439e-945e-45c174be3815', N'【这里只能指定用户，如admin】【2019-07-28 21:32】同意,备注：admin准了', N'2019-07-28 21:32:04.003', N'49df1602-f5f3-4d52-afb7-3802da619558', N'admin')
GO

INSERT INTO [dbo].[FlowInstanceOperationHistory]  VALUES (N'33370972-0fb7-4f96-aafa-4ef2eaed45cc', N'0eacf4e4-455f-439e-945e-45c174be3815', N'【这里只能指定用户，如test】【2019-07-28 21:33】同意,备注：', N'2019-07-28 21:33:31.610', N'6ba79766-faa0-4259-8139-a4a6d35784e0', N'test')
GO

INSERT INTO [dbo].[FlowInstanceOperationHistory]  VALUES (N'6412009f-4edd-450b-bf4b-e241d5016880', N'05403247-63c0-4fa6-9243-89de66453390', N'【所有人可审核】【2019-07-28 21:38】同意,备注：', N'2019-07-28 21:38:15.050', N'00000000-0000-0000-0000-000000000000', N'超级管理员')
GO

INSERT INTO [dbo].[FlowInstanceOperationHistory]  VALUES (N'cb60034a-f748-433d-b6f1-4f821419015c', N'48c4eafb-cbae-463c-906b-da3aab22fe1e', N'【管理员角色可审核】【2019-07-28 21:06】同意,备注：这个我帮你一下吧', N'2019-07-28 21:06:24.447', N'49df1602-f5f3-4d52-afb7-3802da619558', N'admin')
GO

INSERT INTO [dbo].[FlowInstanceOperationHistory]  VALUES (N'415c6eab-a9e2-49a1-87e4-2e790a83bcf0', N'0e7440b9-b3d6-4d55-bf27-dbf9d2907f09', N'【创建】超级管理员创建了一个流程进程【1564320191405/申请电脑】', N'2019-07-28 21:23:29.193', N'00000000-0000-0000-0000-000000000000', N'超级管理员')
GO

INSERT INTO [dbo].[FlowInstanceOperationHistory]  VALUES (N'0b97843e-0552-444d-8f44-faefa87cf596', N'd4b4f635-fd6a-4d61-99e3-8eafb09dce51', N'【创建】超级管理员创建了一个流程进程【1564320191408/申请很多电脑】', N'2019-07-28 21:23:45.947', N'00000000-0000-0000-0000-000000000000', N'超级管理员')
GO

INSERT INTO [dbo].[FlowInstanceOperationHistory]  VALUES (N'd7397c16-fe0e-47e4-838e-efe00107ae51', N'67d18244-e8cd-4bf8-b2f8-a86a375e51b9', N'【创建】超级管理员创建了一个流程进程【1564326992881/领取办公用品】', N'2019-07-28 23:17:30.313', N'00000000-0000-0000-0000-000000000000', N'超级管理员')
GO




-- ----------------------------
-- Records of [FlowInstanceTransitionHistory]
-- ----------------------------
INSERT INTO [dbo].[FlowInstanceTransitionHistory]  VALUES (N'c4eb457b-db59-44ce-86f3-6f41a5be7664', N'e735c8ab-2a8f-4554-8e7d-722ff7a6f162', N'1564314904791', N'3', N'node_1', N'1564314907655', N'2', N'所有人可审核', N'0', N'0', N'2019-07-28 20:05:41.207', N'00000000-0000-0000-0000-000000000000', N'超级管理员')
GO

INSERT INTO [dbo].[FlowInstanceTransitionHistory]  VALUES (N'57a213dc-7279-4dd5-b25f-f8294a4d84cb', N'48c4eafb-cbae-463c-906b-da3aab22fe1e', N'1564314904791', N'3', N'node_1', N'1564314907655', N'2', N'所有人可审核', N'0', N'0', N'2019-07-28 20:10:41.260', N'00000000-0000-0000-0000-000000000000', N'超级管理员')
GO

INSERT INTO [dbo].[FlowInstanceTransitionHistory]  VALUES (N'9336f1e3-a56e-4445-98e2-b9f48af04e8b', N'48c4eafb-cbae-463c-906b-da3aab22fe1e', N'1564314907655', N'2', N'所有人可审核', N'1564314909567', N'2', N'申请数目大于10走这里', N'0', N'0', N'2019-07-28 21:04:50.037', N'00000000-0000-0000-0000-000000000000', N'超级管理员')
GO

INSERT INTO [dbo].[FlowInstanceTransitionHistory]  VALUES (N'9f62bce8-dfce-4146-8262-724c30081e71', N'48c4eafb-cbae-463c-906b-da3aab22fe1e', N'1564314909567', N'2', N'申请数目大于10走这里', N'1564314912495', N'2', N'管理员角色可审核', N'0', N'0', N'2019-07-28 21:05:50.207', N'49df1602-f5f3-4d52-afb7-3802da619558', N'admin')
GO

INSERT INTO [dbo].[FlowInstanceTransitionHistory]  VALUES (N'9b762fe2-87c7-46d0-9426-3266f2e9e4aa', N'4d188305-14f8-42a0-9a9b-4f75bebe59fd', N'1564314379796', N'3', N'node_1', N'1564314382019', N'2', N'所有人可审批', N'0', N'0', N'2019-07-28 21:07:49.747', N'49df1602-f5f3-4d52-afb7-3802da619558', N'admin')
GO

INSERT INTO [dbo].[FlowInstanceTransitionHistory]  VALUES (N'7352f127-ab1d-422a-89c1-b6f485932269', N'fd0be09f-2cef-472a-ba81-de01673c5a1b', N'1564314904791', N'3', N'node_1', N'1564314907655', N'2', N'所有人可审核', N'0', N'0', N'2019-07-28 21:08:25.360', N'49df1602-f5f3-4d52-afb7-3802da619558', N'admin')
GO

INSERT INTO [dbo].[FlowInstanceTransitionHistory]  VALUES (N'08985d9c-0887-4cfb-8f63-07d31780b0e4', N'fb6418d5-326d-47d8-8403-dcd183c613bc', N'1564314752457', N'3', N'node_1', N'1564314754728', N'2', N'所有人可以执行', N'0', N'0', N'2019-07-28 21:25:41.963', N'00000000-0000-0000-0000-000000000000', N'超级管理员')
GO

INSERT INTO [dbo].[FlowInstanceTransitionHistory]  VALUES (N'112efeb2-83cb-4b29-a499-fc37d9fb745a', N'05403247-63c0-4fa6-9243-89de66453390', N'1564314904791', N'3', N'node_1', N'1564314907655', N'2', N'所有人可审核', N'0', N'0', N'2019-07-28 21:26:58.117', N'00000000-0000-0000-0000-000000000000', N'超级管理员')
GO

INSERT INTO [dbo].[FlowInstanceTransitionHistory]  VALUES (N'301a670e-bc05-40b2-8dd6-b5e2a2be9aba', N'0eacf4e4-455f-439e-945e-45c174be3815', N'1564320467424', N'3', N'node_1', N'1564320471304', N'2', N'所有人可审核', N'0', N'0', N'2019-07-28 21:31:00.050', N'00000000-0000-0000-0000-000000000000', N'超级管理员')
GO

INSERT INTO [dbo].[FlowInstanceTransitionHistory]  VALUES (N'07299501-0402-4dea-b029-8bb0a6638471', N'0eacf4e4-455f-439e-945e-45c174be3815', N'1564320471304', N'2', N'所有人可审核', N'1564320473223', N'0', N'这个地方可以选会签的类型', N'0', N'0', N'2019-07-28 21:31:20.353', N'00000000-0000-0000-0000-000000000000', N'超级管理员')
GO

INSERT INTO [dbo].[FlowInstanceTransitionHistory]  VALUES (N'ffcc13cb-48d6-4af4-ab22-31df53f5f3cf', N'0eacf4e4-455f-439e-945e-45c174be3815', N'1564320473223', N'0', N'这个地方可以选会签的类型', N'1564320482303', N'4', N'node_7', N'0', N'1', N'2019-07-28 21:33:31.613', N'6ba79766-faa0-4259-8139-a4a6d35784e0', N'test')
GO

INSERT INTO [dbo].[FlowInstanceTransitionHistory]  VALUES (N'63802202-1739-4ac4-a0a7-8d357a28b3a0', N'05403247-63c0-4fa6-9243-89de66453390', N'1564314907655', N'2', N'所有人可审核', N'1564314909567', N'2', N'申请数目大于10走这里', N'0', N'0', N'2019-07-28 21:38:15.050', N'00000000-0000-0000-0000-000000000000', N'超级管理员')
GO

INSERT INTO [dbo].[FlowInstanceTransitionHistory]  VALUES (N'725eca78-65dc-4446-90f0-2c94b986e785', N'48c4eafb-cbae-463c-906b-da3aab22fe1e', N'1564314912495', N'2', N'管理员角色可审核', N'1564314915487', N'4', N'node_6', N'0', N'1', N'2019-07-28 21:06:24.450', N'49df1602-f5f3-4d52-afb7-3802da619558', N'admin')
GO

INSERT INTO [dbo].[FlowInstanceTransitionHistory]  VALUES (N'14228cf1-c1fc-4d82-a4d9-ac6d5d5f3fc5', N'0e7440b9-b3d6-4d55-bf27-dbf9d2907f09', N'1564314904791', N'3', N'node_1', N'1564314907655', N'2', N'所有人可审核', N'0', N'0', N'2019-07-28 21:23:29.193', N'00000000-0000-0000-0000-000000000000', N'超级管理员')
GO

INSERT INTO [dbo].[FlowInstanceTransitionHistory]  VALUES (N'0a432312-9717-4c62-858c-265853b7699a', N'd4b4f635-fd6a-4d61-99e3-8eafb09dce51', N'1564314904791', N'3', N'node_1', N'1564314907655', N'2', N'所有人可审核', N'0', N'0', N'2019-07-28 21:23:45.947', N'00000000-0000-0000-0000-000000000000', N'超级管理员')
GO

INSERT INTO [dbo].[FlowInstanceTransitionHistory]  VALUES (N'6bbb0d71-6eea-477c-91f7-7e42195b215a', N'67d18244-e8cd-4bf8-b2f8-a86a375e51b9', N'1564314904791', N'3', N'node_1', N'1564314907655', N'2', N'所有人可审核', N'0', N'0', N'2019-07-28 23:17:30.320', N'00000000-0000-0000-0000-000000000000', N'超级管理员')
GO



-- ----------------------------
-- Records of [FlowScheme]
-- ----------------------------
INSERT INTO [dbo].[FlowScheme]  VALUES (N'2cfafb29-8fef-4a22-849f-e510c0f0d4bb', N'1564314361470', N'一个普通的请假流程', N'', N'', N'', N'{"title":"newFlow_1","nodes":[{"name":"node_1","left":46,"top":105,"type":"start round mix","id":"1564314379796","width":26,"height":26,"alt":true},{"name":"所有人可审批","left":167,"top":104,"type":"node","id":"1564314382019","width":104,"height":50,"alt":true,"setInfo":{"NodeName":"所有人可审批","NodeCode":"node_2","NodeRejectType":"0","NodeDesignate":"ALL_USER","NodeConfluenceType":"all","NodeDesignateData":{"users":[],"roles":[],"orgs":[]}}},{"name":"admin审批","left":177,"top":228,"type":"node","id":"1564314385315","width":104,"height":46,"alt":true,"setInfo":{"NodeName":"admin审批","NodeCode":"node_3","NodeRejectType":"0","NodeDesignate":"SPECIAL_USER","NodeConfluenceType":"all","NodeDesignateData":{"users":["49df1602-f5f3-4d52-afb7-3802da619558"],"roles":[],"orgs":[]}}},{"name":"test审批","left":364,"top":113,"type":"node","id":"1564314386675","width":104,"height":51,"alt":true,"setInfo":{"NodeName":"test审批","NodeCode":"node_4","NodeRejectType":"0","NodeDesignate":"SPECIAL_USER","NodeConfluenceType":"all","NodeDesignateData":{"users":["6ba79766-faa0-4259-8139-a4a6d35784e0"],"roles":[],"orgs":[]}}},{"name":"node_5","left":419,"top":239,"type":"end round","id":"1564314389179","width":26,"height":26,"alt":true}],"lines":[{"type":"sl","from":"1564314379796","to":"1564314382019","id":"1564314397060","name":"","dash":false,"alt":true},{"type":"sl","from":"1564314382019","to":"1564314386675","id":"1564314399066","name":"","dash":false,"alt":true},{"type":"sl","from":"1564314386675","to":"1564314385315","id":"1564314400938","name":"","dash":false,"alt":true},{"type":"sl","from":"1564314385315","to":"1564314389179","id":"1564314402522","name":"","dash":false,"alt":true}],"areas":[],"initNum":11}', N'5d68feac-bc11-4e37-bee1-4c5610b70185', N'0', N'0', N'1', N'0', N'0', N'里面有所有人都可审批、指定用户可审批', N'2019-07-28 19:48:20.420', N'', N'', N'2019-07-28 19:48:20.423', N'', N'')
GO

INSERT INTO [dbo].[FlowScheme]  VALUES (N'b880fa18-e405-407c-ae74-eeb0807d5f8a', N'1564314509135', N'指定角色的审批流程', N'', N'', N'', N'{"title":"newFlow_1","nodes":[{"name":"node_1","left":58,"top":101,"type":"start round mix","id":"1564314535611","width":26,"height":26,"alt":true},{"name":"指定了管理员角色","left":179,"top":109,"type":"node","id":"1564314538146","width":104,"height":61,"alt":true,"setInfo":{"NodeName":"指定了管理员角色","NodeCode":"node_2","NodeRejectType":"0","NodeDesignate":"SPECIAL_ROLE","NodeConfluenceType":"all","NodeDesignateData":{"users":[],"roles":["09ee2ffa-7463-4938-ae0b-1cb4e80c7c13"],"orgs":[]}}},{"name":"指定了测试角色","left":192,"top":207,"type":"node","id":"1564314538770","width":104,"height":42,"alt":true,"setInfo":{"NodeName":"指定了测试角色","NodeCode":"node_3","NodeRejectType":"0","NodeDesignate":"SPECIAL_ROLE","NodeConfluenceType":"all","NodeDesignateData":{"users":[],"roles":["0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d"],"orgs":[]}}},{"name":"node_4","left":386,"top":211,"type":"end round","id":"1564314540834","width":26,"height":26,"alt":true}],"lines":[{"type":"sl","from":"1564314535611","to":"1564314538146","id":"1564314542850","name":"","dash":false,"alt":true},{"type":"sl","from":"1564314538146","to":"1564314538770","id":"1564314544313","name":"","dash":false,"alt":true},{"type":"sl","from":"1564314538770","to":"1564314540834","id":"1564314545466","name":"","dash":false,"alt":true}],"areas":[],"initNum":9}', N'6dfd447d-37c9-4a59-92a5-b00df579725b', N'0', N'0', N'1', N'0', N'0', NULL, N'2019-07-28 19:49:52.237', N'', N'', N'2019-07-28 19:49:52.237', N'', N'')
GO

INSERT INTO [dbo].[FlowScheme]  VALUES (N'4f8c7a8b-a61b-4802-8429-61b6a49d167d', N'1564314688386', N'复杂表单的流程', N'', N'', N'', N'{"title":"newFlow_1","nodes":[{"name":"node_1","left":233,"top":115,"type":"start round mix","id":"1564314752457","width":26,"height":26,"alt":true},{"name":"所有人可以执行","left":392,"top":133,"type":"node","id":"1564314754728","width":104,"height":56,"alt":true,"setInfo":{"NodeConfluenceType":"all","NodeDesignate":"ALL_USER","NodeDesignateData":{"users":[],"roles":[]}}},{"name":"管理员和测试角色都可以执行","left":599,"top":152,"type":"node","id":"1564314756312","width":177,"height":126,"alt":true,"setInfo":{"NodeConfluenceType":"all","NodeDesignate":"SPECIAL_ROLE","NodeDesignateData":{"users":[],"roles":["09ee2ffa-7463-4938-ae0b-1cb4e80c7c13","0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d"]}}},{"name":"node_4","left":668,"top":336,"type":"end round","id":"1564314759624","width":26,"height":26,"alt":true}],"lines":[{"type":"sl","from":"1564314752457","to":"1564314754728","id":"1564314761888","name":"","dash":false},{"type":"sl","from":"1564314754728","to":"1564314756312","id":"1564314762776","name":"","dash":false},{"type":"sl","from":"1564314756312","to":"1564314759624","id":"1564314763873","name":"","dash":false}],"areas":[],"initNum":9}', N'ec35908a-80ec-4587-9b11-ee614934846d', N'0', N'0', N'0', N'0', N'0', N'这是企业版添加的复杂表单流程，基于开发的表单页面，可以实现复杂的表单交互功能，如上传等', N'2019-07-28 19:53:36.157', N'', N'', N'2019-07-28 21:22:45.197', N'', N'')
GO

INSERT INTO [dbo].[FlowScheme]  VALUES (N'b9673c3f-457a-472d-9dad-1480c5b8bcb4', N'1564314688386', N'带条件分支领料模板', N'', N'', N'', N'{"title":"newFlow_1","nodes":[{"name":"node_1","left":125,"top":232,"type":"start round mix","id":"1564314904791","width":26,"height":26,"alt":true},{"name":"所有人可审核","left":246,"top":218,"type":"node","id":"1564314907655","width":110,"height":69,"alt":true,"setInfo":{"NodeConfluenceType":"all","NodeDesignate":"ALL_USER","NodeDesignateData":{"users":[],"roles":[]}}},{"name":"申请数目大于10走这里","left":461,"top":179,"type":"node","id":"1564314909567","width":104,"height":76,"alt":true,"setInfo":{"NodeConfluenceType":"all","NodeDesignate":"SPECIAL_USER","NodeDesignateData":{"users":["49df1602-f5f3-4d52-afb7-3802da619558"],"roles":[]}}},{"name":"小于等于10走这里，test账号审核","left":476,"top":333,"type":"node","id":"1564314910199","width":104,"height":96,"alt":true,"setInfo":{"NodeConfluenceType":"all","NodeDesignate":"SPECIAL_USER","NodeDesignateData":{"users":["6ba79766-faa0-4259-8139-a4a6d35784e0"],"roles":[]}}},{"name":"管理员角色可审核","left":694,"top":245,"type":"node","id":"1564314912495","width":104,"height":56,"alt":true,"setInfo":{"NodeConfluenceType":"all","NodeDesignate":"SPECIAL_ROLE","NodeDesignateData":{"users":[],"roles":["09ee2ffa-7463-4938-ae0b-1cb4e80c7c13"]}}},{"name":"node_6","left":848,"top":271,"type":"end round","id":"1564314915487","width":26,"height":26,"alt":true}],"lines":[{"type":"sl","from":"1564314904791","to":"1564314907655","id":"1564314918063","name":"","dash":false},{"type":"sl","from":"1564314907655","to":"1564314909567","id":"1564314919111","name":"","dash":false},{"type":"sl","from":"1564314907655","to":"1564314910199","id":"1564314920391","name":"","dash":false},{"type":"sl","from":"1564314909567","to":"1564314912495","id":"1564314921759","name":"","dash":false},{"type":"sl","from":"1564314910199","to":"1564314912495","id":"1564314923574","name":"","dash":false},{"type":"sl","from":"1564314912495","to":"1564314915487","id":"1564314924822","name":"","dash":false}],"areas":[],"initNum":14}', N'6dfd447d-37c9-4a59-92a5-b00df579725b', N'0', N'0', N'0', N'0', N'0', N'可以在分支线上设定分支条件', N'2019-07-28 19:58:03.467', N'', N'', N'2019-07-28 21:22:26.727', N'', N'')
GO

INSERT INTO [dbo].[FlowScheme]  VALUES (N'18593e9f-000e-4b9e-8148-9ee23a59fd56', N'1564320423976', N'带会签功能的流程', N'', N'', N'', N'{"title":"newFlow_1","nodes":[{"name":"node_1","left":27,"top":46,"type":"start round mix","id":"1564320467424","width":26,"height":26,"alt":true},{"name":"所有人可审核","left":178,"top":54,"type":"node","id":"1564320471304","width":104,"height":56,"alt":true,"setInfo":{"NodeConfluenceType":"all","NodeDesignate":"ALL_USER","NodeDesignateData":{"users":[],"roles":[]}}},{"name":"这个地方可以选会签的类型","left":365,"top":51,"type":"fork","id":"1564320473223","width":104,"height":76,"alt":true,"setInfo":{"NodeConfluenceType":"all","NodeDesignate":"ALL_USER","NodeDesignateData":{"users":[],"roles":[]}}},{"name":"这里只能指定用户，如admin","left":99,"top":190,"type":"node","id":"1564320475431","width":174,"height":74,"alt":true,"setInfo":{"NodeConfluenceType":"all","NodeDesignate":"SPECIAL_USER","NodeDesignateData":{"users":["49df1602-f5f3-4d52-afb7-3802da619558"],"roles":[]}}},{"name":"这里只能指定用户，如test","left":459,"top":201,"type":"node","id":"1564320475943","width":172,"height":61,"alt":true,"setInfo":{"NodeConfluenceType":"all","NodeDesignate":"SPECIAL_USER","NodeDesignateData":{"users":["6ba79766-faa0-4259-8139-a4a6d35784e0"],"roles":[]}}},{"name":"node_6","left":294,"top":329,"type":"join","id":"1564320478447","width":104,"height":26,"alt":true},{"name":"node_7","left":45,"top":340,"type":"end round","id":"1564320482303","width":26,"height":26,"alt":true}],"lines":[{"type":"sl","from":"1564320467424","to":"1564320471304","id":"1564320486639","name":"","dash":false,"alt":true},{"type":"sl","from":"1564320471304","to":"1564320473223","id":"1564320487615","name":"","dash":false,"alt":true},{"type":"sl","from":"1564320473223","to":"1564320475431","id":"1564320489350","name":"","dash":false,"alt":true},{"type":"sl","from":"1564320473223","to":"1564320475943","id":"1564320490639","name":"","dash":false,"alt":true},{"type":"sl","from":"1564320475431","to":"1564320478447","id":"1564320492038","name":"","dash":false,"alt":true},{"type":"sl","from":"1564320475943","to":"1564320478447","id":"1564320493295","name":"","dash":false,"alt":true},{"type":"sl","from":"1564320478447","to":"1564320482303","id":"1564320494927","name":"","dash":false,"alt":true}],"areas":[],"initNum":15}', N'6dfd447d-37c9-4a59-92a5-b00df579725b', N'0', N'0', N'0', N'0', N'0', N'需要多人审批通过，或至少有一个审批通过的情况', N'2019-07-28 21:30:27.650', N'', N'', N'2019-07-28 21:30:27.650', N'', N'')
GO



-- ----------------------------
-- Records of [Form]
-- ----------------------------
INSERT INTO [dbo].[Form]  VALUES (N'ec35908a-80ec-4587-9b11-ee614934846d', N'自定义开发的复杂表单', N'1', N'FrmLeaveReq', N'0', N'', N'', N'', N'0', N'0', N'', N'0', N'自定义开发的复杂表单，当前只对企业版开放', N'2019-07-28 19:34:38.037', N'', N'', N'2019-07-28 19:34:38.037', N'', N'')
GO

INSERT INTO [dbo].[Form]  VALUES (N'6dfd447d-37c9-4a59-92a5-b00df579725b', N'简单的动态表单--领料单', N'0', N'', N'0', N'[{"name":"TOOLS","title":"TOOLS","leipiplugins":"select","size":"1","orgwidth":"150","style":"width: 150px;","value":"电脑,平板,手机","selected":"selected","content":"<select name=\"leipiNewField\" title=\"TOOLS\" leipiplugins=\"select\" size=\"1\" orgwidth=\"150\" style=\"width: 150px;\"><option value=\"电脑\" selected=\"selected\">电脑</option><option value=\"平板\">平板</option><option value=\"手机\">手机</option></select>"},{"type":"text","name":"NUMBERS","title":"NUMBERS","value":"1","leipiplugins":"text","orghide":"0","orgalign":"left","orgwidth":"150","orgtype":"int","style":"text-align: left; width: 150px;","content":"<input name=\"leipiNewField\" type=\"text\" title=\"NUMBERS\" value=\"1\" leipiplugins=\"text\" orghide=\"0\" orgalign=\"left\" orgwidth=\"150\" orgtype=\"int\" style=\"text-align: left; width: 150px;\"/>"}]', N'<p style="text-align: center;"><span style="font-size: 24px;">领料单</span><br/></p><p><span style="font-size: 24px;"><br/></span></p><p style="text-align: center;"><span style="font-size: 18px;">因工作需要，需领取{TOOLS}&nbsp;&nbsp;</span>{NUMBERS}<span style="font-size: 18px;">台，望批准！</span></p><p><span style="font-size: 18px;"><br/></span></p><p style="text-align: center;"><span style="font-size: 18px;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 谢谢！</span></p>', N'<p style="text-align: center;"><span style="font-size: 24px;">领料单</span><br/></p><p><span style="font-size: 24px;"><br/></span></p><p style="text-align: center;"><span style="font-size: 18px;">因工作需要，需领取{|-<select name="leipiNewField" title="TOOLS" leipiplugins="select" size="1" orgwidth="150" style="width: 150px;"><option value="电脑" selected="selected">电脑</option><option value="平板">平板</option><option value="手机">手机</option></select>&nbsp;&nbsp;-|}</span><input name="leipiNewField" type="text" title="NUMBERS" value="1" leipiplugins="text" orghide="0" orgalign="left" orgwidth="150" orgtype="int" style="text-align: left; width: 150px;"/><span style="font-size: 18px;">台，望批准！</span></p><p><span style="font-size: 18px;"><br/></span></p><p style="text-align: center;"><span style="font-size: 18px;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 谢谢！</span></p>', N'0', N'0', N'', N'0', N'简单的动态表单，适用于无需编程，快速添加', N'2019-07-28 19:39:06.757', N'', N'', N'2019-07-28 22:04:10.137', N'', N'')
GO

INSERT INTO [dbo].[Form]  VALUES (N'5d68feac-bc11-4e37-bee1-4c5610b70185', N'MVC添加的请假条', N'0', N'', N'0', N'[{"type":"text","name":"DAYS","title":"DAYS","value":"2","leipiplugins":"text","orghide":"0","orgalign":"left","orgwidth":"150","orgtype":"int","style":"text-align: left; width: 150px;","content":"<input name=\"leipiNewField\" type=\"text\" title=\"DAYS\" value=\"2\" leipiplugins=\"text\" orghide=\"0\" orgalign=\"left\" orgwidth=\"150\" orgtype=\"int\" style=\"text-align: left; width: 150px;\"/>"},{"name":"REASON","title":"REASON","leipiplugins":"textarea","value":"因病请假","orgrich":"0","orgfontsize":"","orgwidth":"300","orgheight":"150","style":"width:300px;height:150px;","content":"<textarea title=\"REASON\" name=\"leipiNewField\" leipiplugins=\"textarea\" value=\"因病请假\" orgrich=\"0\" orgfontsize=\"\" orgwidth=\"300\" orgheight=\"150\" style=\"width:300px;height:150px;\">因病请假</textarea>"}]', N'<p style="text-align: center;"><strong><span style="font-size: 24px;">请假条</span></strong></p><p style="text-align: center;"><br/></p><p style="text-align: center;">因身体原因，想请假{DAYS}天，望领导批准。具体请假原因如下：</p><p style="text-align: center;">{REASON}</p>', N'<p style="text-align: center;"><strong><span style="font-size: 24px;">请假条</span></strong></p><p style="text-align: center;"><br/></p><p style="text-align: center;">因身体原因，想请假<input name="leipiNewField" type="text" title="DAYS" value="2" leipiplugins="text" orghide="0" orgalign="left" orgwidth="150" orgtype="int" style="text-align: left; width: 150px;"/>天，望领导批准。具体请假原因如下：</p><p style="text-align: center;"><textarea title="REASON" name="leipiNewField" leipiplugins="textarea" value="因病请假" orgrich="0" orgfontsize="" orgwidth="300" orgheight="150" style="width:300px;height:150px;">因病请假</textarea></p>', N'1', N'0', NULL, N'0', N'这个表单是用开源MVC添加的，和企业版的效果一致', N'2019-07-28 19:44:03.100', N'', N'', N'2019-07-28 21:10:18.570', N'', N'')
GO




-- ----------------------------
-- Records of [FrmLeaveReq]
-- ----------------------------
INSERT INTO [dbo].[FrmLeaveReq]  VALUES (N'd7f7fc13-acc3-4572-bb50-b7cda11b7ca1', N'李玉宝', N'事假', N'2019-07-09', N'2019-07-28 11:24:51.000', N'2019-07-30', N'2019-07-28 13:24:55.000', N'说起来原因有很多，但是我只想说。我要写代码', N'', N'2019-07-28 21:25:41.907', N'', N'', N'fb6418d5-326d-47d8-8403-dcd183c613bc')
GO



-- ----------------------------
-- Records of [Module]
-- ----------------------------
INSERT INTO [dbo].[Module]  VALUES (N'0031262c-689c-4b96-bae2-2c9d67076ade', N'.0.1.2.', N'流程设计', N'/flowSchemes/index', N'', N'0', N'0', N'layui-icon-engine', N'0', N'基础配置', N'', N'0', N'7580672f-a390-4bb6-982d-9a4570cb5199', N'FlowScheme', N'1')
GO

INSERT INTO [dbo].[Module]  VALUES (N'069475e3-c997-487a-9f29-e6a864c5c1d4', N'.0.2.', N'流程中心', N'/', N'', N'0', N'0', N'layui-icon-senior', N'0', N'根节点', N'', N'0', NULL, NULL, N'1')
GO

INSERT INTO [dbo].[Module]  VALUES (N'37bb9414-19a0-4223-9056-71f8c758a930', N'.0.2.3.', N'已处理流程', N'/flowinstances/disposed', N'', N'0', N'0', N'layui-icon-ok-circle', N'0', N'流程中心', N'', N'1', N'069475e3-c997-487a-9f29-e6a864c5c1d4', N'FlowInstanceDisposed', N'1')
GO

INSERT INTO [dbo].[Module]  VALUES (N'4abafc83-c8f5-452f-9882-e113a86e7a3e', N'.0.2.2.', N'待处理流程', N'/flowinstances/wait', N'', N'0', N'0', N'layui-icon-help', N'0', N'流程中心', N'', N'1', N'069475e3-c997-487a-9f29-e6a864c5c1d4', N'FlowInstanceWait', N'1')
GO

INSERT INTO [dbo].[Module]  VALUES (N'6a9e1346-0c01-44d2-8eb1-f929fdab542a', N'.0.1.8.', N'部门管理', N'/OrgManager/Index', N'', N'0', N'0', N'layui-icon-group', N'0', N'基础配置', N'', N'0', N'7580672f-a390-4bb6-982d-9a4570cb5199', N'Org', N'1')
GO

INSERT INTO [dbo].[Module]  VALUES (N'7580672f-a390-4bb6-982d-9a4570cb5199', N'.0.1.', N'基础配置', N' ', N' ', N'1', N'0', N'layui-icon-set-fill', N'0', N'根节点', N' ', N'0', NULL, NULL, N'1')
GO

INSERT INTO [dbo].[Module]  VALUES (N'92b00259-2d15-43e7-9321-adffb29e8bf2', N'.0.1.5.', N'表单设计', N'/forms/index', N'', N'0', N'0', N'layui-icon-theme', N'0', N'基础配置', N'', N'0', N'7580672f-a390-4bb6-982d-9a4570cb5199', N'Form', N'1')
GO

INSERT INTO [dbo].[Module]  VALUES (N'9486ff22-b696-4d7f-8093-8a3e53c45453', N'.0.2.1.', N'我的流程', N'/flowInstances/Index', N'', N'0', N'0', N'layui-icon-share', N'0', N'流程中心', N'', N'2', N'069475e3-c997-487a-9f29-e6a864c5c1d4', N'FlowInstance', N'1')
GO

INSERT INTO [dbo].[Module]  VALUES (N'a94d5648-c2a9-405e-ba6f-f1602ec9b807', N'.0.1.7.', N'分类管理', N'/Categories/Index', N'', N'0', N'0', N'layui-icon-app', N'0', N'基础配置', N'', N'0', N'7580672f-a390-4bb6-982d-9a4570cb5199', N'Category', N'0')
GO

INSERT INTO [dbo].[Module]  VALUES (N'bc80478d-0547-4437-9cff-be4b40144bdf', N'.0.1.6.', N'模块管理', N'/ModuleManager/Index', N' ', N'1', N'0', N'layui-icon-tabs', N'0', N'基础配置', N' ', N'0', N'7580672f-a390-4bb6-982d-9a4570cb5199', N'Module', N'1')
GO

INSERT INTO [dbo].[Module]  VALUES (N'bedb41a2-f310-4775-af99-01be08adda93', N'.0.1.1.', N'角色管理', N'/RoleManager/Index', N'', N'1', N'0', N'layui-icon-user', N'0', N'基础配置', N'', N'0', N'7580672f-a390-4bb6-982d-9a4570cb5199', N'Role', N'1')
GO

INSERT INTO [dbo].[Module]  VALUES (N'e8dc5db6-4fc4-4795-a1cc-681cbcceec91', N'.0.1.3.', N'资源管理', N'/Resources/Index', N'', N'0', N'0', N'layui-icon-cellphone', N'0', N'基础配置', N'', N'0', N'7580672f-a390-4bb6-982d-9a4570cb5199', N'Resource', N'0')
GO

INSERT INTO [dbo].[Module]  VALUES (N'ef386d5d-cd58-43c0-a4ab-80afd0dbcd6c', N'.0.1.4.', N'用户管理', N'/UserManager/Index', N'', N'0', N'0', N'layui-icon-friends', N'0', N'基础配置', N'', N'0', N'7580672f-a390-4bb6-982d-9a4570cb5199', N'User', N'1')
GO



-- ----------------------------
-- Records of [ModuleElement]
-- ----------------------------
INSERT INTO [dbo].[ModuleElement]  VALUES (N'0d25438e-1436-48e0-aedf-0f1690693282', N'btnAccessModule', N'为角色分配模块', N'', N'assignRoleModule(this)', N'layui-icon-search', N'layui-btn-normal', N'为角色分配模块', N'4', N'bedb41a2-f310-4775-af99-01be08adda93', NULL, NULL)
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'15a4f88c-4fae-4cab-ba2f-0cbd2cca8736', N'btnAssignReource', N'为角色分配资源', N'', N'openRoleReourceAccess(this)', N'layui-icon-search', N'layui-btn-normal', N'为角色分配资源', N'3', N'bedb41a2-f310-4775-af99-01be08adda93', NULL, NULL)
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'17ae4fd4-ab4e-439e-ba1d-2a53b46d112b', N'btnDel', N'删除', N'', N'', N'layui-icon-delete', N'layui-btn-danger', N'', N'2', N'0031262c-689c-4b96-bae2-2c9d67076ade', N'', N'')
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'18cc3217-28a6-49b2-9a20-080230065984', N'btnEdit', N'编辑', N'', N'', N'layui-icon-edit', N'layui-btn-normal', N'', N'1', N'0031262c-689c-4b96-bae2-2c9d67076ade', N'', N'')
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'1a473afd-cbd4-41e9-9471-81f9435aaabe', N'btnEdit', N'编辑', N' ', N'edit()', N'layui-icon-edit', N'layui-btn-normal', N'编辑分类', N'0', N'a94d5648-c2a9-405e-ba6f-f1602ec9b807', NULL, NULL)
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'1c870438-4260-43a5-8996-a6e1dc8bbf6a', N'btnAdd', N'添加', N'', N'', N'layui-icon-add-1', N'layui-btn-normal', N'', N'0', N'6a9e1346-0c01-44d2-8eb1-f929fdab542a', N'', N'')
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'1c9acc3e-a40d-4d07-b495-6e60eb9b71b9', N'btnEdit', N'编辑', N'', N'edit()', N'layui-icon-edit', N'layui-btn-normal', N'编辑角色', N'1', N'bedb41a2-f310-4775-af99-01be08adda93', NULL, NULL)
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'2d595a2a-5de5-479e-a331-b53c799a6b10', N'btnAdd', N'添加', N'', N'add()', N'layui-icon-add-1', N'layui-btn-normal', N'添加分类', N'0', N'a94d5648-c2a9-405e-ba6f-f1602ec9b807', NULL, NULL)
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'2feefce1-e3d8-42ac-b811-2352679628da', N'btnDel', N'删除', N'', N'del()', N'layui-icon-delete', N'layui-btn-danger', N'刪除用戶', N'2', N'ef386d5d-cd58-43c0-a4ab-80afd0dbcd6c', NULL, NULL)
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'34730f5a-d307-457b-9041-5f7de30abfa9', N'btnEdit', N'编辑', N'', N'edit()', N'layui-icon-edit', N'layui-btn-normal', N'编辑用户', N'1', N'ef386d5d-cd58-43c0-a4ab-80afd0dbcd6c', NULL, NULL)
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'362d1eda-c85e-4b14-a80a-b923291e08de', N'btnAdd', N'添加', N'', N'add()', N'layui-icon-add-1', N'layui-btn-normal', N'添加', N'0', N'f0f06b8f-0a86-487c-8b0e-0a12573ccd46', NULL, NULL)
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'38109ca0-32ec-44bd-a243-017e591b532b', N'btnEditStock', N'编辑', N' ', N'edit()', N'layui-icon-edit', N'layui-btn-normal', N'编辑进出库', N'0', N'89c3bfbe-246f-4112-8eb1-b6789da54202', NULL, NULL)
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'3dc0ec4d-bf86-4bae-9ec0-1d6c2403fb99', N'btnAdd', N'添加', N'', N'add()', N'layui-icon-add-1', N'layui-btn-normal', N'', N'1', N'92b00259-2d15-43e7-9321-adffb29e8bf2', NULL, NULL)
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'44075557-496e-4dde-bb75-7b69f51ab4fe', N'btnEdit', N'编辑', N'', N'edit()', N'layui-icon-edit', N'layui-btn-normal', N'编辑模块', N'2', N'bc80478d-0547-4437-9cff-be4b40144bdf', NULL, NULL)
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'4bfa8ea0-6b0d-426f-8687-b654575ca780', N'btnEdit', N'编辑', N'', N'edit()', N'layui-icon-edit', N'layui-btn-normal', N'编辑资源', N'2', N'e8dc5db6-4fc4-4795-a1cc-681cbcceec91', NULL, NULL)
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'4f2737db-633f-4946-8a71-b08b9885f151', N'btnEdit', N'编辑', N'', N'edit()', N'layui-icon-edit', N'layui-btn-normal', N'', N'2', N'92b00259-2d15-43e7-9321-adffb29e8bf2', NULL, NULL)
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'50c9df24-b233-42cb-9a0d-4ce158c75f86', N'btnAdd', N'添加', N'', N'add()', N'layui-icon-add-1', N'layui-btn-normal', N'添加用戶', N'0', N'ef386d5d-cd58-43c0-a4ab-80afd0dbcd6c', NULL, NULL)
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'584c7a3b-d28a-47b4-8648-7797d05d83d1', N'btnDel', N'删除', N'', N'del()', N'layui-icon-delete', N'layui-btn-danger', N'', N'3', N'9486ff22-b696-4d7f-8093-8a3e53c45453', NULL, NULL)
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'5ed1681c-13d2-4c87-8675-a8d95c0b40ae', N'btnAddMenu', N'添加菜单', N'', N'assignButton()', N'layui-icon-add-1', N'layui-btn-normal', N'为模块分配按钮', N'4', N'bc80478d-0547-4437-9cff-be4b40144bdf', NULL, NULL)
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'5ed1681c-13d2-4c87-8676-a8d95c0b40ae', N'btnEditMenu', N'编辑菜单', N'', N'', N'layui-icon-add-1', N'layui-btn-normal', N'编辑菜单', N'5', N'bc80478d-0547-4437-9cff-be4b40144bdf', NULL, NULL)
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'5ed1681c-13d2-4c87-8677-a8d95c0b40ae', N'btnDelMenu', N'删除菜单', N'', N'', N'layui-icon-delete', N'layui-btn-danger', N'', N'6', N'bc80478d-0547-4437-9cff-be4b40144bdf', N'', N'')
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'645b40ac-4223-44a7-aab4-66eb56cf9864', N'btnAdd', N'添加', N'', N'add()', N'layui-icon-add-1', N'layui-btn-normal', N'添加角色', N'0', N'bedb41a2-f310-4775-af99-01be08adda93', NULL, NULL)
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'68484265-7802-4f06-b024-33e8b2f2edcf', N'btnAdd', N'新的申请', N'', N'add()', N'layui-icon-add-1', N'layui-btn-normal', N'申请物品', N'0', N'9486ff22-b696-4d7f-8093-8a3e53c45453', NULL, NULL)
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'68fc793f-069f-43e1-a012-42ac2d7c585c', N'btnDel', N'删除', N'', N'del()', N'layui-icon-delete', N'layui-btn-danger', N'删除角色', N'2', N'bedb41a2-f310-4775-af99-01be08adda93', NULL, NULL)
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'6c814946-db5c-48bd-84dd-b1c38196ad74', N'btnAdd', N'添加模版', N'', N'', N'layui-icon-add-1', N'layui-btn-normal', N'', N'0', N'0031262c-689c-4b96-bae2-2c9d67076ade', N'', N'')
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'6db928fe-93df-460f-9472-8bb0b6cae52c', N'btnAdd', N'添加', N'', N'add()', N'layui-icon-add-1', N'layui-btn-normal', N'添加进出库', N'0', N'89c3bfbe-246f-4112-8eb1-b6789da54202', NULL, NULL)
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'79dcd3eb-3aaf-4e08-83c9-713d8ff446fe', N'btnVerification', N'处理', N'', N'', N'layui-icon-triangle-r', N'layui-btn-normal', N'', N'5', N'4abafc83-c8f5-452f-9882-e113a86e7a3e', N'', N'')
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'7b2b1ffb-398b-4f7b-83da-8f484e1bcea0', N'btnDel', N'删除', N'', N'', N'layui-icon-delete', N'layui-btn-danger', N'', N'2', N'6a9e1346-0c01-44d2-8eb1-f929fdab542a', N'', N'')
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'7f071c63-1620-4486-9264-5806b2e63218', N'btnAccessRole', N'为用户分配角色', N'', N'openUserRoleAccess(this)', N'layui-icon-search', N'layui-btn-normal', N'为用户分配角色', N'5', N'ef386d5d-cd58-43c0-a4ab-80afd0dbcd6c', NULL, NULL)
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'816b12b3-e916-446d-a2fa-329cfd13c831', N'btnDetail', N'进度详情', N'', N'', N'layui-icon-search', N'layui-btn-normal', N'', N'4', N'9486ff22-b696-4d7f-8093-8a3e53c45453', NULL, NULL)
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'826b12b3-e916-446d-a2fa-329cfd13c831', N'btnDetail', N'进度详情', N'', N'', N'layui-icon-search', N'layui-btn-normal', N'', N'4', N'4abafc83-c8f5-452f-9882-e113a86e7a3e', N'', N'')
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'84694ea5-d6e1-4a65-8a59-7b5b779688d4', N'btnAdd', N'添加', N'', N'add()', N'layui-icon-add-1', N'layui-btn-normal', N'添加模块', N'1', N'bc80478d-0547-4437-9cff-be4b40144bdf', NULL, NULL)
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'84e38920-f6e5-499c-bf52-a3c6f8499ff7', N'btnDelStock', N'删除', N' ', N'del()', N'layui-icon-delete', N'layui-btn-danger', N'删除分类', N'0', N'a94d5648-c2a9-405e-ba6f-f1602ec9b807', NULL, NULL)
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'8966b04f-8e26-4046-8b03-0c64f9f833dd', N'btnDel', N'删除', N'', N'del()', N'layui-icon-delete', N'layui-btn-danger', N'', N'3', N'92b00259-2d15-43e7-9321-adffb29e8bf2', NULL, NULL)
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'9c96e485-84a6-45f0-b6a7-f01dab94b0c6', N'btnPreview', N'预览', N'', N'preview()', N'layui-icon-search', N'layui-btn-normal', N'', N'4', N'92b00259-2d15-43e7-9321-adffb29e8bf2', NULL, NULL)
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'9e2c6754-f258-4b14-96a0-b9d981196a65', N'btnAdd', N'添加', N'', N'add()', N'layui-icon-add-1', N'layui-btn-normal', N'添加资源', N'0', N'e8dc5db6-4fc4-4795-a1cc-681cbcceec91', NULL, NULL)
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'b3e23ebc-0ff2-41b3-bff0-fd5e93f6828a', N'btnDetail', N'查看详情', N'', N'', N'layui-icon-search', N'layui-btn-normal', N'', N'0', N'37bb9414-19a0-4223-9056-71f8c758a930', N'', N'')
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'c3d7b478-21e9-4c1e-b866-a3c80be7909b', N'btnRefresh', N'刷新', N'', N'refresh()', N'layui-icon-refresh', N'layui-btn-normal', N'刷新分类', N'0', N'a94d5648-c2a9-405e-ba6f-f1602ec9b807', NULL, NULL)
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'c4c1acbb-9cbf-4b1e-9cc0-ccf5ff544ec2', N'btnDel', N'删除', N'', N'del()', N'layui-icon-delete', N'layui-btn-danger', N'删除进出库', N'0', N'89c3bfbe-246f-4112-8eb1-b6789da54202', NULL, NULL)
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'c7d7daf0-3669-4a22-8bed-b092617deb9c', N'btnDel', N'删除', N'', N'del()', N'layui-icon-delete', N'layui-btn-danger', N'删除资源', N'3', N'e8dc5db6-4fc4-4795-a1cc-681cbcceec91', NULL, NULL)
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'd1ba6a72-ba14-44c0-baba-46d0ad96fe8a', N'btnRefresh', N'刷新', N'', N'refresh()', N'layui-icon-refresh', N'layui-btn-normal', N'刷新用户', N'3', N'ef386d5d-cd58-43c0-a4ab-80afd0dbcd6c', NULL, NULL)
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'd352c8ee-3dff-4d28-a0de-903ae68f2533', N'btnPreview', N'预览', N'', N'', N'layui-icon-cellphone', N'layui-btn-normal', N'', N'1', N'0031262c-689c-4b96-bae2-2c9d67076ade', N'', N'')
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'daddf3b9-71b5-45ac-b85d-5a11c522f2f4', N'btnDel', N'删除', N' ', N'del()', N'layui-icon-delete', N'layui-btn-danger', N'删除模块', N'3', N'bc80478d-0547-4437-9cff-be4b40144bdf', NULL, NULL)
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'ef42721f-d223-4a00-a1d9-80b81121f21a', N'btnEdit', N'编辑', N'', N'', N'layui-icon-edit', N'layui-btn-normal', N'', N'0', N'6a9e1346-0c01-44d2-8eb1-f929fdab542a', N'', N'')
GO

INSERT INTO [dbo].[ModuleElement]  VALUES (N'f8dde22a-2a37-47c4-8e67-70fb3af5303e', N'btnRefresh', N'刷新', N'', N'', N'layui-icon-refresh', N'layui-btn-normal', N'', N'0', N'6a9e1346-0c01-44d2-8eb1-f929fdab542a', N'', N'')
GO



-- ----------------------------
-- Records of [Org]
-- ----------------------------
INSERT INTO [dbo].[Org]  VALUES (N'08f41bf6-4388-4b1e-bd3e-2ff538b44b1b', N'.0.1.3.1.', N'研发小组', N'', N'研发部', N'0', N'0', N'', N'0', N'0', N'', N'2016-10-14 11:40:31.000', N'0', N'1', N'990cb229-cc18-41f3-8e2b-13f0f0110798', NULL, NULL)
GO

INSERT INTO [dbo].[Org]  VALUES (N'543a9fcf-4770-4fd9-865f-030e562be238', N'.0.1.', N'集团总部', N'', N'根节点', N'0', N'0', N'', N'0', N'0', N'', N'2016-10-14 11:37:13.000', N'0', N'0', NULL, NULL, NULL)
GO

INSERT INTO [dbo].[Org]  VALUES (N'86449128-d5ac-44bf-b999-f7735b7458fd', N'.0.2.1.', N'汇丰软件部', N'', N'汇丰', N'0', N'0', N'', N'0', N'0', N'', N'2016-05-26 15:11:03.000', N'0', N'1', N'c36e43df-3a99-45da-80d9-3ac5d24f4014', NULL, NULL)
GO

INSERT INTO [dbo].[Org]  VALUES (N'990cb229-cc18-41f3-8e2b-13f0f0110798', N'.0.1.3.', N'研发部', N'', N'集团总部', N'0', N'1', N'', N'0', N'0', N'', N'2016-04-16 13:03:41.000', N'0', N'0', N'543a9fcf-4770-4fd9-865f-030e562be238', NULL, NULL)
GO

INSERT INTO [dbo].[Org]  VALUES (N'c36e43df-3a99-45da-80d9-3ac5d24f4014', N'.0.2.', N'汇丰', N'', N'根节点', N'0', N'0', N'', N'0', N'0', N'', N'2016-05-26 15:10:40.000', N'0', N'1', NULL, NULL, NULL)
GO



-- ----------------------------
-- Records of [Relevance]
-- ----------------------------
INSERT INTO [dbo].[Relevance]  VALUES (N'01b2717d-4a14-4a86-9e37-1950e1a2eb5e', N'', N'RoleModule', N'0', N'2019-07-28 21:32:55.347', N'', N'0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', N'7580672f-a390-4bb6-982d-9a4570cb5199', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'0353f625-2322-4449-81e1-db0ace4d67c8', N'', N'UserOrg', N'0', N'2018-09-12 00:10:47.000', N'', N'1df68dfd-3b6d-4491-872f-00a0fc6c5a64', N'86449128-d5ac-44bf-b999-f7735b7458fd', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'03b55a9e-a44f-44fa-9383-4117bf8aba60', N'', N'RoleResource', N'0', N'2018-09-12 00:15:54.000', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'XXX_DELETEACCOUNT', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'03be9b5e-38b0-4525-8431-b26d35ce6ce3', N'', N'UserElement', N'0', N'2016-09-07 15:30:43.000', N'0', N'3a95e392-07d4-4af3-b30d-140ca93340f5', N'816b12b3-e916-446d-a2fa-329cfd13c831', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'06dfd97d-17e0-42b8-bde7-40006d8c8eb2', N'', N'UserElement', N'0', N'2018-04-06 14:50:37.000', N'', N'49df1602-f5f3-4d52-afb7-3802da619558', N'584c7a3b-d28a-47b4-8648-7797d05d83d1', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'06f4c4a2-faa8-4bad-9184-50ceb517f30b', N'', N'ProcessUser', N'0', N'2016-09-08 16:48:14.000', N'0', N'10cc09fb-d469-41e5-ae3f-fdd805a4bd4c', N'3b64b643-cb9a-4654-81e4-6dd9b2f8a6f7', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'077e24ab-4c48-4a5e-bfa9-90ea00449136', N'', N'RoleOrg', N'0', N'2018-09-12 00:08:47.000', N'', N'3e761e88-ddf7-4a62-b219-9a315b4564f2', N'86449128-d5ac-44bf-b999-f7735b7458fd', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'08ff97f7-17fc-4072-b29a-287135898ece', N'', N'RoleResource', N'0', N'2016-09-04 23:20:22.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'fdf3aac3-4507-40ad-aa2f-d7f0459de252', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'0a9bcd14-0e27-474a-8c0e-0d023d6013eb', N'', N'RoleDataProperty', N'0', N'2019-01-08 02:23:02.000', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'Resource', N'Description', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'0b3d3a9b-8a96-43d4-918c-fa7e3ea5f5ca', N'', N'RoleOrg', N'0', N'2018-09-12 00:08:37.000', N'', N'0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', N'990cb229-cc18-41f3-8e2b-13f0f0110798', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'0b729611-c225-4fb6-8584-404a58373ff0', N'', N'UserOrg', N'0', N'2018-09-12 00:10:31.000', N'', N'49df1602-f5f3-4d52-afb7-3802da619558', N'08f41bf6-4388-4b1e-bd3e-2ff538b44b1b', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'0fd5b371-b010-4846-8833-95cc1e813a32', N'', N'UserElement', N'0', N'2016-09-07 15:31:16.000', N'0', N'ea25646b-964b-4d41-ab03-d8964e1494fb', N'68484265-7802-4f06-b024-33e8b2f2edcf', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'10a76196-ba0c-4294-bb8f-dcd063eb4aab', N'', N'UserOrg', N'0', N'2017-10-12 09:13:38.000', N'', N'3eacdedd-e93a-4816-b49c-99ba3d5323c2', N'990cb229-cc18-41f3-8e2b-13f0f0110798', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'10e58d75-dec1-4b85-882f-9dac79ad1210', N'', N'RoleResource', N'0', N'2016-10-21 18:08:13.000', N'0', N'4980a85b-e3db-4607-bc2c-0baf0140d7df', N'ec99f670-0eca-465c-9f64-d4d5dc510b83', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'1196cfff-9a57-4ef2-a3ee-abd438871264', N'', N'RoleDataProperty', N'0', N'2019-01-08 02:23:02.000', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'Resource', N'AppId', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'119e4152-4883-40e7-bcfa-fad6ccefc223', N'', N'RoleElement', N'0', N'2019-07-28 21:32:55.357', N'', N'0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', N'68484265-7802-4f06-b024-33e8b2f2edcf', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'120d7a5d-203c-4261-95f5-0125757fb386', N'', N'UserElement', N'0', N'2016-10-20 17:01:01.000', N'0', N'3a95e392-07d4-4af3-b30d-140ca93340f5', N'7f071c63-1620-4486-9264-5806b2e63218', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'12aba9d7-3eeb-43e0-acb0-1ee62b6f2b96', N'', N'RoleDataProperty', N'0', N'2019-07-28 21:33:04.617', N'', N'0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', N'Category', N'Disabled', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'13433400-a32c-4539-b988-8b417c09bc0e', N'', N'UserModule', N'0', N'2016-09-07 15:30:07.000', N'0', N'3b64b643-cb9a-4654-81e4-6dd9b2f8a6f7', N'9486ff22-b696-4d7f-8093-8a3e53c45453', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'13612a4c-b20c-4bd0-a2cd-0ae47576364d', N'', N'UserElement', N'0', N'2016-10-20 16:34:12.000', N'0', N'3a95e392-07d4-4af3-b30d-140ca93340f5', N'c7d7daf0-3669-4a22-8bed-b092617deb9c', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'13f1fd43-b36f-4cd9-9870-952645e0c23a', N'', N'RoleElement', N'0', N'2019-01-08 02:22:32.000', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'c7d7daf0-3669-4a22-8bed-b092617deb9c', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'1490edd4-9bd3-4e71-bfa4-56f6558c1d3f', N'', N'UserElement', N'0', N'2018-04-06 09:48:24.000', N'', N'6ba79766-faa0-4259-8139-a4a6d35784e0', N'79dcd3eb-3aaf-4e08-83c9-713d8ff446fe', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'16154fc4-d18e-44a3-bcf2-5539b168aba7', N'', N'RoleElement', N'0', N'2016-10-24 17:25:15.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'18cc3217-28a6-49b2-9a20-080230065984', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'1740ff26-a4d0-44cc-9fab-a0105c2c60b6', N'', N'UserOrg', N'0', N'2017-10-12 13:59:49.000', N'', N'63c9c82a-e0d3-4bde-bbd2-057cda2f5283', N'08f41bf6-4388-4b1e-bd3e-2ff538b44b1b', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'1873ed85-a88a-4236-bd40-2c416aa2576c', N'', N'RoleModule', N'0', N'2016-09-02 17:03:39.000', N'0', N'211e12c7-e466-496e-8d26-0660a38e24cc', N'7580672f-a390-4bb6-982d-9a4570cb5199', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'19c9621c-3d23-46b7-a841-54d5c82ec8e8', N'', N'UserOrg', N'0', N'2016-09-02 13:56:53.000', N'0', N'3b64b643-cb9a-4654-81e4-6dd9b2f8a6f7', N'990cb229-cc18-41f3-8e2b-13f0f0110798', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'19eec5f3-ed32-4377-b616-92190fdc026a', N'', N'RoleElement', N'0', N'2019-07-28 21:32:55.357', N'', N'0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', N'1a473afd-cbd4-41e9-9471-81f9435aaabe', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'1acec4c4-0136-4e2b-a839-8676dbd6594a', N'', N'ProcessUser', N'0', N'2016-09-14 11:38:23.000', N'0', N'6c6afe3c-349c-4198-8710-cf19c90f3afd', N'3b64b643-cb9a-4654-81e4-6dd9b2f8a6f7', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'1b52e0cb-2df1-41e2-90ab-fc051be1d983', N'', N'RoleModule', N'0', N'2019-01-08 02:22:31.000', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'069475e3-c997-487a-9f29-e6a864c5c1d4', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'1ced1564-2fea-4c04-8aea-f071fa5bb293', N'', N'UserModule', N'0', N'2016-09-05 16:24:55.000', N'0', N'ea25646b-964b-4d41-ab03-d8964e1494fb', N'069475e3-c997-487a-9f29-e6a864c5c1d4', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'1cf19b35-e2c2-436f-99b9-03ac2b232cc6', N'', N'RoleElement', N'0', N'2016-09-04 23:21:04.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'44075557-496e-4dde-bb75-7b69f51ab4fe', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'2014027e-0cff-41cf-974b-56126d6eaa9a', N'', N'RoleElement', N'0', N'2016-09-05 09:22:11.000', N'0', N'4980a85b-e3db-4607-bc2c-0baf0140d7df', N'c4c1acbb-9cbf-4b1e-9cc0-ccf5ff544ec2', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'20f03189-18c8-4d2d-b924-85375f4b6c26', N'', N'RoleDataProperty', N'0', N'2019-01-08 02:23:02.000', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'Category', N'Description', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'22ccf653-9972-4611-ba0e-384c28c51f0f', N'', N'RoleElement', N'0', N'2019-01-08 02:22:32.000', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'c3d7b478-21e9-4c1e-b866-a3c80be7909b', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'242e9543-3343-41d4-8816-15ffeeaef551', N'', N'UserElement', N'0', N'2016-09-07 15:31:16.000', N'0', N'ea25646b-964b-4d41-ab03-d8964e1494fb', N'584c7a3b-d28a-47b4-8648-7797d05d83d1', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'27c4d50c-32da-4dbc-88a1-84b343cdd649', N'', N'UserElement', N'0', N'2016-10-20 17:01:00.000', N'0', N'3a95e392-07d4-4af3-b30d-140ca93340f5', N'6839a297-350b-4215-b680-4e5dfdae5615', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'29b06cd6-af0c-4c63-9aba-e5431c5d62ec', N'', N'UserOrg', N'0', N'2017-10-12 09:13:38.000', N'', N'3eacdedd-e93a-4816-b49c-99ba3d5323c2', N'08f41bf6-4388-4b1e-bd3e-2ff538b44b1b', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'2a1b833c-dc81-46e2-b308-e22e0f112f77', N'', N'RoleElement', N'0', N'2019-01-08 02:22:32.000', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'2d595a2a-5de5-479e-a331-b53c799a6b10', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'2a36a2b7-41aa-4190-b88c-75d44a56ad6e', N'', N'UserModule', N'0', N'2017-02-06 00:14:18.000', N'0', N'3a95e392-07d4-4af3-b30d-140ca93340f5', N'92b00259-2d15-43e7-9321-adffb29e8bf2', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'2ab3e3b4-cdcc-4f8b-86f1-aa9c2d51d1dd', N'', N'UserOrg', N'0', N'2018-09-12 00:10:43.000', N'', N'229f3a49-ab27-49ce-b383-9f10ca23a9d5', N'86449128-d5ac-44bf-b999-f7735b7458fd', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'2bb3fddb-0f51-442e-8dbf-236beb47d8a6', N'', N'RoleOrg', N'0', N'2018-04-14 13:16:45.000', N'', N'77e6d0c3-f9e1-4933-92c3-c1c6eef75593', N'08f41bf6-4388-4b1e-bd3e-2ff538b44b1b', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'2ca288a6-d222-4328-951e-c01c3e77a0c7', N'', N'RoleElement', N'0', N'2016-09-04 23:21:00.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'7f071c63-1620-4486-9264-5806b2e63218', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'2d0fcc88-a7c0-4d33-8a08-1d688e9dde83', N'', N'RoleModule', N'0', N'2016-09-02 17:03:39.000', N'0', N'211e12c7-e466-496e-8d26-0660a38e24cc', N'a94d5648-c2a9-405e-ba6f-f1602ec9b807', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'2d15e438-cc3a-41e9-9b13-325bfd5c804a', N'', N'RoleElement', N'0', N'2016-09-04 23:21:09.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'84e38920-f6e5-499c-bf52-a3c6f8499ff7', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'2ebff9a4-b2d5-4a35-a7dd-2cfa2f5b0522', N'', N'ProcessUser', N'0', N'2016-09-07 17:33:39.000', N'0', N'52cc7933-a045-4dcc-8c17-1b618bfa772b', N'3b64b643-cb9a-4654-81e4-6dd9b2f8a6f7', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'30c82d18-7892-4e5f-9aee-e4f483a858c2', N'', N'UserModule', N'0', N'2016-09-05 16:24:55.000', N'0', N'ea25646b-964b-4d41-ab03-d8964e1494fb', N'9486ff22-b696-4d7f-8093-8a3e53c45453', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'332a373c-f485-4f85-9af9-7792f7462bf1', N'', N'RoleModule', N'0', N'2016-09-02 17:03:47.000', N'0', N'648b04c4-4ac2-4d69-bef6-07081ef27871', N'89c3bfbe-246f-4112-8eb1-b6789da54202', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'340c60fe-8b95-474c-aa04-9197903998d2', N'', N'RoleModule', N'0', N'2016-09-04 23:20:34.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'7580672f-a390-4bb6-982d-9a4570cb5199', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'361feb63-bde2-49c7-86ec-6df3ec6f0fe3', N'', N'RoleElement', N'0', N'2016-09-04 23:21:13.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'1c870438-4260-43a5-8996-a6e1dc8bbf6a', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'37c220ed-3b7a-4cad-a001-b706ad4aa2ce', N'', N'RoleElement', N'0', N'2019-07-28 21:32:55.357', N'', N'0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', N'84e38920-f6e5-499c-bf52-a3c6f8499ff7', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'386d6cb7-c465-422c-974f-3250b0e4888f', N'', N'UserOrg', N'0', N'2018-09-12 00:10:35.000', N'', N'6ba79766-faa0-4259-8139-a4a6d35784e0', N'08f41bf6-4388-4b1e-bd3e-2ff538b44b1b', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'392dc41e-7186-4efb-a8e5-b5317e4122fb', N'', N'RoleResource', N'0', N'2018-09-10 12:54:14.000', N'', N'0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', N'OPENAUTH_DELETEACCOUNT', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'3b687a79-da14-4ba9-9a62-6abfd1c86c9e', N'', N'RoleModule', N'0', N'2019-07-28 21:32:55.347', N'', N'0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', N'4abafc83-c8f5-452f-9882-e113a86e7a3e', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'3bcaab20-e096-480e-a9bb-0fdb70686714', N'', N'RoleElement', N'0', N'2016-09-04 23:21:00.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'cf7388be-2677-427c-ad78-8f00f1062b96', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'3de0359b-6331-4dc7-a00e-751f71dbadb5', N'', N'ProcessUser', N'0', N'2016-09-28 09:23:30.000', N'0', N'68295d2a-4dfd-4c5e-81e3-9c787e2603bc', N'3b64b643-cb9a-4654-81e4-6dd9b2f8a6f7', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'4190f00a-11a0-4814-849b-cc5232fa4dd4', N'', N'RoleResource', N'0', N'2018-09-12 00:15:54.000', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'OPENAUTH_DELETEACCOUNT', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'45fcbc8b-2951-40a1-8329-4bdf3c8f70e4', N'', N'UserOrg', N'0', N'2018-09-12 00:10:35.000', N'', N'6ba79766-faa0-4259-8139-a4a6d35784e0', N'990cb229-cc18-41f3-8e2b-13f0f0110798', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'460d1c98-2a68-43cf-8d38-d40ceb89916f', N'', N'UserOrg', N'0', N'2017-10-12 09:13:38.000', N'', N'3eacdedd-e93a-4816-b49c-99ba3d5323c2', N'86449128-d5ac-44bf-b999-f7735b7458fd', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'4757bb30-e4bc-4c2d-a824-947ef151d341', N'', N'UserRole', N'0', N'2016-09-07 20:21:16.000', N'0', N'3b64b643-cb9a-4654-81e4-6dd9b2f8a6f7', N'4980a85b-e3db-4607-bc2c-0baf0140d7df', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'4ba3982b-f0ae-4f9a-980e-1eaedc3b5f2e', N'', N'UserElement', N'0', N'2016-09-07 17:48:34.000', N'0', N'3b64b643-cb9a-4654-81e4-6dd9b2f8a6f7', N'584c7a3b-d28a-47b4-8648-7797d05d83d1', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'4c2fb006-53d6-4041-8cf6-e5d74d788897', N'', N'UserModule', N'0', N'2018-04-06 09:48:19.000', N'', N'6ba79766-faa0-4259-8139-a4a6d35784e0', N'9486ff22-b696-4d7f-8093-8a3e53c45453', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'4c69794b-9957-4f6b-b0fb-6455fe643565', N'', N'UserElement', N'0', N'2018-04-06 14:50:41.000', N'', N'49df1602-f5f3-4d52-afb7-3802da619558', N'826b12b3-e916-446d-a2fa-329cfd13c831', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'4daccce5-cb7b-46aa-8bed-3c85c72436be', N'', N'RoleOrg', N'0', N'2018-09-12 00:08:37.000', N'', N'0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', N'08f41bf6-4388-4b1e-bd3e-2ff538b44b1b', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'4e613188-0387-4d17-a60d-703b4a606d75', N'', N'RoleModule', N'0', N'2016-09-04 23:20:34.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'bc80478d-0547-4437-9cff-be4b40144bdf', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'4e665304-9f05-410e-b68f-44d45281b788', N'', N'RoleOrg', N'0', N'2018-09-12 00:08:47.000', N'', N'3e761e88-ddf7-4a62-b219-9a315b4564f2', N'c36e43df-3a99-45da-80d9-3ac5d24f4014', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'4e6c69a6-eeba-45d9-923d-16a7c002ac3e', N'', N'RoleModule', N'0', N'2019-01-08 02:22:31.000', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'7580672f-a390-4bb6-982d-9a4570cb5199', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'4ec39ee9-9ee9-4aa9-a0db-eb0fdf8d2f00', N'', N'UserElement', N'0', N'2018-04-06 09:48:27.000', N'', N'6ba79766-faa0-4259-8139-a4a6d35784e0', N'b3e23ebc-0ff2-41b3-bff0-fd5e93f6828a', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'4ee89c07-55e2-4ca6-9ef1-449cfe0a2c3c', N'', N'RoleResource', N'0', N'2018-09-12 00:15:54.000', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'OPENAUTH_LOGIN', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'4fde1dc6-9d73-4c7c-9238-28981858c5a6', N'', N'RoleModule', N'0', N'2016-09-05 09:21:56.000', N'0', N'4980a85b-e3db-4607-bc2c-0baf0140d7df', N'89c3bfbe-246f-4112-8eb1-b6789da54202', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'5167dbcd-3a32-4ae8-827e-6f381cc58fa2', N'', N'RoleElement', N'0', N'2016-09-04 23:21:00.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'fa816af1-a28d-47b5-9b8b-c46e18f902e9', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'53a4be87-4fa8-415b-97b5-2298ce8b17c8', N'', N'UserResource', N'0', N'2018-04-14 14:38:04.000', N'', N'49df1602-f5f3-4d52-afb7-3802da619558', N'XXX_LOGIN', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'54b2e9b6-1f7c-4a39-92c9-98f58429c1fc', N'', N'RoleModule', N'0', N'2016-09-02 17:03:39.000', N'0', N'211e12c7-e466-496e-8d26-0660a38e24cc', N'bc80478d-0547-4437-9cff-be4b40144bdf', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'54d8d1b8-2b5b-498d-9c0d-33e8bad86572', N'', N'RoleElement', N'0', N'2019-01-08 02:22:32.000', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'826b12b3-e916-446d-a2fa-329cfd13c831', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'55b10ecc-3fb3-4127-b69e-e7a3467d7a1a', N'', N'RoleElement', N'0', N'2016-09-05 09:22:11.000', N'0', N'4980a85b-e3db-4607-bc2c-0baf0140d7df', N'6db928fe-93df-460f-9472-8bb0b6cae52c', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'5725ff79-43c6-4778-bbff-131cf364dab6', N'', N'UserElement', N'0', N'2016-10-20 17:01:01.000', N'0', N'3a95e392-07d4-4af3-b30d-140ca93340f5', N'cf7388be-2677-427c-ad78-8f00f1062b96', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'5998b564-03d5-4e65-a74d-6bd8e30aafe3', N'', N'RoleElement', N'0', N'2019-07-28 21:32:55.357', N'', N'0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', N'816b12b3-e916-446d-a2fa-329cfd13c831', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'5a20d59c-6ee6-4fe2-98fe-7b35b11026ae', N'', N'UserElement', N'0', N'2016-09-07 15:30:20.000', N'0', N'3b64b643-cb9a-4654-81e4-6dd9b2f8a6f7', N'68484265-7802-4f06-b024-33e8b2f2edcf', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'5a86259a-9555-4aa7-be8d-a874f88b66a8', N'', N'RoleModule', N'0', N'2019-01-08 02:22:31.000', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'9486ff22-b696-4d7f-8093-8a3e53c45453', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'5b0ec87e-3465-48c2-98da-e4c28a6f8f34', N'', N'RoleElement', N'0', N'2019-01-08 02:22:32.000', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'b3e23ebc-0ff2-41b3-bff0-fd5e93f6828a', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'5b2d5db8-d603-4be3-add2-c85ef3c53ddc', N'', N'UserResource', N'0', N'2018-04-14 14:38:05.000', N'', N'49df1602-f5f3-4d52-afb7-3802da619558', N'OPENAUTH_LOGIN', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'5ccce632-f8f0-452b-8faf-4a5372004e85', N'', N'RoleResource', N'0', N'2018-09-12 00:15:54.000', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'XXX_CHECKUSER', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'620b368a-7b56-4c74-ab85-8bc91d08ddc9', N'', N'RoleElement', N'0', N'2016-09-04 23:20:42.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'1c9acc3e-a40d-4d07-b495-6e60eb9b71b9', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'63a22a27-c8bd-4bdf-a3bb-6ffeae19484e', N'', N'RoleModule', N'0', N'2019-01-08 02:22:31.000', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'e8dc5db6-4fc4-4795-a1cc-681cbcceec91', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'6431a464-6f1f-4ffc-8157-89212b70f09a', N'', N'RoleOrg', N'0', N'2016-09-05 00:00:00.000', N'0', N'4980a85b-e3db-4607-bc2c-0baf0140d7df', N'08f41bf6-4388-4b1e-bd3e-2ff538b44b1b', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'648500cc-e1e6-426d-9f17-c6061ce606a1', N'', N'UserOrg', N'0', N'2017-12-11 16:19:06.000', N'', N'de8be521-f1ec-4483-b124-0be342890507', N'08f41bf6-4388-4b1e-bd3e-2ff538b44b1b', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'64879608-334c-48c7-bd80-a562d9619d95', N'', N'RoleDataProperty', N'0', N'2019-01-08 02:23:02.000', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'Category', N'Name', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'64e4f5aa-28ef-4690-9b20-5f0b543964f6', N'', N'UserElement', N'0', N'2016-09-07 15:30:20.000', N'0', N'3b64b643-cb9a-4654-81e4-6dd9b2f8a6f7', N'816b12b3-e916-446d-a2fa-329cfd13c831', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'655f4567-4a0d-42f8-8616-0ce6f3d4a107', N'', N'RoleDataProperty', N'0', N'2019-07-28 21:33:04.617', N'', N'0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', N'Category', N'Name', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'6645b6fb-efcf-4e48-9c13-84f79bc5be34', N'', N'RoleOrg', N'0', N'2018-04-14 13:16:45.000', N'', N'77e6d0c3-f9e1-4933-92c3-c1c6eef75593', N'86449128-d5ac-44bf-b999-f7735b7458fd', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'66e25fc5-093d-42ab-85dc-a38f6600889b', N'', N'UserOrg', N'0', N'2016-09-02 13:57:32.000', N'0', N'ea25646b-964b-4d41-ab03-d8964e1494fb', N'c36e43df-3a99-45da-80d9-3ac5d24f4014', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'68912e65-256e-45b6-b48e-036382598d32', N'', N'RoleOrg', N'0', N'2016-10-17 10:03:49.000', N'0', N'2eb423d6-6ad9-4efe-b423-872478a2a434', N'990cb229-cc18-41f3-8e2b-13f0f0110798', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'6b9c4789-042c-4f6f-a749-ee68ee87462d', N'', N'ProcessUser', N'0', N'2016-10-27 16:47:52.000', N'0', N'054ff054-d8ae-4911-a596-8fb1f66b348f', N'3a95e392-07d4-4af3-b30d-140ca93340f5', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'6da6d662-8cef-47cd-80b3-fa885b2dca7a', N'', N'RoleOrg', N'0', N'2018-04-14 13:16:45.000', N'', N'77e6d0c3-f9e1-4933-92c3-c1c6eef75593', N'990cb229-cc18-41f3-8e2b-13f0f0110798', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'6db5666b-6f8c-4e83-bada-0b45054bd9a4', N'', N'RoleElement', N'0', N'2016-09-04 23:20:42.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'0d25438e-1436-48e0-aedf-0f1690693282', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'6e94ac03-bfdf-4eb6-b097-5e9b3d540497', N'', N'RoleDataProperty', N'0', N'2019-07-28 21:33:04.617', N'', N'0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', N'Category', N'Description', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'6fe52499-f800-47ce-96fc-a2b5b43505d5', N'', N'UserElement', N'0', N'2018-04-06 09:48:22.000', N'', N'6ba79766-faa0-4259-8139-a4a6d35784e0', N'584c7a3b-d28a-47b4-8648-7797d05d83d1', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'715d017a-68b6-468d-aa3f-32ca4cfd4b9e', N'', N'RoleModule', N'0', N'2016-09-04 23:20:34.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'bedb41a2-f310-4775-af99-01be08adda93', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'72bf4729-af60-42f5-b0d7-717362ffad7f', N'', N'RoleElement', N'0', N'2016-09-04 23:21:00.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'2feefce1-e3d8-42ac-b811-2352679628da', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'72d150c7-60a5-428e-8a7e-d484d2c97cd8', N'', N'RoleDataProperty', N'0', N'2019-01-08 02:23:02.000', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'Resource', N'Id', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'736e90f7-3747-472e-816d-dbb7fdf3b0bb', N'', N'RoleOrg', N'0', N'2018-09-12 00:08:42.000', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'08f41bf6-4388-4b1e-bd3e-2ff538b44b1b', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'7475b0c3-f204-4f95-a22f-80591fe76bc7', N'', N'ProcessUser', N'0', N'2016-10-31 11:52:39.000', N'0', N'b8bcdf59-1e29-4d97-a364-12ac8e8c5c61', N'3b64b643-cb9a-4654-81e4-6dd9b2f8a6f7', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'75340ad3-fb80-4646-b1de-ba801688ddc2', N'', N'RoleElement', N'0', N'2016-09-04 23:21:04.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'5ed1681c-13d2-4c87-8675-a8d95c0b40ae', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'77bd93da-2c2b-4ba8-bf05-3a1382811a6a', N'', N'RoleModule', N'0', N'2016-09-02 17:03:39.000', N'0', N'211e12c7-e466-496e-8d26-0660a38e24cc', N'e8dc5db6-4fc4-4795-a1cc-681cbcceec91', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'77eec82a-f713-4584-872c-761fdbcdb456', N'', N'UserElement', N'0', N'2018-04-06 14:50:37.000', N'', N'49df1602-f5f3-4d52-afb7-3802da619558', N'68484265-7802-4f06-b024-33e8b2f2edcf', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'77fc08e6-98ae-4d33-b294-bd9fed5b14ed', N'', N'UserElement', N'0', N'2018-04-06 14:50:36.000', N'', N'49df1602-f5f3-4d52-afb7-3802da619558', N'816b12b3-e916-446d-a2fa-329cfd13c831', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'797c6e5f-7f3c-4891-89b9-a054e10f6c00', N'', N'UserModule', N'0', N'2018-04-06 09:48:01.000', N'', N'49df1602-f5f3-4d52-afb7-3802da619558', N'37bb9414-19a0-4223-9056-71f8c758a930', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'7f25286f-246b-4143-98eb-c3e574fe7455', N'', N'ProcessUser', N'0', N'2016-09-07 17:33:39.000', N'0', N'52cc7933-a045-4dcc-8c17-1b618bfa772b', N'3a95e392-07d4-4af3-b30d-140ca93340f5', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'7fd7f976-f10e-44aa-a7ba-7ca40d2e8f90', N'', N'RoleOrg', N'0', N'2016-10-17 10:03:30.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'08f41bf6-4388-4b1e-bd3e-2ff538b44b1b', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'80310629-5e52-482c-9a0f-5c5bdfabcd9e', N'', N'RoleOrg', N'0', N'2016-09-05 00:00:00.000', N'0', N'4980a85b-e3db-4607-bc2c-0baf0140d7df', N'990cb229-cc18-41f3-8e2b-13f0f0110798', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'81340d27-20c4-4602-828f-910564be08fa', N'', N'RoleElement', N'0', N'2019-07-28 21:32:55.357', N'', N'0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', N'79dcd3eb-3aaf-4e08-83c9-713d8ff446fe', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'832f4a8f-7791-4aa6-bcd2-20dcb6f5ef37', N'', N'UserElement', N'0', N'2016-09-02 14:53:04.000', N'0', N'3a95e392-07d4-4af3-b30d-140ca93340f5', N'15a4f88c-4fae-4cab-ba2f-0cbd2cca8736', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'835485ce-4c3b-41ff-8966-0adaea125f8d', N'', N'RoleModule', N'0', N'2019-07-28 21:32:55.347', N'', N'0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', N'a94d5648-c2a9-405e-ba6f-f1602ec9b807', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'84a52091-08a0-4a46-b661-3cd206771c29', N'', N'RoleModule', N'0', N'2016-09-04 23:20:34.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'0031262c-689c-4b96-bae2-2c9d67076ade', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'854e0658-ab8a-4869-b157-9941955acdc6', N'', N'RoleElement', N'0', N'2016-09-04 23:21:09.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'1a473afd-cbd4-41e9-9471-81f9435aaabe', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'85ab02d8-995f-4f66-9828-e53f04af09b9', N'', N'RoleModule', N'0', N'2019-01-08 02:22:31.000', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'a94d5648-c2a9-405e-ba6f-f1602ec9b807', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'88a4c966-d042-4a2e-b133-ff7eded1c5de', N'', N'RoleElement', N'0', N'2016-09-04 23:21:13.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'7b2b1ffb-398b-4f7b-83da-8f484e1bcea0', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'8b633f3c-965b-4e35-8496-c364890d7760', N'', N'RoleElement', N'0', N'2016-09-04 23:21:09.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'c3d7b478-21e9-4c1e-b866-a3c80be7909b', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'8fa4a52f-9c0a-43c9-9b7e-b378efb4e1df', N'', N'RoleResource', N'0', N'2018-09-10 12:54:14.000', N'', N'0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', N'OPENAUTH_LOGIN', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'9043a72d-862f-49b4-bfe3-51d9bd289f14', N'', N'RoleElement', N'0', N'2019-01-08 02:22:32.000', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'816b12b3-e916-446d-a2fa-329cfd13c831', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'9210adfa-b783-4368-8c8d-86c30ec9cdd1', N'', N'RoleModule', N'0', N'2019-01-08 02:22:31.000', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'37bb9414-19a0-4223-9056-71f8c758a930', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'92f0b297-96c1-47d4-84dd-571374431bc0', N'', N'RoleElement', N'0', N'2016-09-04 23:21:04.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'84694ea5-d6e1-4a65-8a59-7b5b779688d4', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'93bcac7a-0ff1-488c-8d1c-3da7e44cbefc', N'', N'RoleElement', N'0', N'2016-09-04 23:21:00.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'd1ba6a72-ba14-44c0-baba-46d0ad96fe8a', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'95cd06bd-7cad-4790-b5f8-15738360da95', N'', N'RoleModule', N'0', N'2019-01-08 02:22:31.000', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'4abafc83-c8f5-452f-9882-e113a86e7a3e', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'960224e6-5910-472b-a5ef-b2aa9a8b106f', N'', N'UserRole', N'0', N'2016-09-06 17:06:15.000', N'0', N'3b64b643-cb9a-4654-81e4-6dd9b2f8a6f7', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'962b278b-0894-4b36-b1a0-6c5c3d11d4c3', N'', N'UserElement', N'0', N'2018-04-06 14:50:17.000', N'', N'49df1602-f5f3-4d52-afb7-3802da619558', N'b3e23ebc-0ff2-41b3-bff0-fd5e93f6828a', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'965f010b-2fd6-4b34-ba23-3e44c1af2877', N'', N'RoleOrg', N'0', N'2016-09-08 16:19:18.000', N'0', N'36094f5d-07e7-40d5-91dc-ff60f98b496a', N'990cb229-cc18-41f3-8e2b-13f0f0110798', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'9ad706e3-8e6b-4bc7-a502-371b298ef062', N'', N'RoleElement', N'0', N'2016-09-04 23:21:13.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'ef42721f-d223-4a00-a1d9-80b81121f21a', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'9ba1fbf0-c101-4b2b-b3e2-f8a255dbdeea', N'', N'UserRole', N'0', N'2019-01-08 02:21:50.000', N'', N'49df1602-f5f3-4d52-afb7-3802da619558', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'9d568d6d-d78d-47d6-8fb6-b1327cdbe83a', N'', N'RoleModule', N'0', N'2016-09-04 23:20:34.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'a94d5648-c2a9-405e-ba6f-f1602ec9b807', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'9e46a946-6e81-4f61-bcba-21e4f7fac3df', N'', N'RoleModule', N'0', N'2016-09-02 17:03:39.000', N'0', N'211e12c7-e466-496e-8d26-0660a38e24cc', N'ef386d5d-cd58-43c0-a4ab-80afd0dbcd6c', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'9e540b53-6cf0-43b9-96df-73c3211b2544', N'', N'RoleElement', N'0', N'2019-07-28 21:32:55.357', N'', N'0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', N'2d595a2a-5de5-479e-a331-b53c799a6b10', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'9e57e1ff-e9cf-4600-a872-ac85f7845bb0', N'', N'RoleOrg', N'0', N'2018-04-14 13:16:45.000', N'', N'77e6d0c3-f9e1-4933-92c3-c1c6eef75593', N'c36e43df-3a99-45da-80d9-3ac5d24f4014', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'9ea4add6-9fdf-4046-8b6f-84f0a1cb2967', N'', N'RoleElement', N'0', N'2019-01-08 02:22:32.000', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'1a473afd-cbd4-41e9-9471-81f9435aaabe', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'9edc7b81-2b51-4193-8805-6062e596ccdc', N'', N'UserOrg', N'0', N'2016-09-02 13:57:32.000', N'0', N'ea25646b-964b-4d41-ab03-d8964e1494fb', N'08f41bf6-4388-4b1e-bd3e-2ff538b44b1b', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'9fa50449-5d87-4579-9f1f-9cdcd876976b', N'', N'RoleElement', N'0', N'2016-09-04 23:21:00.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'6839a297-350b-4215-b680-4e5dfdae5615', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'a051aa08-38da-4b6d-8d90-10b3c2485e4b', N'', N'RoleOrg', N'0', N'2016-09-05 00:00:00.000', N'0', N'4980a85b-e3db-4607-bc2c-0baf0140d7df', N'543a9fcf-4770-4fd9-865f-030e562be238', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'a06fe8c6-3f5e-4085-9bbf-e366571a356c', N'', N'RoleElement', N'0', N'2016-09-04 23:21:04.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'daddf3b9-71b5-45ac-b85d-5a11c522f2f4', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'a0904102-e26a-4bc5-9c95-ed5ef977586b', N'', N'RoleModule', N'0', N'2016-09-02 17:03:39.000', N'0', N'211e12c7-e466-496e-8d26-0660a38e24cc', N'6a9e1346-0c01-44d2-8eb1-f929fdab542a', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'a57900b2-caf1-4cbd-8ac2-f8dd9a40199d', N'', N'UserRole', N'0', N'2018-09-12 00:10:24.000', N'', N'6ba79766-faa0-4259-8139-a4a6d35784e0', N'0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'a5bef7bf-ecdb-4480-ad64-b39a02269607', N'', N'UserModule', N'0', N'2018-04-06 09:48:37.000', N'', N'49df1602-f5f3-4d52-afb7-3802da619558', N'069475e3-c997-487a-9f29-e6a864c5c1d4', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'a8094b46-de5a-40ea-a8ee-69ea905480ef', N'', N'RoleModule', N'0', N'2016-09-05 09:21:56.000', N'0', N'4980a85b-e3db-4607-bc2c-0baf0140d7df', N'069475e3-c997-487a-9f29-e6a864c5c1d4', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'a8123b37-ba70-4aab-aef6-1938733b5210', N'', N'RoleElement', N'0', N'2016-09-04 23:20:42.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'c0d8505c-061a-467d-862a-c94f27caa208', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'a9821db0-49bd-49be-a554-afa811c99760', N'', N'RoleResource', N'0', N'2016-09-04 23:20:22.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'ec99f670-0eca-465c-9f64-d4d5dc510b83', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'aa051096-a23a-431d-9053-bb954f9453a7', N'', N'RoleElement', N'0', N'2016-09-04 23:20:54.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'4bfa8ea0-6b0d-426f-8687-b654575ca780', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'ab190397-32a8-4b0f-bf34-2d648d6fe974', N'', N'RoleDataProperty', N'0', N'2019-01-08 02:23:02.000', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'Resource', N'Name', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'ab84b111-fb5d-4ddd-99d5-479954d9d521', N'', N'RoleOrg', N'0', N'2016-09-08 16:19:18.000', N'0', N'36094f5d-07e7-40d5-91dc-ff60f98b496a', N'08f41bf6-4388-4b1e-bd3e-2ff538b44b1b', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'ab924ba7-8a74-4804-82b0-ecbbedf4c13e', N'', N'RoleElement', N'0', N'2016-09-05 09:22:11.000', N'0', N'4980a85b-e3db-4607-bc2c-0baf0140d7df', N'38109ca0-32ec-44bd-a243-017e591b532b', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'ac184827-9899-4b40-8939-61fe9d2b187c', N'', N'UserElement', N'0', N'2016-09-07 17:48:49.000', N'0', N'3a95e392-07d4-4af3-b30d-140ca93340f5', N'584c7a3b-d28a-47b4-8648-7797d05d83d1', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'acb4d37f-8b45-4a99-b364-99f3881dfcda', N'', N'RoleElement', N'0', N'2016-09-04 23:21:13.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'f8dde22a-2a37-47c4-8e67-70fb3af5303e', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'acc51898-5335-4903-83b9-4701a782bc4d', N'', N'UserElement', N'0', N'2016-10-20 17:01:02.000', N'0', N'3a95e392-07d4-4af3-b30d-140ca93340f5', N'fa816af1-a28d-47b5-9b8b-c46e18f902e9', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'ad267296-5eba-4d59-b821-8148d8cfb3c6', N'', N'RoleModule', N'0', N'2016-09-04 23:20:34.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'e8dc5db6-4fc4-4795-a1cc-681cbcceec91', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'ad29467e-eeee-494c-ab82-f6be5d2619d5', N'', N'RoleElement', N'0', N'2016-09-04 23:21:00.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'50c9df24-b233-42cb-9a0d-4ce158c75f86', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'ad30e13e-6b75-48f9-97e3-c723d3e36a28', N'', N'RoleResource', N'0', N'2018-09-12 00:15:54.000', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'OPENAUTH_MODIFYACCOUNT', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'ad5bc7a6-e307-4fa8-a4ef-ce9e09f7e21b', N'', N'RoleModule', N'0', N'2016-09-05 09:21:56.000', N'0', N'4980a85b-e3db-4607-bc2c-0baf0140d7df', N'9486ff22-b696-4d7f-8093-8a3e53c45453', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'ad905aa6-d3d8-4fe9-99b4-5f8be7891d1e', N'', N'RoleResource', N'0', N'2018-09-12 00:15:54.000', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'XXX_ADMIN', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'ae619801-1959-44fd-a75b-a8cca4d559b4', N'', N'RoleOrg', N'0', N'2018-09-12 00:08:37.000', N'', N'0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', N'543a9fcf-4770-4fd9-865f-030e562be238', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'af263192-daa8-4f29-99b9-1efb96e31627', N'', N'RoleElement', N'0', N'2016-09-04 23:20:42.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'645b40ac-4223-44a7-aab4-66eb56cf9864', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'b0504da3-e071-411d-9ccb-24e92c088a88', N'', N'RoleModule', N'0', N'2019-07-28 21:32:55.347', N'', N'0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', N'069475e3-c997-487a-9f29-e6a864c5c1d4', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'b08d7763-a725-406f-a7d5-d144f00d716e', N'', N'UserOrg', N'0', N'2016-09-02 13:56:41.000', N'0', N'3a95e392-07d4-4af3-b30d-140ca93340f5', N'543a9fcf-4770-4fd9-865f-030e562be238', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'b241dd3d-2965-44e4-929d-9dacb6444e09', N'', N'RoleOrg', N'0', N'2018-04-14 13:16:45.000', N'', N'77e6d0c3-f9e1-4933-92c3-c1c6eef75593', N'543a9fcf-4770-4fd9-865f-030e562be238', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'b246cd89-548c-4471-a43b-6f10b40c26b1', N'', N'RoleOrg', N'0', N'2018-09-12 00:08:42.000', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'990cb229-cc18-41f3-8e2b-13f0f0110798', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'b2490ac0-ba16-48a2-b39d-49f6b87f9387', N'', N'UserModule', N'0', N'2018-04-06 09:48:17.000', N'', N'6ba79766-faa0-4259-8139-a4a6d35784e0', N'069475e3-c997-487a-9f29-e6a864c5c1d4', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'b2edfee4-f980-4aa5-b547-492d677e0674', N'', N'RoleModule', N'0', N'2016-09-04 23:20:34.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'ef386d5d-cd58-43c0-a4ab-80afd0dbcd6c', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'b30dc677-eb4f-463e-a50d-6e8098408e28', N'', N'RoleElement', N'0', N'2019-07-28 21:32:55.357', N'', N'0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', N'584c7a3b-d28a-47b4-8648-7797d05d83d1', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'b3b8f695-a179-489b-90b4-7814ab048a69', N'', N'UserElement', N'0', N'2018-04-06 09:48:21.000', N'', N'6ba79766-faa0-4259-8139-a4a6d35784e0', N'816b12b3-e916-446d-a2fa-329cfd13c831', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'b4c2a294-125c-4768-9214-cea3ccf39a1c', N'', N'RoleOrg', N'0', N'2018-09-12 00:08:42.000', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'543a9fcf-4770-4fd9-865f-030e562be238', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'b672a830-c3a5-408b-a746-65608534b24c', N'', N'UserModule', N'0', N'2017-12-15 17:07:05.000', N'', N'49df1602-f5f3-4d52-afb7-3802da619558', N'9486ff22-b696-4d7f-8093-8a3e53c45453', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'b8606463-4957-424f-bcab-1ea27c15c2c5', N'', N'RoleElement', N'0', N'2019-01-08 02:22:32.000', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'79dcd3eb-3aaf-4e08-83c9-713d8ff446fe', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'b9e63d17-35c8-4456-abab-8f43a1c99adc', N'', N'UserModule', N'0', N'2018-04-06 09:47:59.000', N'', N'49df1602-f5f3-4d52-afb7-3802da619558', N'4abafc83-c8f5-452f-9882-e113a86e7a3e', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'bbdc3ea9-3f21-48b0-9d7a-39545d6183d0', N'', N'UserElement', N'0', N'2018-04-06 09:48:25.000', N'', N'6ba79766-faa0-4259-8139-a4a6d35784e0', N'826b12b3-e916-446d-a2fa-329cfd13c831', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'bd069b36-a98d-4d36-a695-4cb0b3995375', N'', N'RoleDataProperty', N'0', N'2019-07-28 21:33:04.617', N'', N'0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', N'Category', N'SortNo', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'bd783f53-23fa-41f4-8cec-7c61fab52072', N'', N'UserOrg', N'0', N'2018-03-15 09:19:06.000', N'', N'0ceff0f8-f848-440c-bc26-d8605ac858cd', N'86449128-d5ac-44bf-b999-f7735b7458fd', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'bda5f089-64d6-4fb8-9012-d7f3ff36902a', N'', N'UserOrg', N'0', N'2017-10-12 13:59:09.000', N'', N'ffd92ed2-5330-4ec2-a42d-6e0e9005db3b', N'990cb229-cc18-41f3-8e2b-13f0f0110798', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'bed2842a-e9ff-4598-889f-2889033f8e67', N'', N'RoleElement', N'0', N'2019-01-08 02:22:32.000', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'4bfa8ea0-6b0d-426f-8687-b654575ca780', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'bee6572d-8fb8-4e0e-af15-93aafc989717', N'', N'RoleElement', N'0', N'2016-09-04 23:20:42.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'68fc793f-069f-43e1-a012-42ac2d7c585c', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'c14addeb-1812-4a78-9152-1f7115b22d89', N'', N'UserRole', N'0', N'2016-09-05 00:00:47.000', N'0', N'3a95e392-07d4-4af3-b30d-140ca93340f5', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'c2d3b7d6-b47d-4bd8-9dc6-d9134d86713f', N'', N'RoleOrg', N'0', N'2016-10-17 10:03:30.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'86449128-d5ac-44bf-b999-f7735b7458fd', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'c3050d65-d26b-4e46-bece-a212b0cc00ec', N'', N'RoleElement', N'0', N'2016-09-04 23:20:42.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'15a4f88c-4fae-4cab-ba2f-0cbd2cca8736', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'c4771ac5-3375-4de9-adb8-a603398f0d62', N'', N'RoleElement', N'0', N'2016-09-04 23:21:09.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'2d595a2a-5de5-479e-a331-b53c799a6b10', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'c4d4846f-e737-448a-a0c9-6545c759ed6b', N'', N'RoleElement', N'0', N'2019-07-28 21:32:55.357', N'', N'0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', N'826b12b3-e916-446d-a2fa-329cfd13c831', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'c50fae2a-b36f-486f-9d53-e58406590101', N'', N'ProcessUser', N'0', N'2016-10-27 16:47:52.000', N'0', N'054ff054-d8ae-4911-a596-8fb1f66b348f', N'3b64b643-cb9a-4654-81e4-6dd9b2f8a6f7', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'c58cb482-6ab7-49eb-b5b0-e45424b6e502', N'', N'RoleElement', N'0', N'2016-09-04 23:21:00.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'34730f5a-d307-457b-9041-5f7de30abfa9', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'c68dccbb-b7c5-4db1-b426-b58a19f42145', N'', N'RoleElement', N'0', N'2019-01-08 02:22:32.000', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'9e2c6754-f258-4b14-96a0-b9d981196a65', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'c733cfbe-2f71-41e4-92a6-4ff97cf88dc4', N'', N'UserModule', N'0', N'2018-04-06 09:48:19.000', N'', N'6ba79766-faa0-4259-8139-a4a6d35784e0', N'4abafc83-c8f5-452f-9882-e113a86e7a3e', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'c9099371-8d4e-4f5b-9686-2c60a2c1c641', N'', N'ProcessUser', N'0', N'2016-09-08 16:48:14.000', N'0', N'10cc09fb-d469-41e5-ae3f-fdd805a4bd4c', N'3a95e392-07d4-4af3-b30d-140ca93340f5', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'c98b3d02-a76b-4ecc-94a5-cfeffd5e29fb', N'', N'RoleModule', N'0', N'2016-09-02 17:03:39.000', N'0', N'211e12c7-e466-496e-8d26-0660a38e24cc', N'bedb41a2-f310-4775-af99-01be08adda93', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'd22b89f8-50d1-4816-9bb2-576ea49d9245', N'', N'RoleElement', N'0', N'2019-01-08 02:22:32.000', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'68484265-7802-4f06-b024-33e8b2f2edcf', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'd5c82edc-9410-4073-968d-f6ccbefa112f', N'', N'RoleElement', N'0', N'2019-07-28 21:32:55.357', N'', N'0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', N'c3d7b478-21e9-4c1e-b866-a3c80be7909b', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'da6c0645-0bf9-4ade-9dd3-1b09e91e504c', N'', N'RoleElement', N'0', N'2016-09-05 09:22:07.000', N'0', N'4980a85b-e3db-4607-bc2c-0baf0140d7df', N'816b12b3-e916-446d-a2fa-329cfd13c831', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'df2d90b3-4e2e-40e9-b406-220009726460', N'', N'RoleModule', N'0', N'2016-09-04 23:20:34.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'6a9e1346-0c01-44d2-8eb1-f929fdab542a', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'dfbcc1cb-4103-46ac-8f4f-ce8bb3402392', N'', N'RoleElement', N'0', N'2019-01-08 02:22:32.000', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'584c7a3b-d28a-47b4-8648-7797d05d83d1', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'dfd5430b-3422-465a-be79-05a1e06deed2', N'', N'RoleElement', N'0', N'2016-09-04 23:20:54.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'c7d7daf0-3669-4a22-8bed-b092617deb9c', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'e12b77de-b7ce-4f38-b7a3-f3b2d285f33b', N'', N'RoleOrg', N'0', N'2016-10-17 10:03:49.000', N'0', N'2eb423d6-6ad9-4efe-b423-872478a2a434', N'08f41bf6-4388-4b1e-bd3e-2ff538b44b1b', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'e28c0dcd-168a-4b60-a514-7b6eb8026709', N'', N'RoleOrg', N'0', N'2016-10-17 10:03:30.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'990cb229-cc18-41f3-8e2b-13f0f0110798', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'e32af2f6-f88c-4113-8b87-88ff27b1022e', N'', N'RoleDataProperty', N'0', N'2019-07-28 21:33:04.617', N'', N'0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', N'Category', N'Icon', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'e5689793-8dd7-4d07-bf2e-4977eba430f4', N'', N'RoleElement', N'0', N'2019-01-08 02:22:32.000', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'84e38920-f6e5-499c-bf52-a3c6f8499ff7', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'e619a82e-edfb-4542-94df-0b92850667ad', N'', N'RoleResource', N'0', N'2018-04-14 14:39:56.000', N'', N'0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', N'OPENAUTH_MODIFYACCOUNT', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'e785147c-f46b-474f-8fad-73b14fa69822', N'', N'UserRole', N'0', N'2016-09-06 17:06:29.000', N'0', N'3a95e392-07d4-4af3-b30d-140ca93340f5', N'4980a85b-e3db-4607-bc2c-0baf0140d7df', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'e84f6b9c-716d-4e94-a1aa-7fd0d1a2e23e', N'', N'RoleModule', N'0', N'2016-09-02 17:03:47.000', N'0', N'648b04c4-4ac2-4d69-bef6-07081ef27871', N'069475e3-c997-487a-9f29-e6a864c5c1d4', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'e9cf3d63-6305-46c7-93b4-14053387c62c', N'', N'UserModule', N'0', N'2018-04-06 09:48:18.000', N'', N'6ba79766-faa0-4259-8139-a4a6d35784e0', N'37bb9414-19a0-4223-9056-71f8c758a930', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'ec72f6ae-09ee-4db9-99a1-bf15c8e35dda', N'', N'ProcessUser', N'0', N'2016-09-14 11:38:23.000', N'0', N'6c6afe3c-349c-4198-8710-cf19c90f3afd', N'3a95e392-07d4-4af3-b30d-140ca93340f5', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'ec9c80ce-dbdf-4ba5-9091-82f75392c3b0', N'', N'UserElement', N'0', N'2016-09-07 15:30:43.000', N'0', N'3a95e392-07d4-4af3-b30d-140ca93340f5', N'68484265-7802-4f06-b024-33e8b2f2edcf', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'edc75249-8f09-46e8-a371-6ca4b6294b6b', N'', N'RoleModule', N'0', N'2019-07-28 21:32:55.347', N'', N'0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', N'9486ff22-b696-4d7f-8093-8a3e53c45453', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'ee1986a0-24cc-4dec-b5f5-68ef959ab650', N'', N'UserElement', N'0', N'2018-04-06 14:50:40.000', N'', N'49df1602-f5f3-4d52-afb7-3802da619558', N'79dcd3eb-3aaf-4e08-83c9-713d8ff446fe', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'ee4f39fd-4fbf-4f68-9a70-d6c7d7db9723', N'', N'ProcessUser', N'0', N'2016-10-31 11:52:39.000', N'0', N'b8bcdf59-1e29-4d97-a364-12ac8e8c5c61', N'3a95e392-07d4-4af3-b30d-140ca93340f5', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'eec41fcb-61c0-4e56-a5c0-a9f8be6e6fdc', N'', N'UserModule', N'0', N'2016-09-07 15:30:06.000', N'0', N'3b64b643-cb9a-4654-81e4-6dd9b2f8a6f7', N'069475e3-c997-487a-9f29-e6a864c5c1d4', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'f03f503b-3898-44a0-a588-3ba4e27b72d5', N'', N'RoleDataProperty', N'0', N'2019-01-08 02:23:02.000', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'Category', N'Id', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'f09076fe-9a9a-41ca-b7ec-8922ad1f48d4', N'', N'RoleDataProperty', N'0', N'2019-07-28 21:33:04.617', N'', N'0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', N'Category', N'Id', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'f41de4d2-369d-46e1-b84d-4bd2c37b8c20', N'', N'UserOrg', N'0', N'2018-09-12 00:10:31.000', N'', N'49df1602-f5f3-4d52-afb7-3802da619558', N'990cb229-cc18-41f3-8e2b-13f0f0110798', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'f4ba636a-9002-43e6-93eb-95132a3e68c5', N'', N'ProcessUser', N'0', N'2016-09-28 09:23:30.000', N'0', N'68295d2a-4dfd-4c5e-81e3-9c787e2603bc', N'3a95e392-07d4-4af3-b30d-140ca93340f5', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'f579a427-a9ed-4ebe-8411-72e8e6abd01d', N'', N'UserElement', N'0', N'2016-09-05 16:25:26.000', N'0', N'ea25646b-964b-4d41-ab03-d8964e1494fb', N'816b12b3-e916-446d-a2fa-329cfd13c831', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'f61ee29b-7988-404d-b692-5a8f667684be', N'', N'UserElement', N'0', N'2018-04-06 09:48:23.000', N'', N'6ba79766-faa0-4259-8139-a4a6d35784e0', N'68484265-7802-4f06-b024-33e8b2f2edcf', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'f6367ca1-0486-46a4-b9c6-65c00936a516', N'', N'RoleElement', N'0', N'2016-09-04 23:20:54.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'9e2c6754-f258-4b14-96a0-b9d981196a65', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'f671f582-9111-4000-aadd-660449d0d4b0', N'', N'RoleResource', N'0', N'2018-09-12 00:15:54.000', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'XXX_LOGIN', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'f6a9cdf7-50c1-48b4-ae29-f999691f3a1d', N'', N'RoleDataProperty', N'0', N'2019-01-08 02:23:02.000', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'Category', N'TypeId', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'fa7c4d39-b31a-4668-8716-d40a62aa722b', N'', N'UserOrg', N'0', N'2017-10-12 13:59:49.000', N'', N'63c9c82a-e0d3-4bde-bbd2-057cda2f5283', N'990cb229-cc18-41f3-8e2b-13f0f0110798', NULL, NULL)
GO



-- ----------------------------
-- Records of [Resource]
-- ----------------------------
INSERT INTO [dbo].[Resource]  VALUES (N'OPENAUTH_DELETEACCOUNT', N'', N'注销账号', N'0', N'openauth.net注销账号的权限', N'', N'', N'110', N'OpenAuth.Net', N'', N'', N'0')
GO

INSERT INTO [dbo].[Resource]  VALUES (N'OPENAUTH_LOGIN', N'', N'登陆', N'0', N'openauth.net登陆的权限', N'', N'', N'110', N'OpenAuth.Net', N'', N'', N'0')
GO

INSERT INTO [dbo].[Resource]  VALUES (N'OPENAUTH_MODIFYACCOUNT', N'', N'修改账号', N'0', N'openauth.net修改账号的权限', N'', N'', N'110', N'OpenAuth.Net', N'', N'', N'0')
GO

INSERT INTO [dbo].[Resource]  VALUES (N'XXX_ADMIN', N'', N'XXX管理员', N'0', N'', N'', N'', N'119', N'XXX管理平台', N'', N'', N'0')
GO

INSERT INTO [dbo].[Resource]  VALUES (N'XXX_CHECKUSER', N'', N'审核用户', N'0', N'', N'', N'', N'119', N'XXX管理平台', N'', N'', N'0')
GO

INSERT INTO [dbo].[Resource]  VALUES (N'XXX_DELETEACCOUNT', N'', N'注销账号', N'0', N'', N'', N'', N'119', N'XXX管理平台', N'', N'', N'0')
GO

INSERT INTO [dbo].[Resource]  VALUES (N'XXX_LOGIN', N'', N'登陆', N'0', N'登陆xxx平台的权限', N'', N'', N'119', N'XXX管理平台', N'', N'', N'0')
GO



-- ----------------------------
-- Records of [Role]
-- ----------------------------
INSERT INTO [dbo].[Role]  VALUES (N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'管理员', N'0', N'2018-04-09 22:48:24.000', N'', N'', N'')
GO

INSERT INTO [dbo].[Role]  VALUES (N'0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', N'测试', N'0', N'2018-04-09 22:48:29.000', N'', N'', N'')
GO

INSERT INTO [dbo].[Role]  VALUES (N'3e761e88-ddf7-4a62-b219-9a315b4564f2', N'汇丰测试', N'0', N'2018-04-09 22:48:42.000', N'', N'', N'')
GO

INSERT INTO [dbo].[Role]  VALUES (N'77e6d0c3-f9e1-4933-92c3-c1c6eef75593', N'神', N'1', N'2018-04-14 13:16:45.000', N'', N'', N'')
GO




-- ----------------------------
-- Records of [User]
-- ----------------------------
INSERT INTO [dbo].[User]  VALUES (N'0ceff0f8-f848-440c-bc26-d8605ac858cd', N'test5', N'test5', N'test5', N'1', N'1', N'', N'2018-03-15 09:19:05.000', N'', N'', N'')
GO

INSERT INTO [dbo].[User]  VALUES (N'1df68dfd-3b6d-4491-872f-00a0fc6c5a64', N'test4', N'test4', N'test4', N'1', N'1', N'', N'2017-12-12 14:07:11.000', N'', N'', N'')
GO

INSERT INTO [dbo].[User]  VALUES (N'229f3a49-ab27-49ce-b383-9f10ca23a9d5', N'test3', N'test3', N'test3', N'1', N'1', N'', N'2017-12-12 14:07:05.000', N'', N'', N'')
GO

INSERT INTO [dbo].[User]  VALUES (N'49df1602-f5f3-4d52-afb7-3802da619558', N'admin', N'admin', N'admin', N'1', N'0', N'', N'2017-12-11 16:18:54.000', N'', N'', N'')
GO

INSERT INTO [dbo].[User]  VALUES (N'6ba79766-faa0-4259-8139-a4a6d35784e0', N'test', N'test', N'test', N'1', N'0', N'', N'2017-12-11 16:19:00.000', N'', N'', N'')
GO

INSERT INTO [dbo].[User]  VALUES (N'de8be521-f1ec-4483-b124-0be342890507', N'test2', N'test2', N'test2', N'1', N'1', N'', N'2017-12-11 16:19:06.000', N'', N'', N'')
GO

