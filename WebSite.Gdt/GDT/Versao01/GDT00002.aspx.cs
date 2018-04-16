using System;
using Dominio.DOMCOR;
using System.Data;
using Dominio.DOMACE;
using Dominio.DOMDB;
using iTextSharp.text;//ESTENSAO 1 (TEXT)
using iTextSharp.text.pdf;
using System.Text;
using System.Web.UI;
using GDTLibrary;
using System.Collections.Generic;
using System.Web.Script.Serialization;
using System.Web.UI.WebControls;

public partial class GDT_Versao01_GDT00002 : System.Web.UI.Page
{
    ACEL0310 ACEL0310 = new ACEL0310();
    StringBuilder Query = new StringBuilder();
    DatabaseOracle dbOracle = new DatabaseOracle();

    protected void Page_Load(object sender, EventArgs e)
    {
        string usuario = "";
        string empresa = "";
        if (Session["codUsuario"] != null)
        {
            try
            {
                //ValidaAcessoPrograma("GDT00002");

                usuario = Session["codUsuario"].ToString();
                empresa = Session["codEmpresa"].ToString();
                txtEmprTerceiro.Value = empresa;
                if (Request.QueryString["empr"] != null && Request.QueryString["dpesCod"] != null)
                {                   
                    montaLinkFuncionario();
                }

                if (!IsPostBack)
                {
                    if (Request.QueryString["empr"] != null && Request.QueryString["dpesCod"] != null)
                    {
                        consultaTerceiro(Request.QueryString["empr"].ToString(), Request.QueryString["dpesCod"].ToString());
                        montaTabelaObras(Request.QueryString["dpesCod"].ToString());
                        montaLinkFuncionario();
                    }
                }
            }
            catch (Exception exc)
            {
                ScriptManager.RegisterStartupScript(Page, typeof(Page), "ShowValidation", "javascript:alertErroDomsge('ERRO',\"" + ACEL0310.trataMensagemErro(exc.Message) + "\")", true);
            }

        }
    }

