
layui.define("jquery", function (exports) {
    var jQuery = layui.jquery,
        $ = layui.jquery;

        //获取url的参数值
        $.getUrlParam = function (name) {
            var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
            var r = window.location.search.substr(1).match(reg);
            if (r != null) return unescape(r[2]); return null;
        }

        //把name/value的数组转为obj对象
        $.arrayToObj = function(array) {
            var result = {};
            for (var i = 0; i < array.length; i++) {
                var field = array[i];
                if (field.name in result) {
                    result[field.name] += ',' + field.value;
                } else {
                    result[field.name] = field.value;
                }
            }
            return result;
        }
    exports('utils');
});