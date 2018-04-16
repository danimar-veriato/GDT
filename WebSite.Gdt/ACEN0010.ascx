<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ACEN0010.ascx.cs" Inherits="ACE_Versao01_ACEN0010" %>
<li class="dropdown"><a class="dropdown-toggle count-info" onclick="javascript:alertaCritico('C');" data-toggle="dropdown"
    href="#"><i class="fa fa-exclamation-triangle"></i><span runat="server" style="display: none;" class="label label-danger SpanDanger">
        <asp:Label Text="" runat="server" ID="lblAlertCritica" CssClass="lblCritico" /></span> </a>
    <ul class="dropdown-menu dropdown-alerts conteudoCritico">
    </ul>
</li>
<li class="dropdown"><a class="dropdown-toggle count-info" onclick="javascript:alertaAlto('A');" data-toggle="dropdown"
    href="#">
    <i class="fa fa-bell"></i><span runat="server" style="display: none;" class="label label-warning SpanWarning">
        <asp:Label Text="" runat="server" ID="lblAlertAlta" CssClass="lblAlto" /></span> </a>
    <ul class="dropdown-menu dropdown-alerts conteudoAlto">
    </ul>
</li>
<li class="dropdown"><a class="dropdown-toggle count-info" onclick="javascript:alertaNormal('N');" data-toggle="dropdown"
    href="#"><i class="fa fa-info-circle"></i><span style="display: none;" class="label label-info SpanInfo">
        <asp:Label Text="" runat="server" ID="lblAlertNormal" CssClass="lblNormal" /></span> </a>
    <ul class="dropdown-menu dropdown-alerts conteudoNormal">
    </ul>
</li>
<input type="hidden" id="codEmpr" value="" runat="server" />
<input type="hidden" id="codUsu" value="" runat="server" />

<style>
    .divAlert::-webkit-scrollbar
    {
        width: 6px;
    }

    /* Track */
    .divAlert::-webkit-scrollbar-track
    {
        -webkit-box-shadow: inset 0 0 6px rgba(185, 185, 185,0.3);
        -webkit-border-radius: 10px;
        border-radius: 10px;
    }

    /* Handle */
    .divAlert::-webkit-scrollbar-thumb
    {
        -webkit-border-radius: 10px;
        border-radius: 10px;
        background: rgba(185, 185, 185,0.8);
        -webkit-box-shadow: inset 0 0 6px rgba(185, 185, 185,0.5);
    }

        .divAlert::-webkit-scrollbar-thumb:window-inactive
        {
            background: rgba(185, 185, 185,0.4);
        }

    .sweet-alert p
    {
        color: #797979;
        font-size: inherit;
        font-weight: 300;
        position: relative;
        text-align: left;
    }

    .sweet-alert h2
    {
        color: #575757;
        font-size: 16px;
        text-align: left;
        font-weight: 300;
        text-transform: none;
        position: relative;
        margin: 0px 0px 3px 0px;
        padding: 0;
        line-height: 40px;
        display: block;
        border-bottom: 1px solid #e7eaec;
    }

    .sweet-alert button
    {
        background-color: #8CD4F5;
        color: white;
        border: none;
        box-shadow: none;
        font-size: 12px;
        font-weight: inherit;
        -webkit-border-radius: 2px;
        border-radius: 2px;
        padding: 3px 7px;
        margin: 26px 5px 0 5px;
        cursor: pointer;
    }

    .adiarItemBtn
    {
        color: white;
        background-color: #C1C1C1;
    }

        .adiarItemBtn:hover
        {
            color: white;
            background-color: #b9b9b9;
        }