    private void consultaTerceiro(string empresa, string codigoTerceiro)
    {
        try
        {
            Terceiro terc = new Terceiro();
            DataSet ds = terc.consultaTerceiro(empresa, codigoTerceiro);
            if (ds.Tables[0].Rows.Count > 0)
            {
                txtEmprTerceiro.Value = ds.Tables[0].Rows[0]["EMPR_CODIGO"].ToString();
                txtCodTerceiro.Value = ds.Tables[0].Rows[0]["DPES_CODIGO"].ToString();
                rbSituacaoTerc.SelectedValue = ds.Tables[0].Rows[0]["SITUACAO"].ToString();
                txtEmergenciaTerc.Text = ds.Tables[0].Rows[0]["CONTATO_EMERGENCIA"].ToString();
                txtNumTrabalhadoresTerc.Text = ds.Tables[0].Rows[0]["QTDE_TRABALHADORES"].ToString();
                txtCodContador.Value = ds.Tables[0].Rows[0]["DPES_CODIGO_CONTADOR"].ToString();
                rbTipoDocSocietarioTerc.SelectedValue = ds.Tables[0].Rows[0]["TIPO_DOC_SOCIETARIO"].ToString();
                txtVencAlvaraTerc.Text = ds.Tables[0].Rows[0]["DT_VENC_ALVARA"].ToString();
                txtVencCndFederal.Text = ds.Tables[0].Rows[0]["DT_VENC_CND_FEDERAL"].ToString();
                txtVencCndMunicipal.Text = ds.Tables[0].Rows[0]["DT_VENC_CND_MUNICIPAL"].ToString();
                rbIsentoCNDEstadual.SelectedValue = ds.Tables[0].Rows[0]["IND_ISENTO_CND_ESTADUAL"].ToString();
                txtVencCndEstadual.Text = ds.Tables[0].Rows[0]["DT_VENC_CND_ESTADUAL"].ToString();
                rbIsentoFGTS.SelectedValue = ds.Tables[0].Rows[0]["IND_ISENTO_FGTS_CRF"].ToString();
                txtVencFGTS.Text = ds.Tables[0].Rows[0]["DT_VENC_FGTS_CRF"].ToString();
                rbIsentoPPRA.SelectedValue = ds.Tables[0].Rows[0]["IND_ISENTO_PPRA"].ToString();
                txtVencPPRA.Text = ds.Tables[0].Rows[0]["DT_VENC_PPRA"].ToString();
                rbIsentoPCMSO.SelectedValue = ds.Tables[0].Rows[0]["IND_ISENTO_PCMSO"].ToString();
                txtVencPCMSO.Text = ds.Tables[0].Rows[0]["DT_VENC_PCMSO"].ToString();
                chkAsoTerc.Checked = ds.Tables[0].Rows[0]["IND_ASO"].ToString().Equals("S") ? true : false;
                chkAvalOftalTerc.Checked = ds.Tables[0].Rows[0]["IND_AVAL_OFTALMOLOGICA"].ToString().Equals("S") ? true : false;
                chkAudiometriaTerc.Checked = ds.Tables[0].Rows[0]["IND_AUDIOMETRIA"].ToString().Equals("S") ? true : false;
                chkAcuidadeVisualTerc.Checked = ds.Tables[0].Rows[0]["IND_ACUIDADE_VISUAL"].ToString().Equals("S") ? true : false;
                chkAvalPsicoTerc.Checked = ds.Tables[0].Rows[0]["IND_AVAL_PSICOSSOCIAL"].ToString().Equals("S") ? true : false;
                chkEletroCardiogramaTerc.Checked = ds.Tables[0].Rows[0]["IND_ELETROCARDIOGRAMA"].ToString().Equals("S") ? true : false;
                chkEletroEncefalogramaTerc.Checked = ds.Tables[0].Rows[0]["IND_ELETROENCEFALOGRAMA"].ToString().Equals("S") ? true : false;
                chkEspirometriaTerc.Checked = ds.Tables[0].Rows[0]["IND_ESPIROMETRIA"].ToString().Equals("S") ? true : false;
                chkRXLomboSacraTerc.Checked = ds.Tables[0].Rows[0]["IND_RX_COL_LOMBO_SACRA"].ToString().Equals("S") ? true : false;
                chkRXToraxTerc.Checked = ds.Tables[0].Rows[0]["IND_RX_TORAX"].ToString().Equals("S") ? true : false;
                chkHemogramaTerc.Checked = ds.Tables[0].Rows[0]["IND_HEMOGRAMA_COMPLETO"].ToString().Equals("S") ? true : false;
                chkPlaquetasTerc.Checked = ds.Tables[0].Rows[0]["IND_PLAQUETAS"].ToString().Equals("S") ? true : false;
                chkTipoSanguineoTerc.Checked = ds.Tables[0].Rows[0]["IND_TIPO_SANGUINEO"].ToString().Equals("S") ? true : false;
                chkGlicemiaTerc.Checked = ds.Tables[0].Rows[0]["IND_GLICEMIA_GLICOSE"].ToString().Equals("S") ? true : false;
                chkGamaGtTerc.Checked = ds.Tables[0].Rows[0]["IND_GAMA_GT"].ToString().Equals("S") ? true : false;
                chkColesterolTerc.Checked = ds.Tables[0].Rows[0]["IND_COLESTEROL_TOT_FRAC"].ToString().Equals("S") ? true : false;
                chkTgoTerc.Checked = ds.Tables[0].Rows[0]["IND_TGO"].ToString().Equals("S") ? true : false;
                chkTgpTerc.Checked = ds.Tables[0].Rows[0]["IND_TGP"].ToString().Equals("S") ? true : false;
                chkManganesTerc.Checked = ds.Tables[0].Rows[0]["IND_MANGANES"].ToString().Equals("S") ? true : false;
                rbIsentoLTCAT.SelectedValue = ds.Tables[0].Rows[0]["IND_ISENTO_LTCAT"].ToString();
                txtVencLTCAT.Text = ds.Tables[0].Rows[0]["DT_VENC_LTCAT"].ToString();
                rbIsentoPPR.SelectedValue = ds.Tables[0].Rows[0]["IND_ISENTO_PPR"].ToString();
                txtVencPPR.Text = ds.Tables[0].Rows[0]["DT_VENC_PPR"].ToString();
                rbIsentoPCA.SelectedValue = ds.Tables[0].Rows[0]["IND_ISENTO_PCA"].ToString();
                txtVencPCA.Text = ds.Tables[0].Rows[0]["DT_VENC_PCA"].ToString();
                rbIsentoPGRS.SelectedValue = ds.Tables[0].Rows[0]["IND_ISENTO_PGRS"].ToString();
                txtVencPGRS.Text = ds.Tables[0].Rows[0]["DT_VENC_PGRS"].ToString();
                rbIsentoPS.SelectedValue = ds.Tables[0].Rows[0]["IND_ISENTO_PS"].ToString();
                txtVencPS.Text = ds.Tables[0].Rows[0]["DT_VENC_PS"].ToString();
                rbIsentoPCMAT.SelectedValue = ds.Tables[0].Rows[0]["IND_ISENTO_PCMAT"].ToString();
                txtVencPCMAT.Text = ds.Tables[0].Rows[0]["DT_VENC_PCMAT"].ToString();

                if (!String.IsNullOrEmpty(txtCodTerceiro.Value))
                {
                    DataSet complementoTerc = terc.complementoPessoa(txtCodTerceiro.Value);
                    if (complementoTerc.Tables[0].Rows.Count > 0)
                    {
                        txtEnderecoTerc.Value = complementoTerc.Tables[0].Rows[0]["ENDERECO"].ToString();
                        txtTelefoneTerc.Value = complementoTerc.Tables[0].Rows[0]["TELEFONE"].ToString();
                    }
                }

                if (!String.IsNullOrEmpty(txtCodContador.Value))
                {
                    DataSet complementoContador = terc.complementoPessoa(txtCodContador.Value);
                    if (complementoContador.Tables[0].Rows.Count > 0)
                    {
                        txtEnderecoContTerc.Value = complementoContador.Tables[0].Rows[0]["ENDERECO"].ToString();
                        txtTelefoneContTerc.Value = complementoContador.Tables[0].Rows[0]["TELEFONE"].ToString();
                        txtEmailContTerc.Value = complementoContador.Tables[0].Rows[0]["EMAIL"].ToString();
                    }
                }

            }
        }
        catch (Exception exc)
        {
            ScriptManager.RegisterStartupScript(Page, typeof(Page), "ShowValidation", "javascript:alertErroDomsge('ERRO',\"" + ACEL0310.trataMensagemErro(exc.Message) + "\")", true);
        }
    }

