layui.use(["form"],
    function() {
        var form = layui.form(), layer = layui.layer;

        //监听提交
        form.on("submit(*)",
            function(data) {
                $.post(
                    "/login/index",
                    data.field,
                    function(data) {
                        var result = JSON.parse(data);
                        if (result.Status) {
                            location.href = result.Result;
                        } else {
                            layer.msg(result.Message);
                        }
                    });
                return false;
            });
    });