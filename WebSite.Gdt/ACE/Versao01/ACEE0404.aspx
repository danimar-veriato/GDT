<%@ Page Title="" Language="C#" MasterPageFile="~/DOMSGE.master" AutoEventWireup="true" CodeFile="ACEE0404.aspx.cs" Inherits="ACE_Versao01_ACEE0404" %>

<%@ MasterType VirtualPath="~/DomSGE.master" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>


<asp:Content ID="Content" ContentPlaceHolderID="phConteudo" runat="Server">

    <div class="middle-box text-center animated fadeInDown" style="margin-top: 10%; left: 50%">
        <h1>404</h1>
        <h3 class="font-bold">Página não encontrada -
            <asp:Label ID="lblUrl" runat="server" />
        </h3>

        <div class="error-desc">
            Desculpe, mas a página que você está procurando não foi encontrada. Tente verificar a URL, ou então clique em atualizar no seu navegador.
            <br />
            <br />
            <a href="ACEN6060.aspx" class="btn btn-primary">Dashboard</a>


        </div>
    </div>

</asp:Content>