    protected void btnGravaTerceiro_Click(object sender, EventArgs e)
    {
        try
        {
            StringBuilder mensagem = new StringBuilder();

            if (String.IsNullOrEmpty(txtCodTerceiro.Value))
            {
                mensagem.Append("O campo <strong>Código Terceiro</strong>, deve ser preenchido.<br>");
            }
            if (String.IsNullOrEmpty(rbSituacaoTerc.SelectedValue))
            {
                mensagem.Append("O campo <strong>Situação do Terceiro</strong>, deve ser preenchido.<br>");
            }
            if (String.IsNullOrEmpty(txtNumTrabalhadoresTerc.Text))
            {
                mensagem.Append("O campo <strong>Nº de Trabalhadores</strong>, deve ser preenchido.<br>");
            }
            if (String.IsNullOrEmpty(rbTipoDocSocietarioTerc.SelectedValue))
            {
                mensagem.Append("O campo <strong>Tipo Documento Societário</strong>, deve ser preenchido.<br>");
            }
            if (String.IsNullOrEmpty(txtVencCndFederal.Text))
            {
                mensagem.Append("O campo <strong>Vencimento CND Federal</strong>, deve ser preenchido.<br>");
            }
            if (String.IsNullOrEmpty(txtVencCndMunicipal.Text))
            {
                mensagem.Append("O campo <strong>Vencimento CND Municipal</strong>, deve ser preenchido.<br>");
            }
            if (String.IsNullOrEmpty(rbIsentoCNDEstadual.SelectedValue))
            {
                mensagem.Append("O campo <strong>Isento CND Estadual</strong>, deve ser preenchido.<br>");
            }
            if (rbIsentoCNDEstadual.SelectedValue.Equals("N") && String.IsNullOrEmpty(txtVencCndEstadual.Text))
            {
                mensagem.Append("O campo <strong>Vencimento CND Estadual</strong>, deve ser preenchido.<br>");
            }
            if (String.IsNullOrEmpty(rbIsentoFGTS.SelectedValue))
            {
                mensagem.Append("O campo <strong>Isento FGTS CRF</strong>, deve ser preenchido.<br>");
            }
            if (rbIsentoFGTS.SelectedValue.Equals("N") && String.IsNullOrEmpty(txtVencFGTS.Text))
            {
                mensagem.Append("O campo <strong>Vencimento FGTS CRF</strong>, deve ser preenchido.<br>");
            }
            if (String.IsNullOrEmpty(rbIsentoPPRA.SelectedValue))
            {
                mensagem.Append("O campo <strong>Isento PPRA</strong>, deve ser preenchido.<br>");
            }
            if (rbIsentoPPRA.SelectedValue.Equals("N") && String.IsNullOrEmpty(txtVencPPRA.Text))
            {
                mensagem.Append("O campo <strong>Vencimento PPRA</strong>, deve ser preenchido.<br>");
            }
            if (String.IsNullOrEmpty(rbIsentoPCMSO.SelectedValue))
            {
                mensagem.Append("O campo <strong>Isento PCMSO</strong>, deve ser preenchido.<br>");
            }
            if (rbIsentoPCMSO.SelectedValue.Equals("N") && String.IsNullOrEmpty(txtVencPCMSO.Text))
            {
                mensagem.Append("O campo <strong>Vencimento PCMSO</strong>, deve ser preenchido.<br>");
            }
            if (rbIsentoPCMSO.SelectedValue.Equals("N") && !chkAsoTerc.Checked && !chkAvalOftalTerc.Checked &&
                !chkAudiometriaTerc.Checked && !chkAcuidadeVisualTerc.Checked && !chkAvalPsicoTerc.Checked &&
                !chkEletroCardiogramaTerc.Checked && !chkEletroEncefalogramaTerc.Checked && !chkEspirometriaTerc.Checked &&
                !chkRXLomboSacraTerc.Checked && !chkRXToraxTerc.Checked && !chkHemogramaTerc.Checked && !chkPlaquetasTerc.Checked &&
                !chkTipoSanguineoTerc.Checked && !chkGlicemiaTerc.Checked && !chkGamaGtTerc.Checked && !chkColesterolTerc.Checked &&
                !chkTgoTerc.Checked && !chkTgpTerc.Checked && !chkManganesTerc.Checked)
            {
                mensagem.Append("Foi definido que o terceiro NÃO é isento de PCMSO, porém <strong>não foi selecionado nehum exame na lista de exames previstos</strong>, selecione os exames necessários.<br>");
            }
            if (String.IsNullOrEmpty(rbIsentoLTCAT.SelectedValue))
            {
                mensagem.Append("O campo <strong>Isento LTCAT</strong>, deve ser preenchido.<br>");
            }
            if (rbIsentoLTCAT.SelectedValue.Equals("N") && String.IsNullOrEmpty(txtVencLTCAT.Text))
            {
                mensagem.Append("O campo <strong>Vencimento LTCAT</strong>, deve ser preenchido.<br>");
            }
            if (String.IsNullOrEmpty(rbIsentoPPR.SelectedValue))
            {
                mensagem.Append("O campo <strong>Isento PPR</strong>, deve ser preenchido.<br>");
            }
            if (rbIsentoPPR.SelectedValue.Equals("N") && String.IsNullOrEmpty(txtVencPPR.Text))
            {
                mensagem.Append("O campo <strong>Vencimento PPR</strong>, deve ser preenchido.<br>");
            }
            if (String.IsNullOrEmpty(rbIsentoPCA.SelectedValue))
            {
                mensagem.Append("O campo <strong>Isento PCA</strong>, deve ser preenchido.<br>");
            }
            if (rbIsentoPCA.SelectedValue.Equals("N") && String.IsNullOrEmpty(txtVencPCA.Text))
            {
                mensagem.Append("O campo <strong>Vencimento PCA</strong>, deve ser preenchido.<br>");
            }
            if (String.IsNullOrEmpty(rbIsentoPGRS.SelectedValue))
            {
                mensagem.Append("O campo <strong>Isento PGRS</strong>, deve ser preenchido.<br>");
            }
            if (rbIsentoPGRS.SelectedValue.Equals("N") && String.IsNullOrEmpty(txtVencPGRS.Text))
            {
                mensagem.Append("O campo <strong>Vencimento PGRS</strong>, deve ser preenchido.<br>");
            }
            if (String.IsNullOrEmpty(rbIsentoPS.SelectedValue))
            {
                mensagem.Append("O campo <strong>Isento PS</strong>, deve ser preenchido.<br>");
            }
            if (rbIsentoPS.SelectedValue.Equals("N") && String.IsNullOrEmpty(txtVencPS.Text))
            {
                mensagem.Append("O campo <strong>Vencimento PS</strong>, deve ser preenchido.<br>");
            }
            if (String.IsNullOrEmpty(rbIsentoPCMAT.SelectedValue))
            {
                mensagem.Append("O campo <strong>Isento PCMAT</strong>, deve ser preenchido.<br>");
            }
            if (rbIsentoPCMAT.SelectedValue.Equals("N") && String.IsNullOrEmpty(txtVencPCMAT.Text))
            {
                mensagem.Append("O campo <strong>Vencimento PCMAT</strong>, deve ser preenchido.<br>");
            }

            if (!String.IsNullOrEmpty(mensagem.ToString()))
            {
                lblMsgErroTerc.Text = "<strong>Painel de erros:</strong><br>" + mensagem.ToString();
                divMsgErroTerc.Visible = true;
                ScriptManager.RegisterStartupScript(Page, typeof(Page), "ShowValidation", "toogleTab('1','1');javascript:alertDomsge('Campo Obrigatório!',\"Verifique os erros apontados no painel de erros." + "\", 'rgba(197, 105, 16, 0.8)')", true);
            }
            else
            {
                lblMsgErroTerc.Text = "";
                divMsgErroTerc.Visible = false;
                gravaTerceiro();
            }



        }
        catch (Exception exc)
        {
            ScriptManager.RegisterStartupScript(Page, typeof(Page), "ShowValidation", "javascript:alertErroDomsge('ERRO',\"" + ACEL0310.trataMensagemErro(exc.Message) + "\")", true);
        }
    }

