
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
INSERT INTO [dbo].[FlowInstance]  VALUES (N'6da79fdb-cad6-4ab8-83d4-fd14e4021c4b', N'', N'1536684129781', N'开发流程2018-09-12 00:43:34', N'1536683913550', N'0', N'领导审批', N'1536683910415', N'{"title":"newFlow_1","initNum":16,"lines":[{"id":"1536683929709","type":"sl","from":"1536683905671","to":"1536683910415","name":"","dash":false},{"id":"1536683931022","type":"sl","from":"1536683910415","to":"1536683913550","name":"","dash":false},{"id":"1536683949701","type":"sl","from":"1536683913550","to":"1536683920518","name":"","dash":false},{"id":"1536683950902","type":"sl","from":"1536683913550","to":"1536683921264","name":"","dash":false},{"id":"1536683952318","type":"sl","from":"1536683920518","to":"1536683923990","name":"","dash":false},{"id":"1536683953926","type":"sl","from":"1536683921264","to":"1536683923990","name":"","dash":false},{"id":"1536683956662","type":"sl","from":"1536683923990","to":"1536683916278","name":"","dash":false}],"nodes":[{"id":"1536683905671","name":"node_1","type":"start round mix","left":213,"top":104,"width":26,"height":26,"alt":true,"setInfo":null},{"id":"1536683910415","name":"内部讨论","type":"node","left":290,"top":112,"width":105,"height":36,"alt":true,"setInfo":{"NodeDesignate":"ALL_USER","NodeDesignateData":{"users":[],"roles":[],"orgs":null},"NodeCode":null,"NodeName":null,"NodeRejectType":null,"Taged":1,"UserName":"超级管理员","UserId":"00000000-0000-0000-0000-000000000000","Description":"我准了","TagedTime":"2018-09-12 00:45","NodeConfluenceType":"all","ConfluenceOk":null,"ConfluenceNo":null}},{"id":"1536683913550","name":"领导审批","type":"fork","left":293,"top":206,"width":104,"height":44,"alt":true,"setInfo":{"NodeDesignate":"ALL_USER","NodeDesignateData":{"users":[],"roles":[],"orgs":null},"NodeCode":null,"NodeName":null,"NodeRejectType":null,"Taged":null,"UserName":null,"UserId":null,"Description":null,"TagedTime":null,"NodeConfluenceType":"all","ConfluenceOk":null,"ConfluenceNo":null}},{"id":"1536683916278","name":"node_4","type":"end round","left":330,"top":486,"width":26,"height":26,"alt":true,"setInfo":null},{"id":"1536683920518","name":"admin审核","type":"node","left":177,"top":294,"width":104,"height":39,"alt":true,"setInfo":{"NodeDesignate":"SPECIAL_USER","NodeDesignateData":{"users":["49df1602-f5f3-4d52-afb7-3802da619558"],"roles":[],"orgs":null},"NodeCode":null,"NodeName":null,"NodeRejectType":null,"Taged":null,"UserName":null,"UserId":null,"Description":null,"TagedTime":null,"NodeConfluenceType":"all","ConfluenceOk":null,"ConfluenceNo":null}},{"id":"1536683921264","name":"test审核","type":"node","left":414,"top":287,"width":104,"height":44,"alt":true,"setInfo":{"NodeDesignate":"SPECIAL_USER","NodeDesignateData":{"users":["6ba79766-faa0-4259-8139-a4a6d35784e0"],"roles":[],"orgs":null},"NodeCode":null,"NodeName":null,"NodeRejectType":null,"Taged":null,"UserName":null,"UserId":null,"Description":null,"TagedTime":null,"NodeConfluenceType":"all","ConfluenceOk":null,"ConfluenceNo":null}},{"id":"1536683923990","name":"再有任意一人审核","type":"join","left":297,"top":398,"width":104,"height":46,"alt":true,"setInfo":{"NodeDesignate":"ALL_USER","NodeDesignateData":{"users":[],"roles":[],"orgs":null},"NodeCode":null,"NodeName":null,"NodeRejectType":null,"Taged":null,"UserName":null,"UserId":null,"Description":null,"TagedTime":null,"NodeConfluenceType":"all","ConfluenceOk":null,"ConfluenceNo":null}}],"areas":[]}', N'', N'', N'{"data_1":"OpenAuth.Net","data_2":"重庆","data_3":"男","data_4":"高中","data_5":"大转","data_6":"本科","data_7":"30","data_8":"还是没太懂这个文件的格式，我是男的"}', N'0', N'[{"style":"text-align: left; width: 150px;","title":"文本框","value":"OpenAuth.Net","name":"data_1","orgheight":"","orgwidth":"150","orgalign":"left","orgfontsize":"","orghide":"0","leipiplugins":"text","orgtype":"text","content":"<input style=\"text-align: left; width: 150px;\" title=\"文本框\" value=\"OpenAuth.Net\" name=\"data_1\" orgheight=\"\" orgwidth=\"150\" orgalign=\"left\" orgfontsize=\"\" orghide=\"0\" leipiplugins=\"text\" orgtype=\"text\"/>"},{"leipiplugins":"select","name":"data_2","title":"省份","size":"1","orgwidth":"150","style":"width: 150px;","value":"北京,深圳,上海,重庆,浙江,苏州,广东","selected":"selected","content":"<span leipiplugins=\"select\"><select name=\"data_2\" title=\"省份\" leipiplugins=\"select\" size=\"1\" orgwidth=\"150\" style=\"width: 150px;\"><option value=\"北京\" selected=\"selected\">北京</option><option value=\"深圳\">深圳</option><option value=\"上海\">上海</option><option value=\"重庆\">重庆</option><option value=\"浙江\">浙江</option><option value=\"苏州\">苏州</option><option value=\"广东\">广东</option></select>&nbsp;&nbsp;</span>"},{"leipiplugins":"radios","title":"性别","name":"data_3","orgchecked":"orgchecked0","value":"男,女","content":"<span leipiplugins=\"radios\" name=\"data_3\" title=\"性别\"><input type=\"radio\" name=\"data_3\" value=\"男\"  checked=\"checked\"/>男&nbsp;<input type=\"radio\" name=\"data_3\" value=\"女\"  />女&nbsp;</span>","options":[{"name":"data_3","value":"男","checked":"","type":"radio"},{"name":"data_3","value":"女","type":"radio"}]},{"leipiplugins":"checkboxs","title":"学历","orgchecked":"orgchecked0","parse_name":"checkboxs_0","name":"data_4,data_5,data_6","value":"高中,大转,本科","content":"<span leipiplugins=\"checkboxs\"  title=\"学历\"><input type=\"checkbox\" name=\"data_4\" value=\"高中\"  />高中&nbsp;<input type=\"checkbox\" name=\"data_5\" value=\"大转\"  />大转&nbsp;<input type=\"checkbox\" name=\"data_6\" value=\"本科\"  checked=\"checked\"/>本科&nbsp;</span>","options":[{"name":"data_4","value":"高中","type":"checkbox"},{"name":"data_5","value":"大转","type":"checkbox"},{"name":"data_6","value":"本科","checked":"checked","type":"checkbox"}]},{"name":"data_7","type":"text","title":"Age","value":"","leipiplugins":"text","orghide":"0","orgalign":"left","orgwidth":"150","orgtype":"text","style":"text-align: left; width: 150px;","content":"<input name=\"data_7\" type=\"text\" title=\"Age\" value=\"\" leipiplugins=\"text\" orghide=\"0\" orgalign=\"left\" orgwidth=\"150\" orgtype=\"text\" style=\"text-align: left; width: 150px;\"/>"},{"title":"多行文本","name":"data_8","leipiplugins":"textarea","value":"","orgrich":"0","orgfontsize":"12","orgwidth":"600","orgheight":"80","style":"font-size: 12px; width: 752px; height: 194px; margin: 0px;","content":"<textarea title=\"多行文本\" name=\"data_8\" leipiplugins=\"textarea\" value=\"\" orgrich=\"0\" orgfontsize=\"12\" orgwidth=\"600\" orgheight=\"80\" style=\"font-size: 12px; width: 752px; height: 194px; margin: 0px;\"></textarea>"}]', N'<p style="text-align: center;"><br/></p><p style="text-align: center;"><span style="font-size: 24px;">这是一个报告</span></p><table class="table table-bordered"><tbody><tr class="firstRow"><td valign="top" style="word-break: break-all; border-color: rgb(221, 221, 221);">文件名</td><td valign="top" style="word-break: break-all; border-color: rgb(221, 221, 221);" width="227">{data_1}</td><td valign="top" style="word-break: break-all; border-color: rgb(221, 221, 221);" width="85">省份</td><td valign="top" style="border-color: rgb(221, 221, 221);" width="312">{data_2}</td></tr><tr><td valign="top" style="word-break: break-all; border-color: rgb(221, 221, 221);">性别</td><td valign="top" style="word-break: break-all; border-color: rgb(221, 221, 221);" width="41">{data_3}</td><td valign="top" style="word-break: break-all; border-color: rgb(221, 221, 221);" width="85">学历</td><td valign="top" style="word-break: break-all; border-color: rgb(221, 221, 221);" width="312">{checkboxs_0}</td></tr><tr><td valign="top" style="word-break: break-all; border-color: rgb(221, 221, 221);">年龄</td><td valign="top" style="border-color: rgb(221, 221, 221); word-break: break-all;" width="41">{data_7}</td><td valign="top" style="word-break: break-all; border-color: rgb(221, 221, 221);" width="85">签名</td><td valign="top" style="border-color: rgb(221, 221, 221); word-break: break-all;" width="312">yubaolee</td></tr></tbody></table><p></p><p>{data_8}</p><p></p><p><br/></p>', N'80f45153-ad90-45ea-9ec1-90c6e5020e25', N'', N'0', N'2018-09-11 16:00:00.000', N'00000000-0000-0000-0000-000000000000', N'System', N'0', N'这个流程一定要懂的', N'0', N'49df1602-f5f3-4d52-afb7-3802da619558,6ba79766-faa0-4259-8139-a4a6d35784e0')
GO

