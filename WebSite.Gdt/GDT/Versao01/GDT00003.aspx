<%@ Page Title="" Language="C#" MasterPageFile="~/DOMSGE.master" AutoEventWireup="true" CodeFile="GDT00003.aspx.cs" Inherits="GDT_Versao01_GDT00003" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="~/ACEN1010.ascx" TagPrefix="uc1" TagName="ACEN1010" %>


<asp:Content ID="Content1" ContentPlaceHolderID="phConteudo" Runat="Server">
    <cc1:ToolkitScriptManager ID="ToolkitScriptManager1" EnablePartialRendering="true"
        runat="server" EnableScriptGlobalization="True" ScriptMode="Release">
    </cc1:ToolkitScriptManager>

    <link href="../../template/css/plugins/dataTables/CDNdataTables.bootstrap.css" rel="stylesheet" />
    <link href="../../template/css/plugins/datapicker/datepicker3.css" rel="stylesheet" />

    <asp:UpdatePanel ID="updatePanel1" runat="server">
        <ContentTemplate>
             <div class="ibox row" style="position: relative; margin-bottom: 5px;">
                <div class="ibox-title">
                    <h5>GDT00003 - Consulta de Terceiros</h5>
                    <div class="pull-right">
                        <a href="GDT00002.aspx" class="btn btn-primary btn-xs" data-toggle="tooltip" data-placement="bottom" title="Cadastrar novo terceiro"><i class="fa fa-user-plus"></i>&nbsp;Novo Terceiro</a>
                    </div>
                    <div class="clearfix"></div>
                </div>
            </div>

            <div class="ibox " style="margin-bottom: 10px; z-index: 1;" id="divTop">
                <div class="ibox-content fadeInUp" style="padding-top: 5px; padding-bottom: 5px;">
                    <div class="row">
                        <input type="hidden" class="form-control" runat="server" id="txtEmpresaFiltro" title="" />
                        <table id="terceirosTable" class="display nowrap compact cell-border" cellspacing="0" width="100%">
                            <caption><h2 style="font-weight: bold">Terceiros cadastrados</h2></caption>
                            <thead>
                                <tr>
                                    <th>Edição</th>                                    
                                    <th>Terceiro</th>
                                    <th>Razão Social</th>
                                    <th>Situação</th>
                                    <th>Venc. Alvará</th>
                                    <th>Venc. CND Federal</th>
                                    <th>Venc. CND Municipal</th>
                                </tr>
                            </thead>
                            <tbody>
                            </tbody>

                        </table>
                    </div>
                </div>
            </div>
            <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                <ProgressTemplate>
                    <uc1:ACEN1010 runat="server" ID="ACEN1010" />
                </ProgressTemplate>
            </asp:UpdateProgress>
        </ContentTemplate>
    </asp:UpdatePanel>

    <script src="../../template/js/plugins/datapicker/bootstrap-datepicker.js"></script>
    <script src="../../template/js/plugins/datapicker/bootstrap-datepicker.pt-BR.js"></script>
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/v/dt/dt-1.10.15/datatables.min.css" />
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/buttons/1.3.1/css/buttons.dataTables.min.css" />
    <script type="text/javascript" src="https://cdn.datatables.net/v/dt/dt-1.10.15/datatables.min.js"></script>
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.15/css/jquery.dataTables.min.css" />

    <script type="text/javascript" src="https://cdn.datatables.net/1.10.15/js/jquery.dataTables.min.js"></script>
    <script type="text/javascript" src="https://cdn.datatables.net/buttons/1.3.1/js/dataTables.buttons.min.js"></script>
    <script type="text/javascript" src="https://cdn.datatables.net/buttons/1.3.1/js/buttons.colVis.min.js"></script>
    <%--Excell--%>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
    <script type="text/javascript" src="https://cdn.datatables.net/buttons/1.3.1/js/buttons.html5.min.js"></script>
    <%--checkbox--%>
    <script type="text/javascript" src="https://cdn.datatables.net/select/1.2.2/js/dataTables.select.min.js"></script>
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/select/1.2.2/css/select.dataTables.min.css" />

    <script type="text/javascript">
        //monta a tabela de terceiros
        $(document).ready(function () {
            $.ajax({
                type: "POST",
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                url: "GDT00003.aspx/GetTerceiros",
                data: "{'empresa':'" + $("[id$=txtEmpresaFiltro]").val() + "'}",
                success: function (data) {
                    var datatableVariable = $('#terceirosTable').DataTable({
                        "scrollY": true,
                        "scrollX": true,
                        "pagingType": "full_numbers",
                        "processing": true,
                        dom: 'Bfrtip',
                        buttons: [
                            {
                                extend: 'collection',
                                text: 'Funcionalidades',
                                buttons: [{
                                    extend: 'excelHtml5',
                                    text: '<i class="fa fa-file-excel-o"> Excel</i>',
                                    titleAttr: 'Excel',
                                    title: 'Terceiros',
                                    exportOptions: {
                                        columns: ':visible'
                                    },
                                    customize: function (xlsx) {
                                        var sheet = xlsx.xl.worksheets['sheet1.xml'];

                                        $('row c[r^="C"]', sheet).attr('s', '2');
                                    }
                                },
                                  'colvis'
                                ]

                            }
                        ],

                        language: {
                            decimal: ",",
                            thousands: ".",
                            processing: "Processando...",
                            search: "Filtrar:&nbsp;&nbsp;",
                            lengthMenu: "_MENU_ registros por página",
                            info: "Exibindo de _START_ até _END_ de _TOTAL_ registros",
                            infoEmpty: "Nenhum registro para exibir",
                            infoFiltered: " (filtrado de _MAX_ registros)",
                            infoPostFix: "",
                            loadingRecords: "Por favor aguarde - carregando...",
                            zeroRecords: "Nenhum registro para exibir",
                            emptyTable: "Nenhum registro encontrado",
                            paginate: {
                                first: "Primeira página",
                                previous: "Página anterior",
                                next: "Próxima página",
                                last: "Última página"
                            },
                            aria: {
                                sortAscending: ": Ordenar colunas de forma ascendente",
                                sortDescending: ": Ordenar colunas de forma descendente"
                            }
                        },
                        aaSorting: [],
                        "aaData": JSON.parse(data.d),
                        "aoColumns": [
                            {
                                orderable: false,
                                "mData": "EmprCodigo",
                                "mData": "DpesCodigo",
                                "fnCreatedCell": function (nTd, sData, oData, iRow, iCol) {
                                    $(nTd).html("<a href='GDT00002.aspx?empr=" + oData.EmprCodigo + "&dpesCod=" + oData.DpesCodigo + "'> <i class=\"fa fa-edit\"> Editar" + "</a></i>");
                                }
                            },                                                        
                            { "mData": "DpesCodigo", "className": "dt-right" },
                            { "mData": "RazaoSocial" },
                            { "mData": "Situacao" },
                            { "mData": "DtVencAlvara" },
                            { "mData": "DtVencCndFederal" },
                            { "mData": "DtVencCndMunicipal" }
                        ],
                        //pinta a coluna de vemelho se a data estiver vencida
                        "columnDefs": [
                        {
                            "targets": [4,5,6],
                            "createdCell": function (td, cellData, rowData, row, col) {                                                               
                                var color;
                                var strData = cellData;
                                var partesData = strData.split("/");
                                var data = new Date(partesData[2], partesData[1] - 1, partesData[0]);                                

                                if (data > new Date()) {
                                    color = '#0099CC';
                                    fonte = '#FFFFFF';
                                } else {
                                    color = '#FF4040';
                                    fonte = '#FFFFFF';
                                }
                                $(td).css('background', color);
                                $(td).css('color', fonte);
                            }
                        }
                        ]
                    });
                },
                error: function (request, status, error) {
                    alert("Erro GetTerceiros:" + request.responseText);
                }
            });
        });



        $('.input-daterange').datepicker({
            keyboardNavigation: false,
            todayBtn: "linked",
            calendarWeeks: true,
            forceParse: false,
            autoclose: true,
            format: 'dd/mm/yyyy'
        });
    </script>
</asp:Content>

