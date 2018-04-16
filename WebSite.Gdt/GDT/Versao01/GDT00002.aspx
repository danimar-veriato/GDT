<%@ Page Title="" Language="C#" MasterPageFile="~/DOMSGE.master" AutoEventWireup="true" CodeFile="GDT00002.aspx.cs" Inherits="GDT_Versao01_GDT00002" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="~/ACEN1010.ascx" TagPrefix="uc1" TagName="ACEN1010" %>
<script runat="server">

    protected void btnNovoFuncionario_Click(object sender, EventArgs e)
    {

    }
</script>


<asp:Content ID="Content1" ContentPlaceHolderID="phConteudo" runat="Server">
    <cc1:ToolkitScriptManager ID="ToolkitScriptManager1" EnablePartialRendering="true"
        runat="server" EnableScriptGlobalization="True" ScriptMode="Release">
    </cc1:ToolkitScriptManager>

    <%--<link href="../../template/js/plugins/bootstrap-select/bootstrap-select.css" rel="stylesheet" />--%>
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
                    <h5>GDT00002 - Manutenção de Terceiros</h5>
                    <div class="pull-right">
                        <div class="btn-group">
                            <a href="GDT00002.aspx" id="btnNovoTerceiro" runat="server" class="btn btn-primary btn-xs" data-toggle="tooltip" data-placement="bottom" title="Cadastrar novo terceiro"><i class="fa fa-user-plus"></i>&nbsp;Novo Terceiro</a>
                        </div>
                        <div class="btn-group">
                            <a href="GDT00003.aspx" id="btnConsultaTerceiros" runat="server" class="btn btn-primary btn-xs" data-toggle="tooltip" data-placement="bottom" title="Lista de terceiros"><i class="fa fa-list"></i>&nbsp;Lista Terceiros</a>                            
                        </div>
                        <div class="btn-group">
                            <a href="#" id="btnNovoFuncionario" runat="server" class="btn btn-primary btn-xs" data-toggle="tooltip" data-placement="bottom" title="Cadastrar novo funcionário"><i class="fa fa-users"></i>&nbsp;Novo Funcionário</a>
                            
                        </div>
                        <div class="btn-group">
                            <a href="GDT00005.aspx" id="btnConsultaFuncionarios" runat="server" class="btn btn-primary btn-xs" data-toggle="tooltip" data-placement="bottom" title="Lista de funcionários do terceiro"><i class="fa fa-list"></i>&nbsp;Consultar Funcionários</a>                            
                        </div>
                        <div class="btn-group">
                            <asp:LinkButton ID="btnGerarPDF" runat="server" CssClass="btn btn-primary   btn-xs" data-toggle="tooltip" data-placement="bottom" title="Gera PDF com as pendências do terceiro"
                                OnClick="btnGerarPDF_Click"><i class="fa fa-file-pdf-o"></i> &nbsp;Gerar PDF</asp:LinkButton>
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
                            <li role="presentation"><a href="#contato" aria-controls="contato" role="tab" data-toggle="tab">Contatos</a></li>
                            <li role="presentation"><a href="#avaliacao" aria-controls="avaliacao" role="tab" data-toggle="tab">Avaliações</a></li>
                            <li role="presentation"><a href="#inss" aria-controls="inss" role="tab" data-toggle="tab">INSS/GPS</a></li>
                        </ul>

                        <input type="hidden" id="txtTipoOperacao" runat="server" value="I" />
                        <input type="hidden" id="txtEmprTerceiro" runat="server" />

                        <!-- Conteúdo -->
                        <div class="tab-content">

                            <div role="tabpanel" class="tab-pane active" id="geral">
                                <div style="margin-left: 10px; margin-right: 10px; margin-top: 15px;">
                                    <div class="panel panel-Fockink">
                                        <div class="panel-heading">
                                            <h3 class="panel-title">Identificação do Terceiro</h3>
                                            <span class="pull-right clickable"><i class="glyphicon glyphicon-chevron-up"></i></span>
                                        </div>
                                        <div class="panel-body">
                                            <div style="margin-left: 10px; margin-right: 10px; margin-top: 15px;">
                                                <fieldset>
                                                    <div class="row">
                                                        <div class="col-md-12">
                                                            <div class="col-md-12 alert alert-danger fade in" visible="false" runat="server" id="divMsgErroTerc">
                                                                <asp:Label ID="lblMsgErroTerc" CssClass="" runat="server" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-8 form-group">
                                                            <label>Código Terceiro *</label>
                                                            <input type="hidden" name="optionvalue" tooltip="Razão social do terceiro" runat="server" id="txtCodTerceiro" class="select2Terceiro"
                                                                style="width: 100%" />
                                                        </div>
                                                        <div class="col-md-4 form-group">
                                                            <label>Situação do Terceiro *</label>
                                                            <asp:RadioButtonList ID="rbSituacaoTerc" class="radio_button_horizontal" runat="server" RepeatDirection="Horizontal" ToolTip="Indica a situação do terceiro">
                                                                <asp:ListItem Text="Ativo" Value="A" Selected="true"></asp:ListItem>
                                                                <asp:ListItem Text="Inativo" Value="I" Selected="false"></asp:ListItem>
                                                            </asp:RadioButtonList>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-8 form-group">
                                                            <label>Endereço</label>
                                                            <input type="text" class="form-control input-sm" runat="server" id="txtEnderecoTerc" title="Endereço do terceiro" readonly="true" />
                                                        </div>
                                                        <div class="col-md-4 form-group">
                                                            <label>Telefone Comercial</label>
                                                            <input type="text" class="form-control input-sm" runat="server" id="txtTelefoneTerc" title="Telefone comercial do terceiro" readonly="true" />
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-12 form-group">
                                                            <label>Contatos de Emergência</label>
                                                            <asp:TextBox ID="txtEmergenciaTerc" runat="server" MaxLength="4000" TextMode="MultiLine" Rows="2" ToolTip="Informe os contatos para situações de emergência" placeholder="Informe os contatos para situações de emergência" CssClass="form-control input-sm" />
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-3 form-group">
                                                            <label>Nº de Trabalhadores *</label>
                                                            <asp:TextBox ID="txtNumTrabalhadoresTerc" type="number" MaxLength="5" runat="server" ToolTip="Informe a quantidade de trabalhadores que estão em obras da Fockink" placeholder="Quant. trabalhadores" CssClass="form-control input-sm" />
                                                        </div>
                                                        <div class="col-md-9 form-group">
                                                            <label>Código Contador</label>
                                                            <input type="hidden" name="optionvalue" tooltip="Razão social do contador do terceiro" runat="server" id="txtCodContador" class="select2Contador"
                                                                style="width: 100%" />
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-8 form-group">
                                                            <label>Endereço Contador</label>
                                                            <input type="text" class="form-control input-sm" runat="server" id="txtEnderecoContTerc" title="Endereço do contador" readonly="true" />
                                                        </div>
                                                        <div class="col-md-4 form-group">
                                                            <label>Telefone Comercial</label>
                                                            <input type="text" class="form-control input-sm" runat="server" id="txtTelefoneContTerc" title="Telefone comercial do contador" readonly="true" />
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-8 form-group">
                                                            <label>E-mail</label>
                                                            <input type="text" class="form-control input-sm" runat="server" id="txtEmailContTerc" title="E-mail do contador" readonly="true" />
                                                        </div>
                                                    </div>
                                                </fieldset>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="panel panel-Fockink">
                                        <div class="panel-heading">
                                            <h3 class="panel-title">Obras em Andamento (contratos em aberto)</h3>
                                            <span class="pull-right clickable"><i class="glyphicon glyphicon-chevron-up"></i></span>
                                        </div>
                                        <div class="panel-body">
                                            <div style="margin-left: 10px; margin-right: 10px; margin-top: 15px;">
                                                <fieldset>
                                                    <div class="row">
                                                        <asp:Table runat="server" ID="tableObras" class="table table-bordered table-hover dataTables">
                                                        </asp:Table>
                                                    </div>
                                                </fieldset>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="panel panel-Fockink">
                                        <div class="panel-heading">
                                            <h3 class="panel-title">Vencimentos de Documentos</h3>
                                            <span class="pull-right clickable"><i class="glyphicon glyphicon-chevron-up"></i></span>
                                        </div>
                                        <div class="panel-body">
                                            <div style="margin-left: 10px; margin-right: 10px; margin-top: 15px;">
                                                <fieldset>
                                                    <div class="row">
                                                        <div class="col-md-4 form-group">
                                                            <label>Tipo Documento Societário *</label>
                                                            <asp:RadioButtonList ID="rbTipoDocSocietarioTerc" class="radio_button_horizontal" runat="server" RepeatDirection="Horizontal" ToolTip="Indica o tipo de documento societário" required="true">
                                                                <asp:ListItem Text="Contrato Social" Value="CS" Selected="false"></asp:ListItem>
                                                                <asp:ListItem Text="Requerimento Empresa Individual" Value="RE" Selected="false"></asp:ListItem>
                                                            </asp:RadioButtonList>
                                                        </div>

                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-3 form-group">
                                                            <label>Vencimento Alvará</label>
                                                            <div class="input-group date datepicker" data-date-language="pt-BR" style="padding-left: 0;">
                                                                <asp:TextBox runat="server" CssClass="form-control input-sm data-lib" ID="txtVencAlvaraTerc" ToolTip="Data de vencimento do alvará do terceiro" placeholder="dd/mm/aaaa" />
                                                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-3 form-group">
                                                            <label>Vencimento CND Federal *</label>
                                                            <div class="input-group date datepicker" data-date-language="pt-BR" style="padding-left: 0;">
                                                                <asp:TextBox runat="server" CssClass="form-control input-sm data-lib" ID="txtVencCndFederal" ToolTip="Data de vencimento da CND Federal" placeholder="dd/mm/aaaa" />
                                                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-3 form-group">
                                                            <label>Vencimento CND Municipal *</label>
                                                            <div class="input-group date datepicker" data-date-language="pt-BR" style="padding-left: 0;">
                                                                <asp:TextBox runat="server" CssClass="form-control input-sm data-lib" ID="txtVencCndMunicipal" ToolTip="Data de vencimento da CND Municipal" placeholder="dd/mm/aaaa" />
                                                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-3 form-group">
                                                            <label>Isento CND Estadual? *</label>
                                                            <asp:RadioButtonList ID="rbIsentoCNDEstadual" class="radio_button_horizontal" runat="server" RepeatDirection="Horizontal" ToolTip="Indica se o terceiro é isento da CND Estadual" required="true">
                                                                <asp:ListItem Text="Não" Value="N" Selected="false"></asp:ListItem>
                                                                <asp:ListItem Text="Sim" Value="S" Selected="false"></asp:ListItem>
                                                            </asp:RadioButtonList>
                                                        </div>
                                                        <div class="col-md-3 form-group">
                                                            <label>Vencimento CND Estadual</label>
                                                            <div class="input-group date datepicker" data-date-language="pt-BR" style="padding-left: 0;">
                                                                <asp:TextBox runat="server" CssClass="form-control input-sm data-lib" ID="txtVencCndEstadual" ToolTip="Data de vencimento da CND Estadual" placeholder="dd/mm/aaaa" />
                                                                <span class="input-group-addon vencCndEst"><i class="fa fa-calendar"></i></span>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-3 form-group">
                                                            <label>Isento FGTS CRF? *</label>
                                                            <asp:RadioButtonList ID="rbIsentoFGTS" class="radio_button_horizontal" runat="server" RepeatDirection="Horizontal" ToolTip="Indica se o terceiro é isento de GFTS CRF" required="true">
                                                                <asp:ListItem Text="Não" Value="N" Selected="false"></asp:ListItem>
                                                                <asp:ListItem Text="Sim" Value="S" Selected="false"></asp:ListItem>
                                                            </asp:RadioButtonList>
                                                        </div>
                                                        <div class="col-md-3 form-group">
                                                            <label>Vencimento FGTS CRF</label>
                                                            <div class="input-group date datepicker" data-date-language="pt-BR" style="padding-left: 0;">
                                                                <asp:TextBox runat="server" CssClass="form-control input-sm data-lib" ID="txtVencFGTS" ToolTip="Data de vencimento do FGTS CRF" placeholder="dd/mm/aaaa" />
                                                                <span class="input-group-addon vencFGTS"><i class="fa fa-calendar"></i></span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-3 form-group">
                                                            <label>Isento PPRA? *</label>
                                                            <asp:RadioButtonList ID="rbIsentoPPRA" class="radio_button_horizontal" runat="server" RepeatDirection="Horizontal" ToolTip="Indica se é isento de programa de prevenção de riscos ambientais" required="true">
                                                                <asp:ListItem Text="Não" Value="N" Selected="false"></asp:ListItem>
                                                                <asp:ListItem Text="Sim" Value="S" Selected="false"></asp:ListItem>
                                                            </asp:RadioButtonList>
                                                        </div>
                                                        <div class="col-md-3 form-group">
                                                            <label>Vencimento PPRA</label>
                                                            <div class="input-group date datepicker" data-date-language="pt-BR" style="padding-left: 0;">
                                                                <asp:TextBox runat="server" CssClass="form-control input-sm data-lib" ID="txtVencPPRA" ToolTip="Data de vencimento do PPRA" placeholder="dd/mm/aaaa" />
                                                                <span class="input-group-addon vencPPRA"><i class="fa fa-calendar"></i></span>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-3 form-group">
                                                            <label>Isento PCMSO? *</label>
                                                            <asp:RadioButtonList ID="rbIsentoPCMSO" class="radio_button_horizontal" runat="server" RepeatDirection="Horizontal" ToolTip="Indica se é isento de programa de controle médico de saúde ocupacional" required="true">
                                                                <asp:ListItem Text="Não" Value="N" Selected="false"></asp:ListItem>
                                                                <asp:ListItem Text="Sim" Value="S" Selected="false"></asp:ListItem>
                                                            </asp:RadioButtonList>
                                                        </div>
                                                        <div class="col-md-3 form-group">
                                                            <label>Vencimento PCMSO</label>
                                                            <div class="input-group date datepicker" data-date-language="pt-BR" style="padding-left: 0;">
                                                                <asp:TextBox runat="server" CssClass="form-control input-sm data-lib" ID="txtVencPCMSO" ToolTip="Data de vencimento do PCMSO" placeholder="dd/mm/aaaa" />
                                                                <span class="input-group-addon vencPCMSO"><i class="fa fa-calendar"></i></span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row examePCMSO">
                                                        <div class="col-md-6 form-group">
                                                            <label style="color: #FF0000">Marque os exames do PCMSO que o terceiro deve fornecer aos funcionários</label>
                                                        </div>
                                                    </div>
                                                    <div class="row examePCMSO">
                                                        <div class="col-md-3 form-group">
                                                            <label style="padding-left: 0;">
                                                                <input type="checkbox" name="name" value="" runat="server" id="chkAsoTerc" title="Indica que o terceiro deve fornecer o atestado de saúde ocupacional no PCMSO" />
                                                                <i></i><strong>ASO </strong>
                                                            </label>
                                                        </div>
                                                        <div class="col-md-3 form-group">
                                                            <label style="padding-left: 0;">
                                                                <input type="checkbox" name="name" value="" runat="server" id="chkAvalOftalTerc" title="Indica que o terceiro deve fornecer a avaliação oftalmológica no PCMSO" />
                                                                <i></i><strong>Avaliação Oftalmológica </strong>
                                                            </label>
                                                        </div>
                                                        <div class="col-md-3 form-group">
                                                            <label style="padding-left: 0;">
                                                                <input type="checkbox" name="name" value="" runat="server" id="chkAudiometriaTerc" title="Indica que o terceiro deve fornecer a audiometria no PCMSO" />
                                                                <i></i><strong>Audiometria </strong>
                                                            </label>
                                                        </div>
                                                        <div class="col-md-3 form-group">
                                                            <label style="padding-left: 0;">
                                                                <input type="checkbox" name="name" value="" runat="server" id="chkAcuidadeVisualTerc" title="Indica que o terceiro deve fornecer o exame de acuidade visual no PCMSO" />
                                                                <i></i><strong>Acuidade Visual </strong>
                                                            </label>
                                                        </div>
                                                    </div>
                                                    <div class="row examePCMSO">
                                                        <div class="col-md-3 form-group">
                                                            <label style="padding-left: 0;">
                                                                <input type="checkbox" name="name" value="" runat="server" id="chkAvalPsicoTerc" title="Indica que o terceiro deve fornecer a avaliação psicossocial no PCMSO" />
                                                                <i></i><strong>Avaliação Psicossocial </strong>
                                                            </label>
                                                        </div>
                                                        <div class="col-md-3 form-group">
                                                            <label style="padding-left: 0;">
                                                                <input type="checkbox" name="name" value="" runat="server" id="chkEletroCardiogramaTerc" title="Indica que o terceiro deve fornecer o exame de eletrocardiograma no PCMSO" />
                                                                <i></i><strong>Eletrocardiograma </strong>
                                                            </label>
                                                        </div>
                                                        <div class="col-md-3 form-group">
                                                            <label style="padding-left: 0;">
                                                                <input type="checkbox" name="name" value="" runat="server" id="chkEletroEncefalogramaTerc" title="Indica que o terceiro deve fornecer o exame de eletroencefalograma no PCMSO" />
                                                                <i></i><strong>Eletroencefalograma </strong>
                                                            </label>
                                                        </div>
                                                        <div class="col-md-3 form-group">
                                                            <label style="padding-left: 0;">
                                                                <input type="checkbox" name="name" value="" runat="server" id="chkEspirometriaTerc" title="Indica que o terceiro deve fornecer o exame de espirometria no PCMSO" />
                                                                <i></i><strong>Espirometria </strong>
                                                            </label>
                                                        </div>
                                                    </div>
                                                    <div class="row examePCMSO">
                                                        <div class="col-md-3 form-group">
                                                            <label style="padding-left: 0;">
                                                                <input type="checkbox" name="name" value="" runat="server" id="chkRXLomboSacraTerc" title="Indica que o terceiro deve fornecer a raio x da coluna lombo sacra no PCMSO" />
                                                                <i></i><strong>Raio X Coluna Lombo Sacra </strong>
                                                            </label>
                                                        </div>
                                                        <div class="col-md-3 form-group">
                                                            <label style="padding-left: 0;">
                                                                <input type="checkbox" name="name" value="" runat="server" id="chkRXToraxTerc" title="Indica que o terceiro deve fornecer a raio x do tórax no PCMSO" />
                                                                <i></i><strong>Raio X Tórax </strong>
                                                            </label>
                                                        </div>
                                                        <div class="col-md-3 form-group">
                                                            <label style="padding-left: 0;">
                                                                <input type="checkbox" name="name" value="" runat="server" id="chkHemogramaTerc" title="Indica que o terceiro deve fornecer o hemograma completo no PCMSO" />
                                                                <i></i><strong>Hemograma Completo </strong>
                                                            </label>
                                                        </div>
                                                        <div class="col-md-3 form-group">
                                                            <label style="padding-left: 0;">
                                                                <input type="checkbox" name="name" value="" runat="server" id="chkPlaquetasTerc" title="Indica que o terceiro deve fornecer o exame de plaquetas no PCMSO" />
                                                                <i></i><strong>Plaquetas </strong>
                                                            </label>
                                                        </div>
                                                    </div>
                                                    <div class="row examePCMSO">
                                                        <div class="col-md-3 form-group">
                                                            <label style="padding-left: 0;">
                                                                <input type="checkbox" name="name" value="" runat="server" id="chkTipoSanguineoTerc" title="Indica que o terceiro deve fornecer o exame de tipo sanguíneo no PCMSO" />
                                                                <i></i><strong>Tipo Sanguíneo </strong>
                                                            </label>
                                                        </div>
                                                        <div class="col-md-3 form-group">
                                                            <label style="padding-left: 0;">
                                                                <input type="checkbox" name="name" value="" runat="server" id="chkGlicemiaTerc" title="Indica que o terceiro deve fornecer o exame glicemia ou glicose no PCMSO" />
                                                                <i></i><strong>Glicemia e/ou Glicose </strong>
                                                            </label>
                                                        </div>
                                                        <div class="col-md-3 form-group">
                                                            <label style="padding-left: 0;">
                                                                <input type="checkbox" name="name" value="" runat="server" id="chkGamaGtTerc" title="Indica que o terceiro deve fornecer o exame de Gama Glutamil Trasnferase no PCMSO" />
                                                                <i></i><strong>Gama GT </strong>
                                                            </label>
                                                        </div>
                                                        <div class="col-md-3 form-group">
                                                            <label style="padding-left: 0;">
                                                                <input type="checkbox" name="name" value="" runat="server" id="chkColesterolTerc" title="Indica que o terceiro deve fornecer o exame de colesterol total e frações no PCMSO" />
                                                                <i></i><strong>Colesterol Total e Frações </strong>
                                                            </label>
                                                        </div>
                                                    </div>
                                                    <div class="row examePCMSO">
                                                        <div class="col-md-3 form-group">
                                                            <label style="padding-left: 0;">
                                                                <input type="checkbox" name="name" value="" runat="server" id="chkTgoTerc" title="Indica que o terceiro deve fornecer o exame de Transaminase Glutâmico-Oxalacética no PCMSO" />
                                                                <i></i><strong>TGO </strong>
                                                            </label>
                                                        </div>
                                                        <div class="col-md-3 form-group">
                                                            <label style="padding-left: 0;">
                                                                <input type="checkbox" name="name" value="" runat="server" id="chkTgpTerc" title="Indica que o terceiro deve fornecer o exame de Transaminase Glutâmico-Pirúvica no PCMSO" />
                                                                <i></i><strong>TGP </strong>
                                                            </label>
                                                        </div>
                                                        <div class="col-md-3 form-group">
                                                            <label style="padding-left: 0;">
                                                                <input type="checkbox" name="name" value="" runat="server" id="chkManganesTerc" title="Indica que o terceiro deve fornecer o exame de Manganês no PCMSO" />
                                                                <i></i><strong>Manganês </strong>
                                                            </label>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-3 form-group">
                                                            <label>Isento LTCAT? *</label>
                                                            <asp:RadioButtonList ID="rbIsentoLTCAT" class="radio_button_horizontal" runat="server" RepeatDirection="Horizontal" ToolTip="Indica se é isento de laudo técnico de condições de ambiente de trabalho" required="true">
                                                                <asp:ListItem Text="Não" Value="N" Selected="false"></asp:ListItem>
                                                                <asp:ListItem Text="Sim" Value="S" Selected="false"></asp:ListItem>
                                                            </asp:RadioButtonList>
                                                        </div>
                                                        <div class="col-md-3 form-group">
                                                            <label>Vencimento LTCAT</label>
                                                            <div class="input-group date datepicker" data-date-language="pt-BR" style="padding-left: 0;">
                                                                <asp:TextBox runat="server" CssClass="form-control input-sm data-lib" ID="txtVencLTCAT" ToolTip="Data de vencimento do LTCAT" placeholder="dd/mm/aaaa" />
                                                                <span class="input-group-addon vencLTCAT"><i class="fa fa-calendar"></i></span>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-3 form-group">
                                                            <label>Isento PPR? *</label>
                                                            <asp:RadioButtonList ID="rbIsentoPPR" class="radio_button_horizontal" runat="server" RepeatDirection="Horizontal" ToolTip="Indica se é isento de programa de proteção respiratório" required="true">
                                                                <asp:ListItem Text="Não" Value="N" Selected="false"></asp:ListItem>
                                                                <asp:ListItem Text="Sim" Value="S" Selected="false"></asp:ListItem>
                                                            </asp:RadioButtonList>
                                                        </div>
                                                        <div class="col-md-3 form-group">
                                                            <label>Vencimento PPR</label>
                                                            <div class="input-group date datepicker" data-date-language="pt-BR" style="padding-left: 0;">
                                                                <asp:TextBox runat="server" CssClass="form-control input-sm data-lib" ID="txtVencPPR" ToolTip="Data de vencimento do PPR" placeholder="dd/mm/aaaa" />
                                                                <span class="input-group-addon vencPPR"><i class="fa fa-calendar"></i></span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-3 form-group">
                                                            <label>Isento PCA? *</label>
                                                            <asp:RadioButtonList ID="rbIsentoPCA" class="radio_button_horizontal" runat="server" RepeatDirection="Horizontal" ToolTip="Indica se é isento de programa de controle auditivo" required="true">
                                                                <asp:ListItem Text="Não" Value="N" Selected="false"></asp:ListItem>
                                                                <asp:ListItem Text="Sim" Value="S" Selected="false"></asp:ListItem>
                                                            </asp:RadioButtonList>
                                                        </div>
                                                        <div class="col-md-3 form-group">
                                                            <label>Vencimento PCA</label>
                                                            <div class="input-group date datepicker" data-date-language="pt-BR" style="padding-left: 0;">
                                                                <asp:TextBox runat="server" CssClass="form-control input-sm data-lib" ID="txtVencPCA" ToolTip="Data de vencimento do PCA" placeholder="dd/mm/aaaa" />
                                                                <span class="input-group-addon vencPCA"><i class="fa fa-calendar"></i></span>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-3 form-group">
                                                            <label>Isento PGRS? *</label>
                                                            <asp:RadioButtonList ID="rbIsentoPGRS" class="radio_button_horizontal" runat="server" RepeatDirection="Horizontal" ToolTip="Indica se é isento de programa de gerenciamento de resíduos sólidos" required="true">
                                                                <asp:ListItem Text="Não" Value="N" Selected="false"></asp:ListItem>
                                                                <asp:ListItem Text="Sim" Value="S" Selected="false"></asp:ListItem>
                                                            </asp:RadioButtonList>
                                                        </div>
                                                        <div class="col-md-3 form-group">
                                                            <label>Vencimento PGRS</label>
                                                            <div class="input-group date datepicker" data-date-language="pt-BR" style="padding-left: 0;">
                                                                <asp:TextBox runat="server" CssClass="form-control input-sm data-lib" ID="txtVencPGRS" ToolTip="Data de vencimento do PGRS" placeholder="dd/mm/aaaa" />
                                                                <span class="input-group-addon vencPGRS"><i class="fa fa-calendar"></i></span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-3 form-group">
                                                            <label>Isento PS? *</label>
                                                            <asp:RadioButtonList ID="rbIsentoPS" class="radio_button_horizontal" runat="server" RepeatDirection="Horizontal" ToolTip="Indica se é isento de programa de plano de segurança" required="true">
                                                                <asp:ListItem Text="Não" Value="N" Selected="false"></asp:ListItem>
                                                                <asp:ListItem Text="Sim" Value="S" Selected="false"></asp:ListItem>
                                                            </asp:RadioButtonList>
                                                        </div>
                                                        <div class="col-md-3 form-group">
                                                            <label>Vencimento PS</label>
                                                            <div class="input-group date datepicker" data-date-language="pt-BR" style="padding-left: 0;">
                                                                <asp:TextBox runat="server" CssClass="form-control input-sm data-lib" ID="txtVencPS" ToolTip="Data de vencimento do PS" placeholder="dd/mm/aaaa" />
                                                                <span class="input-group-addon vencPS"><i class="fa fa-calendar"></i></span>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-3 form-group">
                                                            <label>Isento PCMAT? *</label>
                                                            <asp:RadioButtonList ID="rbIsentoPCMAT" class="radio_button_horizontal" runat="server" RepeatDirection="Horizontal" ToolTip="Indica se é isento de programa de condições e meio ambiente de trabalho na indústria da construção civil" required="true">
                                                                <asp:ListItem Text="Não" Value="N" Selected="false"></asp:ListItem>
                                                                <asp:ListItem Text="Sim" Value="S" Selected="false"></asp:ListItem>
                                                            </asp:RadioButtonList>
                                                        </div>
                                                        <div class="col-md-3 form-group">
                                                            <label>Vencimento PCMAT</label>
                                                            <div class="input-group date datepicker" data-date-language="pt-BR" style="padding-left: 0;">
                                                                <asp:TextBox runat="server" CssClass="form-control input-sm data-lib" ID="txtVencPCMAT" ToolTip="Data de vencimento do PCMAT" placeholder="dd/mm/aaaa" />
                                                                <span class="input-group-addon vencPCMAT"><i class="fa fa-calendar"></i></span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </fieldset>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-12 text-center">
                                            <div class="btn-group">
                                                <asp:LinkButton runat="server" Text="Salvar" CssClass="btn btn-rounded btn-primary" ID="btnGravaTerceiro" data-toggle="tooltip" data-placement="top" title="Grava as informações gerais do terceiro" OnClick="btnGravaTerceiro_Click" />

                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div role="tabpanel" class="tab-pane" id="contato">
                                <div style="margin-left: 10px; margin-right: 10px; margin-top: 15px;">
                                    <div class="panel panel-Fockink">
                                        <div class="panel-heading">
                                            <label>Identificação dos Contatos do Terceiro</label>
                                        </div>
                                        <div style="margin-left: 10px; margin-right: 10px; margin-top: 15px;">
                                            <fieldset>
                                                <div class="row">
                                                    <div class="col-md-8 form-group">
                                                        <label>.... *</label>
                                                    </div>
                                                </div>
                                            </fieldset>
                                        </div>

                                    </div>
                                </div>
                            </div>

                            <div role="tabpanel" class="tab-pane" id="avaliacao">
                                <div style="margin-left: 10px; margin-right: 10px; margin-top: 15px;">
                                    <div class="panel panel-Fockink">
                                        <div class="panel-heading">
                                            <label>Registro de Avaliações</label>
                                        </div>
                                        <div style="margin-left: 10px; margin-right: 10px; margin-top: 15px;">
                                            <fieldset>
                                                <div class="row">
                                                    <div class="col-md-8 form-group">
                                                        <label>.... *</label>
                                                    </div>
                                                </div>
                                            </fieldset>
                                        </div>

                                    </div>
                                </div>
                            </div>

                            <div role="tabpanel" class="tab-pane" id="inss">
                                <div style="margin-left: 10px; margin-right: 10px; margin-top: 15px;">
                                    <div class="panel panel-Fockink">
                                        <div class="panel-heading">
                                            <label>Registro de INSS/GPS</label>
                                        </div>
                                        <div style="margin-left: 10px; margin-right: 10px; margin-top: 15px;">
                                            <fieldset>
                                                <div class="row">
                                                    <div class="col-md-8 form-group">
                                                        <label>.... *</label>
                                                    </div>
                                                </div>
                                            </fieldset>
                                        </div>

                                    </div>
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
    
    
    <script type="text/javascript" src="../../template/fockink/js/TerceiroInfo.js"></script>



    <script>       

        $(function () {
            DomSgeGDT00002();
        });

        $(document).ready(function () {
            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(EndRequestHandler);
            function EndRequestHandler(sender, args) {
                DomSgeGDT00002();
            }
        });

        function DomSgeGDT00002() {            
            $('.datepicker').datepicker({
                todayBtn: "linked",
                keyboardNavigation: false,
                forceParse: false,
                calendarWeeks: true,
                autoclose: true,
                format: 'dd/mm/yyyy'
            });

            $(document).ready(function () {
                $('.select2Terceiro').select2({
                    placeholder: "Pesquise o terceiro",
                    allowClear: true,
                    minimumInputLength: 3,
                    initSelection: function (element, callback) {
                        var id = $(element).val();
                        if (id !== "") {
                            $.ajax('../../autoComplete1.ashx?tipo=pessoaDetalhe', {
                                data: {
                                    id: id
                                },
                                dataType: "json"
                            }).done(function (data) { callback(data); });
                        }
                    },
                    ajax: {
                        url: "../../autoComplete1.ashx?tipo=pessoaDetalhe",
                        dataType: 'json',
                        data: function (term, page) {
                            return {
                                q: term
                            };
                        },
                        results: function (data, page) {

                            return { results: data };
                        }
                    }
                })

                $('.select2Terceiro').on("change", function (e) {
                    if (e.val != "") {
                        var objeto = $(this).select2("data");
                        $("[id$=txtEnderecoTerc]").val("" + objeto.endereco);
                        $("[id$=txtTelefoneTerc]").val("" + objeto.telefone);                                                
                    }
                    else {
                        $("[id$=txtEnderecoTerc]").val("");
                        $("[id$=txtTelefoneTerc]").val("");                                                
                    }
                });

                $('.select2Contador').select2({
                    placeholder: "Pesquise o contador",
                    allowClear: true,
                    minimumInputLength: 3,
                    initSelection: function (element, callback) {
                        var id = $(element).val();
                        if (id !== "") {
                            $.ajax('../../autoComplete1.ashx?tipo=pessoaDetalhe', {
                                data: {
                                    id: id
                                },
                                dataType: "json"
                            }).done(function (data) { callback(data); });
                        }
                    },
                    ajax: {
                        url: "../../autoComplete1.ashx?tipo=pessoaDetalhe",
                        dataType: 'json',
                        data: function (term, page) {
                            return {
                                q: term
                            };
                        },
                        results: function (data, page) {

                            return { results: data };
                        }
                    }
                })

                $('.select2Contador').on("change", function (e) {
                    if (e.val != "") {
                        var objeto = $(this).select2("data");
                        $("[id$=txtEnderecoContTerc]").val("" + objeto.endereco);
                        $("[id$=txtTelefoneContTerc]").val("" + objeto.telefone);
                        $("[id$=txtEmailContTerc]").val("" + objeto.email);
                    }
                    else {
                        $("[id$=txtEnderecoContTerc]").val("");
                        $("[id$=txtTelefoneContTerc]").val("");
                        $("[id$=txtEmailContTerc]").val("");
                    }
                });
            });


            //Informações gerais
            $(document).ready(function () {
                gerenciaIsentoCNDEstadual();
                gerenciaIsentoFgts();
                gerenciaIsentoPpra();
                gerenciaIsentoPCMSO();
                gerenciaIsentoLTCAT();
                gerenciaIsentoPPR();
                gerenciaIsentoPCA();
                gerenciaIsentoPGRS();
                gerenciaIsentoPS();
                gerenciaIsentoPCMAT();
            });
        }
        
       
       
        function toogleTab(oldTab, newTab) {
            $("#tab-" + oldTab + "").removeClass("active");
            $(".li" + oldTab + "").removeClass("active");
            $("#tab-" + newTab + "").addClass("active");
            $(".li" + newTab + "").addClass("active");
        }

    </script>

</asp:Content>

