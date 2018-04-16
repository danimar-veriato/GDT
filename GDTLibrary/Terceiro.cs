using System;
using System.Data;
using System.Text;
using Dominio.DOMDB;

namespace GDTLibrary
{
    /// <summary>
    /// Classe para manunteção de dados de Terceiros do sistema GDT
    /// </summary>
    public class Terceiro
    {
        // Histórico de Alterações
        // Nº Alt.  Data        Pessoa            Chamado  Descrição
        // ------- ----------- ------------------ -------- -----------------------------------------------------------------------------------------------
        // 00      11/04/2018  Adriano Tomczak     #20265   -Criação da Classe. 
        //

        StringBuilder Query = new StringBuilder();
        DatabaseOracle dbOracle = new DatabaseOracle();

        #region atributos
        public string EmprCodigo { get; set; }
        public Int32 DpesCodigo { get; set; }
        public string Situacao { get; set; }
        public string ContatoEmergencia { get; set; }
        public string DtVencAlvara { get; set; }
        public string TipoDocSocietario { get; set; }
        public string DtVencCndFederal { get; set; }
        public string DtVencCndMunicipal { get; set; }
        public string IndIsentoCndEstadual { get; set; }
        public string DtVencCndEstadual { get; set; }
        public string IndIsentoFgtsCrf { get; set; }
        public string DtVencFgtsCrf { get; set; }
        public string IndIsentoPpra { get; set; }
        public string DtVencPpra { get; set; }
        public string IndIsentoPcmso { get; set; }
        public string DtVencPcmso { get; set; }
        public string IndAso { get; set; }
        public string IndAvalOftalmologica { get; set; }
        public string IndAudiometria { get; set; }
        public string IndAcuidadeVisual { get; set; }
        public string IndAvalPsicossocial { get; set; }
        public string IndEletrocardiograma { get; set; }
        public string IndEletroencefalograma { get; set; }
        public string IndEspirometria { get; set; }
        public string IndRxColLomboSacra { get; set; }
        public string IndRxTorax { get; set; }
        public string IndHemogramaCompleto { get; set; }
        public string IndPlaquetas { get; set; }
        public string IndTipoSanguineo { get; set; }
        public string IndGlicemiaGlicose { get; set; }
        public string IndGamaGt { get; set; }
        public string IndColesterolTotFrac { get; set; }
        public string IndTgo { get; set; }
        public string IndTgp { get; set; }
        public string IndManganes { get; set; }
        public string IndIsentoLtcat { get; set; }
        public string DtVencLtcat { get; set; }
        public string IndIsentoPpr { get; set; }
        public string DtVencPpr { get; set; }
        public string IndIsentoPca { get; set; }
        public string DtVencPca { get; set; }
        public string IndIsentoPgrs { get; set; }
        public string DtVencPgrs { get; set; }
        public Int32 QtdeTrabalhadores { get; set; }
        public Int32 DpesCodigoContador { get; set; }
        public string IndIsentoPs { get; set; }
        public string DtVencPs { get; set; }
        public string IndIsentoPcmat { get; set; }
        public string DtVencPcmat { get; set; }
        #endregion atributos