</style>
<script>
    function alertaNormal(tpAlerta) {
        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../ACE/Versao01/ACEN0008.ashx?tpAlerta=N&codEmpr=" + $("#<%=codEmpr.ClientID %>").val() + "&codUsu=" + $("#<%=codUsu.ClientID %>").val(),
            data: "{}",
            dataType: "json",
            success: function (data) {
                $(".conteudoNormal").empty();

                $.each(data, function (index, data) {
                    $(".conteudoNormal").append("<li><a href=\"#\" onclick=\"javascript:modalAlerta('" + data.seq + "', '" + tpAlerta + "');\"><div>"
                        + "<i class=\"" + data.icone + "\"></i> "
                        + data.descricao + " <span class=\"pull-right  small label label-info\">"
                        + data.count + "</span></div></a></li><li class=\"divider\"></li>");
                });

                $(".conteudoNormal").append("<li><div class=\"text-center link-block\"><a href=\"#\" onclick=\"javascript:modalAlerta('ALL', '" + tpAlerta + "');\"> "
                    + "<strong>Ver todos</strong> <i class=\"fa fa-angle-right\"></i></a></div></li></ul>");
            },
            error: function (xhr, status) {
                $(".conteudoNormal").empty();
                $(".conteudoNormal").append("<li><div class=\"text-center\"><i class=\"fa fa-thumbs-o-up fa-fw\"></i>"
                    + "Não há nada aqui!</div></li><li class=\"divider\"></li>");
            }
        });
    }

    function alertaAlto(tpAlerta) {
        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../ACE/Versao01/ACEN0008.ashx?tpAlerta=A&codEmpr=" + $("#<%=codEmpr.ClientID %>").val() + "&codUsu=" + $("#<%=codUsu.ClientID %>").val(),
            data: "{}",
            dataType: "json",
            success: function (data) {
                $(".conteudoAlto").empty();

                $.each(data, function (index, data) {
                    $(".conteudoAlto").append("<li><a href=\"#\" onclick=\"javascript:modalAlerta('" + data.seq + "', '" + tpAlerta + "');\">" +
                        "<div><i class=\"" + data.icone + "\"></i> " + data.descricao + " <span class=\"pull-right  small label label-warning\">"
                        + data.count + "</span></div></a></li><li class=\"divider\"></li>");
                });

                $(".conteudoAlto").append("<li><div class=\"text-center link-block\"><a href=\"#\" onclick=\"javascript:modalAlerta('ALL', '" + tpAlerta + "');\"> "
                    + "<strong>Ver todos</strong> <i class=\"fa fa-angle-right\"></i></a></div></li></ul>");
            },
            error: function (xhr, status) {
                $(".conteudoAlto").empty();
                $(".conteudoAlto").append("<li><div class=\"text-center\"><i class=\"fa fa-thumbs-o-up fa-fw\"></i>"
                    + "Não há nada aqui!</div></li><li class=\"divider\"></li>");
            }
        });
    }

    function alertaCritico(tpAlerta) {
        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../ACE/Versao01/ACEN0008.ashx?tpAlerta=C&codEmpr=" + $("#<%=codEmpr.ClientID %>").val() + "&codUsu=" + $("#<%=codUsu.ClientID %>").val(),
            data: "{}",
            dataType: "json",
            success: function (data) {
                $(".conteudoCritico").empty();

                $.each(data, function (index, data) {
                    $(".conteudoCritico").append("<li><a href=\"#\" onclick=\"javascript:modalAlerta('" + data.seq + "', '" + tpAlerta + "');\">" +
                        "<div><i class=\"" + data.icone + "\"></i> " + data.descricao + " <span class=\"pull-right  small label label-danger\">"
                        + data.count + "</span></div></a></li><li class=\"divider\"></li>");
                });

                $(".conteudoCritico").append("<li><div class=\"text-center link-block\"><a href=\"#\" onclick=\"javascript:modalAlerta('ALL', '" + tpAlerta + "');\"> "
                    + "<strong>Ver todos</strong> <i class=\"fa fa-angle-right\"></i></a></div></li></ul>");
            },
            error: function (xhr, status) {
                $(".conteudoCritico").empty();
                $(".conteudoCritico").append("<li><div class=\"text-center\"><i class=\"fa fa-thumbs-o-up fa-fw\"></i>"
                    + "Não há nada aqui!</div></li><li class=\"divider\"></li>");
            }
        });
    }

    window.setInterval(function () {
        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../ACE/Versao01/ACEN0008.ashx?refresh=S",
            data: "{}",
            dataType: "json",
            success: function (data) {
                $.each(data, function (index, data) {
                    $(".lblNormal").text(data.normal);
                    if (data.normal > 0) {
                        $(".SpanInfo").css("display", "inline");
                    } else {
                        $(".SpanInfo").css("display", "none");
                    }
                    $(".lblAlto").text(data.alto);
                    if (data.alto > 0) {
                        $(".SpanWarning").css("display", "inline");
                    } else {
                        $(".SpanWarning").css("display", "none");
                    }
                    $(".lblCritico").text(data.critico);
                    if (data.critico > 0) {
                        $(".SpanDanger").css("display", "inline");
                    } else {
                        $(".SpanDanger").css("display", "none");
                    }
                });
            },
        });

        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../ACE/Versao01/ACEN0008.ashx?verifyAlert=S",
            data: "{}",
            dataType: "json",
            success: function (data) {
                var textoAlerta = "<div class='feed-activity-list divAlert' style='overflow-y: auto; max-height:40vh; padding-right:3px;'>";
                var seqAlerta = '';

                $.each(data, function (index, data) {
                    textoAlerta = textoAlerta + "	<div class='feed-element' id='item-agenda-" + data.id + "'>" +
                                                  "		<div>" +
                                                  "			<small class='pull-right text-navy'>" +
                                                  "         </small>" +
                                                  "			<strong>" + data.titulo + "</strong>" +
                                                  "			<div>" + data.texto + "</div>" +
                                                  "			<small class='text-muted'>" + data.dthrOcor + "</small>" +
                                                  "			<small class='pull-right text-navy'>" +
                                                  "             <a type='button' class='label label-default adiarItemBtn' onclick='javascript:adiarItem(" + data.id + ");'>Adiar</a>" +
                                                  "             <a type='button' class='label label-primary' onclick='javascript:descartarItem(" + data.id + ");'>Descartar</a>" +
                                                  "         </small>" +
                                                  "		</div>" +
                                                  "	</div>";
                    seqAlerta = seqAlerta + data.id + ',';
                });

                textoAlerta = textoAlerta + "</div>";
                swal({
                    title: "Alerta DomSge!",
                    text: "<div >" + textoAlerta + "</div>",
                    html: true,
                    confirmButtonColor: '#1ab394',
                    showCancelButton: true,
                    closeOnConfirm: false,
                    showLoaderOnConfirm: true,
                    confirmButtonText: 'Descartar tudo',
                    cancelButtonText: 'Adiar tudo (15min)',
                },
                function (isConfirm) {
                    if (isConfirm) {
                        $.ajax({
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "../../ACE/Versao01/ACEN0008.ashx?readAlert=" + seqAlerta.slice(0, -1),
                            data: "{}",
                            dataType: "json",
                            success: function (data) {

                            },
                        });
                        setTimeout(function () { swal.close(); }, 1000);

                    } else {
                        $.ajax({
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "../../ACE/Versao01/ACEN0008.ashx?remindLater=" + seqAlerta.slice(0, -1),
                            data: "{}",
                            dataType: "json",
                            success: function (data) {
                                //alguma coisa...
                            },
                        });
                    }
                });
            },
        });
    }, 10000);

    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../ACE/Versao01/ACEN0008.ashx?refresh=S",
        data: "{}",
        dataType: "json",
        success: function (data) {
            $.each(data, function (index, data) {
                $(".lblNormal").text(data.normal);
                if (data.normal > 0) {
                    $(".SpanInfo").css("display", "inline");
                } else {
                    $(".SpanInfo").css("display", "none");
                }
                $(".lblAlto").text(data.alto);
                if (data.alto > 0) {
                    $(".SpanWarning").css("display", "inline");
                } else {
                    $(".SpanWarning").css("display", "none");
                }
                $(".lblCritico").text(data.critico);
                if (data.critico > 0) {
                    $(".SpanDanger").css("display", "inline");
                } else {
                    $(".SpanDanger").css("display", "none");
                }
            });
        },
    });

    function adiarItem(id) {
        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../ACE/Versao01/ACEN0008.ashx?remindLater=" + id,
            data: "{}",
            dataType: "json",
            success: function (data) {

            },
        });


        var elem = $('.divAlert');

        if (elem.children().length == 1) {
            swal.close();
        }

        $('#item-agenda-' + id).fadeOut("slow", function () {
            $('#item-agenda-' + id).remove();
        });
    }

    function descartarItem(id) {
        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../ACE/Versao01/ACEN0008.ashx?readAlert=" + id,
            data: "{}",
            dataType: "json",
            success: function (data) {

            },
        });

        var elem = $('.divAlert');

        if (elem.children().length == 1) {
            swal.close();
        }

        $('#item-agenda-' + id).fadeOut("slow", function () {
            $('#item-agenda-' + id).remove();
        });
    }
</script>
