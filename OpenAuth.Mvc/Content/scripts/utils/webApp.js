var app = angular.module('webAppDesign', [])
.run(['$rootScope', '$lrfnRequest', '$lrmDesigner', function ($rootScope, $lrfnRequest, $lrmDesigner) {
    $rootScope.windowWidth = $lrfnRequest("windowWidth");

    $rootScope.windowHeight = $lrfnRequest("windowHeight") - 41;
    var _projectId = $lrfnRequest("projectId");
    $rootScope.designer = $lrmDesigner.init(_projectId);
}])
.controller('lrAppCtrl', ['$rootScope', '$scope', '$lrGetIframe', function ($rootScope, $scope, $lrGetIframe) {
    $scope.pageTemplates = $rootScope.designer.templates.getPageTemps();
    $scope.addPage = $rootScope.designer.addPage;
    $scope.btnSaveProject = $rootScope.designer.saveProject;
    //$scope.isTabsAdded = true;


    //加载完成开始初始化
    $rootScope.$on('iframeLoaded', function (event) {
        $rootScope.designer.vm.isBeginView = true;
        $lrGetIframe('phoneDIndex').doBroadcast('init', $rootScope.designer.currentPage);
        $scope.$apply();
    });
}])
//用来设置窗口大小
.controller('lrAppMidbarCtrl', ['$scope', '$rootScope', function ($scope, $rootScope) {
    var phoneHeight = 765.284, phoneWidth = 387.578;
    var iframeH = 568, iframeW = 320, iframeMT = 84.9764;

    $scope.phoneScale = '1';
    $scope.phoneHeight = phoneHeight + 'px';
    $scope.phoneWidth = +phoneWidth + 'px';

    $scope.phoneIframeH = iframeH + 'px';
    $scope.phoneIframeW = iframeW + 'px';
    $scope.phoneIframeMT = iframeMT + 'px';

    $scope.marginTop = (($rootScope.windowHeight - phoneHeight - 82) / 2 > 0 ? ($rootScope.windowHeight - phoneHeight - 82) / 2 : 0) + "px";
    $scope.changePhoneScale = function () {
        var _height = parseFloat($scope.phoneScale) * phoneHeight;
        $scope.phoneHeight = _height + 'px';
        $scope.phoneWidth = parseFloat($scope.phoneScale) * phoneWidth + 'px';
        $scope.marginTop = (($rootScope.windowHeight - _height - 82) / 2 > 0 ? ($rootScope.windowHeight - _height - 82) / 2 : 0) + "px";

        $scope.phoneIframeH = parseFloat($scope.phoneScale) * iframeH + 'px';
        $scope.phoneIframeW = parseFloat($scope.phoneScale) * iframeW + 'px';
        $scope.phoneIframeMT = parseFloat($scope.phoneScale) * iframeMT + 'px';
    };
}])
/*扩展标签属性*/
.directive("lrappComponents", ["$rootScope", "$lrmComponents", function ($rootScope, $lrmComponents) {
    return {
        restrict: "E",
        replace: true,
        template: '<div ng-repeat="component in $root.componentGroups" class="lr-item-row lr-component" data-value="{{component.id}}"><i class="fa {{component.icon}}"></i>{{component.text}}</div>',
        link: function (scope, element, attr) {
            $rootScope.componentGroups = $lrmComponents.all();
        }
    }
}])
.directive("lrappPagetree", ["$rootScope", function ($rootScope) {
    return {
        restrict: "E",
        require: '?ngModel',
        replace: true,
        template: '<div></div>',
        link: function (scope, element, attr, ngModel) {
            if (!ngModel)
            {
                return;
            }
            ngModel.$render = function () {
                ngModel.$viewValue(element);
            }
        }
    }
}])
.directive('lrappBox', function () {
    return {
        restrict: 'E',
        replace: true,
        transclude: true,
        template:
        '<div class="lr-box expanded">' +
        '<h4 class="lr-box-toggle"></h4>' +
        '<div class="lr-box-content" ng-transclude></div>' +
        '</div>',
        link: function (scope, element, attr) {
            var toggle = element.find('.lr-box-toggle');
            element.find('h4').html('<span class="caret"></span>' + attr.name);
            toggle.on('click', function () {
                if (element.is('.expanded')) {
                    element.removeClass('expanded');
                }
                else {
                    element.addClass('expanded');
                }
            });
        }
    };
})
.directive("lrappToggleb", ["$rootScope", function (e) {
    return {
        restrict: "E",
        require: '?ngModel',
        template: '<span class="left-text"></span><div class="track"><div class="handle"></div></div><span class="right-text" ></span>',
        link: function (scope, element, attr, ngModel) {
            ngModel.$render = function () {
                if (ngModel.$viewValue) {
                    element.addClass("active");
                }
            };
            element.on("click", function () {
                scope.$apply(cgValue);
            });

            function cgValue() {
                element.addClass("animate");
                var flag = element.is(".active");
                if (flag) {
                    element.removeClass("active");
                }
                else {
                    element.addClass("active");
                }
                ngModel.$setViewValue(!flag);
            }
        }
    }
}])
.directive('lrappColorPicker', function () {
    return {
        restrict: "E",
        replace: true,
        template: '<div class="input-append color" data-form="colorpicker" data-color="#ffffff" data-color-format="hex">' +
                '<span class="add-on"><i style="background-color: #ffffff"></i></span>' +
                '<input type="text" value="#ffffff" />' +
                '</div>',
        link: function (scope, element, attr) {

            if (attr.value) {
                attr.color = attr.value;
                element.find('i').css('background-color', attr.value);
                element.find('input').val(attr.value);
            }
            element.colorpicker();

        }
    }
})
/*数据模型*/
.factory('$lrmComponents', ['$rootScope', function ($rootScope) {//组件类型
    var _doRemove = function (data) {
        var components = $rootScope.designer.currentPage.ChildNodes;

        components.splice(components.indexOf(data), 1);
        $rootScope.designer.templates.fnPageTree.refresh();
        $rootScope.designer.currentPage = $rootScope.designer.templates.getHasTemps()[0];
        $rootScope.designer.currentFocus = $rootScope.designer.templates.getHasTemps()[0];
        $rootScope.designer.doPhoneBroadcast(appBroadcastCode.cgSelectTemplatePage, { "cmd": "removeComponent", object: $rootScope.designer.templates.getHasTemps()[0] });
        $.webappDesigner.attributes($rootScope.designer);
    }

    var components = [
        {
            id: "lrHeader",
            text: "标题",
            icon: "fa-header",
            setValue: function (name, value, data) {
                switch (name) {
                    case "text":
                        if (data.text != value) {
                            data.text = value;
                            data.attr.text = value;
                            $rootScope.designer.doPhoneBroadcast(appBroadcastCode.cgAttr, { "cmd": "componentAttr", "attrName": 'text', "object": data });
                            $rootScope.designer.templates.fnPageTree.refreshNode(data.id, data.text);
                        }
                        break;
                    case "size":
                        if (data.attr.size != value) {
                            data.attr.size = value;
                            $rootScope.designer.doPhoneBroadcast(appBroadcastCode.cgAttr, { "cmd": "componentAttr", "attrName": 'size', "object": data });
                        }
                        break;
                    case "weightSize":
                        if (data.attr.weight.size != value) {
                            data.attr.weight.size = value;
                            $rootScope.designer.doPhoneBroadcast(appBroadcastCode.cgAttr, { "cmd": "componentAttr", "attrName": 'weightSize', "object": data });
                        }
                    case "italic":
                        if (data.attr.weight.isItalic != value) {
                            data.attr.weight.isItalic = value;
                            $rootScope.designer.doPhoneBroadcast(appBroadcastCode.cgAttr, { "cmd": "componentAttr", "attrName": 'isItalic', "object": data });
                        }
                        break;
                    case "color":
                        if (data.attr.color != value) {
                            data.attr.color = value;
                            $rootScope.designer.doPhoneBroadcast(appBroadcastCode.cgAttr, { "cmd": "componentAttr", "attrName": 'color', "object": data });
                        }
                        break;
                    case "align":
                        if (data.attr.align != value) {
                            data.attr.align = value;
                            $rootScope.designer.doPhoneBroadcast(appBroadcastCode.cgAttr, { "cmd": "componentAttr", "attrName": 'align', "object": data });
                        }
                        break;
                }
            },
        },
        {
            id: "lrParagraph",
            text: "段落",
            icon: "fa fa-align-left",
            setValue: function (name, value, data) {
                if (data.attr[name] != value) {
                    data.attr[name] = value;
                    $rootScope.designer.doPhoneBroadcast(appBroadcastCode.cgAttr, { "cmd": "componentAttr", "attrName": name, "object": data });
                }
            }
        },
        //{ id: "lrBtnBar", text: "按钮组", icon: "fa fa-th-large" },
        {
            id: "lrBtn",
            text: "按钮",
            icon: "fa fa-square",
            setValue: function (name, value, data) {
                switch (name) {
                    case "link":
                        if (data.attr.link != value)
                        {
                            data.attr.link = value;
                        }
                        break;
                    case "text":
                        if (data.attr.text != value) {
                            data.attr.text = value;
                            data.text = value;
                            $rootScope.designer.doPhoneBroadcast(appBroadcastCode.cgAttr, { "cmd": "componentAttr", "attrName": 'text', "object": data });
                            $rootScope.designer.templates.fnPageTree.refreshNode(data.id, data.text);
                        }
                        break;
                    case "weightSize":
                    case "italic":
                        if (data.attr.weight[name] != value) {
                            data.attr.weight[name] = value;
                            $rootScope.designer.doPhoneBroadcast(appBroadcastCode.cgAttr, { "cmd": "componentAttr", "attrName": name, "object": data });
                        }
                        break;
                    case "size": 
                    case "color":
                    case "align":
                    case "btnType":
                    case "btnTheme":
                    case "btnSize":
                        if (data.attr[name] != value) {
                            data.attr[name] = value;
                            $rootScope.designer.doPhoneBroadcast(appBroadcastCode.cgAttr, { "cmd": "componentAttr", "attrName": name, "object": data });
                        }
                        break;
                }
            },
        },
        {
            id: "lrInput",
            text: "文本框",
            icon: "fa fa-italic",
            setValue: function (name, value, data) {
                if (data.attr[name] != value) {
                    data.attr[name] = value;
                    $rootScope.designer.doPhoneBroadcast(appBroadcastCode.cgAttr, { "cmd": "componentAttr", "attrName": name, "object": data });
                }
            }
        },
        {
            id: "lrList3",
            text: "列表类型一",
            icon: "fa fa-th-list",
            setValue: function (name, value, data) {
                if (data.attr[name] != value) {
                    data.attr[name] = value;
                    $rootScope.designer.doPhoneBroadcast(appBroadcastCode.cgAttr, { "cmd": "componentAttr", "attrName": name, "object": data });
                }
            }
        },
        {
            id: "lrList4",
            text: "列表类型二",
            icon: "fa fa-list-ul",
            setValue: function (name, value, data) {
                if (data.attr[name] != value) {
                    data.attr[name] = value;
                    $rootScope.designer.doPhoneBroadcast(appBroadcastCode.cgAttr, { "cmd": "componentAttr", "attrName": name, "object": data });
                }
            }
        }
        //{ id: "lrTextarea", text: "文本区", icon: "fa fa-align-justify" }
    ];
    return {
        all: function () {
            return components;
        },
        getOne:function(id){
            for(var i in components)
            {
                if (components[i].id == id)
                {
                    return components[i];
                }
            }
        },
        doRemove: _doRemove
    };
}])
.factory('$lrmTemplates', ['$rootScope', '$lrfnGuid', '$lrdialogTop', function ($rootScope, $lrfnGuid, $lrdialogTop) {//模板类型(树形菜单)
    /*设置空白页的属性的方法*/
    var setBlankPageValue = function (name, value, data) {
        switch (name) {
            case "text":
                if (data.text != value) {
                    data.text = value;
                    $rootScope.designer.doPhoneBroadcast(appBroadcastCode.cgAttr, { "cmd": "pageText", "value": value });
                    refreshTreeNode(data.id, data.text);
                }
                break;
            case "routing":
                if (data.attr.routing != value)
                {
                    data.attr.routing = value;
                }
                break;
            case "bgColor":
                if (data.attr.bgColor != value)
                {
                    data.attr.bgColor = value;
                    $rootScope.designer.doPhoneBroadcast(appBroadcastCode.cgAttr, { "cmd": "pageBgColor", "value": value });
                }
                break;
            case "isTabed":
                if (data.attr.isTabed != value) {
                    data.attr.isTabed = value;
                }
                break;
            case "isPadding":
                if (data.attr.isPadding != value) {
                    data.attr.isPadding = value;
                    $rootScope.designer.doPhoneBroadcast(appBroadcastCode.cgAttr, { "cmd": "pageIsPadding", "value": value });
                }
                break;
            case "isHeadHide":
                if (data.attr.isHeadHide != value) {
                    data.attr.isHeadHide = value;
                    $rootScope.designer.doPhoneBroadcast(appBroadcastCode.cgAttr, { "cmd": "pageIsHeadHide", "value": value });
                }
                break;
        }
    };

    var pageTemplates = [{//页面模板
        value: "lrPageBlank",
        text: "页面",
        png: "../../Content/webApp/img/template-blank.png",
        img: "fa fa-file-o",
        hasChildren: false,
        isexpand: false,
        parentnodes: "0",
        attr: {
            value: 'lrPageBlank',
            type: 'page',
            routing: '/',
            bgColor: '#ffffff',
            isTabed: 'true',
            isPadding: 'true',
            isHeadHide: 'false',
            isFirst:false
        },
        setValue: setBlankPageValue,
        doButton: function (data) {
            if (hasTemplates.length > 1) {
                hasTemplates.splice(hasTemplates.indexOf(data), 1);
                refreshTree();
                $rootScope.designer.currentPage = hasTemplates[0];
                $rootScope.designer.currentFocus = hasTemplates[0];
                $rootScope.designer.doPhoneBroadcast(appBroadcastCode.cgSelectTemplatePage, { "cmd": "removePage", object: hasTemplates[0] });
                $.webappDesigner.attributes($rootScope.designer);
            }
            else {
                $lrdialogTop('必须保留一个页面', 'error');
            }
        },
        type:"page"
    }];
    var hasTemplates = [];
    
    /*刷新模板树*/
    function refreshTree(id) {
        var _id = "";
        if ($rootScope.pageTree != undefined) {
            $rootScope.pageTree.treeview({
                data: hasTemplates,
                isTool: true,
                nodeTools: [{ text: '删除', img: 'fa fa-trash-o' },
                    { text: '复制', img: 'fa fa-clone' },
                    {
                        text: '标记默认页',
                        img: 'fa fa-thumb-tack',
                        node:"page",
                        callback: function (id) {
                            for (var i in hasTemplates)
                            {
                                hasTemplates[i].attr.isFirst = false;
                                if (hasTemplates[i].id == id)
                                {
                                    hasTemplates[i].attr.isFirst = true;
                                    $rootScope.pageTree.refreshNodeIcon(id, "fa fa-yahoo", ".fa-yahoo");
                                }
                            }
                        }
                    }],
                onnodeclick: function (item) {
                    treeNotChecked();
                    var _currentPage = $rootScope.designer.currentPage;
                    var _currentFocus = $rootScope.designer.currentFocus;
                    if (_currentFocus.id != item.id) {
                        $rootScope.designer.currentFocus = item;
                        if (item.parentnodes == "0")//说明是页面
                        {
                            $rootScope.designer.currentPage = item;
                            $rootScope.designer.doPhoneBroadcast(appBroadcastCode.cgSelectTemplatePage, { "cmd": "selectPage", "object": item });
                        }
                        else {
                            if (item.parentnodes != _currentPage.id) {
                                for (var i in hasTemplates) {
                                    var _page = hasTemplates[i];
                                    if (_page.id == item.parentnodes) {
                                        $rootScope.designer.currentPage = _page;
                                        break;
                                    }
                                }
                            }
                            $rootScope.designer.doPhoneBroadcast(appBroadcastCode.cgSelectTemplatePage, { "cmd": "selectComponent", "object": item, "currentPage": $rootScope.designer.currentPage });
                        }
                        $.webappDesigner.attributes($rootScope.designer);
                    }
                }
            });
            if (id == undefined) {
                _id = hasTemplates[0].id
            }
            else {
                _id = id;
            }
            $rootScope.pageTree.setNodeChecked(_id);
            treeNotChecked();

            for (var i in hasTemplates) {
                if (hasTemplates[i].attr.isFirst == true) {
                    $rootScope.pageTree.refreshNodeIcon(hasTemplates[i].id, "fa fa-yahoo", ".fa-yahoo");
                    break;
                }
            }
        }
    }
    function refreshTreeNode(nodeId,text)
    {
        $rootScope.pageTree.refreshNode(nodeId, text);
    }


    /*设置tabs的属性的方法*/
    var setTabsValue = function (name, value, data) {
        switch (name) {
            case "bgColor":
                if (data.attr.bgColor != value) {
                    data.attr.bgColor = value;
                    $rootScope.designer.doPhoneBroadcast(appBroadcastCode.cgAttr, { "cmd": "tabsBgColor", "value": value });
                }
                break;
            case "iconColor":
                if (data.attr.iconColor != value) {
                    data.attr.iconColor = value;
                    $rootScope.designer.doPhoneBroadcast(appBroadcastCode.cgAttr, { "cmd": "tabsIconColor", "value": value });
                }
            case "iconType":
                if (data.attr.iconType != value) {
                    data.attr.iconType = value;
                    $rootScope.designer.doPhoneBroadcast(appBroadcastCode.cgAttr, { "cmd": "tabsIconType", "value": value });
                }
                break;
        }
    };
    /*设置tab属性*/
    var setTabValue = function (name, value, data) {
        switch (name)
        {
            case "text":
                if (data.attr.text != value)
                {
                    data.attr.text = value;
                    $rootScope.designer.doPhoneBroadcast(appBroadcastCode.cgAttr, { "cmd": "tabText", "value": value });
                    $rootScope.tabsTree.refreshNode(data.id, value);
                }
                break;
            case "iconOn":
                if (data.attr.iconOn != value) {
                    data.attr.iconOn = value;
                    $rootScope.designer.doPhoneBroadcast(appBroadcastCode.cgAttr, { "cmd": "tabIconOn", "value": value });
                }
                break;
            case "iconOff":
                if (data.attr.iconOff != value) {
                    data.attr.iconOff = value;
                    $rootScope.designer.doPhoneBroadcast(appBroadcastCode.cgAttr, { "cmd": "tabIconOff", "value": value });
                }
                break;
            case "innerTabPage":
                if (data.attr.lrInnerTabPage != value) {
                    data.attr.lrInnerTabPage = value;
                }
                break;

        }
    }
    /*删除tab*/
    var removeTab = function (data)
    {
        if (hasTabsTemplates[0].ChildNodes.length > 1) {
            hasTabsTemplates[0].ChildNodes.splice(hasTabsTemplates[0].ChildNodes.indexOf(data), 1);
            refreshTabsTree();
            focusTabsNode(hasTabsTemplates[0].ChildNodes[0].id);
            $rootScope.designer.doPhoneBroadcast(appBroadcastCode.doTabTemplate, { "cmd": "removeTab", id: hasTabsTemplates[0].ChildNodes[0].id });
        }
        else {
            $lrdialogTop('Tab不能全部删除', 'error');
        }
    }
    /*tabs树*/
    var tabTemplate = {
        text: "Tab页",
        img: "fa fa-cube",
        hasChildren: false,
        isexpand: false,
        parentnodes: "lrTabs",
        attr: {
            value: "lrTab",
            iconOn: "ion-ios-home",
            iconOff: "ion-ios-home-outline",
            innerTabPage: "DefaultPage",
        },
        setValue: setTabValue,
        doButton: removeTab
    };

    var hasTabsTemplates = [
        {
            id:"lrTabs",//页面模板
            value: "lrTabs",
            text: "Tabs控制器",
            img: "fa fa-sitemap",
            hasChildren: true,
            isexpand: true,
            parentnodes: "0",
            attr: {
                type: 'tabs',
                value: 'lrTabs',
                bgColor: 'stable',
                iconColor: "dark",
                iconType:"top"
            },
            setValue: setTabsValue,
            doButton: function () {
                var _dst = angular.copy(tabTemplate);
                _dst.id = $lrfnGuid();
                hasTabsTemplates[0].ChildNodes.push(_dst);
                refreshTabsTree();
                focusTabsNode(_dst.id);
                $rootScope.designer.doPhoneBroadcast(appBroadcastCode.doTabTemplate, { "cmd": "addTab", id: _dst.id });
            }
        }];
    function refreshTabsTree()
    {
        if ($rootScope.tabsTree != undefined) {
            $rootScope.tabsTree.treeview({
                data: hasTabsTemplates,
                onnodeclick: function (item) {
                    pTreeNotChecked();
                    var _currentPage = $rootScope.designer.currentPage;
                    var _currentFocus = $rootScope.designer.currentFocus;
                    if (_currentFocus.id != item.id)
                    {
                        if (_currentPage.id != "lrTabs") {
                            $rootScope.designer.currentPage = hasTabsTemplates[0];
                        }
                        
                        $rootScope.designer.currentFocus = item;
                        $rootScope.designer.doPhoneBroadcast(appBroadcastCode.cgSelectTemplatePage, { "cmd": "lrTabs", "data": hasTabsTemplates[0].ChildNodes, "focus": item });
                        $.webappDesigner.attributes($rootScope.designer);
                    }
                }
            });
        }
    }
    function focusTabsNode(id)
    {
        for (var i in hasTabsTemplates[0].ChildNodes) {
            var item = hasTabsTemplates[0].ChildNodes[i];
            if (item.id == id) {
                $rootScope.designer.currentFocus = item;
                $.webappDesigner.attributes($rootScope.designer);
                break;
            }
        }
        pTreeNotChecked();
        $rootScope.tabsTree.setNodeChecked(id);
    }

    /*取消选中*/
    function pTreeNotChecked() {
        if ($rootScope.pageTree != undefined) {
            $rootScope.pageTree.setNodeChecked("");
        }
    }
    function treeNotChecked()
    {
        if ($rootScope.tabsTree != undefined)
        {
            $rootScope.tabsTree.setNodeChecked("");
        }
    }

    return {
        init: function (data) {
            hasTemplates = data;
        },
        getPageTemps: function () {
            return pageTemplates;
        },
        getHasTemps: function () {
            return hasTemplates;
        },
        getHasTabsTemps: function () {
            return hasTabsTemplates;
        },
        getComponent: function (id, pageId) {
            for (var i in hasTemplates) {
                var item = hasTemplates[i];
                if (item.hasChildren && pageId == item.id) {
                    for (var j in item.ChildNodes) {
                        var _childone = item.ChildNodes[j];
                        if (_childone.id == id) {
                            return _childone;
                        }
                    }
                }
            }
            return null;
        },
        addPage: function (data) {
            var _id = ""; var _dst = {};
            if (data == undefined) {
                _dst = angular.copy(pageTemplates[0]);
                _dst.id = $lrfnGuid();
                _id = _dst.id;
                hasTemplates.push(_dst);
            }
            else {
                _dst = data;
                _id = data.id;
                hasTemplates.push(data);
            }
            refreshTree(_id);
            return _dst;
        },
        addComponent: function (obj) {
            for (var i in hasTemplates) {
                var item = hasTemplates[i];
                if (item.id == obj.parentnodes) {
                    hasTemplates[i].hasChildren = true;
                    hasTemplates[i].isexpand = true;
                    if (hasTemplates[i].ChildNodes == undefined) {
                        hasTemplates[i].ChildNodes = [];
                    }
                    hasTemplates[i].ChildNodes.push(obj);
                }
            }
        },
        initTabs: function (data) {
            var _data = [
                {
                    id: "lrtab0001",
                    text: "首页",
                    img: "fa fa-cube",
                    hasChildren: false,
                    isexpand: false,
                    parentnodes: "lrTabs",
                    attr: {
                        value: "lrTab",
                        iconOn: "ion-ios-home",
                        iconOff: "ion-ios-home-outline",
                        innerTabPage: "DefaultPage",
                    },
                    setValue: setTabValue,
                    doButton: removeTab
                },
                {
                    id: "lrtab0002",
                    text: "实例",
                    img: "fa fa-cube",
                    hasChildren: false,
                    isexpand: false,
                    parentnodes: "lrTabs",
                    attr: {
                        value: "lrTab",
                        iconOn: "ion-ios-book",
                        iconOff: "ion-ios-book-outline",
                        innerTabPage: "DefaultPage",
                    },
                    setValue: setTabValue,
                    doButton: removeTab
                },
                {
                    id: "lrtab0003",
                    text: "通知",
                    img: "fa fa-cube",
                    hasChildren: false,
                    isexpand: false,
                    parentnodes: "lrTabs",
                    attr: {
                        value: "lrTab",
                        iconOn: "ion-ios-bell",
                        iconOff: "ion-ios-bell-outline",
                        innerTabPage: "DefaultPage",
                    },
                    setValue: setTabValue,
                    doButton: removeTab
                },
                {
                    id: "lrtab0004",
                    text: "我的",
                    img: "fa fa-cube",
                    hasChildren: false,
                    isexpand: false,
                    parentnodes: "lrTabs",
                    attr: {
                        value: "lrTab",
                        iconOn: "ion-ios-person",
                        iconOff: "ion-ios-person-outline",
                        innerTabPage: "DefaultPage",
                    },
                    setValue: setTabValue,
                    doButton: removeTab
                }
            ];
            if (data == undefined)
            {
                data = _data;
            }
            hasTabsTemplates[0].ChildNodes = data;
        },
        fnPageTree: {
            init: function (obj) {
                $rootScope.pageTree = obj;
                refreshTree();
            },
            refresh: refreshTree,
            focusNode: function (id) {
                treeNotChecked();
                $rootScope.pageTree.setNodeChecked(id);
            },
            refreshNode: refreshTreeNode
        },
        fnTabsTree: {
            init: function (obj) {
                $rootScope.tabsTree = obj;
                refreshTabsTree();
            },
            refresh: refreshTabsTree,
            focusNode: focusTabsNode
        }
    };
}])
.factory('$lrmDesigner', ['$rootScope', '$lrmComponents', '$lrmTemplates', '$http', '$lrdialogTop', '$lrGetIframe', '$lrfnGuid', function ($rootScope, $lrmComponents, $lrmTemplates, $http, $lrdialogTop, $lrGetIframe, $lrfnGuid) {
    var designer = {
        projectId: "",
        projectName: "",
        projectIcon: "icon-webApp.png",
        currentPage: {},
        currentFocus: {},
        isTabsAdded:false,
        templates: $lrmTemplates,
        components:$lrmComponents,
        api: {
            saveProjectUrl: "../../AppManage/AppProjects/SaveForm",
            getProjectUrl: "../../AppManage/AppProjects/GetFormJson"
        },
        doPhoneBroadcast: function (cmd, data) {
            $lrGetIframe('phoneDIndex').doBroadcast(cmd, data);
        },
        vm: {
            isBeginView: false
        },
        addPage: function (pageTemplate) {
            var _dst = angular.copy(pageTemplate);
            _dst.id = $lrfnGuid();
            designer.currentPage = _dst;
            designer.currentFocus = _dst;
            designer.templates.addPage(_dst);
            designer.doPhoneBroadcast(appBroadcastCode.cgSelectTemplatePage, { "cmd": "addPage", "object": _dst });
            $.webappDesigner.attributes(designer);
        },
        saveProject: function () {
            var _projectEntity = {
                "F_Name": designer.projectName,
                "F_Icon": designer.projectIcon,
            };
            if (_projectEntity.F_Name == "") {
                $lrdialogTop('请输入项目名称', 'error');
                return false;
            }

            $http.post(designer.api.saveProjectUrl + "?keyValue=" + designer.projectId, _projectEntity)
            .success(function (data) {
                $lrdialogTop('保存成功', 'success');
            })
            .error(function () {
                $lrdialogTop('保存失败', 'error');
            });
        }
    };


    function onBroadcast() {
        $rootScope.$on(appBroadcastCode.addComponent, function (event, data) {//添加组件
            try {
                var treeOne = {
                    text: data.text,
                    img: data.img,
                    parentnodes: designer.currentPage.id,
                    id: data.id,
                    attr: data,
                    setValue: designer.components.getOne(data.value).setValue,
                    doButton: designer.components.doRemove
                };
                designer.templates.addComponent(treeOne);
                designer.templates.fnPageTree.refresh(treeOne.id);
                designer.currentFocus = treeOne;
                $.webappDesigner.attributes(designer);
            }
            catch (e)
            {
                console.log(e.message);
            }
        });

        $rootScope.$on(appBroadcastCode.doTabTemplatePhone, function (event, data) {//对tab的操作

            switch (data.cmd)
            {
                case "selectTab":
                    designer.templates.fnTabsTree.focusNode(data.id);
                    break;
                case "duplicate":
                    var _dst = angular.copy(data.object);
                    _dst.id = $lrfnGuid();
                    designer.templates.getHasTabsTemps()[0].ChildNodes.push(_dst);
                    designer.templates.fnTabsTree.refresh();
                    designer.templates.fnTabsTree.focusNode(_dst.id);
                    $rootScope.designer.doPhoneBroadcast(appBroadcastCode.doTabTemplate, { "cmd": "addTab", id: _dst.id });
                    break;
                case "remove":
                    var _lists = designer.templates.getHasTabsTemps()[0].ChildNodes;

                    if (_lists.length > 1) {
                        _lists.splice(_lists.indexOf(data.object), 1);
                        designer.templates.fnTabsTree.refresh();
                        designer.templates.fnTabsTree.focusNode(_lists[0].id);
                        $rootScope.designer.doPhoneBroadcast(appBroadcastCode.doTabTemplate, { "cmd": "removeTab", id: _lists[0].id });
                    }
                    else {
                        $lrdialogTop('Tab不能全部删除', 'error');
                    }
                    break;
            }
        });

        $rootScope.$on(appBroadcastCode.doComponentPhone, function (event, data) {//对tab的操作
            designer.templates.fnPageTree.focusNode(data.id);
            designer.currentFocus = designer.templates.getComponent(data.id, designer.currentPage.id);
            $.webappDesigner.attributes(designer);
        });
    }

    return {
        init: function (projectId) {
            designer.projectId = projectId;
            if (designer.projectId == "") {
                var tempData = designer.templates.addPage();
                designer.templates.initTabs();
                designer.currentPage = tempData;
                designer.currentFocus = tempData;
                $.webappDesigner.attributes(designer);
            }
            else {
                $http.get(designer.api.getProjectUrl + "?keyValue=" + designer.projectId)
                .success(function (data) {
                    designer.projectName = data.F_Name;
                    designer.projectIcon = data.F_Icon;
                })
                .error(function () {
                    designer.projectId = "";
                    $lrdialogTop('获取数据失败', 'error');
                });
            }
            onBroadcast();
            return designer;
        }
    };
}])
/*方法*/
.factory('$lrfnRequest', function () {//获取传递参数
    return function (keyValue) {
        var search = location.search.slice(1);
        var arr = search.split("&");
        for (var i = 0; i < arr.length; i++) {
            var ar = arr[i].split("=");
            if (ar[0] == keyValue) {
                if (unescape(ar[1]) == 'undefined') {
                    return "";
                } else {
                    return unescape(ar[1]);
                }
            }
        }
        return "";
    }
})
.factory('$lrfnGuid', function () {
    return function () {
        var guid = "";
        for (var i = 1; i <= 32; i++) {
            var n = Math.floor(Math.random() * 16.0).toString(16);
            guid += n;
            if ((i == 8) || (i == 12) || (i == 16) || (i == 20)) guid += "-";
        }
        return guid;
    };
})
.factory('$lrdialogTop', function () {
    return function (content, type) {
        $(".tip_container").remove();
        var bid = parseInt(Math.random() * 100000);
        $("body").prepend('<div id="tip_container' + bid + '" class="container tip_container"><div id="tip' + bid + '" class="mtip"><i class="micon"></i><span id="tsc' + bid + '"></span><i id="mclose' + bid + '" class="mclose"></i></div></div>');
        var $this = $(this);
        var $tip_container = $("#tip_container" + bid);
        var $tip = $("#tip" + bid);
        var $tipSpan = $("#tsc" + bid);
        //先清楚定时器
        clearTimeout(window.timer);
        //主体元素绑定事件
        $tip.attr("class", type).addClass("mtip");
        $tipSpan.html(content);
        $tip_container.slideDown(300);
        //提示层隐藏定时器
        window.timer = setTimeout(function () {
            $tip_container.slideUp(300);
            $(".tip_container").remove();
        }, 4000);
        $("#tip_container" + bid).css("left", ($(window).width() - $("#tip_container" + bid).width()) / 2);
    }
})
.factory('$lrGetIframe', function () {
    function isbrowsername() {
        var userAgent = navigator.userAgent; //取得浏览器的userAgent字符串
        var isOpera = userAgent.indexOf("Opera") > -1;
        if (isOpera) {
            return "Opera"
        }; //判断是否Opera浏览器
        if (userAgent.indexOf("Firefox") > -1) {
            return "FF";
        } //判断是否Firefox浏览器
        if (userAgent.indexOf("Chrome") > -1) {
            if (window.navigator.webkitPersistentStorage.toString().indexOf('DeprecatedStorageQuota') > -1) {
                return "Chrome";
            } else {
                return "360";
            }
        }//判断是否Chrome浏览器//360浏览器
        if (userAgent.indexOf("Safari") > -1) {
            return "Safari";
        } //判断是否Safari浏览器
        if (userAgent.indexOf("compatible") > -1 && userAgent.indexOf("MSIE") > -1 && !isOpera) {
            return "IE";
        }; //判断是否IE浏览器
    }
    return function (id) {
        if (isbrowsername() == "Chrome" || isbrowsername() == "FF") {
            return frames[id].contentWindow;
        }
        else {
            return frames[id];
        }
    }
});