        #region metodos
        /// <summary>
        /// Médodo responsável pela manutenção de dados de Terceiros
        /// </summary>
        public void gravaTerceiro()
        {
            try
            {
                //verifica se o terceiro já existe
                Query.Remove(0, Query.Length);
                Query.Append(" SELECT 1 ");
                Query.Append("   FROM gdt_terceiro");
                Query.Append("  WHERE empr_codigo = '" + EmprCodigo + "' ");
                Query.Append("    and dpes_codigo = " + DpesCodigo + " ");
                DataSet ds = dbOracle.Lista("gdt_terceiro", Query.ToString());

                if (ds != null && ds.Tables[0].Rows.Count > 0)                    
                {
                    //se encontrar registro, faz update
                    Query.Remove(0, Query.Length);
                    Query.Append(" UPDATE gdt_terceiro ");
                    Query.Append("    SET empr_codigo = '" + EmprCodigo + "', ");
                    Query.Append("        dpes_codigo = " + DpesCodigo + ", ");
                    Query.Append("        situacao = " + Situacao + ", ");
                    if (!String.IsNullOrEmpty(ContatoEmergencia))
                    {
                        Query.Append("    contato_emergencia = '" + ContatoEmergencia + "', ");
                    }
                    else
                    {
                        Query.Append("    contato_emergencia = null, ");
                    }                   
                    if (!String.IsNullOrEmpty(DtVencAlvara))
                    {
                        Query.Append("    dt_venc_alvara = '" + DtVencAlvara + "', ");
                    }
                    else
                    {
                        Query.Append("    dt_venc_alvara = null, ");
                    }                    
                    Query.Append("    tipo_doc_societario = '" + TipoDocSocietario + "', ");
                    Query.Append("    dt_venc_cnd_federal = TO_DATE('" + DtVencCndFederal + "','DD/MM/RRRR'), ");                   
                    Query.Append("    dt_venc_cnd_municipal = TO_DATE('" + DtVencCndMunicipal + "','DD/MM/RRRR'), ");
                    Query.Append("    ind_isento_cnd_estadual = '" + IndIsentoCndEstadual + "', ");
                    if (!String.IsNullOrEmpty(DtVencCndEstadual))
                    {                        
                        Query.Append("    dt_venc_cnd_estadual = TO_DATE('" + DtVencCndEstadual + "','DD/MM/RRRR'), ");
                    }
                    else
                    {
                        Query.Append("    dt_venc_cnd_estadual = null, ");
                    }
                    Query.Append("    ind_isento_fgts_crf = '" + IndIsentoFgtsCrf + "', ");
                    if (!String.IsNullOrEmpty(DtVencFgtsCrf))
                    {                        
                        Query.Append("    dt_venc_fgts_crf = TO_DATE('" + DtVencFgtsCrf + "','DD/MM/RRRR'), ");
                    }
                    else
                    {
                        Query.Append("    dt_venc_fgts_crf = null, ");
                    }
                    Query.Append("    ind_isento_ppra = '" + IndIsentoPpra + "', ");
                    if (!String.IsNullOrEmpty(DtVencPpra))
                    {                        
                        Query.Append("    dt_venc_ppra = TO_DATE('" + DtVencPpra + "','DD/MM/RRRR'), ");
                    }
                    else
                    {
                        Query.Append("    dt_venc_ppra = null, ");
                    }
                    Query.Append("    ind_isento_pcmso = '" + IndIsentoPcmso + "', ");
                    if (!String.IsNullOrEmpty(DtVencPcmso))
                    {                        
                        Query.Append("    dt_venc_pcmso = TO_DATE('" + DtVencPcmso + "','DD/MM/RRRR'), ");
                    }
                    else
                    {
                        Query.Append("    dt_venc_pcmso = null, ");
                    }
                    Query.Append("    ind_aso = '" + IndAso + "', ");
                    Query.Append("    ind_aval_oftalmologica = '" + IndAvalOftalmologica + "', ");
                    Query.Append("    ind_audiometria = '" + IndAudiometria + "', ");
                    Query.Append("    ind_acuidade_visual = '" + IndAcuidadeVisual + "', ");
                    Query.Append("    ind_aval_psicossocial = '" + IndAvalPsicossocial + "', ");
                    Query.Append("    ind_eletrocardiograma = '" + IndEletrocardiograma + "', ");
                    Query.Append("    ind_eletroencefalograma = '" + IndEletroencefalograma + "', ");
                    Query.Append("    ind_espirometria = '" + IndEspirometria + "', ");
                    Query.Append("    ind_rx_col_lombo_sacra = '" + IndRxColLomboSacra + "', ");
                    Query.Append("    ind_rx_torax = '" + IndRxTorax + "', ");
                    Query.Append("    ind_hemograma_completo = '" + IndHemogramaCompleto + "', ");
                    Query.Append("    ind_plaquetas = '" + IndPlaquetas + "', ");
                    Query.Append("    ind_tipo_sanguineo = '" + IndTipoSanguineo + "', ");
                    Query.Append("    ind_glicemia_glicose = '" + IndGlicemiaGlicose + "', ");
                    Query.Append("    ind_gama_gt = '" + IndGamaGt + "', ");
                    Query.Append("    ind_colesterol_tot_frac = '" + IndColesterolTotFrac + "', ");
                    Query.Append("    ind_tgo = '" + IndTgo + "', ");
                    Query.Append("    ind_tgp = '" + IndTgp + "', ");
                    Query.Append("    ind_manganes = '" + IndManganes + "', ");
                    Query.Append("    ind_isento_ltcat = '" + IndIsentoLtcat + "', ");
                    if (!String.IsNullOrEmpty(DtVencLtcat))
                    {                        
                        Query.Append("    dt_venc_ltcat = TO_DATE('" + DtVencLtcat + "','DD/MM/RRRR'), ");
                    }
                    else
                    {
                        Query.Append("    dt_venc_ltcat = null, ");
                    }
                    Query.Append("    ind_isento_ppr = '" + IndIsentoPpr + "', ");
                    if (!String.IsNullOrEmpty(DtVencPpr))
                    {                        
                        Query.Append("    dt_venc_ppr = TO_DATE('" + DtVencPpr + "','DD/MM/RRRR'), ");
                    }
                    else
                    {
                        Query.Append("    dt_venc_ppr = null, ");
                    }
                    Query.Append("    ind_isento_pca = '" + IndIsentoPca + "', ");
                    if (!String.IsNullOrEmpty(DtVencPca))
                    {                        
                        Query.Append("    dt_venc_pca = TO_DATE('" + DtVencPca + "','DD/MM/RRRR'), ");
                    }
                    else
                    {
                        Query.Append("    dt_venc_pca = null, ");
                    }
                    Query.Append("    ind_isento_pgrs = '" + IndIsentoPgrs + "', ");
                    if (!String.IsNullOrEmpty(DtVencPgrs))
                    {                        
                        Query.Append("    dt_venc_pgrs = TO_DATE('" + DtVencPgrs + "','DD/MM/RRRR'), ");
                    }
                    else
                    {
                        Query.Append("    dt_venc_pgrs = null, ");
                    }
                    Query.Append("    qtde_trabalhadores = " + QtdeTrabalhadores + ", ");
                    if (!String.IsNullOrEmpty(Convert.ToString(DpesCodigoContador)))
                    {
                        Query.Append("    dpes_codigo_contador = " + DpesCodigoContador + ", ");
                    }
                    else
                    {
                        Query.Append("    dpes_codigo_contador = null, ");
                    }
                    Query.Append("    ind_isento_ps = '" + IndIsentoPs + "', ");
                    if (!String.IsNullOrEmpty(DtVencPs))
                    {                        
                        Query.Append("    dt_venc_ps = TO_DATE('" + DtVencPs + "','DD/MM/RRRR'), ");
                    }
                    else
                    {
                        Query.Append("    dt_venc_ps = null, ");
                    }
                    Query.Append("    ind_isento_pcmat = '" + IndIsentoPcmat + "', ");
                    if (!String.IsNullOrEmpty(DtVencPcmat))
                    {                        
                        Query.Append("    dt_venc_pcmat = TO_DATE('" + DtVencPcmat + "','DD/MM/RRRR') ");
                    }
                    else
                    {
                        Query.Append("    dt_venc_pcmat = null ");
                    }

                    Query.Append("  WHERE empr_codigo = '" + EmprCodigo + "' ");
                    Query.Append("    and dpes_codigo = " + DpesCodigo + " ");

                    dbOracle.InUp("gdt_terceiro", Query.ToString(), "ACESSOS", "U");
                }
                else
                {
                    //se não encontrar insere um registro
                    Query.Remove(0, Query.Length);
                    Query.Append("INSERT into gdt_terceiro ( ");
                    Query.Append("       empr_codigo, ");
                    Query.Append("       dpes_codigo, ");
                    Query.Append("       situacao, ");
                    Query.Append("       contato_emergencia, ");
                    Query.Append("       dt_venc_alvara, ");
                    Query.Append("       tipo_doc_societario, ");
                    Query.Append("       dt_venc_cnd_federal, ");
                    Query.Append("       dt_venc_cnd_municipal, ");
                    Query.Append("       ind_isento_cnd_estadual, ");
                    Query.Append("       dt_venc_cnd_estadual, ");
                    Query.Append("       ind_isento_fgts_crf, ");
                    Query.Append("       dt_venc_fgts_crf, ");
                    Query.Append("       ind_isento_ppra, ");
                    Query.Append("       dt_venc_ppra, ");
                    Query.Append("       ind_isento_pcmso, ");
                    Query.Append("       dt_venc_pcmso, ");
                    Query.Append("       ind_aso, ");
                    Query.Append("       ind_aval_oftalmologica, ");
                    Query.Append("       ind_audiometria, ");
                    Query.Append("       ind_acuidade_visual, ");
                    Query.Append("       ind_aval_psicossocial, ");
                    Query.Append("       ind_eletrocardiograma, ");
                    Query.Append("       ind_eletroencefalograma, ");
                    Query.Append("       ind_espirometria, ");
                    Query.Append("       ind_rx_col_lombo_sacra, ");
                    Query.Append("       ind_rx_torax, ");
                    Query.Append("       ind_hemograma_completo, ");
                    Query.Append("       ind_plaquetas, ");
                    Query.Append("       ind_tipo_sanguineo, ");
                    Query.Append("       ind_glicemia_glicose, ");
                    Query.Append("       ind_gama_gt, ");
                    Query.Append("       ind_colesterol_tot_frac, ");
                    Query.Append("       ind_tgo, ");
                    Query.Append("       ind_tgp, ");
                    Query.Append("       ind_manganes, ");
                    Query.Append("       ind_isento_ltcat, ");
                    Query.Append("       dt_venc_ltcat, ");
                    Query.Append("       ind_isento_ppr, ");
                    Query.Append("       dt_venc_ppr, ");
                    Query.Append("       ind_isento_pca, ");
                    Query.Append("       dt_venc_pca, ");
                    Query.Append("       ind_isento_pgrs, ");
                    Query.Append("       dt_venc_pgrs, ");
                    Query.Append("       qtde_trabalhadores, ");
                    Query.Append("       dpes_codigo_contador, ");
                    Query.Append("       ind_isento_ps, ");
                    Query.Append("       dt_venc_ps, ");
                    Query.Append("       ind_isento_pcmat, ");
                    Query.Append("       dt_venc_pcmat ) ");
                    Query.Append(" VALUES ( ");
                    Query.Append(" '" + EmprCodigo + "', ");
                    Query.Append("" + DpesCodigo + ", ");
                    Query.Append(" '" + Situacao + "', ");
                    if (!String.IsNullOrEmpty(ContatoEmergencia))
                    {
                        Query.Append(" '" + ContatoEmergencia + "', ");
                    }
                    else
                    {
                        Query.Append(" null,");
                    }
                    if (!String.IsNullOrEmpty(DtVencAlvara))
                    {
                        Query.Append(" TO_DATE('" + DtVencAlvara + "','DD/MM/RRRR'), ");                        
                    }
                    else
                    {
                        Query.Append(" null,");
                    }
                    Query.Append(" '" + TipoDocSocietario + "', ");                    
                    Query.Append(" TO_DATE('" + DtVencCndFederal + "','DD/MM/RRRR'), ");                    
                    Query.Append(" TO_DATE('" + DtVencCndMunicipal + "','DD/MM/RRRR'), ");
                    Query.Append(" '" + IndIsentoCndEstadual + "', ");
                    if (!String.IsNullOrEmpty(DtVencCndEstadual))
                    {                        
                        Query.Append(" TO_DATE('" + DtVencCndEstadual + "','DD/MM/RRRR'), ");
                    }
                    else
                    {
                        Query.Append(" null,");
                    }
                    Query.Append(" '" + IndIsentoFgtsCrf + "', ");
                    if (!String.IsNullOrEmpty(DtVencFgtsCrf))
                    {                        
                        Query.Append(" TO_DATE('" + DtVencFgtsCrf + "','DD/MM/RRRR'), ");
                    }
                    else
                    {
                        Query.Append(" null,");
                    }
                    Query.Append(" '" + IndIsentoPpra + "', ");
                    if (!String.IsNullOrEmpty(DtVencPpra))
                    {                        
                        Query.Append(" TO_DATE('" + DtVencPpra + "','DD/MM/RRRR'), ");
                    }
                    else
                    {
                        Query.Append(" null,");
                    }
                    Query.Append(" '" + IndIsentoPcmso + "', ");
                    if (!String.IsNullOrEmpty(DtVencPcmso))
                    {                        
                        Query.Append(" TO_DATE('" + DtVencPcmso + "','DD/MM/RRRR'), ");
                    }
                    else
                    {
                        Query.Append(" null,");
                    }
                    Query.Append(" '" + IndAso + "', ");
                    Query.Append(" '" + IndAvalOftalmologica + "', ");
                    Query.Append(" '" + IndAudiometria + "', ");
                    Query.Append(" '" + IndAcuidadeVisual + "', ");
                    Query.Append(" '" + IndAvalPsicossocial + "', ");
                    Query.Append(" '" + IndEletrocardiograma + "', ");
                    Query.Append(" '" + IndEletroencefalograma + "', ");
                    Query.Append(" '" + IndEspirometria + "', ");
                    Query.Append(" '" + IndRxColLomboSacra + "', ");
                    Query.Append(" '" + IndRxTorax + "', ");
                    Query.Append(" '" + IndHemogramaCompleto + "', ");
                    Query.Append(" '" + IndPlaquetas + "', ");
                    Query.Append(" '" + IndTipoSanguineo + "', ");
                    Query.Append(" '" + IndGlicemiaGlicose + "', ");
                    Query.Append(" '" + IndGamaGt + "', ");
                    Query.Append(" '" + IndColesterolTotFrac + "', ");
                    Query.Append(" '" + IndTgo + "', ");
                    Query.Append(" '" + IndTgp + "', ");
                    Query.Append(" '" + IndManganes + "', ");
                    Query.Append(" '" + IndIsentoLtcat + "', ");
                    if (!String.IsNullOrEmpty(DtVencLtcat))
                    {                        
                        Query.Append(" TO_DATE('" + DtVencLtcat + "','DD/MM/RRRR'), ");
                    }
                    else
                    {
                        Query.Append(" null,");
                    }
                    Query.Append(" '" + IndIsentoPpr + "', ");
                    if (!String.IsNullOrEmpty(DtVencPpr))
                    {                        
                        Query.Append(" TO_DATE('" + DtVencPpr + "','DD/MM/RRRR'), ");
                    }
                    else
                    {
                        Query.Append(" null,");
                    }
                    Query.Append(" '" + IndIsentoPca + "', ");
                    if (!String.IsNullOrEmpty(DtVencPca))
                    {                        
                        Query.Append(" TO_DATE('" + DtVencPca + "','DD/MM/RRRR'), ");
                    }
                    else
                    {
                        Query.Append(" null,");
                    }
                    Query.Append(" '" + IndIsentoPgrs + "', ");
                    if (!String.IsNullOrEmpty(DtVencPgrs))
                    {                        
                        Query.Append(" TO_DATE('" + DtVencPgrs + "','DD/MM/RRRR'), ");
                    }
                    else
                    {
                        Query.Append(" null,");
                    }
                    Query.Append(" " + QtdeTrabalhadores + ", ");
                    if (!String.IsNullOrEmpty(Convert.ToString(DpesCodigoContador)))
                    {
                        Query.Append(" " + DpesCodigoContador + ", ");
                    }
                    else
                    {
                        Query.Append(" null,");
                    }
                    Query.Append(" '" + IndIsentoPs + "', ");
                    if (!String.IsNullOrEmpty(DtVencPs))
                    {                        
                        Query.Append(" TO_DATE('" + DtVencPs + "','DD/MM/RRRR'), ");
                    }
                    else
                    {
                        Query.Append(" null,");
                    }
                    Query.Append(" '" + IndIsentoPcmat + "', ");
                    if (!String.IsNullOrEmpty(DtVencPcmat))
                    {                        
                        Query.Append(" TO_DATE('" + DtVencPcmat + "','DD/MM/RRRR') ) ");
                    }
                    else
                    {
                        Query.Append("'') ");
                    }
                    dbOracle.InUp("gdt_terceiro", Query.ToString(), "ACESSOS", "I");
                }
            }
            catch (Exception exc)
            {
                throw new Exception(exc.Message);
            }
        }