INSERT INTO [dbo].[FlowInstance]  VALUES (N'd73e4412-9c49-4511-a30e-0d2f844afcee', N'', N'1523002870978', N'我请个假', N'1523002637238', N'2', N'admin审核', N'1523002636766', N'{"title":"newFlow_1","nodes":[{"name":"node_1","left":101,"top":105,"type":"start round mix","id":"1523002631942","width":26,"height":26,"alt":true},{"name":"所有人都可以审","left":218,"top":122,"type":"node","id":"1523002636766","width":104,"height":50,"alt":true,"setInfo":{"NodeDesignateData":{"users":[],"role":[],"org":[]},"NodeName":"所有人都可以审","NodeCode":"node_2","NodeRejectType":"0","NodeDesignate":"ALL_USER","Taged":1,"UserId":"00000000-0000-0000-0000-000000000000","UserName":"超级管理员","Description":"自己处理一下","TagedTime":"2018-04-06 16:22"}},{"name":"admin审核","left":215,"top":190,"type":"node","id":"1523002637238","width":104,"height":49,"alt":true,"setInfo":{"NodeDesignateData":{"users":["49df1602-f5f3-4d52-afb7-3802da619558"],"role":[],"org":[]},"NodeName":"admin审核","NodeCode":"node_3","NodeRejectType":"0","NodeDesignate":"SPECIAL_USER"}},{"name":"node_4","left":260,"top":287,"type":"end round","id":"1523002639310","width":26,"height":26,"alt":true}],"lines":[{"type":"sl","from":"1523002631942","to":"1523002636766","id":"1523002641196","name":"","dash":false},{"type":"sl","from":"1523002636766","to":"1523002637238","id":"1523002642292","name":"","dash":false},{"type":"sl","from":"1523002637238","to":"1523002639310","id":"1523002643868","name":"","dash":false}],"areas":[],"initNum":9}', N'', N'', N'{"data_1":"玉宝","data_2":"3","data_3":""}', N'0', N'[{"name":"data_1","title":"Name","value":"玉宝","leipiplugins":"text","orghide":"0","style":"text-align: left; width: 150px;","orgalign":"left","orgwidth":"150","orgtype":"text","type":"text","content":"<input name=\"data_1\" title=\"Name\" value=\"玉宝\" leipiplugins=\"text\" orghide=\"0\" style=\"text-align: left; width: 150px;\" orgalign=\"left\" orgwidth=\"150\" orgtype=\"text\" type=\"text\"/>"},{"leipiplugins":"select","name":"data_2","title":"Days","size":"1","style":"width: 150px;","orgwidth":"150","value":"1,3,5,7","selected":"selected","content":"<span leipiplugins=\"select\"><select name=\"data_2\" title=\"Days\" leipiplugins=\"select\" size=\"1\" style=\"width: 150px;\" orgwidth=\"150\"><option value=\"1\">1</option><option value=\"3\" selected=\"selected\">3</option><option value=\"5\">5</option><option value=\"7\">7</option></select>&nbsp;&nbsp;</span>"},{"title":"Comment","name":"data_3","leipiplugins":"textarea","value":"","orgrich":"1","orgfontsize":"","orgwidth":"300","orgheight":"80","style":"width: 316px; height: 139px;","content":"<textarea title=\"Comment\" name=\"data_3\" leipiplugins=\"textarea\" value=\"\" orgrich=\"1\" orgfontsize=\"\" orgwidth=\"300\" orgheight=\"80\" style=\"width: 316px; height: 139px;\"></textarea>"}]', N'<p><br/></p><p style="text-align: center;">姓名：{data_1}</p><p style="text-align: center;">天数：{data_2}</p><p style="text-align: center;">备注：{data_3}</p>', N'a4cffd58-7bac-498a-a327-58a644dfdd93', N'', N'0', N'2018-04-06 16:21:36.000', N'00000000-0000-0000-0000-000000000000', N'System', N'0', N'', N'0', N'49df1602-f5f3-4d52-afb7-3802da619558')
GO

INSERT INTO [dbo].[FlowInstance]  VALUES (N'd8fa445f-edd9-4604-8d9e-b17ba921f9dd', N'', N'1523688313680', N'天气好，请个假', N'1523688050220', N'0', N'会签开始（要包括所有会签节点的审核人）', N'1523688045356', N'{"title":"newFlow_1","nodes":[{"name":"node_1","left":88,"top":84,"type":"start round mix","id":"1523688043300","width":26,"height":26,"alt":true},{"name":"任何人可以审核","left":201,"top":79,"type":"node","id":"1523688045356","width":148,"height":52,"alt":true,"setInfo":{"NodeDesignateData":{"users":[],"roles":[],"orgs":[]},"NodeName":"任何人可以审核","NodeCode":"node_2","NodeRejectType":"0","NodeDesignate":"ALL_USER","Taged":1,"UserId":"00000000-0000-0000-0000-000000000000","UserName":"超级管理员","Description":"自己当然要通过啊","TagedTime":"2018-04-14 14:46"}},{"name":"会签开始（要包括所有会签节点的审核人）","left":198,"top":165,"type":"fork","id":"1523688050220","width":162,"height":81,"alt":true,"setInfo":{"NodeDesignateData":{"users":["49df1602-f5f3-4d52-afb7-3802da619558","6ba79766-faa0-4259-8139-a4a6d35784e0"],"roles":[],"orgs":[]},"NodeName":"会签开始（要包括所有会签节点的审核人）","NodeCode":"node_3","NodeRejectType":"0","NodeDesignate":"SPECIAL_USER"}},{"name":"admin审核","left":119,"top":283,"type":"node","id":"1523688053956","width":104,"height":39,"alt":true,"setInfo":{"NodeDesignateData":{"users":["49df1602-f5f3-4d52-afb7-3802da619558"],"roles":[],"orgs":[]},"NodeName":"admin审核","NodeCode":"node_4","NodeRejectType":"0","NodeDesignate":"SPECIAL_USER"}},{"name":"test审核","left":337,"top":286,"type":"node","id":"1523688054452","width":104,"height":38,"alt":true,"setInfo":{"NodeDesignateData":{"users":["6ba79766-faa0-4259-8139-a4a6d35784e0"],"roles":[],"orgs":[]},"NodeName":"test审核","NodeCode":"node_5","NodeRejectType":"0","NodeDesignate":"SPECIAL_USER"}},{"name":"会签结束","left":221,"top":362,"type":"join","id":"1523688063308","width":104,"height":46,"alt":true,"setInfo":{"NodeDesignateData":{"users":[],"roles":[],"orgs":[]},"NodeName":"会签结束","NodeCode":"node_7","NodeRejectType":"0","NodeDesignate":"ALL_USER"}},{"name":"node_8","left":261,"top":443,"type":"end round","id":"1523688066308","width":26,"height":26,"alt":true}],"lines":[{"type":"sl","from":"1523688043300","to":"1523688045356","id":"1523688073290","name":"","dash":false},{"type":"sl","from":"1523688045356","to":"1523688050220","id":"1523688074210","name":"","dash":false},{"type":"sl","from":"1523688050220","to":"1523688053956","id":"1523688075338","name":"","dash":false},{"type":"sl","from":"1523688050220","to":"1523688054452","id":"1523688079394","name":"","dash":false},{"type":"sl","from":"1523688053956","to":"1523688063308","id":"1523688080746","name":"","dash":false},{"type":"sl","from":"1523688054452","to":"1523688063308","id":"1523688082204","name":"","dash":false},{"type":"sl","from":"1523688063308","to":"1523688066308","id":"1523688084522","name":"","dash":false}],"areas":[],"initNum":16}', N'', N'', N'{"data_1":"玉宝","data_2":"3","data_3":"想去洗个车啊，老板"}', N'0', N'[{"name":"data_1","title":"Name","value":"玉宝","leipiplugins":"text","orghide":"0","style":"text-align: left; width: 150px;","orgalign":"left","orgwidth":"150","orgtype":"text","type":"text","content":"<input name=\"data_1\" title=\"Name\" value=\"玉宝\" leipiplugins=\"text\" orghide=\"0\" style=\"text-align: left; width: 150px;\" orgalign=\"left\" orgwidth=\"150\" orgtype=\"text\" type=\"text\"/>"},{"leipiplugins":"select","name":"data_2","title":"Days","size":"1","style":"width: 150px;","orgwidth":"150","value":"1,3,5,7","selected":"selected","content":"<span leipiplugins=\"select\"><select name=\"data_2\" title=\"Days\" leipiplugins=\"select\" size=\"1\" style=\"width: 150px;\" orgwidth=\"150\"><option value=\"1\">1</option><option value=\"3\" selected=\"selected\">3</option><option value=\"5\">5</option><option value=\"7\">7</option></select>&nbsp;&nbsp;</span>"},{"title":"Comment","name":"data_3","leipiplugins":"textarea","value":"","orgrich":"1","orgfontsize":"","orgwidth":"300","orgheight":"80","style":"width: 316px; height: 139px;","content":"<textarea title=\"Comment\" name=\"data_3\" leipiplugins=\"textarea\" value=\"\" orgrich=\"1\" orgfontsize=\"\" orgwidth=\"300\" orgheight=\"80\" style=\"width: 316px; height: 139px;\"></textarea>"}]', N'<p><br/></p><p style="text-align: center;">姓名：{data_1}</p><p style="text-align: center;">天数：{data_2}</p><p style="text-align: center;">备注：{data_3}</p>', N'a4cffd58-7bac-498a-a327-58a644dfdd93', N'', N'0', N'2018-04-14 14:46:01.000', N'00000000-0000-0000-0000-000000000000', N'System', N'0', N'', N'0', N'49df1602-f5f3-4d52-afb7-3802da619558,6ba79766-faa0-4259-8139-a4a6d35784e0')
GO

