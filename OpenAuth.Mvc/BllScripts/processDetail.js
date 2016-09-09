var schemecode = 'SimpleWF';
var wfdesigner = undefined;

function wfdesignerRedraw() {
    var data;

    if (wfdesigner != undefined) {
        data = wfdesigner.data;
        wfdesigner.destroy();
    }
    var processid = $("#processId").val();

    wfdesigner = new WorkflowDesigner({
        name: 'simpledesigner',
        apiurl: '/Designer/API',
        renderTo: 'wfdesigner',
        imagefolder: '/images/',
        graphwidth: 850,
        graphheight: 450
    });

    if (data == undefined) {
        var p = { schemecode: schemecode, processid: processid, readonly: true };
        if (wfdesigner.exists(p))
            wfdesigner.load(p);
        else
            wfdesigner.create();
    } else {
        wfdesigner.data = data;
        wfdesigner.render();
    }
}

wfdesignerRedraw();

$(function () {
    $(".btn-cmd")
        .on("click", function () {   //执行命令
            $.post("/CommonApplies/ExeCmd?id=" +$("#processId").val() +"&cmd=" +$(this).val() ,
               function (data) {
                   if (data.statusCode == "200") {
                       BJUI.dialog('refresh', 'detailDlg');
                   }
                   else {
                       $(this).alertmsg('warn', data.message);
                   }
               },'json');
        });
});

//@@ sourceURL=processDetail.js