
var wfdesigner = undefined;

function wfdesignerRedraw() {
    var data;

    if (wfdesigner != undefined) {
        data = wfdesigner.data;
        wfdesigner.destroy();
    }
    var processid = $("#processId").val();
    var schemecode = $("#schemeCode").val();

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
    $(".workflowcmd")
        .on("click", function () {   //执行命令
            $.post("/FlowInstances/ExeCmd?id=" +$("#processId").val() +"&cmd=" +$(this).val() ,
               function (data) {
                   if (data.Status) {
                       location.reload();
                   }
                   else {
                       alert(data.Message);
                   }
               },'json');
        });
});

 