INSERT INTO [dbo].[FlowInstance]  VALUES (N'db026b5c-9f60-496d-a861-991327d975ab', N'', N'1536684129781', N'开发流程2018-09-12 00:42:32', N'1536683910415', N'2', N'内部讨论', N'1536683905671', N'{"title":"newFlow_1","nodes":[{"name":"node_1","left":213,"top":104,"type":"start round mix","id":"1536683905671","width":26,"height":26,"alt":true},{"name":"内部讨论","left":290,"top":112,"type":"node","id":"1536683910415","width":105,"height":36,"alt":true,"setInfo":{"NodeConfluenceType":"all","NodeDesignate":"ALL_USER","NodeDesignateData":{"users":[],"roles":[]}}},{"name":"领导审批","left":293,"top":206,"type":"fork","id":"1536683913550","width":104,"height":44,"alt":true,"setInfo":{"NodeConfluenceType":"all","NodeDesignate":"ALL_USER","NodeDesignateData":{"users":[],"roles":[]}}},{"name":"node_4","left":330,"top":486,"type":"end round","id":"1536683916278","width":26,"height":26,"alt":true},{"name":"admin审核","left":177,"top":294,"type":"node","id":"1536683920518","width":104,"height":39,"alt":true,"setInfo":{"NodeConfluenceType":"all","NodeDesignate":"SPECIAL_USER","NodeDesignateData":{"users":["49df1602-f5f3-4d52-afb7-3802da619558"],"roles":[]}}},{"name":"test审核","left":414,"top":287,"type":"node","id":"1536683921264","width":104,"height":44,"alt":true,"setInfo":{"NodeConfluenceType":"all","NodeDesignate":"SPECIAL_USER","NodeDesignateData":{"users":["6ba79766-faa0-4259-8139-a4a6d35784e0"],"roles":[]}}},{"name":"再有任意一人审核","left":297,"top":398,"type":"join","id":"1536683923990","width":104,"height":46,"alt":true,"setInfo":{"NodeConfluenceType":"all","NodeDesignate":"ALL_USER","NodeDesignateData":{"users":[],"roles":[]}}}],"lines":[{"type":"sl","from":"1536683905671","to":"1536683910415","id":"1536683929709","name":"","dash":false,"alt":true},{"type":"sl","from":"1536683910415","to":"1536683913550","id":"1536683931022","name":"","dash":false,"alt":true},{"type":"sl","from":"1536683913550","to":"1536683920518","id":"1536683949701","name":"","dash":false,"alt":true},{"type":"sl","from":"1536683913550","to":"1536683921264","id":"1536683950902","name":"","dash":false,"alt":true},{"type":"sl","from":"1536683920518","to":"1536683923990","id":"1536683952318","name":"","dash":false,"alt":true},{"type":"sl","from":"1536683921264","to":"1536683923990","id":"1536683953926","name":"","dash":false,"alt":true},{"type":"sl","from":"1536683923990","to":"1536683916278","id":"1536683956662","name":"","dash":false,"alt":true}],"areas":[],"initNum":16}', N'', N'', N'{"data_1":"OpenAuth.Net","data_2":"北京","data_3":"","data_4":"高中","data_5":"大转","data_6":"本科","data_7":"30","data_8":"这是什么开发文档？？？？我晕"}', N'0', N'[{"style":"text-align: left; width: 150px;","title":"文本框","value":"OpenAuth.Net","name":"data_1","orgheight":"","orgwidth":"150","orgalign":"left","orgfontsize":"","orghide":"0","leipiplugins":"text","orgtype":"text","content":"<input style=\"text-align: left; width: 150px;\" title=\"文本框\" value=\"OpenAuth.Net\" name=\"data_1\" orgheight=\"\" orgwidth=\"150\" orgalign=\"left\" orgfontsize=\"\" orghide=\"0\" leipiplugins=\"text\" orgtype=\"text\"/>"},{"leipiplugins":"select","name":"data_2","title":"省份","size":"1","orgwidth":"150","style":"width: 150px;","value":"北京,深圳,上海,重庆,浙江,苏州,广东","selected":"selected","content":"<span leipiplugins=\"select\"><select name=\"data_2\" title=\"省份\" leipiplugins=\"select\" size=\"1\" orgwidth=\"150\" style=\"width: 150px;\"><option value=\"北京\" selected=\"selected\">北京</option><option value=\"深圳\">深圳</option><option value=\"上海\">上海</option><option value=\"重庆\">重庆</option><option value=\"浙江\">浙江</option><option value=\"苏州\">苏州</option><option value=\"广东\">广东</option></select>&nbsp;&nbsp;</span>"},{"leipiplugins":"radios","title":"性别","name":"data_3","orgchecked":"orgchecked0","value":"男,女","content":"<span leipiplugins=\"radios\" name=\"data_3\" title=\"性别\"><input type=\"radio\" name=\"data_3\" value=\"男\"  checked=\"checked\"/>男&nbsp;<input type=\"radio\" name=\"data_3\" value=\"女\"  />女&nbsp;</span>","options":[{"name":"data_3","value":"男","checked":"","type":"radio"},{"name":"data_3","value":"女","type":"radio"}]},{"leipiplugins":"checkboxs","title":"学历","orgchecked":"orgchecked0","parse_name":"checkboxs_0","name":"data_4,data_5,data_6","value":"高中,大转,本科","content":"<span leipiplugins=\"checkboxs\"  title=\"学历\"><input type=\"checkbox\" name=\"data_4\" value=\"高中\"  />高中&nbsp;<input type=\"checkbox\" name=\"data_5\" value=\"大转\"  />大转&nbsp;<input type=\"checkbox\" name=\"data_6\" value=\"本科\"  checked=\"checked\"/>本科&nbsp;</span>","options":[{"name":"data_4","value":"高中","type":"checkbox"},{"name":"data_5","value":"大转","type":"checkbox"},{"name":"data_6","value":"本科","checked":"checked","type":"checkbox"}]},{"name":"data_7","type":"text","title":"Age","value":"","leipiplugins":"text","orghide":"0","orgalign":"left","orgwidth":"150","orgtype":"text","style":"text-align: left; width: 150px;","content":"<input name=\"data_7\" type=\"text\" title=\"Age\" value=\"\" leipiplugins=\"text\" orghide=\"0\" orgalign=\"left\" orgwidth=\"150\" orgtype=\"text\" style=\"text-align: left; width: 150px;\"/>"},{"title":"多行文本","name":"data_8","leipiplugins":"textarea","value":"","orgrich":"0","orgfontsize":"12","orgwidth":"600","orgheight":"80","style":"font-size: 12px; width: 752px; height: 194px; margin: 0px;","content":"<textarea title=\"多行文本\" name=\"data_8\" leipiplugins=\"textarea\" value=\"\" orgrich=\"0\" orgfontsize=\"12\" orgwidth=\"600\" orgheight=\"80\" style=\"font-size: 12px; width: 752px; height: 194px; margin: 0px;\"></textarea>"}]', N'<p style="text-align: center;"><br/></p><p style="text-align: center;"><span style="font-size: 24px;">这是一个报告</span></p><table class="table table-bordered"><tbody><tr class="firstRow"><td valign="top" style="word-break: break-all; border-color: rgb(221, 221, 221);">文件名</td><td valign="top" style="word-break: break-all; border-color: rgb(221, 221, 221);" width="227">{data_1}</td><td valign="top" style="word-break: break-all; border-color: rgb(221, 221, 221);" width="85">省份</td><td valign="top" style="border-color: rgb(221, 221, 221);" width="312">{data_2}</td></tr><tr><td valign="top" style="word-break: break-all; border-color: rgb(221, 221, 221);">性别</td><td valign="top" style="word-break: break-all; border-color: rgb(221, 221, 221);" width="41">{data_3}</td><td valign="top" style="word-break: break-all; border-color: rgb(221, 221, 221);" width="85">学历</td><td valign="top" style="word-break: break-all; border-color: rgb(221, 221, 221);" width="312">{checkboxs_0}</td></tr><tr><td valign="top" style="word-break: break-all; border-color: rgb(221, 221, 221);">年龄</td><td valign="top" style="border-color: rgb(221, 221, 221); word-break: break-all;" width="41">{data_7}</td><td valign="top" style="word-break: break-all; border-color: rgb(221, 221, 221);" width="85">签名</td><td valign="top" style="border-color: rgb(221, 221, 221); word-break: break-all;" width="312">yubaolee</td></tr></tbody></table><p></p><p>{data_8}</p><p></p><p><br/></p>', N'80f45153-ad90-45ea-9ec1-90c6e5020e25', N'', N'0', N'2018-09-04 16:00:00.000', N'00000000-0000-0000-0000-000000000000', N'System', N'0', N'我没搞懂啊，提交一个看看', N'0', N'1')
GO