/*Dom操作和给外部调用的方法*/
(function ($) {
    function lrAppBox(name, strhtml) {
        var html = '<div class="lr-box expanded">';
        html += '<h4 class="lr-box-toggle" onClick="lrappbox(this)"><span class="caret"></span>' + name + '</h4>';
        html += '<div class="lr-box-content">' + strhtml + '</div>';
        html += '</div>';
        return html;
    }
    function lrAppColorPicker(color, width, name) {
        var html = '<div class="input-append color" data-form="colorpicker" data-color="' + color + '" style="width:' + width + 'px;" data-color-format="hex">' +
                '<span class="add-on"><i style="background-color: ' + color + '"></i></span>' +
                '<input type="text" data-name="'+name+'" value="' + color + '" />' +
                '</div>';
        return html;
    }
    function buttonGroup(name,data,value, style) {
        var html = '<div class="btn-group" style="' + style + '">';

        for (var i in data) {
            var _item = data[i];
            var _icon = _item.icon == undefined ? '<span style="font-size:18px; line-height: 19px;">' + _item.text + '</span>' : '<span class="' + _item.icon + '"></span>';
            var _actived = "";
            if (_item.value == value)
            {
                _actived = "actived";
            }
            html += '<a type="button" class="btn btn-default ' + _actived + ' b' + data.length + ' " onClick="lrappBtnGroup(this)"><input type="text" data-name="' + name + '" style="display:none;" value="' + _item.value + '" >' + _icon + '</a>';
        }
        html += '</div>';

        return html;
    }
    function lrAppToggle(name,value) {
        var _active = '';
        if (value == 'true' )
        {
            _active = 'active';
        }
        var _html = '<lrapp-toggle class="' + _active + '"  onClick="lrappToggle(this)"><input type="text" data-name="' + name + '" style="display:none;" value="' + value + '" > <span class="left-text  "  ></span><div class="track"><div class="handle"></div></div><span class="right-text" ></span></lrapp-toggle>';
        return _html;
    }
    function lrCombox(name, value, data, width) {
        var _option = '';
        for (var i in data)
        {
            var item = data[i];
            _option += '<li data-value="' + item.value + '" data-icon = "' + item.icon + '" >' + item.text + '</li>';
        }
        var _html = '<div id="' + name + '"  type="select" class="ui-select" data-name="' + name + '" data-value="' + value + '" style="width:' + width + 'px;display: inline-block;"  >' + _option + '</div>';
        return _html;
    };

    var _tempsAttr = {//模板属性设置
        lrTabs: function (data) {
            var _html = "";
            var _boxHtml = "";
            var _color = [
                { text: "Light", value: "light", icon: "<span class='color-square light-bg light-border space-right'></span>" },
                { text: "Stable", value: "stable", icon: "<span class='color-square stable-bg stable-border space-right'></span>" },
                { text: "Dark", value: "dark", icon: "<span class='color-square dark-bg dark-border space-right'></span>" },
                { text: "Positive", value: "positive", icon: "<span class='color-square positive-bg positive-border space-right'></span>" },
                { text: "Balanced", value: "balanced", icon: "<span class='color-square balanced-bg balanced-border space-right'></span>" },
                { text: "Assertive", value: "assertive", icon: "<span class='color-square assertive-bg assertive-border space-right'></span>" },
                { text: "Calm", value: "calm", icon: "<span class='color-square calm-bg calm-border space-right'></span>" },
                { text: "Energized", value: "energized", icon: "<span class='color-square energized-bg energized-border space-right'></span>" },
                { text: "Royal", value: "royal", icon: "<span class='color-square royal-bg royal-border space-right'></span>" }
            ];
            var _types = [
                { text: "顶部图标", value: "top", icon: "" },
                { text: "只有图标", value: "only", icon: "" },
                { text: "左侧图标", value: "left", icon: "" },
            ];
            _html += '<div class="lr-app-right-header"><span class="lr-app-title">' + data.text + '</span></div>';
            
            _boxHtml += '<div class="form-group"><label class="control-label">背景色</label>' + lrCombox("bgColor", data.attr.bgColor, _color, 205) + '</div>';
            _boxHtml += '<div class="form-group"><label class="control-label">图标色</label>' + lrCombox("iconColor", data.attr.iconColor, _color, 205) + '</div>';
            _boxHtml += '<div class="form-group"><label class="control-label">类型</label>' + lrCombox("iconType", data.attr.iconType, _types, 205) + '</div>';

            _html += lrAppBox('样式', _boxHtml);

            _html += '<div style="margin:10px;"><button type="button" class="btn btn-danger btn-block">增加新的Tab</button></div>';
            return _html;
        },
        lrTab: function (data,designer) {
            var _html = "";
            var _boxHtml = "";

            var _pages = designer.templates.getHasTemps();
            var _innerPages = [];
            for (var i in _pages)
            {
                var _item = _pages[i];
                var _point = { text: _item.text, value: _item.id, icon: "" };
                _innerPages.push(_point);
            }

            _html += '<div class="lr-app-right-header"><span class="lr-app-typePage"><a>Tabs控制器</a><span class="lr-app-slash">/</span></span>' + data.text + '</div>';
            _boxHtml += '<div class="form-group"><label class="control-label">标题</label><input type="text" class="form-control" data-name="text" value="' + data.text + '" ></div>';
            _boxHtml += '<div class="form-group"><label class="control-label">未选中图标</label>' + lrCombox("iconOff", data.attr.iconOff, webAppData.iconList, 205) + '</div>';
            _boxHtml += '<div class="form-group"><label class="control-label">选中图标</label>' + lrCombox("iconOn", data.attr.iconOn, webAppData.iconList, 205) + '</div>';
            _boxHtml += '<div class="form-group"><label class="control-label">内嵌页面</label>' + lrCombox("innerTabPage", data.attr.innerTabPage, _innerPages, 205) + '</div>';


            _html += lrAppBox('设置', _boxHtml);
            _html += '<div style="margin:10px;"><button type="button" class="btn btn-danger btn-block">删除</button></div>';
            return _html;
        },
        lrPageBlank: function (data) {

            var _html = "";
            var _boxHtml = "";

            _html += '<div class="lr-app-right-header"><span class="lr-app-title">' + data.text + '</span></div>';

            _html += '<div class="lr-box" style="padding-top:10px;">';
            _html += '<div class="form-group"><label class="control-label">标题</label><input type="text" class="form-control W" data-name="text" value="' + data.text + '" ></div>';
            _html += '<div class="form-group"><label class="control-label">路由</label><input type="text" class="form-control W" data-name="routing" value="' + data.attr.routing + '"></div></div>';

            _boxHtml = '<div class="form-group"><label class="control-label">Color</label>' + lrAppColorPicker(data.attr.bgColor, 205, "bgColor") + '</div>';
            _html += lrAppBox('背景', _boxHtml);

            _boxHtml = '<div class="form-group form-toggle "><label class="control-label">显示tabs</label>' + lrAppToggle('isTabed', data.attr.isTabed) + '</div>';
            _boxHtml += '<div class="form-group form-toggle "><label class="control-label">内边距</label>' + lrAppToggle('isPadding',data.attr.isPadding) + '</div>';
            _boxHtml += '<div class="form-group form-toggle "><label class="control-label">隐藏头部</label>' + lrAppToggle('isHeadHide', data.attr.isHeadHide) + '</div>';

            _html += lrAppBox('混合属性', _boxHtml);

            _html += '<div style="margin:10px;"><button type="button" class="btn btn-danger btn-block">删除</button></div>';

            return _html;
        },
        lrHeader: function (data, designer) {

            var _html = '';
            var _boxHtml = '';
            var _size = [{ text: "H1", value: "H1", icon: "" },
              { text: "H2", value: "H2", icon: "" },
              { text: "H3", value: "H3", icon: "" },
              { text: "H4", value: "H4", icon: "" },
              { text: "H5", value: "H5", icon: "" }
            ];
            var _weightSize = [{ text: "200", value: "200", icon: "" },
              { text: "300", value: "300", icon: "" },
              { text: "400", value: "400", icon: "" },
              { text: "500", value: "500", icon: "" },
              { text: "600", value: "600", icon: "" }
            ];


            _html += '<div class="lr-app-right-header"><span class="lr-app-typePage"><a>' + designer.currentPage.text + '</a><span class="lr-app-slash">/</span></span>' + data.text + '</div>';

            _boxHtml = '<div class="form-group"><input type="text" class="form-control W " data-name="text" value="' + data.text + '" ></div>';
            _boxHtml += '<div class="form-group"><label class="control-label">Size</label>' + lrCombox("size", data.attr.size, _size, 205) + '</div>';
            _boxHtml += '<div class="form-group"><label class="control-label">Weight</label>' + lrCombox("weightSize", data.attr.weight.size, _weightSize, 100);
            _boxHtml += buttonGroup("italic", [{ 'text': 'I', 'value': 'false' }, { 'icon': 'fa fa-italic', 'value': 'true' }], data.attr.weight.isItalic, "margin-left:5px;");
            _boxHtml += '</div>';

            _boxHtml += '<div class="form-group"><label class="control-label">Color</label>' + lrAppColorPicker(data.attr.color, 205, "color") + '</div>';
            _boxHtml += '<div class="form-group"><label class="control-label">Align</label>';
            _boxHtml += buttonGroup("align", [{ 'icon': 'fa fa-align-left', "value": "left" }, { 'icon': 'fa fa-align-center', "value": "center" }, { 'icon': 'fa fa-align-right', "value": "right" }, { 'icon': 'fa fa-align-justify', "value": "justify" }], data.attr.align);
            _boxHtml += '</div>';

            _html += lrAppBox('Text', _boxHtml);

            _html += '<div style="margin:10px;"><button type="button" class="btn btn-danger btn-block">删除</button></div>';

            return _html;
        },
        lrParagraph: function (data, designer) {
            var _html = '';
            var _boxHtml = '';
            var _size = [
              { text: "12px", value: "12px", icon: "" },
              { text: "13px", value: "13px", icon: "" },
              { text: "14px", value: "14px", icon: "" },
              { text: "15px", value: "15px", icon: "" },
              { text: "16px", value: "16px", icon: "" },
              { text: "17px", value: "17px", icon: "" },
              { text: "18px", value: "18px", icon: "" },
              { text: "19px", value: "19px", icon: "" },
              { text: "20px", value: "20px", icon: "" },
              { text: "21px", value: "21px", icon: "" },
              { text: "22px", value: "22px", icon: "" },
              { text: "23px", value: "23px", icon: "" },
              { text: "24px", value: "24px", icon: "" },
              { text: "25px", value: "25px", icon: "" }
            ];


            _html += '<div class="lr-app-right-header"><span class="lr-app-typePage"><a>' + designer.currentPage.text + '</a><span class="lr-app-slash">/</span></span>' + data.text + '</div>';

            _boxHtml += '<div class="form-group"><label class="control-label">Size</label>' + lrCombox("size", data.attr.size, _size, 205) + '</div>';
            _boxHtml += '<div class="form-group"><label class="control-label">Color</label>' + lrAppColorPicker(data.attr.color, 205, "color") + '</div>';
            _boxHtml += '<div class="form-group"><label class="control-label">Align</label>';
            _boxHtml += buttonGroup("align", [{ 'icon': 'fa fa-align-left', "value": "left" }, { 'icon': 'fa fa-align-center', "value": "center" }, { 'icon': 'fa fa-align-right', "value": "right" }, { 'icon': 'fa fa-align-justify', "value": "justify" }], data.attr.align);
            _boxHtml += '</div>';
            _boxHtml += '<div class="form-group"><label class="control-label">内容</label><textarea  class="form-control W"  data-name="content"  style="resize: none;height:100px;">' + data.attr.content + '</textarea></div>';



            _html += lrAppBox('Text', _boxHtml);

            _html += '<div style="margin:10px;"><button type="button" class="btn btn-danger btn-block">删除</button></div>';

            return _html;
        },
        lrBtn: function (data, designer) {
            var _html = '';
            var _boxHtml = '';

            var _pages = designer.templates.getHasTemps();
            var _innerPages = [];
            for (var i in _pages) {
                var _item = _pages[i];
                var _point = { text: _item.text, value: _item.id, icon: "" };
                _innerPages.push(_point);
            }
            var _size = [
             { text: "12px", value: "12px" },
             { text: "13px", value: "13px" },
             { text: "14px", value: "14px" },
             { text: "15px", value: "15px" },
             { text: "16px", value: "16px" },
             { text: "17px", value: "17px" },
             { text: "18px", value: "18px" },
             { text: "19px", value: "19px" },
             { text: "20px", value: "20px" },
             { text: "21px", value: "21px" },
             { text: "22px", value: "22px" },
             { text: "23px", value: "23px" },
             { text: "24px", value: "24px" },
             { text: "25px", value: "25px" }
            ];
            var _weightSize = [{ text: "200", value: "200" },
              { text: "300", value: "300" },
              { text: "400", value: "400" },
              { text: "500", value: "500" },
              { text: "600", value: "600" }
            ];
            var _color = [
                { text: "Light", value: "light", icon: "<span class='color-square light-bg light-border space-right'></span>" },
                { text: "Stable", value: "stable", icon: "<span class='color-square stable-bg stable-border space-right'></span>" },
                { text: "Dark", value: "dark", icon: "<span class='color-square dark-bg dark-border space-right'></span>" },
                { text: "Positive", value: "positive", icon: "<span class='color-square positive-bg positive-border space-right'></span>" },
                { text: "Balanced", value: "balanced", icon: "<span class='color-square balanced-bg balanced-border space-right'></span>" },
                { text: "Assertive", value: "assertive", icon: "<span class='color-square assertive-bg assertive-border space-right'></span>" },
                { text: "Calm", value: "calm", icon: "<span class='color-square calm-bg calm-border space-right'></span>" },
                { text: "Energized", value: "energized", icon: "<span class='color-square energized-bg energized-border space-right'></span>" },
                { text: "Royal", value: "royal", icon: "<span class='color-square royal-bg royal-border space-right'></span>" }
            ];

            _html += '<div class="lr-app-right-header"><span class="lr-app-typePage"><a>' + designer.currentPage.text + '</a><span class="lr-app-slash">/</span></span>' + data.text + '</div>';

            _boxHtml = '<div class="form-group"><label class="control-label">连接</label>' + lrCombox("link", data.attr.link, _innerPages, 205) + '</div>';
            _html += lrAppBox('连接', _boxHtml);

            _boxHtml = '<div class="form-group"><input type="text" class="form-control W " data-name="text" value="' + data.text + '" ></div>';
            _boxHtml += '<div class="form-group"><label class="control-label">Size</label>' + lrCombox("size", data.attr.size, _size, 205) + '</div>';
            _boxHtml += '<div class="form-group"><label class="control-label">Weight</label>' + lrCombox("weightSize", data.attr.weight.size, _weightSize, 100);
            _boxHtml += buttonGroup("italic", [{ 'text': 'I', 'value': 'false' }, { 'icon': 'fa fa-italic', 'value': 'true' }], data.attr.weight.isItalic, "margin-left:5px;");
            _boxHtml += '</div>';
            _boxHtml += '<div class="form-group"><label class="control-label">Color</label>' + lrAppColorPicker(data.attr.color, 205, "color") + '</div>';
            _boxHtml += '<div class="form-group"><label class="control-label">Align</label>';
            _boxHtml += buttonGroup("align", [{ 'icon': 'fa fa-align-left', "value": "left" }, { 'icon': 'fa fa-align-center', "value": "center" }, { 'icon': 'fa fa-align-right', "value": "right" }, { 'icon': 'fa fa-align-justify', "value": "justify" }], data.attr.align);
            _boxHtml += '</div>';
            _html += lrAppBox('文本', _boxHtml);


            _boxHtml = '<div class="form-group"><label class="control-label">类型</label>' + lrCombox("btnType", data.attr.btnType, [{ text: "Default", value: "default" }, { text: "Clear", value: "clear" }, { text: "Outline", value: "outline" }], 205) + '</div>';
            _boxHtml += '<div class="form-group"><label class="control-label">主题</label>' + lrCombox("btnTheme", data.attr.btnTheme, _color, 205) + '</div>';
            _boxHtml += '<div class="form-group"><label class="control-label">尺寸</label>' + lrCombox("btnSize", data.attr.btnSize, [{ text: "Standard", value: "standard" }, { text: "Large", value: "large" }, { text: "Small", value: "small" }], 205) + '</div>';

            _html += lrAppBox('样式', _boxHtml);

            _html += '<div style="margin:10px;"><button type="button" class="btn btn-danger btn-block">删除</button></div>';
            return _html;
        },
        lrInput: function (data, designer) {
            var _html = '';
            var _boxHtml = '';

            var _type = [{ text: "Text", value: "text" },
              { text: "Password", value: "password" }
            ];

            _html += '<div class="lr-app-right-header"><span class="lr-app-typePage"><a>' + designer.currentPage.text + '</a><span class="lr-app-slash">/</span></span>' + data.text + '</div>';

            _boxHtml = '<div class="form-group"><label class="control-label">Placeholder</label><input type="text" class="form-control" data-name="placeholder" value="' + data.attr.placeholder + '" ></div>';
            _boxHtml += '<div class="form-group"><label class="control-label">Type</label>' + lrCombox("inputType", data.attr.inputType, _type, 205) + '</div>';
            _boxHtml += '<div class="form-group"><label class="control-label">Name</label><input type="text" class="form-control" data-name="name" value="' + data.attr.name + '" ></div>';
            _html += lrAppBox('输入框设置', _boxHtml);

            _html += '<div style="margin:10px;"><button type="button" class="btn btn-danger btn-block">删除</button></div>';
            return _html;
        },
        lrList3: function (data, designer) {
            var _html = '';
            var _boxHtml = '';

            var _pages = designer.templates.getHasTemps();
            var _innerPages = [];
            for (var i in _pages) {
                var _item = _pages[i];
                var _point = { text: _item.text, value: _item.id, icon: "" };
                _innerPages.push(_point);
            }
            var _color = [
                  { text: "Light", value: "light", icon: "<span class='color-square light-bg light-border space-right'></span>" },
                  { text: "Stable", value: "stable", icon: "<span class='color-square stable-bg stable-border space-right'></span>" },
                  { text: "Dark", value: "dark", icon: "<span class='color-square dark-bg dark-border space-right'></span>" },
                  { text: "Positive", value: "positive", icon: "<span class='color-square positive-bg positive-border space-right'></span>" },
                  { text: "Balanced", value: "balanced", icon: "<span class='color-square balanced-bg balanced-border space-right'></span>" },
                  { text: "Assertive", value: "assertive", icon: "<span class='color-square assertive-bg assertive-border space-right'></span>" },
                  { text: "Calm", value: "calm", icon: "<span class='color-square calm-bg calm-border space-right'></span>" },
                  { text: "Energized", value: "energized", icon: "<span class='color-square energized-bg energized-border space-right'></span>" },
                  { text: "Royal", value: "royal", icon: "<span class='color-square royal-bg royal-border space-right'></span>" }
            ];
            _html += '<div class="lr-app-right-header"><span class="lr-app-typePage"><a>' + designer.currentPage.text + '</a><span class="lr-app-slash">/</span></span>' + data.text + '</div>';

            _boxHtml = '<div class="form-group"><label class="control-label">连接</label>' + lrCombox("link", data.attr.link, _innerPages, 205) + '</div>';
            _html += lrAppBox('连接', _boxHtml);

            _boxHtml = '<div class="form-group"><label class="control-label">显示文本</label><input type="text" class="form-control" data-name="name" value="' + data.attr.name + '" ></div>';
            _boxHtml += '<div class="form-group"><label class="control-label">主题</label>' + lrCombox("color", data.attr.color, _color, 205) + '</div>';
            _boxHtml += '<div class="form-group"><label class="control-label">图标</label>' + lrCombox("icon", data.attr.icon, webAppData.iconList, 205) + '</div>';
            _html += lrAppBox('列表设置', _boxHtml);

            _html += '<div style="margin:10px;"><button type="button" class="btn btn-danger btn-block">删除</button></div>';
            return _html;
        },
        lrList4: function (data, designer) {
            var _html = '';
            var _boxHtml = '';

            var _pages = designer.templates.getHasTemps();
            var _innerPages = [];
            for (var i in _pages) {
                var _item = _pages[i];
                var _point = { text: _item.text, value: _item.id, icon: "" };
                _innerPages.push(_point);
            }
            var _color = [
                  { text: "a", value: "a", icon: "<span class='color-square bgcolor_a light-border space-right'></span>" },
                  { text: "b", value: "b", icon: "<span class='color-square bgcolor_b light-border space-right'></span>" },
                  { text: "c", value: "c", icon: "<span class='color-square bgcolor_c light-border space-right'></span>" },
                  { text: "d", value: "d", icon: "<span class='color-square bgcolor_d light-border space-right'></span>" },
                  { text: "e", value: "e", icon: "<span class='color-square bgcolor_e light-border space-right'></span>" },
                  { text: "f", value: "f", icon: "<span class='color-square bgcolor_f light-border space-right'></span>" },
                  { text: "g", value: "g", icon: "<span class='color-square bgcolor_g light-border space-right'></span>" },
                  { text: "h", value: "h", icon: "<span class='color-square bgcolor_h light-border space-right'></span>" }
            ];
            _html += '<div class="lr-app-right-header"><span class="lr-app-typePage"><a>' + designer.currentPage.text + '</a><span class="lr-app-slash">/</span></span>' + data.text + '</div>';

            _boxHtml = '<div class="form-group"><label class="control-label">连接</label>' + lrCombox("link", data.attr.link, _innerPages, 205) + '</div>';
            _html += lrAppBox('连接', _boxHtml);

            _boxHtml = '<div class="form-group"><label class="control-label">显示文本</label><input type="text" class="form-control" data-name="name" value="' + data.attr.name + '" ></div>';
            _boxHtml += '<div class="form-group"><label class="control-label">主题</label>' + lrCombox("color", data.attr.color, _color, 205) + '</div>';
            _boxHtml += '<div class="form-group"><label class="control-label">图标</label>' + lrCombox("icon", data.attr.icon, webAppData.iconList, 205) + '</div>';
            _html += lrAppBox('列表设置', _boxHtml);

            _html += '<div style="margin:10px;"><button type="button" class="btn btn-danger btn-block">删除</button></div>';
            return _html;
        },
    }

    $.webappDesigner = {
        attributes: function (data) {
            //console.log(data.currentFocus);
            //var $webAppDesign = angular.element('#webAppDesign');
            //var $rootScope = $webAppDesign.scope().$root;
            var _currentFocus = data.currentFocus;
            var _attr = _currentFocus.attr;
            var _currentPage = data.currentPage;
            var strhtml = '';
            var strBoxHtml = '';

            strhtml = _tempsAttr[_attr.value](_currentFocus, data);

            $('.lr-app-right-bar').html(strhtml).ready(function () {
                $('.color').colorpicker();
                $('.ui-select').each(function (r) {
                    $(this).ComboBox({
                        height: "400px",
                    }).bind('change', function () {
                        var $obj = $(this);
                        var _value = $obj.attr('data-value');
                        var _name = $obj.attr("data-name");
                        data.currentFocus.setValue(_name, _value, data.currentFocus);
                    });
                });
                $('.lr-app-right-bar input').unbind();
                $('.lr-app-right-bar input').bind('input propertychange', function () {
                    var $obj = $(this);
                    var _value = $obj.val();
                    var _name = $obj.attr("data-name");
                    if (_name == "routing")
                    {
                        if (_value.indexOf("/") < 0)
                        {
                            _value = "/" + _value;
                            $obj.val(_value);
                        }
                    }
                    data.currentFocus.setValue(_name, _value, data.currentFocus);
                });
                $('.lr-app-right-bar textarea').unbind();
                $('.lr-app-right-bar textarea').bind('valuechange', function () {
                    var $obj = $(this);
                    var _value = $obj.val();
                    var _name = $obj.attr("data-name");
                    data.currentFocus.setValue(_name, _value, data.currentFocus);
                });

                $('button').on('click', function () {
                    data.currentFocus.doButton(data.currentFocus);
                });
            });
        },
        doBroadcast: function (name, data) {//发送广播
            var $webAppDesign = angular.element('#webAppDesign');
            var $rootScope = $webAppDesign.scope().$root;
            $rootScope.$broadcast(name, data);//iframeLoaded
        }
    };

    $.event.special.valuechange = {
        teardown: function (namespaces) {
            $(this).unbind('.valuechange');
        },
        handler: function (e) {
            $.event.special.valuechange.triggerChanged($(this));
        },
        add: function (obj) {
            $(this)
            .on(
            'keyup.valuechange cut.valuechange paste.valuechange input.valuechange',
            obj.selector, $.event.special.valuechange.handler)
        },
        triggerChanged: function (element) {
            var current = element[0].contentEditable === 'true' ? element
            .html() : element.val(), previous = typeof element
            .data('previous') === 'undefined' ? element[0].defaultValue
            : element.data('previous')
            if (current !== previous) {
                element.trigger('valuechange', [element.data('previous')])
                element.data('previous', current)
            }
        }
    }
    $.fn.ComboBox = function (options) {
        //options参数：description,height,width,allowSearch,url,param,data
        options.id = "key";
        options.text = "text";
        var $select = $(this);
        var json = options.data = [];
        var _description = $select.attr("data-value");
        $select.find('li').each(function (r) {
            var $obj = $(this);
            var _text = $obj.html();
            var _value = $obj.attr('data-value');
            var _icon = $obj.attr('data-icon');
            var _a = {};

            _a[options.id] = _value;
            _a[options.text] = _text;
            _a["icon"] = (_icon == "undefined" ? "" : _icon);
            if (_description == _value)
            {
                _description = _a["icon"] + _text;
            }
            json.push(_a);
        });
        
        var _name = $select.attr("data-name");

        if (options) {
            if ($select.find('.ui-select-text').length == 0) {
                var $select_html = "";
                $select_html += "<div class=\"ui-select-text\" style='color:#999;'>" + _description + "</div>";
                $select_html += "<div class=\"ui-select-option\">";
                $select_html += "<div class=\"ui-select-option-content\" style=\"max-height: " + options.height + "\">" + $select.html() + "</div>";
                if (options.allowSearch) {
                    $select_html += "<div class=\"ui-select-option-search\"><input type=\"text\" class=\"form-control\" placeholder=\"搜索关键字\" /><span class=\"input-query\" title=\"Search\"><i class=\"fa fa-search\"></i></span></div>";
                }
                $select_html += "</div>";
                $select.html('');
                $select.append($select_html);
            }
        }
        var $option_html = $($("<p>").append($select.find('.ui-select-option').clone()).html());
        $option_html.attr('id', $select.attr('id') + '-option');
        $select.find('.ui-select-option').remove();
        if ($option_html.length > 0) {
            $('body').find('#' + $select.attr('id') + '-option').remove();
        }
        $('body').prepend($option_html);
        var $option = $("#" + $select.attr('id') + "-option");
        //var json = options.data;
        
        loadComboBoxView(json);
        function loadComboBoxView(json, searchValue, m) {
            if (json.length > 0) {
                var $_html = $('<ul></ul>');
                if (options.description) {
                    $_html.append('<li data-value="">' + options.description + '</li>');
                }
                $.each(json, function (i) {
                    var row = json[i];
                    var title = row[options.title];
                    if (title == undefined) {
                        title = "";
                    }
                    if (searchValue != undefined) {
                        if (row[m.text].indexOf(searchValue) != -1) {
                            $_html.append('<li data-value="' + row[options.id] + '" title="' + title + '">' + row.icon + row[options.text] + '</li>');
                        }
                    }
                    else {
                        $_html.append('<li data-value="' + row[options.id] + '" title="' + title + '">' + row.icon + row[options.text] + '</li>');
                    }
                });
                $option.find('.ui-select-option-content').html($_html);
                $option.find('li').css('padding', "0 5px");
                $option.find('li').click(function (e) {
                    var data_text = $(this).html();
                    var data_value = $(this).attr('data-value');
                    $select.attr("data-value", data_value).attr("data-text", data_text);
                    $select.find('.ui-select-text').html(data_text).css('color', '#000');
                    $option.slideUp(150);
                    $select.trigger("change");
                    e.stopPropagation();
                }).hover(function (e) {
                    if (!$(this).hasClass('liactive')) {
                        $(this).toggleClass('on');
                    }
                    e.stopPropagation();
                });
            }
        }
        //操作搜索事件
        if (options.allowSearch) {
            $option.find('.ui-select-option-search').find('input').bind("keypress", function (e) {
                if (event.keyCode == "13") {
                    var value = $(this).val();
                    loadComboBoxView($(this)[0].options.data, value, $(this)[0].options);
                }
            }).focus(function () {
                $(this).select();
            })[0]["options"] = options;
        }

        $select.unbind('click');
        $select.bind("click", function (e) {
            if ($select.attr('readonly') == 'readonly' || $select.attr('disabled') == 'disabled') {
                return false;
            }
            $(this).addClass('ui-select-focus');
            if ($option.is(":hidden")) {
                $select.find('.ui-select-option').hide();
                $('.ui-select-option').hide();
                var left = $select.offset().left;
                var top = $select.offset().top + 35;
                var width = $select.width();
                if (options.width) {
                    width = options.width;
                }
                if (($option.height() + top) < $(window).height()) {
                    $option.slideDown(150).css({ top: top, left: left, width: width });
                } else {
                    var _top = (top - $option.height() - 32)
                    $option.show().css({ top: _top, left: left, width: width });
                    $option.attr('data-show', true);
                }
                $option.css('border-top', '1px solid #ccc');
                $option.find('li').removeClass('liactive');
                $option.find('[data-value=' + $select.attr('data-value') + ']').addClass('liactive');
                $option.find('.ui-select-option-search').find('input').select();
            } else {
                if ($option.attr('data-show')) {
                    $option.hide();
                } else {
                    $option.slideUp(150);
                }
            }
            e.stopPropagation();
        });
        $(document).click(function (e) {
            var e = e ? e : window.event;
            var tar = e.srcElement || e.target;
            if (!$(tar).hasClass('form-control')) {
                if ($option.attr('data-show')) {
                    $option.hide();
                } else {
                    $option.slideUp(150);
                }
                $select.removeClass('ui-select-focus');
                e.stopPropagation();
            }
        });
        return $select;
    }
    $.fn.ComboBoxSetValue = function (value) {
        if ($.isNullOrEmpty(value)) {
            return;
        }
        var $select = $(this);
        var $option = $("#" + $select.attr('id') + "-option");
        $select.attr('data-value', value);
        var data_text = $option.find('ul').find('[data-value=' + value + ']').html();
        if (data_text) {
            $select.attr('data-text', data_text);
            $select.find('.ui-select-text').html(data_text).css('color', '#000');
            $option.find('ul').find('[data-value=' + value + ']').addClass('liactive')
        }
        return $select;
    }
    
})(window.jQuery);

function lrappbox(a) {
    var $obj = $(a).parent();
    if ($obj.is('.expanded')) {
        $obj.removeClass('expanded');
    }
    else {
        $obj.addClass('expanded');
    }
}
function lrappBtnGroup(a) {
    var $obj = $(a).parent();
    $input = $(a).find('input');
    $obj.find('.actived').removeClass('actived');
    $(a).addClass('actived');
    $input.trigger('propertychange');
}
function lrappToggle(a) {
    var $obj = $(a);
    $input = $obj.find('input');
    $obj.addClass("animate");
    var flag = $obj.is(".active");
    if (flag) {
        $input.val(false);
        $obj.removeClass("active");
    }
    else {
        $input.val(true);
        $obj.addClass("active");
    }
    $input.trigger('propertychange');
}