    private void gravaTerceiro()
    {
        try
        {
            Terceiro terc = new Terceiro();
            terc.EmprCodigo = txtEmprTerceiro.Value;
            terc.DpesCodigo = Convert.ToInt32(txtCodTerceiro.Value);
            terc.Situacao = rbSituacaoTerc.SelectedValue;
            terc.ContatoEmergencia = txtEmergenciaTerc.Text;
            terc.QtdeTrabalhadores = Convert.ToInt32(txtNumTrabalhadoresTerc.Text);
            terc.DpesCodigoContador = Convert.ToInt32(txtCodContador.Value);
            terc.TipoDocSocietario = rbTipoDocSocietarioTerc.SelectedValue;
            terc.DtVencAlvara = txtVencAlvaraTerc.Text;
            terc.DtVencCndFederal = txtVencCndFederal.Text;
            terc.DtVencCndMunicipal = txtVencCndMunicipal.Text;
            terc.IndIsentoCndEstadual = rbIsentoCNDEstadual.SelectedValue;
            terc.DtVencCndEstadual = txtVencCndEstadual.Text;
            terc.IndIsentoFgtsCrf = rbIsentoFGTS.SelectedValue;
            terc.DtVencFgtsCrf = txtVencFGTS.Text;
            terc.IndIsentoPpra = rbIsentoPPRA.SelectedValue;
            terc.DtVencPpra = txtVencPPRA.Text;
            terc.IndIsentoPcmso = rbIsentoPCMSO.SelectedValue;
            terc.DtVencPcmso = txtVencPCMSO.Text;
            terc.IndAso = chkAsoTerc.Checked ? "S" : "N";
            terc.IndAvalOftalmologica = chkAvalOftalTerc.Checked ? "S" : "N";
            terc.IndAudiometria = chkAudiometriaTerc.Checked ? "S" : "N";
            terc.IndAcuidadeVisual = chkAcuidadeVisualTerc.Checked ? "S" : "N";
            terc.IndAvalPsicossocial = chkAvalPsicoTerc.Checked ? "S" : "N";
            terc.IndEletrocardiograma = chkEletroCardiogramaTerc.Checked ? "S" : "N";
            terc.IndEletroencefalograma = chkEletroEncefalogramaTerc.Checked ? "S" : "N";
            terc.IndEspirometria = chkEspirometriaTerc.Checked ? "S" : "N";
            terc.IndRxColLomboSacra = chkRXLomboSacraTerc.Checked ? "S" : "N";
            terc.IndRxTorax = chkRXToraxTerc.Checked ? "S" : "N";
            terc.IndHemogramaCompleto = chkHemogramaTerc.Checked ? "S" : "N";
            terc.IndPlaquetas = chkPlaquetasTerc.Checked ? "S" : "N";
            terc.IndTipoSanguineo = chkTipoSanguineoTerc.Checked ? "S" : "N";
            terc.IndGlicemiaGlicose = chkGlicemiaTerc.Checked ? "S" : "N";
            terc.IndGamaGt = chkGamaGtTerc.Checked ? "S" : "N";
            terc.IndColesterolTotFrac = chkColesterolTerc.Checked ? "S" : "N";
            terc.IndTgo = chkTgoTerc.Checked ? "S" : "N";
            terc.IndTgp = chkTgpTerc.Checked ? "S" : "N";
            terc.IndManganes = chkManganesTerc.Checked ? "S" : "N";
            terc.IndIsentoLtcat = rbIsentoLTCAT.SelectedValue;
            terc.DtVencLtcat = txtVencLTCAT.Text;
            terc.IndIsentoPpr = rbIsentoPPR.SelectedValue;
            terc.DtVencPpr = txtVencPPR.Text;
            terc.IndIsentoPca = rbIsentoPCA.SelectedValue;
            terc.DtVencPca = txtVencPCA.Text;
            terc.IndIsentoPgrs = rbIsentoPGRS.SelectedValue;
            terc.DtVencPgrs = txtVencPGRS.Text;
            terc.IndIsentoPs = rbIsentoPS.SelectedValue;
            terc.DtVencPs = txtVencPS.Text;
            terc.IndIsentoPcmat = rbIsentoPCMAT.SelectedValue;
            terc.DtVencPcmat = txtVencPCMAT.Text;

            terc.gravaTerceiro();
            ScriptManager.RegisterStartupScript(Page, typeof(Page), "ShowValidation", "toogleTab('1','1'); javascript:alertDomsge('SUCESSO!',\"Os dados do Terceiro foram gravados com sucesso.\", 'rgba(58, 160, 52, 0.8)')", true);
        }
        catch (Exception exc)
        {
            ScriptManager.RegisterStartupScript(Page, typeof(Page), "ShowValidation", "javascript:alertErroDomsge('ERRO',\"" + ACEL0310.trataMensagemErro(exc.Message) + "\")", true);
        }
    }

