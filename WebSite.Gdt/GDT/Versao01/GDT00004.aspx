<%@ Page Title="" Language="C#" MasterPageFile="~/DOMSGE.master" AutoEventWireup="true" CodeFile="GDT00004.aspx.cs" Inherits="GDT_Versao01_GDT00004" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="~/ACEN1010.ascx" TagPrefix="uc1" TagName="ACEN1010" %>

<asp:Content ID="Content1" ContentPlaceHolderID="phConteudo" runat="Server">
    <cc1:ToolkitScriptManager ID="ToolkitScriptManager1" EnablePartialRendering="true"
        runat="server" EnableScriptGlobalization="True" ScriptMode="Release">
    </cc1:ToolkitScriptManager>

    <link href="../../template/css/plugins/dropzone/basic.css" rel="stylesheet" />
    <link href="../../template/css/plugins/dropzone/dropzone.css" rel="stylesheet" />
    <link href="../../template/css/plugins/datapicker/datepicker3.css" rel="stylesheet" />
    <link href="../../template/js/plugins/select2/assets/lib/css/select2.css" rel="stylesheet" />
    <link href="../../template/js/plugins/select2/assets/custom/select2-bootstrap.css" rel="stylesheet" />
    <link href="../../template/css/plugins/jasny/jasny-bootstrap.min.css" rel="stylesheet" />

    <style>
        .radio_button_horizontal input[type="radio"] {
            margin-left: 10px;
            margin-right: 1px;
        }

        .clickable {
            cursor: pointer;
        }

        .panel-heading span {
            margin-top: -20px;
            font-size: 15px;
        }
    </style>
    <asp:UpdatePanel ID="updatePanel1" runat="server">
        <ContentTemplate>
            <div class="ibox row" style="position: relative; margin-bottom: 5px;">
                <div class="ibox-title">
                    <h5>GDT00004 - Manutenção de Funcionário</h5>
                    <div class="pull-right">
                        <div class="btn-group">
                            <a href="GDT00004.aspx" id="btnNovoFuncionario" runat="server" class="btn btn-primary btn-xs" data-toggle="tooltip" data-placement="bottom" title="Cadastrar novo funcionário"><i class="fa fa-user-plus"></i>&nbsp;Novo Funcionário</a>
                        </div>
                        <div class="btn-group">
                            <a href="GDT00005.aspx" id="btnConsultaFuncionarios" runat="server" class="btn btn-primary btn-xs" data-toggle="tooltip" data-placement="bottom" title="Lista de funcionários"><i class="fa fa-list"></i>&nbsp;Lista Funcionários</a>
                        </div>
                    </div>
                    <div class="clearfix"></div>
                </div>
            </div>

            <div class="ibox " style="margin-bottom: 10px; z-index: 1;" id="divTop">
                <div class="ibox-content fadeInUp" style="padding-top: 5px; padding-bottom: 5px;">
                    <div role="tabpanel">
                        <!-- Abas -->
                        <ul class="nav nav-tabs" role="tablist">
                            <li role="presentation" class="active"><a href="#geral" aria-controls="geral" role="tab" data-toggle="tab">Informações Gerais</a></li>
                            <li role="presentation"><a href="#contato" aria-controls="contato" role="tab" data-toggle="tab">xxxx</a></li>
                            <li role="presentation"><a href="#avaliacao" aria-controls="avaliacao" role="tab" data-toggle="tab">xxxxx</a></li>
                            <li role="presentation"><a href="#inss" aria-controls="inss" role="tab" data-toggle="tab">xxxx</a></li>
                        </ul>
                    </div>

                    <!-- Conteúdo -->
                    <div class="tab-content">
                        <input type="hidden" id="txtEmprTerceiro" runat="server" />
                        <input type="hidden" id="txtDpesTerceiro" runat="server" />


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

    <script src="../../template/js/plugins/dropzone/dropzone.js"></script>
    <script src="../../template/js/plugins/dataTables/jquery.dataTables.js"></script>
    <script src="../../template/js/plugins/dataTables/dataTables.bootstrap.js"></script>
    <script src="../../template/js/plugins/bootstrap-select/bootstrap-select.js"></script>
    <script src="../../template/js/plugins/select2/assets/lib/js/select2.js"></script>
    <script src="../../template/js/plugins/select2/assets/lib/js/select2_locale_pt-BR.js"></script>
    <script src="../../template/js/plugins/datapicker/bootstrap-datepicker.js"></script>
    <script src="../../template/js/plugins/datapicker/bootstrap-datepicker.pt-BR.js"></script>
    <script src="../../template/js/plugins/easypiechart/jquery.easypiechart.js"></script>
    <script src="../../template/js/plugins/jasny/jasny-bootstrap.min.js"></script>
    <script src="../../template/dominio/js/isotope.pkgd.js"></script>
    <script src="../../template/js/plugins/checkbox/dist/js/bootstrap-checkbox.min.js"></script>
</asp:Content>

