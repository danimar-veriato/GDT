/* ==========================================================
 * QuickAdmin v2.0.0
 * tables.js
 * 
 * http://www.mosaicpro.biz
 * Copyright MosaicPro
 *
 * Built exclusively for sale @Envato Marketplaces
 * ========================================================== */
// Traduzido menu e quantidade de itens. - Paulo Marques
// Adicionado small para motrar paginas com 5 items e também
// Tabela Scrollable, que permite mostrar todos items sem pag,
// apenas rolando a barra. (usado na dashboard) - Paulo Marques


$(function()
{
    DomsgeDatatable();
});

$(document).ready(function () {
    Sys.WebForms.PageRequestManager.getInstance().add_endRequest(EndRequestHandler);

    function EndRequestHandler(sender, args) {
        DomsgeDatatable();
    }
});

function DomsgeDatatable() {


    function fnInitCompleteCallback(that) {
        var p = that.parent();
        var l = p.find('label');

        l.each(function (index, el) {
            var iw = $("<div>").addClass('col-md-8').appendTo($(el).parent());
            $(el).parent().addClass('form-group');
            $(el).find('input, select').addClass('form-control').removeAttr('size').appendTo(iw);
            $(el).addClass('col-md-4 control-label');
        });
    }

    /* DataTables */
	// Traduzido menu e quantidade de itens.
    if ($('.dynamicTable').size() > 0) {
        $('.dynamicTable').each(function () {
            // DataTables with TableTools
            if ($(this).is('.tableTools')) {
                $(this).dataTable({
                    "sPaginationType": "bootstrap",
                    "sDom": "<'row'<'col-md-3'T><'col-md-4'l><'col-md-3'f><'col-md-2'C>r>t<'row'<'col-md-6'i><'col-md-6'p>>",
                    "oLanguage": {
                        "sLengthMenu": "_MENU_ Itens por página"
                    },
                    "oTableTools": {
                       // "sSwfPath": commonPath + "../../Template/assets/components/tables/datatables/assets/media/copy_csv_xls_pdf.swf"
                    },
                    "fnInitComplete": function () {
                        fnInitCompleteCallback(this);
                    },
                    //"bSort": false
                });
            }
            else if ($(this).is('.tableToolsNoSort')) {
                $(this).dataTable({
                    "sPaginationType": "bootstrap",
                    "sDom": "<'row'<'col-md-3'T><'col-md-4'l><'col-md-3'f><'col-md-2'C>r>t<'row'<'col-md-6'i><'col-md-6'p>>",
                    "oLanguage": {
                        "sLengthMenu": "_MENU_ Itens por página"
                    },
                    "oTableTools": {
                        //"sSwfPath": commonPath + "../../Template/assets/components/tables/datatables/assets/media/copy_csv_xls_pdf.swf"
                    },
                    "fnInitComplete": function () {
                        fnInitCompleteCallback(this);
                    },
                    "bSort": false,
                    "bPaginate":false
                });
            }
            // colVis extras initialization
            else if ($(this).is('.colVis')) {
                $(this).dataTable({
                    "sPaginationType": "bootstrap",
                    "sDom": "<'row'<'col-md-3'f><'col-md-3'l><'col-md-6'C>r>t<'row'<'col-md-6'i><'col-md-6'p>>",
                    "oLanguage": {
                        "sLengthMenu": "_MENU_ per page"
                    },
                    "fnInitComplete": function () {
                        fnInitCompleteCallback(this);
                    }
                });
            }
            // small initialization
            else if ($(this).is('.small')) {
                $(this).dataTable({
                    "iDisplayLength": "5",
                    "sPaginationType": "bootstrap",
                    "sDom": "<'row'<'col-md-3'f><'col-md-6'l><'col-md-3'C>r>t<'row'<'col-md-6'i><'col-md-6'p>>",
                    "oLanguage": {
                        "sLengthMenu": ""
                    },
                    "fnInitComplete": function () {
                        fnInitCompleteCallback(this);
                    }
                });
            }
            //testando scrool table
            else if ($(this).is('.scroller')) {
                $(document).ready(function () {
                    $('.scroller').dataTable({
                        "iDisplayLength": "10000000",
                        "sScrollY": "180px",
                        "sDom": "frtiS",
                        "bDeferRender": true
                    });
                });
            }
            // default initialization
            else {
                $(this).dataTable({
                    "sPaginationType": "bootstrap",
                    "sDom": "<'row'<'col-md-5'T><'col-md-3'l><'col-md-4'f>r>t<'row'<'col-md-6'i><'col-md-6'p>>",
                    "oLanguage": {
                        "sLengthMenu": "_MENU_ per page"
                    },
                    "fnInitComplete": function () {
                        fnInitCompleteCallback(this);
                    }
                });
            }
        });
    }
}