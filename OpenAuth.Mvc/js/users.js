layui.config({
    base: "/js/"
}).use(['form','tree', 'layer', 'jquery', 'table'], function () {
    var form = layui.form,
		layer = parent.layer === undefined ? layui.layer : parent.layer,
		$ = layui.jquery;
    var table = layui.table;

    layui.tree({
        elem: '#demo1' //指定元素
    , target: '_blank' //是否新选项卡打开（比如节点返回href才有效）
    , click: function (item) { //点击节点回调
        layer.msg('当前节名称：' + item.name + '<br>全部参数：' + JSON.stringify(item));
        console.log(item);
    }
    , nodes: [ //节点
      {
          name: '常用文件夹'
        , id: 1
        , alias: 'changyong'
        , children: [
          {
              name: '所有未读（设置跳转）'
            , id: 11
            , href: 'http://www.layui.com/'
            , alias: 'weidu'
          }, {
              name: '置顶邮件'
            , id: 12
          }, {
              name: '标签邮件'
            , id: 13
          }
        ]
      }, {
          name: '我的邮箱'
        , id: 2
        , spread: true
        , children: [
          {
              name: 'QQ邮箱'
            , id: 21
            , spread: true
            , children: [
              {
                  name: '收件箱'
                , id: 211
                , children: [
                  {
                      name: '所有未读'
                    , id: 2111
                  }, {
                      name: '置顶邮件'
                    , id: 2112
                  }, {
                      name: '标签邮件'
                    , id: 2113
                  }
                ]
              }, {
                  name: '已发出的邮件'
                , id: 212
              }, {
                  name: '垃圾邮件'
                , id: 213
              }
            ]
          }, {
              name: '阿里云邮'
            , id: 22
            , children: [
              {
                  name: '收件箱'
                , id: 221
              }, {
                  name: '已发出的邮件'
                , id: 222
              }, {
                  name: '垃圾邮件'
                , id: 223
              }
            ]
          }
        ]
      }
      , {
          name: '收藏夹'
        , id: 3
        , alias: 'changyong'
        , children: [
          {
              name: '爱情动作片'
            , id: 31
            , alias: 'love'
          }, {
              name: '技术栈'
            , id: 12
            , children: [
              {
                  name: '前端'
                , id: 121
              }
              , {
                  name: '全端'
                , id: 122
              }
            ]
          }
        ]
      }
    ]
    });

    //监听表格复选框选择
    table.on('checkbox(list)', function (obj) {
        console.log(obj);
    });
    //监听表格内部按钮
    table.on('tool(list)', function (obj) {
        var data = obj.data;
        if (obj.event === 'detail') {
            layer.msg('ID：' + data.id + ' 的查看操作');
        } else if (obj.event === 'del') {
            layer.confirm('真的删除行么', function (index) {
                obj.del();
                layer.close(index);
            });
        } else if (obj.event === 'edit') {
            layer.alert('编辑行：<br>' + JSON.stringify(data));
        }
    });

    //监听页面主按钮操作
    var active = {
        del: function () { //批量删除
            var checkStatus = table.checkStatus('mainList')
                , data = checkStatus.data;
            layer.alert(JSON.stringify(data));
        }, addData:function() {  //添加
            var index = layui.layer.open({
                title: "添加",
                type: 2,
                content: "addUser.html",
                success: function (layero, index) {
                    setTimeout(function () {
                        layui.layer.tips('点击此处返回列表',
                            '.layui-layer-setwin .layui-layer-close', {
                            tips: 3
                        });
                    }, 500);
                }
            });
            //改变窗口大小时，重置弹窗的高度，防止超出可视区域（如F12调出debug的操作）
            $(window).resize(function () {
                layui.layer.full(index);
            });
            layui.layer.full(index);
        }, search:function() {  //搜索
            var key = $('#key');

            table.reload('mainList', {
                where: {
                    key: key.val(),
                    para1:"1"
                }
            });
        }
    };

    $('.toolList .layui-btn').on('click', function () {
        var type = $(this).data('type');
        active[type] ? active[type].call(this) : '';
    });
})