    public void montaTabelaObras(string codigoTerceiro)
    {
        try
        {
            Terceiro terceiro = new Terceiro();
            DataSet ds = terceiro.listaContratosAbertos(codigoTerceiro, null);
            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {                
                tableObras.Rows.Clear();
                TableHeaderRow tr = new TableHeaderRow();

                TableHeaderCell tcEmpresa = new TableHeaderCell();
                TableHeaderCell tcContrato = new TableHeaderCell();                
                TableHeaderCell tcGnf = new TableHeaderCell();
                TableHeaderCell tcOS = new TableHeaderCell();
                TableHeaderCell tcCliente = new TableHeaderCell();
                TableHeaderCell tcLocalObra = new TableHeaderCell();                
                TableHeaderCell tcEntregaObra = new TableHeaderCell();
                TableHeaderCell tcSupervisor = new TableHeaderCell();
                tcEmpresa.Text = "Empr.";
                tcEmpresa.Width = 60;
                tcContrato.Text = "Contrato";
                tcGnf.Text = "GNF";
                tcOS.Text = "OS";
                tcCliente.Text = "Cliente";
                tcLocalObra.Text = "Local Obra";
                tcEntregaObra.Text = "Entrega Obra";
                tcSupervisor.Text = "Supervisor";

                tr.Cells.Add(tcEmpresa);
                tr.Cells.Add(tcContrato);
                tr.Cells.Add(tcGnf);
                tr.Cells.Add(tcOS);
                tr.Cells.Add(tcCliente);
                tr.Cells.Add(tcLocalObra);
                tr.Cells.Add(tcEntregaObra);
                tr.Cells.Add(tcSupervisor);

                tr.TableSection = TableRowSection.TableHeader;
                tableObras.Rows.Add(tr);

                foreach (DataRow dr in ds.Tables[0].Rows)
                {
                    TableRow tr_ = new TableRow();

                    TableCell tcEmpresa_ = new TableCell();
                    TableCell tcContrato_ = new TableCell();
                    TableCell tcGnf_ = new TableCell();
                    TableCell tcOS_ = new TableCell();
                    TableCell tcCliente_ = new TableCell();
                    TableCell tcLocalObra_ = new TableCell();
                    TableCell tcEntregaObra_ = new TableCell();
                    TableCell tcSupervisor_ = new TableCell();

                    tcEmpresa_.Text = dr["empr_codigo"].ToString();
                    tcContrato_.Text = dr["contrato"].ToString();
                    tcGnf_.Text = dr["gnf"].ToString();
                    tcOS_.Text = dr["os"].ToString();
                    tcCliente_.Text = dr["cliente"].ToString();
                    tcLocalObra_.Text = dr["local_obra"].ToString();
                    tcEntregaObra_.Text = dr["entrega_obra"].ToString();
                    tcSupervisor_.Text = dr["supervisor"].ToString();

                    tr_.Cells.Add(tcEmpresa_);
                    tr_.Cells.Add(tcContrato_);
                    tr_.Cells.Add(tcGnf_);
                    tr_.Cells.Add(tcOS_);
                    tr_.Cells.Add(tcCliente_);
                    tr_.Cells.Add(tcLocalObra_);
                    tr_.Cells.Add(tcEntregaObra_);
                    tr_.Cells.Add(tcSupervisor_);

                    tableObras.Rows.Add(tr_);
                }
            }
            //else
            //{
            //    divExclusaoOutroEscopo.Visible = false;
            //}
        }
        catch (Exception exc)
        {
            ScriptManager.RegisterStartupScript(Page, typeof(Page), "ShowValidation", "javascript:alertErroDomsge('ERRO - montaTabelaObras',\"" + ACEL0310.trataMensagemErro(exc.Message) + "\")", true);
        }
    }

