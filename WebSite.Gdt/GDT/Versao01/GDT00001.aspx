<%@ Page Title="" Language="C#" MasterPageFile="~/DOMSGE.master" AutoEventWireup="true" CodeFile="GDT00001.aspx.cs" Inherits="GDT_Versao01_GDT00001" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="~/ACEN1010.ascx" TagPrefix="uc1" TagName="ACEN1010" %>

<asp:Content ID="Content" ContentPlaceHolderID="phConteudo" runat="Server">
    <cc1:ToolkitScriptManager ID="ToolkitScriptManager1" EnablePartialRendering="true"
        runat="server" EnableScriptGlobalization="True" ScriptMode="Release">
    </cc1:ToolkitScriptManager>

    <style>
        .radio_button_horizontal input[type="radio"] {
            margin-left: 10px;
            margin-right: 1px;
        }

        .legenda_exemplo {
            font-size: 10px;
            color: #909090;
        }
    </style>
    <asp:UpdatePanel ID="updatePanel1" runat="server">
        <ContentTemplate>
            <div class="ibox row" style="position: relative; margin-bottom: 5px;">
                <div class="ibox-title">
                    <h5>GDT00001 - Parâmetros do Sistema GDT</h5>

                    <div class="pull-right">
                        <asp:Button ID="btnSalvar" runat="server" OnClick="btnSalvar_Click" CssClass="btn btn-primary btn-xs" Text="Salvar" />
                    </div>
                </div>
            </div>

            <div class="ibox " style="margin-bottom: 10px; z-index: 1;" id="divTop">
                <div class="ibox-content fadeInUp" style="padding-top: 5px; padding-bottom: 5px;">

                    <div role="tabpanel">
                        <!-- Abas -->
                        <ul class="nav nav-tabs" role="tablist">
                            <li role="presentation" class="active">
                                <a href="#geral" aria-controls="geral" role="tab" data-toggle="tab">Parâmetros Gerais</a></li>
                        </ul>

                        <input type="hidden" id="txtTipoOperacao" runat="server" value="I" />

                        <!-- Conteúdo -->
                        <div class="tab-content">

                            <div role="tabpanel" class="tab-pane active" id="geral">
                                <div style="margin-left: 10px; margin-right: 10px; margin-top: 15px;">

                                    <fieldset>
                                        <legend>Validade de Treinamentos</legend>
                                        <div class="row">
                                            <div class="col-md-2 form-group">
                                                <label>
                                                    Validade NR 10:
                                            <span data-toggle="tooltip" data-placement="top"
                                                title="Validade em anos do treinamento de NR 10 (Segurança em Instalações e Serviços em Eletricidade)">
                                                <i class="fa fa-info-circle alert-info"></i></span>
                                                </label>
                                                <asp:TextBox ID="txtValidadeNR10" MaxLength="10" runat="server" required="true" CssClass="form-control data-lib" Style="text-align: right" type="number" min="1" max="99" step="1"></asp:TextBox>
                                            </div>

                                            <div class="col-md-2 form-group">
                                                <label>
                                                    Validade SEP:
                                            <span data-toggle="tooltip" data-placement="top"
                                                title="Validade em anos do treinamento de Sistema Elétrico de Potência">
                                                <i class="fa fa-info-circle alert-info"></i></span>
                                                </label>
                                                <asp:TextBox ID="txtValidadeSep" MaxLength="2" runat="server" required="true" CssClass="form-control data-lib" Style="text-align: right" type="number" min="1" max="99" step="1"></asp:TextBox>
                                            </div>

                                            <div class="col-md-2 form-group">
                                                <label>
                                                    Validade NR 12:
                                            <span data-toggle="tooltip" data-placement="top"
                                                title="Validade em anos do treinamento de NR 12 (Máquinas e Equipamentos)">
                                                <i class="fa fa-info-circle alert-info"></i></span>
                                                </label>
                                                <asp:TextBox ID="txtValidadeNR12" MaxLength="10" runat="server" required="true" CssClass="form-control data-lib" Style="text-align: right" type="number" min="1" max="99" step="1"></asp:TextBox>
                                            </div>

                                            <div class="col-md-2 form-group">
                                                <label>
                                                    Validade NR 18:
                                            <span data-toggle="tooltip" data-placement="top"
                                                title="Validade em anos do treinamento de NR 18 (Condições e Meio Ambiente para Trabalho na Indústria da Construção)">
                                                <i class="fa fa-info-circle alert-info"></i></span>
                                                </label>
                                                <asp:TextBox ID="txtValidadeNR18" MaxLength="10" runat="server" required="true" CssClass="form-control data-lib" Style="text-align: right" type="number" min="1" max="99" step="1"></asp:TextBox>
                                            </div>

                                            <div class="col-md-2 form-group">
                                                <label>
                                                    Validade NR 33:
                                            <span data-toggle="tooltip" data-placement="top"
                                                title="Validade em anos do treinamento de NR 33 (Segurança e Saúde no Trabalho na Indústria da Construção)">
                                                <i class="fa fa-info-circle alert-info"></i></span>
                                                </label>
                                                <asp:TextBox ID="txtValidadeNR33" MaxLength="10" runat="server" required="true" CssClass="form-control data-lib" Style="text-align: right" type="number" min="1" max="99" step="1"></asp:TextBox>
                                            </div>

                                            <div class="col-md-2 form-group">
                                                <label>
                                                    Validade NR 35:
                                            <span data-toggle="tooltip" data-placement="top"
                                                title="Validade em anos do treinamento de NR 35 (Trabalho em Altura)">
                                                <i class="fa fa-info-circle alert-info"></i></span>
                                                </label>
                                                <asp:TextBox ID="txtValidadeNR35" MaxLength="10" runat="server" required="true" CssClass="form-control data-lib" Style="text-align: right" type="number" min="1" max="99" step="1"></asp:TextBox>
                                            </div>

                                        </div>
                                        

                                    </fieldset>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="clearfix"></div>
                </div>
            </div>

            <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                <ProgressTemplate>
                    <uc1:ACEN1010 runat="server" ID="ACEN1010" />
                </ProgressTemplate>
            </asp:UpdateProgress>

        </ContentTemplate>
    </asp:UpdatePanel>

</asp:Content>

