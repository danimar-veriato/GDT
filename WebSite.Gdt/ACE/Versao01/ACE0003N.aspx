<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ACE0003N.aspx.cs" Inherits="ACE_Versao01_ACE0003N" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="~/ACEN1010.ascx" TagPrefix="uc1" TagName="ACEN1010" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">

    <title>DOMSGE | www.domsge.com.br</title>
    <link href="../../template/css/bootstrap.min.css" rel="stylesheet" />
    <link href="../../template/font-awesome/css/font-awesome.css" rel="stylesheet" />
    <link href="../../template/css/animate.css" rel="stylesheet" />
    <link href="../../template/css/style.css" rel="stylesheet" />
    <link href="../../template/js/plugins/bootstrap-select/bootstrap-select.css" rel="stylesheet" />
    <link href="../../template/dominio/css/dominio-custom.css" rel="stylesheet" />

    <!-- Toastr style -->
    <link href="../../template/css/plugins/toastr/toastr.min.css" rel="stylesheet">

    <style>
        .dropdown-menu > li > a
        {
            line-height: 15px;
            margin: 2px;
        }

        .selected:focus, a
        {
            outline: none !important;
            border: none;
        }

        .bootstrap-select .btn:focus
        {
            outline: solid 1px #18a689 !important;
            border: none;
        }
    </style>
</head>
<body class="gray-bg">
    <form id="form1" runat="server" class="m-t">
        <cc1:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server" EnableScriptGlobalization="True">
        </cc1:ToolkitScriptManager>
        <asp:UpdatePanel ID="upLogin" runat="server">
            <ContentTemplate>
                <div class="middle-box text-center loginscreen  animated fadeInDown">
                    <div>
                        <div>
                            <h1 class="logo-name">SGE</h1>
                        </div>
                        <h3>DOMSGE | www.domsge.com.br</h3>


                        <div class="alert alert-danger alert-dismissable" runat="server" id="divMsg" visible="false">
                            <a href="#" class="close" data-dismiss="alert">×</a> <i class="icon-warning-sign"></i>
                            <asp:Label ID="lblMsg" runat="server"></asp:Label>
                        </div>
                        <asp:Panel ID="tabelaLogin" CssClass="PanelLoginEmpresa" DefaultButton="btnLogin"
                            Visible="true" runat="server">
                            <div class="form-group">
                                <asp:TextBox ID="txtLogin" runat="server" CssClass="form-control" MaxLength="10" placeholder="Usuário" required=""></asp:TextBox>
                            </div>
                            <div class="form-group">
                                <asp:TextBox ID="txtSenha" TextMode="password" CssClass="form-control" runat="server" MaxLength="20" placeholder="Senha" required=""></asp:TextBox>
                            </div>
                            <div class="form-group">
                                <asp:LinkButton class="btn btn-primary btn-block" ID="btnLogin" runat="server" OnClick="btnLogin_onClick">Login</asp:LinkButton>
                            </div>

                        </asp:Panel>
                        <asp:Panel ID="PanelLoginEmpresa" CssClass="PanelLoginEmpresa" DefaultButton="LoginEmpresa"
                            runat="server" Visible="false">
                            <div class="form-group">
                                <asp:TextBox placeholder="Código" autocomplete="off" CssClass="form-control" runat="server" ID="codEmpresa"></asp:TextBox>

                            </div>
                            <div class="form-group">
                                <asp:DropDownList CssClass="form-control selectpicker" ID="selEmpresa" runat="server">
                                </asp:DropDownList>

                            </div>
                            <div class="form-group">
                                <asp:LinkButton CssClass="btn btn-primary btn-block" ID="LoginEmpresa" runat="server"
                                    OnClick="LoginEmpresa_Click">Prosseguir</asp:LinkButton>
                            </div>

                        </asp:Panel>



                        <p class="m-t"><small>DomSGE - Sistema de Gestão Integrado &copy; 2014</small> </p>
                    </div>
                </div>
                <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                    <ProgressTemplate>
                        <uc1:ACEN1010 runat="server" ID="ACEN1010" />
                    </ProgressTemplate>
                </asp:UpdateProgress>

            </ContentTemplate>
        </asp:UpdatePanel>
    </form>
    <script src="../../template/js/jquery-1.10.2.js"></script>
    <script src="../../template/js/bootstrap.min.js"></script>
    <script src="../../template/js/plugins/bootstrap-select/bootstrap-select.js"></script>
    <!-- Toastr script -->
    <script src="../../template/js/plugins/toastr/toastr.min.js"></script>


    <style>
        div, #toast-container.toast-top-center > div
        {
            width: 100%;
            margin: auto;
        }
    </style>

    <script>

        var IEversion = detectIE();

        if (IEversion !== false) {

            if (IEversion == '8' || IEversion == '7') {
                document.write("<div class='toast-top-center' id='toast-container' role='alert' aria-live='polite'><div class='toast toast-error' style='width: 100%;'><button class='toast-close-button' role='button' type='button'>×</button><div class='toast-message'>ATENÇÃO! O Browser que você está utilizando NÃO é homologado. Algumas funções podem não funcionar corretamente.</div></div></div>");
            } else {
                toastr.options = {
                    "closeButton": true,
                    "debug": false,
                    "progressBar": false,
                    "preventDuplicates": false,
                    "positionClass": "toast-top-center",
                    "onclick": null,
                    "showDuration": "99999999",
                    "hideDuration": "99999999",
                    "timeOut": "99999999",
                    "extendedTimeOut": "99999999",
                    "showEasing": "swing",
                    "hideEasing": "linear",
                    "showMethod": "fadeIn",
                    "hideMethod": "fadeOut"
                };

                toastr.error("ATENÇÃO! O Browser que você está utilizando NÃO é homologado. Algumas funções podem não funcionar corretamente.");
            }
        }


        function detectIE() {
            var ua = window.navigator.userAgent;
            var msie = ua.indexOf('MSIE ');
            if (msie > 0) {
                return parseInt(ua.substring(msie + 5, ua.indexOf('.', msie)), 10);
            }
            var trident = ua.indexOf('Trident/');
            if (trident > 0) {
                var rv = ua.indexOf('rv:');
                return parseInt(ua.substring(rv + 3, ua.indexOf('.', rv)), 10);
            }
            var edge = ua.indexOf('Edge/');
            if (edge > 0) {
                return parseInt(ua.substring(edge + 5, ua.indexOf('.', edge)), 10);
            }
            return false;
        }


        $('.selectpicker').selectpicker({
            style: 'form-control'
        });
    </script>
</body>
</html>