INSERT INTO [dbo].[FlowInstance]  VALUES (N'e6566327-1a0e-4378-8f63-91acfa4722d2', N'', N'1523688457002', N'不想上班请个假', N'1523688050220', N'0', N'会签开始（要包括所有会签节点的审核人）', N'1523688045356', N'{"title":"newFlow_1","initNum":16,"lines":[{"id":"1523688073290","type":"sl","from":"1523688043300","to":"1523688045356","name":"","dash":false},{"id":"1523688074210","type":"sl","from":"1523688045356","to":"1523688050220","name":"","dash":false},{"id":"1523688075338","type":"sl","from":"1523688050220","to":"1523688053956","name":"","dash":false},{"id":"1523688079394","type":"sl","from":"1523688050220","to":"1523688054452","name":"","dash":false},{"id":"1523688080746","type":"sl","from":"1523688053956","to":"1523688063308","name":"","dash":false},{"id":"1523688082204","type":"sl","from":"1523688054452","to":"1523688063308","name":"","dash":false},{"id":"1523688084522","type":"sl","from":"1523688063308","to":"1523688066308","name":"","dash":false}],"nodes":[{"id":"1523688043300","name":"node_1","type":"start round mix","left":88,"top":84,"width":26,"height":26,"alt":true,"setInfo":null},{"id":"1523688045356","name":"任何人可以审核","type":"node","left":201,"top":79,"width":148,"height":52,"alt":true,"setInfo":{"NodeDesignate":"ALL_USER","NodeDesignateData":{"users":[],"roles":[],"orgs":[]},"NodeCode":"node_2","NodeName":"任何人可以审核","NodeRejectType":"0","Taged":1,"UserName":"超级管理员","UserId":"00000000-0000-0000-0000-000000000000","Description":"ok","TagedTime":"2018-09-05 14:35","NodeConfluenceType":null,"ConfluenceOk":null,"ConfluenceNo":null}},{"id":"1523688050220","name":"会签开始（要包括所有会签节点的审核人）","type":"fork","left":198,"top":165,"width":162,"height":81,"alt":true,"setInfo":{"NodeDesignate":"SPECIAL_USER","NodeDesignateData":{"users":["49df1602-f5f3-4d52-afb7-3802da619558","6ba79766-faa0-4259-8139-a4a6d35784e0"],"roles":[],"orgs":[]},"NodeCode":"node_3","NodeName":"会签开始（要包括所有会签节点的审核人）","NodeRejectType":"0","Taged":null,"UserName":null,"UserId":null,"Description":null,"TagedTime":null,"NodeConfluenceType":null,"ConfluenceOk":null,"ConfluenceNo":null}},{"id":"1523688053956","name":"admin审核","type":"node","left":119,"top":283,"width":104,"height":39,"alt":true,"setInfo":{"NodeDesignate":"SPECIAL_USER","NodeDesignateData":{"users":["49df1602-f5f3-4d52-afb7-3802da619558"],"roles":[],"orgs":[]},"NodeCode":"node_4","NodeName":"admin审核","NodeRejectType":"0","Taged":null,"UserName":null,"UserId":null,"Description":null,"TagedTime":null,"NodeConfluenceType":null,"ConfluenceOk":null,"ConfluenceNo":null}},{"id":"1523688054452","name":"test审核","type":"node","left":337,"top":286,"width":104,"height":38,"alt":true,"setInfo":{"NodeDesignate":"SPECIAL_USER","NodeDesignateData":{"users":["6ba79766-faa0-4259-8139-a4a6d35784e0"],"roles":[],"orgs":[]},"NodeCode":"node_5","NodeName":"test审核","NodeRejectType":"0","Taged":null,"UserName":null,"UserId":null,"Description":null,"TagedTime":null,"NodeConfluenceType":null,"ConfluenceOk":null,"ConfluenceNo":null}},{"id":"1523688063308","name":"会签结束","type":"join","left":221,"top":362,"width":104,"height":46,"alt":true,"setInfo":{"NodeDesignate":"ALL_USER","NodeDesignateData":{"users":[],"roles":[],"orgs":[]},"NodeCode":"node_7","NodeName":"会签结束","NodeRejectType":"0","Taged":null,"UserName":null,"UserId":null,"Description":null,"TagedTime":null,"NodeConfluenceType":null,"ConfluenceOk":null,"ConfluenceNo":null}},{"id":"1523688066308","name":"node_8","type":"end round","left":261,"top":443,"width":26,"height":26,"alt":true,"setInfo":null}],"areas":[]}', N'', N'', N'{"data_1":"玉宝","data_2":"3","data_3":""}', N'0', N'[{"name":"data_1","title":"Name","value":"玉宝","leipiplugins":"text","orghide":"0","style":"text-align: left; width: 150px;","orgalign":"left","orgwidth":"150","orgtype":"text","type":"text","content":"<input name=\"data_1\" title=\"Name\" value=\"玉宝\" leipiplugins=\"text\" orghide=\"0\" style=\"text-align: left; width: 150px;\" orgalign=\"left\" orgwidth=\"150\" orgtype=\"text\" type=\"text\"/>"},{"leipiplugins":"select","name":"data_2","title":"Days","size":"1","style":"width: 150px;","orgwidth":"150","value":"1,3,5,7","selected":"selected","content":"<span leipiplugins=\"select\"><select name=\"data_2\" title=\"Days\" leipiplugins=\"select\" size=\"1\" style=\"width: 150px;\" orgwidth=\"150\"><option value=\"1\">1</option><option value=\"3\" selected=\"selected\">3</option><option value=\"5\">5</option><option value=\"7\">7</option></select>&nbsp;&nbsp;</span>"},{"title":"Comment","name":"data_3","leipiplugins":"textarea","value":"","orgrich":"1","orgfontsize":"","orgwidth":"300","orgheight":"80","style":"width: 316px; height: 139px;","content":"<textarea title=\"Comment\" name=\"data_3\" leipiplugins=\"textarea\" value=\"\" orgrich=\"1\" orgfontsize=\"\" orgwidth=\"300\" orgheight=\"80\" style=\"width: 316px; height: 139px;\"></textarea>"}]', N'<p><br/></p><p style="text-align: center;">姓名：{data_1}</p><p style="text-align: center;">天数：{data_2}</p><p style="text-align: center;">备注：{data_3}</p>', N'a4cffd58-7bac-498a-a327-58a644dfdd93', N'', N'0', N'2018-04-14 14:47:48.000', N'00000000-0000-0000-0000-000000000000', N'System', N'0', N'', N'0', N'49df1602-f5f3-4d52-afb7-3802da619558,6ba79766-faa0-4259-8139-a4a6d35784e0')
GO




