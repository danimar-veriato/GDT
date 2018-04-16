<%@ Page Title="" Language="C#" MasterPageFile="~/DOMSGE.master" AutoEventWireup="true" CodeFile="erro_request.aspx.cs" Inherits="erro_request" %>

<%@ MasterType VirtualPath="~/DomSGE.master" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>


<asp:Content ID="Content" ContentPlaceHolderID="phConteudo" runat="Server">

    <div class="middle-box text-center animated fadeInDown" style="margin-top: 10%; left: 50%">
        <h1>OPS</h1>
        <h3 class="font-bold">
            Detectados  caracteres não permitidos
        </h3>
        <div class="error-desc">
            Na requisição anterior foram inclusos caracteres não permitidos no processo, tais como aspas simples e códigos HTML. Usamos essa proteção a fim de garantir que não possa ser incluso no sistema qualquer código malicioso que venha a causar danos à sua estrutura ou aos dispositivos que o acessam. 
            <br />
            Para maiores informações consulte nosso artigo no DomWiki sobre SQL Injection. Obrigado.
            <br />
            <a href="javascript: window.history.go(-1)" class="btn btn-primary">Voltar</a>
            <a href="ACE/Versao01/ACEN6060.aspx" class="btn btn-primary">Dashboard</a>


        </div>
    </div>

</asp:Content>
