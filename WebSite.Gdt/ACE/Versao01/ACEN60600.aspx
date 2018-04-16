<%@ Page Title="" Language="C#" MasterPageFile="~/DOMSGE.master" AutoEventWireup="true" CodeFile="ACEN60600.aspx.cs" Inherits="ACE_Versao01_ACEN60600" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content2" ContentPlaceHolderID="phConteudo" runat="Server">
    <cc1:ToolkitScriptManager ID="ToolkitScriptManager1" EnablePartialRendering="true"
        runat="server" EnableScriptGlobalization="True" ScriptMode="Release" EnablePageMethods="true">
    </cc1:ToolkitScriptManager>

    <style>
        .h2-img {
            font-size: 20px !important;
        }
        .img-logo {
            margin-top: -17px;
        }
        .favLink {
            font-size: 12px;
            color: #676a6c;
            font-weight: 600;
        }
        .li-link:hover {
            background-color: #1ab394;
            color: #fff;
        }
        div.popover.fade.left.in {
            max-width: none !important;
        }
        .popover-list {
            cursor: pointer;
        }
        .min-height {
            min-height: 39px;
        }
        .QuckAccess {
            background-color: #F3F3F4;
            border: 1 solid #1AB394;
            border-bottom: 1px solid #1AB394;
        }
        .icone-buscar-sol {
            color: #ed761c;
            margin-left: -44px !important;
            padding-right: 15px;
            padding-top: 5px;
        }
    </style>
    <asp:UpdatePanel ID="updatePanel1" runat="server">
        <ContentTemplate>
            <div class="text-center"><h1>SOEF-Sistema de Orçamentos Eletrônico Fockink</h1></div>
            <div class="col-md-12">
                <div class="row">
                    <div class="col-lg-3">
                        <a href="../../SOEF/Versao01/SOFN00002.aspx">
                            <div class="widget style1 navy-bg">
                                <div class="row">
                                    <div class="col-xs-4">
                                        <i class="fa fa-usd fa-5x"></i>
                                    </div>
                                    <div class="col-xs-8 text-right">
                                        <span>Lista de solicitações </span>
                                        <h2 class="font-bold h2-img">Comercial</h2>
                                    </div>
                                </div>
                            </div>
                        </a>
                    </div>
                    <div class="col-lg-3">
                        <a href="../../SOEF/Versao01/SOFN00006.aspx">
                            <div class="widget style1 blue-bg">
                                <div class="row">
                                    <div class="col-xs-4">
                                        <i class="fa fa-user fa-5x"></i>
                                    </div>
                                    <div class="col-xs-8 text-right">
                                        <span>Lista de solicitações </span>
                                        <h2 class="font-bold h2-img">Orçamentista</h2>
                                    </div>
                                </div>
                            </div>
                        </a>
                    </div>                                        
                </div>
            </div>
            <div class="sidebar-content">
                <div class="sidebard-panel" style="min-height: 100%">
                    <div>
                        <h4>Menú rápido </h4>
                        <ul class="todo-list m-t ui-sortable " style="cursor: pointer; margin-left: -20px; margin-right: -20px;">
                            <li class="li-link" href="../../SOEF/Versao01/SOFN00001.aspx">
                                <i class="fa fa-plus"></i>
                                <span class="m-l-xs">Nova solicitação</span>
                            </li>
                            <li class="li-link" href="../../SOEF/Versao01/SOFN00008.aspx">
                                <i class="fa fa-check"></i>
                                <span class="m-l-xs">Permissões</span>
                            </li>
                            <li class="li-link" href="../../SOEF/Versao01/SOFN00007.aspx">
                                <i class="fa fa-user"></i>
                                <span class="m-l-xs">Usuário x Representante</span>
                            </li>

                        </ul>
                    </div>
                    <asp:PlaceHolder runat="server" ID="phDashLateral" />
                </div>
            </div>
            <div class="row">                
                <div class="col-lg-2">
                    <div class="ibox">
                        <div class="ibox-content">
                            <div class="row">
                                <div class="col-xs-9">
                                    <h5>Solicitações orçamento</h5>
                                </div>
                                <div class="col-xs-3">
                                    <a class="pull-right" style="margin-left: 5px; color: #1AB394" onclick="javascript:EmGeracao();"><i class="fa fa-refresh"></i></a>
                                </div>
                            </div>
                            <h3 class="no-margins" style="min-height: 33px;"><i class="fa fa-spin fa-spinner" style="display: initial; color: #1AB394;" id="iconSpinGeracao"></i>
                                <div id="divTotalGeracao"></div>
                            </h3>
                            <div style="margin-top: -13px">
                                <div class="stat-percent font-bold" style="color: #1AB394;">
                                    <div class="stat-percent popover-list font-bold">
                                        <i class="fa fa-bars badge-primary popover-trigger-sol-geracao" data-html="true" data-container="body" data-toggle="popover" data-placement="top" data-content="" data-original-title="" title=""></i>
                                    </div>
                                </div>
                                <small>Em Geração</small>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-2">
                    <div class="ibox">
                        <div class="ibox-content">
                            <div class="row">
                                <div class="col-xs-9">
                                    <h5>Solicitações orçamento</h5>
                                </div>
                                <div class="col-xs-3">
                                    <a class="pull-right" style="margin-left: 5px; color: #1AB394" onclick="javascript:AguardandoAceite();"><i class="fa fa-refresh"></i></a>
                                </div>
                            </div>
                            <h3 class="no-margins" style="min-height: 33px;"><i class="fa fa-spin fa-spinner" style="display: initial; color: #1AB394;" id="iconSpinAguardAce"></i>
                                <div id="divTotalAguardAce"></div>
                            </h3>
                            <div style="margin-top: -13px">
                                <div class="stat-percent font-bold" style="color: #1AB394;">
                                    <div class="stat-percent popover-list font-bold">
                                        <i class="fa fa-bars badge-primary popover-trigger-sol-aguardAce" data-html="true" data-container="body" data-toggle="popover" data-placement="top" data-content="" data-original-title="" title=""></i>
                                    </div>
                                </div>
                                <small style="color: #0000FF">Aguard. Aceite Solicitação</small>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-2">
                    <div class="ibox">
                        <div class="ibox-content">
                            <div class="row">
                                <div class="col-xs-9">
                                    <h5>Solicitações orçamento</h5>
                                </div>
                                <div class="col-xs-3">
                                    <a class="pull-right" style="margin-left: 5px; color: #1AB394" onclick="javascript:GeracaoNegocio();"><i class="fa fa-refresh"></i></a>
                                </div>
                            </div>
                            <h3 class="no-margins" style="min-height: 33px;"><i class="fa fa-spin fa-spinner" style="display: initial; color: #1AB394;" id="iconSpinGerNeg"></i>
                                <div id="divTotalGerNeg"></div>
                            </h3>
                            <div style="margin-top: -13px">
                                <div class="stat-percent font-bold" style="color: #1AB394;">
                                    <div class="stat-percent popover-list font-bold">
                                        <i class="fa fa-bars badge-primary popover-trigger-sol-gerNeg" data-html="true" data-container="body" data-toggle="popover" data-placement="top" data-content="" data-original-title="" title=""></i>
                                    </div>
                                </div>
                                <small style="color: #0000FF">Aguard. Ger. Negócio</small>
                            </div>
                        </div>
                    </div>
                </div>                
                <div class="col-lg-2">
                    <div class="ibox">
                        <div class="ibox-content">
                            <div class="row">
                                <div class="col-xs-9">
                                    <h5>Solicitações orçamento</h5>
                                </div>
                                <div class="col-xs-3">
                                    <a class="pull-right" style="margin-left: 5px; color: #1AB394" onclick="javascript:CadastroCronograma();"><i class="fa fa-refresh"></i></a>
                                </div>
                            </div>
                            <h3 class="no-margins" style="min-height: 33px;"><i class="fa fa-spin fa-spinner" style="display: initial; color: #1AB394;" id="iconSpinCadCron"></i>
                                <div id="divTotalCadCron"></div>
                            </h3>
                            <div style="margin-top: -13px">
                                <div class="stat-percent font-bold" style="color: #1AB394;">
                                    <div class="stat-percent popover-list font-bold">
                                        <i class="fa fa-bars badge-primary popover-trigger-sol-cadCron" data-html="true" data-container="body" data-toggle="popover" data-placement="top" data-content="" data-original-title="" title=""></i>
                                    </div>
                                </div>
                                <small style="color: #0000FF">Aguard. Cad. Cronograma</small>
                            </div>
                        </div>
                    </div>
                </div>
                 <div class="col-lg-2">
                    <div class="ibox">
                        <div class="ibox-content">
                            <div class="row">
                                <div class="col-xs-9">
                                    <h5>Solicitações orçamento</h5>
                                </div>
                                <div class="col-xs-3">
                                    <a class="pull-right" style="margin-left: 5px; color: #1AB394" onclick="javascript:LiberadoOrcar();"><i class="fa fa-refresh"></i></a>
                                </div>
                            </div>
                            <h3 class="no-margins" style="min-height: 33px;"><i class="fa fa-spin fa-spinner" style="display: initial; color: #1AB394;" id="iconSpinLibOrc"></i>
                                <div id="divTotalLibOrc"></div>
                            </h3>
                            <div style="margin-top: -13px">
                                <div class="stat-percent font-bold" style="color: #1AB394;">
                                    <div class="stat-percent popover-list font-bold">
                                        <i class="fa fa-bars badge-primary popover-trigger-sol-libOrc" data-html="true" data-container="body" data-toggle="popover" data-placement="top" data-content="" data-original-title="" title=""></i>
                                    </div>
                                </div>
                                <small style="color: #0000FF">Liberado p/ Orçar</small>
                            </div>
                        </div>
                    </div>
                </div>               
            </div>
            <div class="row">
                 <div class="col-lg-2">
                    <div class="ibox">
                        <div class="ibox-content">
                            <div class="row">
                                <div class="col-xs-9">
                                    <h5>Solicitações orçamento</h5>
                                </div>
                                <div class="col-xs-3">
                                    <a class="pull-right" style="margin-left: 5px; color: #1AB394" onclick="javascript:AguardAceOrcamento();"><i class="fa fa-refresh"></i></a>
                                </div>
                            </div>
                            <h3 class="no-margins" style="min-height: 33px;"><i class="fa fa-spin fa-spinner" style="display: initial; color: #1AB394;" id="iconSpinAguardAceOrc"></i>
                                <div id="divTotalAguardAceOrc"></div>
                            </h3>
                            <div style="margin-top: -13px">
                                <div class="stat-percent font-bold" style="color: #1AB394;">
                                    <div class="stat-percent popover-list font-bold">
                                        <i class="fa fa-bars badge-primary popover-trigger-sol-AguardAceOrc" data-html="true" data-container="body" data-toggle="popover" data-placement="top" data-content="" data-original-title="" title=""></i>
                                    </div>
                                </div>
                                <small>Aguard. Aceite Orçamento</small>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-2">
                    <div class="ibox">
                        <div class="ibox-content">
                            <div class="row">
                                <div class="col-xs-9">
                                    <h5>Solicitações orçamento</h5>
                                </div>
                                <div class="col-xs-3">
                                    <a class="pull-right" style="margin-left: 5px; color: #1AB394" onclick="javascript:OrcamentoAceito();"><i class="fa fa-refresh"></i></a>
                                </div>
                            </div>
                            <h3 class="no-margins" style="min-height: 33px;"><i class="fa fa-spin fa-spinner" style="display: initial; color: #1AB394;" id="iconSpinOrcAceito"></i>
                                <div id="divTotalOrcAceito"></div>
                            </h3>
                            <div style="margin-top: -13px">
                                <div class="stat-percent font-bold" style="color: #1AB394;">
                                    <div class="stat-percent popover-list font-bold">
                                        <i class="fa fa-bars badge-primary popover-trigger-sol-OrcAceito" data-html="true" data-container="body" data-toggle="popover" data-placement="top" data-content="" data-original-title="" title=""></i>
                                    </div>
                                </div>
                                <small>Orçamento Aceito</small>
                            </div>
                        </div>
                    </div>
                </div>
            </div>            
            <div class="row">
                <div class="form-group">
                    <div class="col-xs-12 col-sm-12 col-md-12">
                        <label class="col-xs-12 col-sm-4 col-md-2 control-label">Pesquisa rápida por:</label>
                        <asp:RadioButtonList ID="rbTipoPesquisa" runat="server" CssClass="radio_button_horizontal" RepeatDirection="Horizontal" ToolTip="Indica o tipo de pesquisa rápida">
                            <asp:ListItem Text="Solicitação" Value="S" Selected="true"></asp:ListItem>
                            <asp:ListItem Text="Negócio (GNF)" Value="N" Selected="false"></asp:ListItem>
                        </asp:RadioButtonList>
                        <div class="col-xs-12 col-sm-6 col-md-4 min-height" id="divBuscaSolic">
                            <a id="btnBuscaAtend" onclick="javascript:quickAccessSolicitacao();"><i class="fa fa-2x fa-share-square-o pull-right icone-buscar-sol" style="color: rgb(26, 179, 148); margin-left: -50px;"></i></a>
                            <input type="number" id="txtNumeroSolRapido" autocomplete="off" class="form-control pull-right QuckAccess" placeholder="Informe a solicitação ou GNF" style="margin-right: 12px;" />
                        </div>
                    </div>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>

    <script>
        $('ul').on('click', 'li', function () {
            if ($(this).attr("href") != null) {
                window.document.location = $(this).attr("href");
            }
        });

        $(document).ready(function () {
            EmGeracao();
            $(".popover-trigger-sol-geracao").click(function () {
                el = $(this);
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "Solicitacao.ashx?type=solicPopoverEG",
                    data: "{}",
                    dataType: "json",
                    success: function (data) {
                        $.each(data, function (index, data) {
                            $(".popover-trigger-sol-geracao").attr('data-content', '<i class="fa fa-spin fa-spinner" style="display: initial;  color: #1AB394;"></i>');
                            $(".popover-trigger-sol-geracao").popover('show');
                            setTimeout(function () {
                                $(".popover-trigger-sol-geracao").attr('data-content', '<div class="animated fadeIn" style="white-space: nowrap;">' + data.conteudo + '</div>');
                                $(".popover-trigger-sol-geracao").popover('show');
                            }, 1000);
                        });
                    }
                });
            });

            AguardandoAceite();
            $(".popover-trigger-sol-aguardAce").click(function () {
                el = $(this);
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "Solicitacao.ashx?type=solicPopoverAA",
                    data: "{}",
                    dataType: "json",
                    success: function (data) {
                        $.each(data, function (index, data) {
                            $(".popover-trigger-sol-aguardAce").attr('data-content', '<i class="fa fa-spin fa-spinner" style="display: initial;  color: #1AB394;"></i>');
                            $(".popover-trigger-sol-aguardAce").popover('show');
                            setTimeout(function () {
                                $(".popover-trigger-sol-aguardAce").attr('data-content', '<div class="animated fadeIn" style="white-space: nowrap;">' + data.conteudo + '</div>');
                                $(".popover-trigger-sol-aguardAce").popover('show');
                            }, 1000);
                        });
                    }
                });
            });

            GeracaoNegocio();
            $(".popover-trigger-sol-gerNeg").click(function () {
                el = $(this);
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "Solicitacao.ashx?type=solicPopoverGN",
                    data: "{}",
                    dataType: "json",
                    success: function (data) {
                        $.each(data, function (index, data) {
                            $(".popover-trigger-sol-gerNeg").attr('data-content', '<i class="fa fa-spin fa-spinner" style="display: initial;  color: #1AB394;"></i>');
                            $(".popover-trigger-sol-gerNeg").popover('show');
                            setTimeout(function () {
                                $(".popover-trigger-sol-gerNeg").attr('data-content', '<div class="animated fadeIn" style="white-space: nowrap;">' + data.conteudo + '</div>');
                                $(".popover-trigger-sol-gerNeg").popover('show');
                            }, 1000);
                        });
                    }
                });
            });

            CadastroCronograma();
            $(".popover-trigger-sol-cadCron").click(function () {
                el = $(this);
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "Solicitacao.ashx?type=solicPopoverCC",
                    data: "{}",
                    dataType: "json",
                    success: function (data) {
                        $.each(data, function (index, data) {
                            $(".popover-trigger-sol-cadCron").attr('data-content', '<i class="fa fa-spin fa-spinner" style="display: initial;  color: #1AB394;"></i>');
                            $(".popover-trigger-sol-cadCron").popover('show');
                            setTimeout(function () {
                                $(".popover-trigger-sol-cadCron").attr('data-content', '<div class="animated fadeIn" style="white-space: nowrap;">' + data.conteudo + '</div>');
                                $(".popover-trigger-sol-cadCron").popover('show');
                            }, 1000);
                        });
                    }
                });
            });

            LiberadoOrcar();
            $(".popover-trigger-sol-libOrc").click(function () {
                el = $(this);
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "Solicitacao.ashx?type=solicPopoverLO",
                    data: "{}",
                    dataType: "json",
                    success: function (data) {
                        $.each(data, function (index, data) {
                            $(".popover-trigger-sol-libOrc").attr('data-content', '<i class="fa fa-spin fa-spinner" style="display: initial;  color: #1AB394;"></i>');
                            $(".popover-trigger-sol-libOrc").popover('show');
                            setTimeout(function () {
                                $(".popover-trigger-sol-libOrc").attr('data-content', '<div class="animated fadeIn" style="white-space: nowrap;">' + data.conteudo + '</div>');
                                $(".popover-trigger-sol-libOrc").popover('show');
                            }, 1000);
                        });
                    }
                });
            });

            AguardAceOrcamento();
            $(".popover-trigger-sol-AguardAceOrc").click(function () {
                el = $(this);
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "Solicitacao.ashx?type=solicPopoverOR",
                    data: "{}",
                    dataType: "json",
                    success: function (data) {
                        $.each(data, function (index, data) {
                            $(".popover-trigger-sol-AguardAceOrc").attr('data-content', '<i class="fa fa-spin fa-spinner" style="display: initial;  color: #1AB394;"></i>');
                            $(".popover-trigger-sol-AguardAceOrc").popover('show');
                            setTimeout(function () {
                                $(".popover-trigger-sol-AguardAceOrc").attr('data-content', '<div class="animated fadeIn" style="white-space: nowrap;">' + data.conteudo + '</div>');
                                $(".popover-trigger-sol-AguardAceOrc").popover('show');
                            }, 1000);
                        });
                    }
                });
            });

            OrcamentoAceito();
            $(".popover-trigger-sol-OrcAceito").click(function () {
                el = $(this);
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "Solicitacao.ashx?type=solicPopoverOA",
                    data: "{}",
                    dataType: "json",
                    success: function (data) {
                        $.each(data, function (index, data) {
                            $(".popover-trigger-sol-OrcAceito").attr('data-content', '<i class="fa fa-spin fa-spinner" style="display: initial;  color: #1AB394;"></i>');
                            $(".popover-trigger-sol-OrcAceito").popover('show');
                            setTimeout(function () {
                                $(".popover-trigger-sol-OrcAceito").attr('data-content', '<div class="animated fadeIn" style="white-space: nowrap;">' + data.conteudo + '</div>');
                                $(".popover-trigger-sol-OrcAceito").popover('show');
                            }, 1000);
                        });
                    }
                });
            });
        });
        function EmGeracao() {
            $("#divTotalGeracao").empty();
            $("#divTotalGeracao").css("display", "initial");
            setTimeout(function () {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "Solicitacao.ashx?type=solicContadorGeracao",
                    data: "{}",
                    dataType: "json",
                    success: function (data) {
                        $.each(data, function (index, data) {
                            $("#divTotalGeracao").empty();
                            $("#divTotalGeracao").append('<div class="animated fadeIn" style="white-space: nowrap; color: #1AB394;">' + data.total + '</div>');
                        });
                        $("#iconSpinGeracao").css("display", "none").fadeOut();
                    }
                });

            }, 1000);
        }

        function AguardandoAceite() {
            $("#divTotalAguardAce").empty();
            $("#divTotalAguardAce").css("display", "initial");
            setTimeout(function () {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "Solicitacao.ashx?type=solicContadorAguardAce",
                    data: "{}",
                    dataType: "json",
                    success: function (data) {
                        $.each(data, function (index, data) {
                            $("#divTotalAguardAce").empty();
                            $("#divTotalAguardAce").append('<div class="animated fadeIn" style="white-space: nowrap; color: #1AB394;">' + data.total + '</div>');
                        });
                        $("#iconSpinAguardAce").css("display", "none").fadeOut();
                    }
                });

            }, 1000);
        }        function GeracaoNegocio() {
            $("#divTotalGerNeg").empty();
            $("#divTotalGerNeg").css("display", "initial");
            setTimeout(function () {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "Solicitacao.ashx?type=solicContadorGerNeg",
                    data: "{}",
                    dataType: "json",
                    success: function (data) {
                        $.each(data, function (index, data) {
                            $("#divTotalGerNeg").empty();
                            $("#divTotalGerNeg").append('<div class="animated fadeIn" style="white-space: nowrap; color: #1AB394;">' + data.total + '</div>');
                        });
                        $("#iconSpinGerNeg").css("display", "none").fadeOut();
                    }
                });

            }, 1000);
        }        function CadastroCronograma() {
            $("#divTotalCadCron").empty();
            $("#divTotalCadCron").css("display", "initial");
            setTimeout(function () {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "Solicitacao.ashx?type=solicContadorCadCron",
                    data: "{}",
                    dataType: "json",
                    success: function (data) {
                        $.each(data, function (index, data) {
                            $("#divTotalCadCron").empty();
                            $("#divTotalCadCron").append('<div class="animated fadeIn" style="white-space: nowrap; color: #1AB394;">' + data.total + '</div>');
                        });
                        $("#iconSpinCadCron").css("display", "none").fadeOut();
                    }
                });

            }, 1000);
        }        function LiberadoOrcar() {
            $("#divTotalLibOrc").empty();
            $("#divTotalLibOrc").css("display", "initial");
            setTimeout(function () {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "Solicitacao.ashx?type=solicContadorLibOrc",
                    data: "{}",
                    dataType: "json",
                    success: function (data) {
                        $.each(data, function (index, data) {
                            $("#divTotalLibOrc").empty();
                            $("#divTotalLibOrc").append('<div class="animated fadeIn" style="white-space: nowrap; color: #1AB394;">' + data.total + '</div>');
                        });
                        $("#iconSpinLibOrc").css("display", "none").fadeOut();
                    }
                });

            }, 1000);
        }        function AguardAceOrcamento() {
            $("#divTotalAguardAceOrc").empty();
            $("#divTotalAguardAceOrc").css("display", "initial");
            setTimeout(function () {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "Solicitacao.ashx?type=solicContadorAguardAceOrc",
                    data: "{}",
                    dataType: "json",
                    success: function (data) {
                        $.each(data, function (index, data) {
                            $("#divTotalAguardAceOrc").empty();
                            $("#divTotalAguardAceOrc").append('<div class="animated fadeIn" style="white-space: nowrap; color: #1AB394;">' + data.total + '</div>');
                        });
                        $("#iconSpinAguardAceOrc").css("display", "none").fadeOut();
                    }
                });

            }, 1000);
        }        function OrcamentoAceito() {
            $("#divTotalOrcAceito").empty();
            $("#divTotalOrcAceito").css("display", "initial");
            setTimeout(function () {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "Solicitacao.ashx?type=solicContadorOrcAceito",
                    data: "{}",
                    dataType: "json",
                    success: function (data) {
                        $.each(data, function (index, data) {
                            $("#divTotalOrcAceito").empty();
                            $("#divTotalOrcAceito").append('<div class="animated fadeIn" style="white-space: nowrap; color: #1AB394;">' + data.total + '</div>');
                        });
                        $("#iconSpinOrcAceito").css("display", "none").fadeOut();
                    }
                });

            }, 1000);
        }                      function quickAccessSolicitacao() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "ACEN60600.aspx/GetDados",
                data: "{'numero':'" + $("#txtNumeroSolRapido").val() + "','tipo':'" + $("[id$=rbTipoPesquisa] input:checked").val() + "'}",
                dataType: "json",
                success: function (data) {
                    var json = JSON.stringify(eval("[" + data.d + "]"));
                    var obj = JSON.parse(data.d);
                    var obj2 = $.parseJSON(obj);
                    $.each(obj2, function (index, data) {
                        if (data.retorno == "0") {
                            $.gritter.add({
                                position: 'bottom-left',
                                title: 'Atençao!',
                                text: 'Solicitação/GNF não existe ou não tens permissão para acessar essa solicitação. Verifique a digitação.',
                                time: 5000
                            });
                            $('#divBuscaSolic').addClass("animated shake");
                            $("#txtNumeroSolRapido").focus();
                            $("#txtNumeroSolRapido").val("");
                            $("#txtNumeroSolRapido").focus();
                            setTimeout(function () {
                                $("#divBuscaSolic").removeClass("animated shake");
                            }, 1500);
                        } else {
                            if (data.retorno != null) {
                                window.location.href = "../../SOEF/Versao01/SOFN00001.aspx?" + data.retorno;
                            }

                        }
                    });
                },
                error: function (xhr, status, error) {
                    alert('Erro acesso rápido solicitação:' + error);
                }
            });
        }        $("#txtNumeroSolRapido").keypress(function (e) {
            //Enter key
            if (e.which == 13) {
                quickAccessSolicitacao();
                return false;
            }
        });
    </script>
</asp:Content>