        /// <summary>
        /// Retorna dados de terceiros cadastrados
        /// </summary>
        /// <param name="empresa">Empresa do terceiro</param>
        /// <param name="codigoTerceiro">Código do terceiro (opcional, se não informado código retorna todos os terceiros cadastrados na empresa)</param>
        /// <returns>Retorna um DataSet de dados do terceiro</returns>
        public DataSet consultaTerceiro(string empresa, string codigoTerceiro)
        {
            try
            {
                Query.Remove(0, Query.Length);
                Query.Append(" SELECT empr_codigo, ");                
                Query.Append("        dpes_codigo, ");
                Query.Append("        corp10000.retorna_razao_social(dpes_codigo) razao_social, ");
                Query.Append("        situacao, ");
                Query.Append("        decode(situacao,'A','Ativo','I','Inativo') situacao_ext, ");
                Query.Append("        contato_emergencia, ");
                Query.Append("        to_char(dt_venc_alvara,'dd/mm/rrrr') dt_venc_alvara, ");
                Query.Append("        tipo_doc_societario, ");                
                Query.Append("        to_char(dt_venc_cnd_federal,'dd/mm/rrrr') dt_venc_cnd_federal, ");                
                Query.Append("        to_char(dt_venc_cnd_municipal,'dd/mm/rrrr') dt_venc_cnd_municipal, ");
                Query.Append("        ind_isento_cnd_estadual, ");                
                Query.Append("        to_char(dt_venc_cnd_estadual,'dd/mm/rrrr') dt_venc_cnd_estadual, ");
                Query.Append("        ind_isento_fgts_crf, ");                
                Query.Append("        to_char(dt_venc_fgts_crf,'dd/mm/rrrr') dt_venc_fgts_crf, ");
                Query.Append("        ind_isento_ppra, ");                
                Query.Append("        to_char(dt_venc_ppra,'dd/mm/rrrr') dt_venc_ppra, ");
                Query.Append("        ind_isento_pcmso, ");                
                Query.Append("        to_char(dt_venc_pcmso,'dd/mm/rrrr') dt_venc_pcmso, ");
                Query.Append("        ind_aso, ");
                Query.Append("        ind_aval_oftalmologica, ");
                Query.Append("        ind_audiometria, ");
                Query.Append("        ind_acuidade_visual, ");
                Query.Append("        ind_aval_psicossocial, ");
                Query.Append("        ind_eletrocardiograma, ");
                Query.Append("        ind_eletroencefalograma, ");
                Query.Append("        ind_espirometria, ");
                Query.Append("        ind_rx_col_lombo_sacra, ");
                Query.Append("        ind_rx_torax, ");
                Query.Append("        ind_hemograma_completo, ");
                Query.Append("        ind_plaquetas, ");
                Query.Append("        ind_tipo_sanguineo, ");
                Query.Append("        ind_glicemia_glicose, ");
                Query.Append("        ind_gama_gt, ");
                Query.Append("        ind_colesterol_tot_frac, ");
                Query.Append("        ind_tgo, ");
                Query.Append("        ind_tgp, ");
                Query.Append("        ind_manganes, ");
                Query.Append("        ind_isento_ltcat, ");                
                Query.Append("        to_char(dt_venc_ltcat,'dd/mm/rrrr') dt_venc_ltcat, ");
                Query.Append("        ind_isento_ppr, ");                
                Query.Append("        to_char(dt_venc_ppr,'dd/mm/rrrr') dt_venc_ppr, ");
                Query.Append("        ind_isento_pca, ");                
                Query.Append("        to_char(dt_venc_pca,'dd/mm/rrrr') dt_venc_pca, ");
                Query.Append("        ind_isento_pgrs, ");                
                Query.Append("        to_char(dt_venc_pgrs,'dd/mm/rrrr') dt_venc_pgrs, ");
                Query.Append("        qtde_trabalhadores, ");
                Query.Append("        dpes_codigo_contador, ");
                Query.Append("        ind_isento_ps, ");                
                Query.Append("        to_char(dt_venc_ps,'dd/mm/rrrr') dt_venc_ps, ");
                Query.Append("        ind_isento_pcmat, ");                
                Query.Append("        to_char(dt_venc_pcmat,'dd/mm/rrrr') dt_venc_pcmat, ");                
                Query.Append("        to_char(dt_cadastro,'dd/mm/rrrr') dt_cadastro ");
                Query.Append("   FROM gdt_terceiro  ");
                Query.Append("  WHERE empr_codigo = '" + empresa + "' ");                
                if (!String.IsNullOrEmpty(Convert.ToString(codigoTerceiro)))
                {
                    Query.Append("   and dpes_codigo = " + codigoTerceiro + " ");
                }
                Query.Append("  order by corp10000.retorna_razao_social(dpes_codigo) ");

                DataSet ds = dbOracle.Lista("gdt_terceiro", Query.ToString());

                return ds;
            }
            catch (Exception exc)
            {
                throw new Exception(exc.Message);
            }
        }