-- ----------------------------
-- Records of [FlowInstanceOperationHistory]
-- ----------------------------
INSERT INTO [dbo].[FlowInstanceOperationHistory]  VALUES (N'0d605151-40d0-4aaa-8942-2392b55f12cf', N'6da79fdb-cad6-4ab8-83d4-fd14e4021c4b', N'【内部讨论】【2018-09-12 00:45】同意,备注：我准了', N'2018-09-12 00:45:15.000', N'00000000-0000-0000-0000-000000000000', N'超级管理员')
GO

INSERT INTO [dbo].[FlowInstanceOperationHistory]  VALUES (N'1419387b-22f0-4b67-bd51-5acdfb50a36c', N'3e42b844-d5d1-4fda-a27c-942755a3bd54', N'【所有人可审下】【2018-04-07 21:50】同意,备注：ok', N'2018-04-07 21:50:29.000', N'00000000-0000-0000-0000-000000000000', N'超级管理员')
GO

INSERT INTO [dbo].[FlowInstanceOperationHistory]  VALUES (N'3024727a-a422-4b68-b525-7e5f8723ab76', N'd8fa445f-edd9-4604-8d9e-b17ba921f9dd', N'【创建】超级管理员创建了一个流程进程【1523688313680/天气好，请个假】', N'2018-04-14 14:46:02.000', N'00000000-0000-0000-0000-000000000000', N'超级管理员')
GO

INSERT INTO [dbo].[FlowInstanceOperationHistory]  VALUES (N'5c5b8a37-973c-4786-9462-e343875b696d', N'e6566327-1a0e-4378-8f63-91acfa4722d2', N'【任何人可以审核】【2018-09-05 14:35】同意,备注：ok', N'2018-09-05 14:35:01.000', N'00000000-0000-0000-0000-000000000000', N'超级管理员')
GO

INSERT INTO [dbo].[FlowInstanceOperationHistory]  VALUES (N'6482670e-522e-418a-932b-b286395db758', N'd73e4412-9c49-4511-a30e-0d2f844afcee', N'【所有人都可以审】【2018-04-06 16:22】同意,备注：自己处理一下', N'2018-04-06 16:22:26.000', N'00000000-0000-0000-0000-000000000000', N'超级管理员')
GO

INSERT INTO [dbo].[FlowInstanceOperationHistory]  VALUES (N'6c0096f2-8e94-446a-b787-d15b7e4946ed', N'db026b5c-9f60-496d-a861-991327d975ab', N'【创建】超级管理员创建了一个流程进程【1536684129781/开发流程2018-09-12 00:42:32】', N'2018-09-12 00:43:17.000', N'00000000-0000-0000-0000-000000000000', N'超级管理员')
GO

INSERT INTO [dbo].[FlowInstanceOperationHistory]  VALUES (N'7d30165f-c6d4-4185-917b-fa9fb92ac134', N'6da79fdb-cad6-4ab8-83d4-fd14e4021c4b', N'【创建】超级管理员创建了一个流程进程【1536684129781/开发流程2018-09-12 00:43:34】', N'2018-09-12 00:44:24.000', N'00000000-0000-0000-0000-000000000000', N'超级管理员')
GO

INSERT INTO [dbo].[FlowInstanceOperationHistory]  VALUES (N'91404754-2d13-40f8-b2c8-dec8692bda92', N'35f9d541-ef0f-4b9b-9ffd-dfe933d47d1f', N'【所有人可审下】【2018-04-07 19:34】同意,备注：', N'2018-04-07 19:34:41.000', N'00000000-0000-0000-0000-000000000000', N'超级管理员')
GO

INSERT INTO [dbo].[FlowInstanceOperationHistory]  VALUES (N'97608015-8131-465b-b391-957ebd46ed62', N'35f9d541-ef0f-4b9b-9ffd-dfe933d47d1f', N'【创建】超级管理员创建了一个流程进程【1523002969474/再借个书】', N'2018-04-06 16:23:32.000', N'00000000-0000-0000-0000-000000000000', N'超级管理员')
GO

INSERT INTO [dbo].[FlowInstanceOperationHistory]  VALUES (N'aba0e717-69b8-4f37-9dde-1043a344dd0a', N'35f9d541-ef0f-4b9b-9ffd-dfe933d47d1f', N'【test审核】【2018-04-07 19:59】同意,备注：', N'2018-04-07 19:48:36.000', N'6ba79766-faa0-4259-8139-a4a6d35784e0', N'test')
GO

INSERT INTO [dbo].[FlowInstanceOperationHistory]  VALUES (N'ae8ab8e9-1efe-46d5-8362-152f4c9de091', N'35f9d541-ef0f-4b9b-9ffd-dfe933d47d1f', N'【admin审核】【2018-04-07 19:40】同意,备注：admin', N'2018-04-07 19:36:42.000', N'49df1602-f5f3-4d52-afb7-3802da619558', N'admin')
GO

INSERT INTO [dbo].[FlowInstanceOperationHistory]  VALUES (N'b1a893fd-d282-4b22-914d-9f148b627d0d', N'3e42b844-d5d1-4fda-a27c-942755a3bd54', N'【admin审核】【2018-04-07 21:51】同意,备注：签一个', N'2018-04-07 21:51:26.000', N'49df1602-f5f3-4d52-afb7-3802da619558', N'admin')
GO

INSERT INTO [dbo].[FlowInstanceOperationHistory]  VALUES (N'c05075e4-cd9c-4267-b960-1929019ed031', N'd8fa445f-edd9-4604-8d9e-b17ba921f9dd', N'【任何人可以审核】【2018-04-14 14:46】同意,备注：自己当然要通过啊', N'2018-04-14 14:46:35.000', N'00000000-0000-0000-0000-000000000000', N'超级管理员')
GO

INSERT INTO [dbo].[FlowInstanceOperationHistory]  VALUES (N'd3d8eb25-8d96-4fbd-b475-5dcc1569848b', N'e6566327-1a0e-4378-8f63-91acfa4722d2', N'【创建】超级管理员创建了一个流程进程【1523688457002/不想上班请个假】', N'2018-04-14 14:47:48.000', N'00000000-0000-0000-0000-000000000000', N'超级管理员')
GO

INSERT INTO [dbo].[FlowInstanceOperationHistory]  VALUES (N'e08346e5-af15-4638-976b-9fe1081527d2', N'3e42b844-d5d1-4fda-a27c-942755a3bd54', N'【创建】超级管理员创建了一个流程进程【1523107997554/111111111111】', N'2018-04-07 21:33:29.000', N'00000000-0000-0000-0000-000000000000', N'超级管理员')
GO

INSERT INTO [dbo].[FlowInstanceOperationHistory]  VALUES (N'f7e387b5-caa0-4cc1-ab0e-b5f81cd030d8', N'd73e4412-9c49-4511-a30e-0d2f844afcee', N'【创建】超级管理员创建了一个流程进程【1523002870978/我请个假】', N'2018-04-06 16:21:36.000', N'00000000-0000-0000-0000-000000000000', N'超级管理员')
GO

INSERT INTO [dbo].[FlowInstanceOperationHistory]  VALUES (N'fa53a997-ef42-47da-8fd5-806a1a939471', N'3e42b844-d5d1-4fda-a27c-942755a3bd54', N'【test审核】【2018-04-07 21:52】同意,备注：1111', N'2018-04-07 21:52:28.000', N'6ba79766-faa0-4259-8139-a4a6d35784e0', N'test')
GO


-- ----------------------------
-- Records of [FlowInstanceTransitionHistory]
-- ----------------------------
INSERT INTO [dbo].[FlowInstanceTransitionHistory]  VALUES (N'0d447267-50ab-4809-9315-674a2f07500d', N'6da79fdb-cad6-4ab8-83d4-fd14e4021c4b', N'1536683905671', N'3', N'node_1', N'1536683910415', N'2', N'内部讨论', N'0', N'0', N'2018-09-12 00:44:24.000', N'00000000-0000-0000-0000-000000000000', N'超级管理员')
GO

INSERT INTO [dbo].[FlowInstanceTransitionHistory]  VALUES (N'176ed6db-c9f8-4cae-8c5a-244b407d0c51', N'3e42b844-d5d1-4fda-a27c-942755a3bd54', N'1523002714678', N'3', N'node_1', N'1523002717150', N'2', N'所有人可审下', N'0', N'0', N'2018-04-07 21:33:29.000', N'00000000-0000-0000-0000-000000000000', N'超级管理员')
GO

INSERT INTO [dbo].[FlowInstanceTransitionHistory]  VALUES (N'48439b01-f1f3-4053-a575-3f56ecf3b5c7', N'e6566327-1a0e-4378-8f63-91acfa4722d2', N'1523688045356', N'2', N'任何人可以审核', N'1523688050220', N'0', N'会签开始（要包括所有会签节点的审核人）', N'0', N'0', N'2018-09-05 14:35:02.000', N'00000000-0000-0000-0000-000000000000', N'超级管理员')
GO

