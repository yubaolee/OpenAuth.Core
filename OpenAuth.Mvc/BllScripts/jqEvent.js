$(function () {
    //modal滚动条置顶
    $('.modal').on('shown.bs.modal', function () {  //modal加载完毕后处理数据
        var scroll = $(".modal-body").scrollTop();
        $(".modal-body").scrollTop(0 - scroll);
    });

    //resize to fit page size
    $(window).on('resize.jqGrid', function () {
        $("#maingrid").jqGrid('setGridWidth', $(".gridwidth").width()-10);
        $("#maingrid").removeAttr("style");  //我擦，不去掉style="width:xxx",jqgrid就会有横向滚动条
    });

    //resize on sidebar collapse/expand
   // var parentColumn = $("#maingrid").closest('[class*="col-"]');
    $(document).on('settings.ace.jqGrid', function (ev, event_name, collapsed) {
        if (event_name === 'sidebar_collapsed' || event_name === 'main_container_fixed') {
            //setTimeout is for webkit only to give time for DOM changes and then redraw!!!
            setTimeout(function () {
              //  $("#maingrid").jqGrid('setGridWidth', parentColumn.width());
                $("#maingrid").jqGrid('setGridWidth', $(".gridwidth").width()-10);
                $("#maingrid").removeAttr("style");  //我擦，不去掉style="width:xxx",jqgrid就会有横向滚动条
            }, 0);
        }
    });

    $(window).triggerHandler('resize.jqGrid');//trigger window resize to make the grid get the correct size

    $(document).one('ajaxloadstart.page', function (e) {
        $("#maingrid").jqGrid('GridUnload');
        $('.ui-jqdialog').remove();
    });
});

//replace icons with FontAwesome icons like above
function updatePagerIcons(table) {
    var replacement =
    {
        'ui-icon-seek-first': 'ace-icon fa fa-angle-double-left bigger-140',
        'ui-icon-seek-prev': 'ace-icon fa fa-angle-left bigger-140',
        'ui-icon-seek-next': 'ace-icon fa fa-angle-right bigger-140',
        'ui-icon-seek-end': 'ace-icon fa fa-angle-double-right bigger-140'
    };
    $('.ui-pg-table:not(.navtable) > tbody > tr > .ui-pg-button > .ui-icon').each(function () {
        var icon = $(this);
        var $class = $.trim(icon.attr('class').replace('ui-icon', ''));

        if ($class in replacement) icon.attr('class', 'ui-icon ' + replacement[$class]);
    });
}