        /// <summary>
        /// Retorna uma lista de contratos em aberto do terceiro
        /// </summary>
        /// <param name="codigoTerceiro">Código do terceiro</param>
        /// <param name="empresa">Empresa do contrato (opcional)</param>
        /// <returns>Retorna um DataSet de contratos</returns>
        public DataSet listaContratosAbertos(string codigoTerceiro, string empresa) {
            try
            {
                Query.Remove(0, Query.Length);
                if (!String.IsNullOrEmpty(codigoTerceiro))
                {
                    Query.Append(" SELECT empr_codigo, ");
                    Query.Append("        contrato_nr contrato, ");
                    Query.Append("        to_char(data_contrato,'dd/mm/rrrr') geracao, ");
                    Query.Append("        hp gnf, ");
                    Query.Append("        os, ");
                    Query.Append("        corp10000.retorna_razao_social(cod_cliente)||' - '||cod_cliente cliente, ");
                    Query.Append("        local_obra, ");
                    Query.Append("        to_char(inicio_obra,'dd/mm/rrrr') inicio_obra, ");
                    Query.Append("        to_char(entrega_obra,'dd/mm/rrrr') entrega_obra, ");
                    Query.Append("        corp10000.retorna_razao_social(dpes_cod_supervisor)||' - '||dpes_cod_supervisor supervisor ");
                    Query.Append("   FROM contratos ");
                    Query.Append("  WHERE cod_terceiro = " + codigoTerceiro + " " );
                    Query.Append("    and tipo_docto   = 'C' ");
                    //contratos que não estão na exceção(constratos reincididos c / saldo em aberto, são colocados na exceção para não serem considerados em aberto)
                    Query.Append("    and	nvl(ind_excecao_relatorio,'N') != 'S' ");
                    //só contratos com saldo
                    Query.Append("    and csdp18000(empr_codigo, contrato_nr, cod_terceiro, tipo_docto) >0 ");
                    //se for necessário filtrar pela empresa
                    if (!String.IsNullOrEmpty(empresa))
                    {
                        Query.Append(" and empr_codigo 	in 	(select codigo ");
                        Query.Append("                         from dom_empresa_grupo deg ");
                        Query.Append("                      connect by prior deg.codigo = deg.empr_codigo ");
                        Query.Append("                        start with deg.codigo = '" + empresa + "') ");
                    }
                    Query.Append("    order by empr_codigo, cod_cliente, contrato_nr");

                    DataSet ds = dbOracle.Lista("contratos", Query.ToString());
                    return ds;
                }
                return null;
            }
            catch (Exception exc)
            {
                throw new Exception(exc.Message);
            }
        }
        /// <summary>
        /// Método para busca de dados complementares do terceiro
        /// </summary>
        /// <param name="codigoPessoa">Código de pessoa</param>
        /// <returns>Retorna um DataSet</returns>
        public DataSet complementoPessoa(string codigoPessoa)
        {
            try
            {
                Query.Remove(0, Query.Length);
                if (!String.IsNullOrEmpty(codigoPessoa))
                {
                    Query.Append(" SELECT decode(logradouro,'.','', logradouro)||' '||descricao||decode(numero,'.',' ',', '||numero)||decode(bairro,'.','',' BAIRRO '||bairro) endereco, ");
                    Query.Append("        corp10000.retorna_meio_comunicacao(1,'T', codigo) telefone, ");
                    Query.Append("        corp10000.retorna_meio_comunicacao(1,'E', codigo) email ");
                    Query.Append("   FROM dom_pessoa");
                    Query.Append("  WHERE codigo = " + codigoPessoa + " ");
                    DataSet ds = dbOracle.Lista("contratos", Query.ToString());
                    return ds;
                }
                return null;
            }
            catch (Exception)
            {

                throw;
            }
        }
        #endregion metodos
    }
}