INSERT INTO [dbo].[FlowInstanceTransitionHistory]  VALUES (N'5c4cb1f3-9b09-4ac6-8e15-35c4adc8af9b', N'e6566327-1a0e-4378-8f63-91acfa4722d2', N'1523688043300', N'3', N'node_1', N'1523688045356', N'2', N'任何人可以审核', N'0', N'0', N'2018-04-14 14:47:48.000', N'00000000-0000-0000-0000-000000000000', N'超级管理员')
GO

INSERT INTO [dbo].[FlowInstanceTransitionHistory]  VALUES (N'7099b3cd-83fe-4e24-a57a-7dae93342eb7', N'db026b5c-9f60-496d-a861-991327d975ab', N'1536683905671', N'3', N'node_1', N'1536683910415', N'2', N'内部讨论', N'0', N'0', N'2018-09-12 00:43:17.000', N'00000000-0000-0000-0000-000000000000', N'超级管理员')
GO

INSERT INTO [dbo].[FlowInstanceTransitionHistory]  VALUES (N'736ef169-c9de-467a-80a8-9d1367459a1f', N'3e42b844-d5d1-4fda-a27c-942755a3bd54', N'1523002717150', N'2', N'所有人可审下', N'1523002732796', N'0', N'开始会签', N'0', N'0', N'2018-04-07 21:50:32.000', N'00000000-0000-0000-0000-000000000000', N'超级管理员')
GO

INSERT INTO [dbo].[FlowInstanceTransitionHistory]  VALUES (N'80754624-337e-45d9-9eb5-447439fe7785', N'd73e4412-9c49-4511-a30e-0d2f844afcee', N'1523002636766', N'2', N'所有人都可以审', N'1523002637238', N'2', N'admin审核', N'0', N'0', N'2018-04-06 16:22:26.000', N'00000000-0000-0000-0000-000000000000', N'超级管理员')
GO

INSERT INTO [dbo].[FlowInstanceTransitionHistory]  VALUES (N'd56d4393-3d77-4e15-bf74-1212087c0fc2', N'd8fa445f-edd9-4604-8d9e-b17ba921f9dd', N'1523688043300', N'3', N'node_1', N'1523688045356', N'2', N'任何人可以审核', N'0', N'0', N'2018-04-14 14:46:02.000', N'00000000-0000-0000-0000-000000000000', N'超级管理员')
GO

INSERT INTO [dbo].[FlowInstanceTransitionHistory]  VALUES (N'dbe4963d-c102-4fd1-9a43-2a7b489cda37', N'd8fa445f-edd9-4604-8d9e-b17ba921f9dd', N'1523688045356', N'2', N'任何人可以审核', N'1523688050220', N'0', N'会签开始（要包括所有会签节点的审核人）', N'0', N'0', N'2018-04-14 14:46:35.000', N'00000000-0000-0000-0000-000000000000', N'超级管理员')
GO

INSERT INTO [dbo].[FlowInstanceTransitionHistory]  VALUES (N'e756f09d-a7de-45e5-a865-9ce25617b4e0', N'd73e4412-9c49-4511-a30e-0d2f844afcee', N'1523002631942', N'3', N'node_1', N'1523002636766', N'2', N'所有人都可以审', N'0', N'0', N'2018-04-06 16:21:36.000', N'00000000-0000-0000-0000-000000000000', N'超级管理员')
GO

INSERT INTO [dbo].[FlowInstanceTransitionHistory]  VALUES (N'f1964787-519f-472f-96ec-423d99df783f', N'6da79fdb-cad6-4ab8-83d4-fd14e4021c4b', N'1536683910415', N'2', N'内部讨论', N'1536683913550', N'0', N'领导审批', N'0', N'0', N'2018-09-12 00:45:15.000', N'00000000-0000-0000-0000-000000000000', N'超级管理员')
GO

INSERT INTO [dbo].[FlowInstanceTransitionHistory]  VALUES (N'f29bd77f-9d63-4f2b-ada7-6ca57bc1d422', N'3e42b844-d5d1-4fda-a27c-942755a3bd54', N'1523002732796', N'0', N'开始会签', N'1523002726014', N'4', N'node_5', N'0', N'1', N'2018-04-07 21:52:28.000', N'6ba79766-faa0-4259-8139-a4a6d35784e0', N'test')
GO



-- ----------------------------
-- Records of [FlowScheme]
-- ----------------------------
INSERT INTO [dbo].[FlowScheme]  VALUES (N'ab86e5f3-2dfe-43a9-9b3d-6588eebd60ab', N'1552563549862', N'简单的请假流程', N'', N'', N'', N'{"title":"newFlow_1","nodes":[{"name":"node_1","left":64,"top":120,"type":"start round mix","id":"1552563568660","width":26,"height":26,"alt":true},{"name":"所有人都可以来批准下","left":179,"top":130,"type":"node","id":"1552563572075","width":127,"height":67,"alt":true,"setInfo":{"NodeDesignateData":{"users":[],"roles":[],"orgs":[]},"NodeName":"所有人都可以来批准下","NodeCode":"node_2","NodeRejectType":"0","NodeDesignate":"ALL_USER","NodeConfluenceType":"all"}},{"name":"领导来吧","left":378,"top":138,"type":"node","id":"1552563576302","width":104,"height":61,"alt":true,"setInfo":{"NodeDesignateData":{"users":["49df1602-f5f3-4d52-afb7-3802da619558"],"roles":[],"orgs":[]},"NodeName":"领导来吧","NodeCode":"node_3","NodeRejectType":"0","NodeDesignate":"SPECIAL_USER","NodeConfluenceType":"all"}},{"name":"node_4","left":411,"top":262,"type":"end round","id":"1552563578491","width":26,"height":26,"alt":true}],"lines":[{"type":"sl","from":"1552563568660","to":"1552563572075","id":"1552563580683","name":"","dash":false,"alt":true},{"type":"sl","from":"1552563572075","to":"1552563576302","id":"1552563583099","name":"","dash":false,"alt":true},{"type":"sl","from":"1552563576302","to":"1552563578491","id":"1552563584844","name":"","dash":false,"alt":true}],"areas":[],"initNum":9}', N'5dd8191f-5a18-4d66-aac0-fae52c0f3925', N'0', N'0', N'1', N'0', N'0', NULL, N'2019-03-14 19:40:48.330', N'', N'', N'2019-03-14 19:40:48.330', N'', N'')
GO

INSERT INTO [dbo].[FlowScheme]  VALUES (N'2b6c66bd-2146-4b0d-b165-d7d074347d36', N'1552565120125', N'带有会签的流程', N'', N'', N'', N'{"title":"newFlow_1","nodes":[{"name":"node_1","left":139,"top":164,"type":"start round mix","id":"1552565195760","width":26,"height":26,"alt":true},{"name":"所有人都可以审批的一步","left":242,"top":180,"type":"node","id":"1552565199679","width":104,"height":76,"alt":true,"setInfo":{"NodeConfluenceType":"all","NodeDesignate":"ALL_USER","NodeDesignateData":{"users":[],"roles":[]}}},{"name":"会签开始","left":486,"top":183,"type":"fork","id":"1552565203399","width":104,"height":36,"alt":true,"setInfo":{"NodeConfluenceType":"all","NodeDesignate":"ALL_USER","NodeDesignateData":{"users":[],"roles":[]}}},{"name":"test审核","left":388,"top":275,"type":"node","id":"1552565206055","width":104,"height":36,"alt":true,"setInfo":{"NodeConfluenceType":"all","NodeDesignate":"SPECIAL_USER","NodeDesignateData":{"users":["6ba79766-faa0-4259-8139-a4a6d35784e0"],"roles":[]}}},{"name":"admin审核","left":666,"top":284,"type":"node","id":"1552565206927","width":104,"height":56,"alt":true,"setInfo":{"NodeConfluenceType":"all","NodeDesignate":"SPECIAL_USER","NodeDesignateData":{"users":["49df1602-f5f3-4d52-afb7-3802da619558"],"roles":[]}}},{"name":"会签结束","left":537,"top":360,"type":"join","id":"1552565209287","width":104,"height":36,"alt":true,"setInfo":{"NodeConfluenceType":"all","NodeDesignate":"ALL_USER","NodeDesignateData":{"users":[],"roles":[]}}},{"name":"看看结果","left":323,"top":386,"type":"node","id":"1552565213759","width":104,"height":36,"alt":true,"setInfo":{"NodeConfluenceType":"all","NodeDesignate":"ALL_USER","NodeDesignateData":{"users":[],"roles":[]}}},{"name":"node_8","left":186,"top":385,"type":"end round","id":"1552565216879","width":26,"height":26,"alt":true}],"lines":[{"type":"sl","from":"1552565195760","to":"1552565199679","id":"1552565219982","name":"","dash":false,"alt":true},{"type":"sl","from":"1552565199679","to":"1552565203399","id":"1552565221519","name":"","dash":false,"alt":true},{"type":"sl","from":"1552565203399","to":"1552565206055","id":"1552565222911","name":"","dash":false,"alt":true},{"type":"sl","from":"1552565203399","to":"1552565206927","id":"1552565224527","name":"","dash":false,"alt":true},{"type":"sl","from":"1552565206055","to":"1552565209287","id":"1552565226023","name":"","dash":false,"alt":true},{"type":"sl","from":"1552565206927","to":"1552565209287","id":"1552565227519","name":"","dash":false,"alt":true},{"type":"sl","from":"1552565209287","to":"1552565213759","id":"1552565228942","name":"","dash":false,"alt":true},{"type":"sl","from":"1552565213759","to":"1552565216879","id":"1552565230654","name":"","dash":false,"alt":true}],"areas":[],"initNum":18}', N'5dd8191f-5a18-4d66-aac0-fae52c0f3925', N'0', N'0', N'0', N'0', N'0', N'会签用于需要多人同时处理的场景，比如所有人都通过，至少有一人通过等', N'2019-03-04 16:00:00.000', N'', N'', N'2019-03-14 20:15:57.767', N'', N'')
GO

