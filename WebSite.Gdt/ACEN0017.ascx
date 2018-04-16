<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ACEN0017.ascx.cs" Inherits="ACEN0017" %>
<nav id="mp-menu" class="mp-menu">
    <div class="mp-level">
        <h2>
            <asp:Image runat="server" ID="LogotipoEmpresaLogada1" />
            <asp:Image runat="server" ID="LogotipoEmpresaLogada" />
        </h2>
        <ul>

            <li class="icon icon-display"><a data-prog="ACEN6060|Dashboard" href="../../ACE/Versao01/ACEN6060.aspx">Dashboard</a>
            </li>

            <asp:PlaceHolder runat="server" ID="phMenuAcessos" />


        </ul>

    </div>
</nav>

<script>
    $(".mp-level a").click(function (element) {
        var codProg = $(this).attr('data-prog').split('|')[0];
        var codTrans = $(this).attr('data-prog').split('|')[1];

        console.log(codProg);

        if (codProg != null) {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../ACEN0018.ashx?codProg=" + codProg + "&codTrans=" + codTrans,
                data: "{}",
                dataType: "json",
                success: function (data) {
                    console.log(data);
                }
            });
        }
    });
</script>
