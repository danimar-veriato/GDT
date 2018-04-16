<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ACE6065N.aspx.cs" Inherits="ACE_Versao01_ACE6065N" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>DOMSGE | www.domsge.com.br    </title>

    <link href="../../template/css/bootstrap.min.css" rel="stylesheet">
    <link href="../../template/font-awesome/css/font-awesome.css" rel="stylesheet">

    <link href="../../template/css/animate.css" rel="stylesheet">
    <link href="../../template/css/style.css" rel="stylesheet">
</head>
<body class="gray-bg">


    <div class="middle-box text-center animated fadeInDown">
        <h2><strong><asp:Label ID="lblCodigo" runat="server"></asp:Label></strong></h2>
        <h3 class="font-bold"><asp:Label ID="lblDescricao" runat="server"></asp:Label></h3>

        <div class="error-desc">
            <asp:Label ID="lblDetalhe" runat="server"></asp:Label> <br/><a href="../../ACE/Versao01/ACEN60600.aspx" class="btn btn-primary m-t">Retornar</a>
        </div>
    </div>

    <!-- Mainly scripts -->
    <script src="../../template/js/jquery-1.10.2.js"></script>
    <script src="../../template/js/bootstrap.min.js"></script>

</body>
</html>