INSERT INTO [dbo].[FlowScheme]  VALUES (N'04bfcff2-1290-4afd-b72e-51d22f89b478', N'1552565120125', N'带分支的流程', N'', N'', N'', N'{"title":"newFlow_1","nodes":[{"name":"node_1","left":167,"top":139,"type":"start round mix","id":"1552565857990","width":26,"height":26,"alt":true},{"name":"node_2","left":322,"top":146,"type":"node","id":"1552565859686","width":104,"height":26,"alt":true,"setInfo":{"NodeConfluenceType":"all","NodeDesignate":"ALL_USER","NodeDesignateData":{"users":[],"roles":[]}}},{"name":"请假天数大于3时到这来","left":519,"top":50,"type":"node","id":"1552565860798","width":104,"height":76,"alt":true,"setInfo":{"NodeConfluenceType":"all","NodeDesignate":"ALL_USER","NodeDesignateData":{"users":[],"roles":[]}}},{"name":"请假条件小于等于3时到这里","left":489,"top":239,"type":"node","id":"1552565861358","width":156,"height":75,"alt":true,"setInfo":{"NodeConfluenceType":"all","NodeDesignate":"ALL_USER","NodeDesignateData":{"users":[],"roles":[]}}},{"name":"node_5","left":751,"top":163,"type":"node","id":"1552565862622","width":104,"height":26,"alt":true},{"name":"node_6","left":895,"top":179,"type":"end round","id":"1552565865430","width":26,"height":26,"alt":true}],"lines":[{"type":"sl","from":"1552565857990","to":"1552565859686","id":"1552565868222","name":"","dash":false},{"type":"sl","from":"1552565859686","to":"1552565861358","id":"1552565869318","name":"","Compares":[{"FieldName":"data_1","Operation":"<=","Value":"3"}],"dash":false},{"type":"sl","from":"1552565859686","to":"1552565860798","id":"1552565870942","name":"","Compares":[{"FieldName":"data_1","Operation":">","Value":"3"}],"dash":false},{"type":"sl","from":"1552565860798","to":"1552565862622","id":"1552565872294","name":"","dash":false},{"type":"sl","from":"1552565861358","to":"1552565862622","id":"1552565873518","name":"","dash":false},{"type":"sl","from":"1552565862622","to":"1552565865430","id":"1552565875254","name":"","dash":false}],"areas":[],"initNum":14}', N'5dd8191f-5a18-4d66-aac0-fae52c0f3925', N'0', N'0', N'0', N'0', N'0', N'适用于连接上添加分支条件的场景，暂对企业版可用', N'2019-03-14 20:19:30.150', N'', N'', N'2019-03-14 20:19:47.960', N'', N'')
GO

-- ----------------------------
-- Records of [Form]
-- ----------------------------
INSERT INTO [dbo].[Form]  VALUES (N'5dd8191f-5a18-4d66-aac0-fae52c0f3925', N'简单的请假', N'0', N'', N'2', N'[{"leipiplugins":"select","name":"data_1","title":"请假天数","size":"1","style":"width: 150px;","orgwidth":"150","value":"1,3,5,10","content":"<span leipiplugins=\"select\"><select name=\"data_1\" title=\"请假天数\" leipiplugins=\"select\" size=\"1\" style=\"width: 150px;\" orgwidth=\"150\"><option value=\"1\">1</option><option value=\"3\">3</option><option value=\"5\">5</option><option value=\"10\">10</option></select>&nbsp;&nbsp;</span>"},{"name":"data_2","type":"text","title":"姓名","value":"李玉宝","leipiplugins":"text","orghide":"0","style":"text-align: left; width: 150px;","orgalign":"left","orgwidth":"150","orgtype":"text","content":"<input name=\"data_2\" type=\"text\" title=\"姓名\" value=\"李玉宝\" leipiplugins=\"text\" orghide=\"0\" style=\"text-align: left; width: 150px;\" orgalign=\"left\" orgwidth=\"150\" orgtype=\"text\"/>"}]', N'<p><br/>请假</p><p>尊敬的领导：</p><p>&nbsp;&nbsp;&nbsp; 最近身体不好，想请{data_1}天假，望批准！</p><p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 请假人：{data_2}</p>', N'<p><br/>请假</p><p>尊敬的领导：</p><p>&nbsp;&nbsp;&nbsp; 最近身体不好，想请{|-<span leipiplugins="select"><select name="data_1" title="请假天数" leipiplugins="select" size="1" style="width: 150px;" orgwidth="150"><option value="1">1</option><option value="3">3</option><option value="5">5</option><option value="10">10</option></select>&nbsp;&nbsp;</span>-|}天假，望批准！</p><p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 请假人：<input name="data_2" type="text" title="姓名" value="李玉宝" leipiplugins="text" orghide="0" style="text-align: left; width: 150px;" orgalign="left" orgwidth="150" orgtype="text"/></p>', N'1', N'0', NULL, N'0', N'基于动态表单生成的，适用于不需要复杂交互的场景', N'2019-03-14 19:35:48.820', N'', N'', N'2019-03-14 19:35:48.820', N'', N'')
GO

INSERT INTO [dbo].[Form]  VALUES (N'5e072661-a1c1-4b38-a552-e28f308da329', N'复杂的请假条', N'1', N'FrmLeaveReq', N'0', N'', N'', N'', N'0', N'0', N'', N'0', N'基于开发者自己开发的表单页面，暂时支持企业版！', N'2019-03-14 19:50:01.753', N'', N'', N'2019-03-14 19:50:01.753', N'', N'')
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

INSERT INTO [dbo].[Relevance]  VALUES (N'120d7a5d-203c-4261-95f5-0125757fb386', N'', N'UserElement', N'0', N'2016-10-20 17:01:01.000', N'0', N'3a95e392-07d4-4af3-b30d-140ca93340f5', N'7f071c63-1620-4486-9264-5806b2e63218', NULL, NULL)
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

INSERT INTO [dbo].[Relevance]  VALUES (N'226da45c-55b7-4294-b5f0-bb374434cc1e', N'', N'RoleDataProperty', N'0', N'2019-01-08 02:23:32.000', N'', N'0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', N'Category', N'Id', N'')
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

INSERT INTO [dbo].[Relevance]  VALUES (N'2c26d7e7-34ba-4807-a9e9-52cdb48ee36d', N'', N'RoleModule', N'0', N'2019-01-08 02:23:27.000', N'', N'0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', N'9486ff22-b696-4d7f-8093-8a3e53c45453', N'', N'')
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