    protected void montaLinkFuncionario()
    {
        try
        {
            string codTerceiro = "";
            string emprTerceiro = "";
            if (!String.IsNullOrEmpty(txtCodTerceiro.Value))
            {
                codTerceiro = txtCodTerceiro.Value;
            }
            if (!String.IsNullOrEmpty(txtEmprTerceiro.Value))
            {
                emprTerceiro = txtEmprTerceiro.Value;
            }

            //monta link para edição de funcionario            
            btnNovoFuncionario.HRef = "GDT00004.aspx?codEmpr=" + emprTerceiro + "&codpessoa=" + codTerceiro;
        }
        catch (Exception exc)
        {
            ScriptManager.RegisterStartupScript(Page, typeof(Page), "ShowValidation", "javascript:alertErroDomsge('ERRO - montaTabelaObras',\"" + ACEL0310.trataMensagemErro(exc.Message) + "\")", true);
        }
    }
    protected void btnGerarPDF_Click(object sender, EventArgs e)
    {

    }



    [System.Web.Services.WebMethod()]
    public static string getContratos(string codigoTerceiro)
    {
        try
        {
            Terceiro terceiro = new Terceiro();
            DataSet ds = terceiro.listaContratosAbertos(codigoTerceiro, null);
            var contratos = new List<Contrato>();

            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                foreach (DataRow dr in ds.Tables[0].Rows)
                {
                    var contrato = new Contrato
                    {
                        Empresa = dr["EMPR_CODIGO"].ToString(),
                        NumeroContrato = dr["CONTRATO"].ToString(),
                        GeracaoContrato = dr["GERACAO"].ToString(),
                        Gnf = dr["GNF"].ToString(),
                        Os = dr["OS"].ToString(),
                        Cliente = dr["CLIENTE"].ToString(),
                        LocalObra = dr["LOCAL_OBRA"].ToString(),
                        InicioObra = dr["INICIO_OBRA"].ToString(),
                        EntregaObra = dr["ENTREGA_OBRA"].ToString(),
                        Supervisor = dr["SUPERVISOR"].ToString()
                    };
                    contratos.Add(contrato);
                }
                var js = new JavaScriptSerializer();

                return js.Serialize(contratos);
            }

            return null;

        }
        catch (Exception)
        {

            throw;
        }
    }


    private void ValidaAcessoPrograma(string codPrograma)
    {
        //Valida se  usuario tem acesso ao PROGRAMA
        if (Session["codUsuario"] != null)
        {
            CORL0001 emp = new CORL0001();
            Usuario usu = new Usuario();
            Programa prog = new Programa();
            ExecutaPrograma execp = new ExecutaPrograma();

            try
            {
                usu.Codusuario = Session["codUsuario"].ToString();
                prog.Cod_programa = codPrograma;

                execp.Programa = prog;
                execp.Usuario = usu;
                emp.CodEmpresa = Session["codEmpresa"].ToString();
                execp.Empresa = emp;

                string dbreturn = execp.ValidaAcessoPrograma();
                if (dbreturn != "S")
                {
                    throw new Exception(dbreturn);
                }
            }
            catch (Exception exc)
            {
                Response.Redirect("~//ACE//Versao01//ACE6065N.aspx?erro=" + exc.Message);
            }
        }
    }
}