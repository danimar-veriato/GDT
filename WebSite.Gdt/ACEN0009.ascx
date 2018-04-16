<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ACEN0009.ascx.cs" Inherits="ACE_Versao01_ACEN0009" %>

<div id="modalAlertaLista" class="modal fade">
    <div class="panel panel-default  modal-dialog">
        <div class="panel-heading">
            <asp:Label Text="Lista de alertas" runat="server" ID="Label1" />
            -
            <asp:Label Text="" runat="server" ID="lblCriticidadeTituloLista" />
            <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
        </div>
        <div class="panel-body">
            <div class="panel-group divPanelBody" id="accordion">
            </div>
        </div>
    </div>
</div>
<script>
    function modalAlerta(idAlerta_, tipoAlerta) {

        if (idAlerta_ == 'ALL') {
            retornaJson(tipoAlerta);
        } else {
            var cor = "info";
            var texto = "";
            if (tipoAlerta == 'N') {
                texto = "Normal/Baixo"; //$("#<%=lblCriticidadeTituloLista.ClientID %>").text('Normal/Baixo');
                cor = "info";
            } else if (tipoAlerta == 'C') {
                texto = "Crítico";  //$("#<%=lblCriticidadeTituloLista.ClientID %>").text('Crítico');
                cor = "danger";
            } else {
                texto = "Alto";  //$("#<%=lblCriticidadeTituloLista.ClientID %>").text('Alto');
                cor = "warning";
            }
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../ACE/Versao01/ACEN0008.ashx?codAlerta=" + idAlerta_ + "&tipoAlerta=" + tipoAlerta,
                data: "{}",
                dataType: "json",
                success: function (data) {
                    $(".divPanelBody").empty();

                    $.each(data, function (index, data) {
                        $("#<%=lblCriticidadeTituloLista.ClientID %>").text(texto + ' - ' + data.descAlerta);
                        $(".divPanelBody").append("<div class='panel panel-" + cor + "' ><div class='panel-heading'><h4 class='panel-title'><a data-toggle='collapse' data-parent='#accordion' href='#"
                            + data.id + "' class='collapsed'>" + data.id + " - " + data.titulo + "</a></h4></div><div id='" + data.id
                            + "' class='panel-collapse collapse' style='height: 0px;'><div class='panel-body'>"
                            + "<p><strong>Descrição:</strong>" + data.texto.replace('\n', '<br />') + "</p>"
                            + "<p><strong>Data e hora:</strong>" + data.dthrOcor + "</p></div></div></div>");
                    });

                    $('#modalAlertaLista').modal('show');
                },
                error: function (data) {
                    console.log(data);
                }
            });
        }
    }

    function retornaJson(tipoAlerta) {
        var cor = "info";
        if (tipoAlerta == 'N') {
            $("#<%=lblCriticidadeTituloLista.ClientID %>").text('Normal/Baixo');
            cor = "info";
        } else if (tipoAlerta == 'C') {
            $("#<%=lblCriticidadeTituloLista.ClientID %>").text('Crítico');
            cor = "danger";
        } else {
            $("#<%=lblCriticidadeTituloLista.ClientID %>").text('Alto');
            cor = "warning";
        }

        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../ACE/Versao01/ACEN0008.ashx?exibirTodos=" + tipoAlerta + "",
            data: "{}",
            dataType: "json",
            success: function (data) {
                $(".divPanelBody").empty();

                $.each(data, function (index, data) {
                    $(".divPanelBody").append("<div class='panel panel-" + cor + "' ><div class='panel-heading'><h4 class='panel-title'><a data-toggle='collapse' data-parent='#accordion' href='#"
                        + data.id + "' class='collapsed'>" + data.id + " - " + data.titulo + "</a></h4></div><div id='" + data.id
                        + "' class='panel-collapse collapse' style='height: 0px;'><div class='panel-body'><p><strong>Tipo de alerta:</strong> " + data.tpAlerta
                        + " - " + data.descAlerta + "</p><p><strong>Descrição:</strong>" + data.texto + "</p><p><strong>Data e hora:</strong>"
                        + data.dthrOcor + "</p></div></div></div>");
                });
                
                $('#modalAlertaLista').modal('show');
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                console.log(XMLHttpRequest);
                console.log(textStatus);
                console.log(errorThrown);
            }
        });
    }
</script>