INSERT INTO [dbo].[Relevance]  VALUES (N'31990e1e-0478-44c7-94f1-6c749a18ac29', N'', N'RoleElement', N'0', N'2019-01-08 02:23:27.000', N'', N'0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', N'2d595a2a-5de5-479e-a331-b53c799a6b10', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'332a373c-f485-4f85-9af9-7792f7462bf1', N'', N'RoleModule', N'0', N'2016-09-02 17:03:47.000', N'0', N'648b04c4-4ac2-4d69-bef6-07081ef27871', N'89c3bfbe-246f-4112-8eb1-b6789da54202', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'340c60fe-8b95-474c-aa04-9197903998d2', N'', N'RoleModule', N'0', N'2016-09-04 23:20:34.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'7580672f-a390-4bb6-982d-9a4570cb5199', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'361feb63-bde2-49c7-86ec-6df3ec6f0fe3', N'', N'RoleElement', N'0', N'2016-09-04 23:21:13.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'1c870438-4260-43a5-8996-a6e1dc8bbf6a', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'386d6cb7-c465-422c-974f-3250b0e4888f', N'', N'UserOrg', N'0', N'2018-09-12 00:10:35.000', N'', N'6ba79766-faa0-4259-8139-a4a6d35784e0', N'08f41bf6-4388-4b1e-bd3e-2ff538b44b1b', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'392dc41e-7186-4efb-a8e5-b5317e4122fb', N'', N'RoleResource', N'0', N'2018-09-10 12:54:14.000', N'', N'0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', N'OPENAUTH_DELETEACCOUNT', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'3bcaab20-e096-480e-a9bb-0fdb70686714', N'', N'RoleElement', N'0', N'2016-09-04 23:21:00.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'cf7388be-2677-427c-ad78-8f00f1062b96', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'3de0359b-6331-4dc7-a00e-751f71dbadb5', N'', N'ProcessUser', N'0', N'2016-09-28 09:23:30.000', N'0', N'68295d2a-4dfd-4c5e-81e3-9c787e2603bc', N'3b64b643-cb9a-4654-81e4-6dd9b2f8a6f7', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'416d027c-87bc-408b-a69c-92ebec1d02c1', N'', N'RoleElement', N'0', N'2019-01-08 02:23:27.000', N'', N'0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', N'584c7a3b-d28a-47b4-8648-7797d05d83d1', N'', N'')
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

INSERT INTO [dbo].[Relevance]  VALUES (N'4ec328bc-5dbf-4e23-85bd-d4ef9299ea8d', N'', N'RoleModule', N'0', N'2019-01-08 02:23:27.000', N'', N'0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', N'a94d5648-c2a9-405e-ba6f-f1602ec9b807', N'', N'')
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

INSERT INTO [dbo].[Relevance]  VALUES (N'5a20d59c-6ee6-4fe2-98fe-7b35b11026ae', N'', N'UserElement', N'0', N'2016-09-07 15:30:20.000', N'0', N'3b64b643-cb9a-4654-81e4-6dd9b2f8a6f7', N'68484265-7802-4f06-b024-33e8b2f2edcf', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'5a86259a-9555-4aa7-be8d-a874f88b66a8', N'', N'RoleModule', N'0', N'2019-01-08 02:22:31.000', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'9486ff22-b696-4d7f-8093-8a3e53c45453', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'5b0ec87e-3465-48c2-98da-e4c28a6f8f34', N'', N'RoleElement', N'0', N'2019-01-08 02:22:32.000', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'b3e23ebc-0ff2-41b3-bff0-fd5e93f6828a', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'5b1bd6e9-49d2-4b29-83b4-168622fc49e8', N'', N'RoleModule', N'0', N'2019-01-08 02:23:27.000', N'', N'0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', N'7580672f-a390-4bb6-982d-9a4570cb5199', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'5b2d5db8-d603-4be3-add2-c85ef3c53ddc', N'', N'UserResource', N'0', N'2018-04-14 14:38:05.000', N'', N'49df1602-f5f3-4d52-afb7-3802da619558', N'OPENAUTH_LOGIN', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'5ccce632-f8f0-452b-8faf-4a5372004e85', N'', N'RoleResource', N'0', N'2018-09-12 00:15:54.000', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'XXX_CHECKUSER', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'620b368a-7b56-4c74-ab85-8bc91d08ddc9', N'', N'RoleElement', N'0', N'2016-09-04 23:20:42.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'1c9acc3e-a40d-4d07-b495-6e60eb9b71b9', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'62db1791-ff90-4f32-b835-b9850d354baa', N'', N'RoleDataProperty', N'0', N'2019-01-08 02:23:32.000', N'', N'0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', N'Category', N'Name', N'')
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

INSERT INTO [dbo].[Relevance]  VALUES (N'6645b6fb-efcf-4e48-9c13-84f79bc5be34', N'', N'RoleOrg', N'0', N'2018-04-14 13:16:45.000', N'', N'77e6d0c3-f9e1-4933-92c3-c1c6eef75593', N'86449128-d5ac-44bf-b999-f7735b7458fd', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'66e25fc5-093d-42ab-85dc-a38f6600889b', N'', N'UserOrg', N'0', N'2016-09-02 13:57:32.000', N'0', N'ea25646b-964b-4d41-ab03-d8964e1494fb', N'c36e43df-3a99-45da-80d9-3ac5d24f4014', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'67a5ec12-060f-44bc-9cde-c7ebaab17b6b', N'', N'RoleModule', N'0', N'2019-01-08 02:23:27.000', N'', N'0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', N'069475e3-c997-487a-9f29-e6a864c5c1d4', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'68912e65-256e-45b6-b48e-036382598d32', N'', N'RoleOrg', N'0', N'2016-10-17 10:03:49.000', N'0', N'2eb423d6-6ad9-4efe-b423-872478a2a434', N'990cb229-cc18-41f3-8e2b-13f0f0110798', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'6b9c4789-042c-4f6f-a749-ee68ee87462d', N'', N'ProcessUser', N'0', N'2016-10-27 16:47:52.000', N'0', N'054ff054-d8ae-4911-a596-8fb1f66b348f', N'3a95e392-07d4-4af3-b30d-140ca93340f5', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'6da6d662-8cef-47cd-80b3-fa885b2dca7a', N'', N'RoleOrg', N'0', N'2018-04-14 13:16:45.000', N'', N'77e6d0c3-f9e1-4933-92c3-c1c6eef75593', N'990cb229-cc18-41f3-8e2b-13f0f0110798', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'6db5666b-6f8c-4e83-bada-0b45054bd9a4', N'', N'RoleElement', N'0', N'2016-09-04 23:20:42.000', N'0', N'db309d88-fd21-4b81-a4d9-ae6276a1d813', N'0d25438e-1436-48e0-aedf-0f1690693282', NULL, NULL)
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

INSERT INTO [dbo].[Relevance]  VALUES (N'80449de2-0cac-46eb-a234-e55b3c2bc39b', N'', N'RoleElement', N'0', N'2019-01-08 02:23:27.000', N'', N'0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', N'1a473afd-cbd4-41e9-9471-81f9435aaabe', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'832f4a8f-7791-4aa6-bcd2-20dcb6f5ef37', N'', N'UserElement', N'0', N'2016-09-02 14:53:04.000', N'0', N'3a95e392-07d4-4af3-b30d-140ca93340f5', N'15a4f88c-4fae-4cab-ba2f-0cbd2cca8736', NULL, NULL)
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

INSERT INTO [dbo].[Relevance]  VALUES (N'ac2bd409-b361-4489-9806-0e05a020fe8b', N'', N'RoleElement', N'0', N'2019-01-08 02:23:27.000', N'', N'0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', N'816b12b3-e916-446d-a2fa-329cfd13c831', N'', N'')
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

INSERT INTO [dbo].[Relevance]  VALUES (N'c9bb01ca-635b-40d2-bc88-4035da43f79e', N'', N'RoleElement', N'0', N'2019-01-08 02:23:27.000', N'', N'0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', N'84e38920-f6e5-499c-bf52-a3c6f8499ff7', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'd22b89f8-50d1-4816-9bb2-576ea49d9245', N'', N'RoleElement', N'0', N'2019-01-08 02:22:32.000', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'68484265-7802-4f06-b024-33e8b2f2edcf', N'', N'')
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'd697371d-9dee-41bc-825f-4c64323fafee', N'', N'RoleElement', N'0', N'2019-01-08 02:23:27.000', N'', N'0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', N'68484265-7802-4f06-b024-33e8b2f2edcf', N'', N'')
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

INSERT INTO [dbo].[Relevance]  VALUES (N'ee1986a0-24cc-4dec-b5f5-68ef959ab650', N'', N'UserElement', N'0', N'2018-04-06 14:50:40.000', N'', N'49df1602-f5f3-4d52-afb7-3802da619558', N'79dcd3eb-3aaf-4e08-83c9-713d8ff446fe', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'ee4f39fd-4fbf-4f68-9a70-d6c7d7db9723', N'', N'ProcessUser', N'0', N'2016-10-31 11:52:39.000', N'0', N'b8bcdf59-1e29-4d97-a364-12ac8e8c5c61', N'3a95e392-07d4-4af3-b30d-140ca93340f5', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'eec41fcb-61c0-4e56-a5c0-a9f8be6e6fdc', N'', N'UserModule', N'0', N'2016-09-07 15:30:06.000', N'0', N'3b64b643-cb9a-4654-81e4-6dd9b2f8a6f7', N'069475e3-c997-487a-9f29-e6a864c5c1d4', NULL, NULL)
GO

INSERT INTO [dbo].[Relevance]  VALUES (N'f03f503b-3898-44a0-a588-3ba4e27b72d5', N'', N'RoleDataProperty', N'0', N'2019-01-08 02:23:02.000', N'', N'09ee2ffa-7463-4938-ae0b-1cb4e80c7c13', N'Category', N'Id', N'')
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

INSERT INTO [dbo].[Relevance]  VALUES (N'feb2809b-ee42-4fbd-86d1-68a3d762f590', N'', N'RoleElement', N'0', N'2019-01-08 02:23:27.000', N'', N'0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d', N'c3d7b478-21e9-4c1e-b866-a3c80be7909b', N'', N'')
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

