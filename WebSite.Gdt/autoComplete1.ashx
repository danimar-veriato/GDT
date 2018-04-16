<%@ WebHandler Language="C#" Class="autoComplete" %>

using System;
using System.Collections.ObjectModel;
using System.Data;
using System.Web;
using System.Web.Script.Serialization;
using Dominio.DOMDB;
using Dominio.DOMCOR;
using System.Web.SessionState;


public class autoComplete : IHttpHandler, System.Web.SessionState.IReadOnlySessionState
{
    public void ProcessRequest(HttpContext context)
    {
        if (context.Session["codUsuario"] != null)
        {

            //  Query string 'term' is for autocomplete. By default, it sends the variable 
            //  "term" with the search word to the backend page.
            string searchText = context.Request.QueryString["q"];
            string IDText = context.Request.QueryString["id"];
            string empr = context.Session["codEmpresa"].ToString();

            DataSet ds = null;
            string tipo = "";

            if (context.Request.QueryString["tipo"] != null)
            {
                tipo = context.Request.QueryString["tipo"];
            }

            DatabaseOracle dbOracle = new DatabaseOracle();

            if (tipo.Equals("pessoa"))
            {
                if (!string.IsNullOrEmpty(IDText))
                {
                    ds = dbOracle.Lista("DOM_PESSOA", "SELECT CODIGO, RAZAO_SOCIAL VALOR FROM DOM_PESSOA WHERE TO_CHAR(CODIGO) = '" + IDText + "'");
                }
                else
                {
                    if (true) //parâmetro se vai ou não filtrar igual a corn5000
                    {

                        ds = dbOracle.Lista("DOM_PESSOA", "SELECT CODIGO, RAZAO_SOCIAL VALOR FROM DOM_PESSOA WHERE UPPER(RAZAO_SOCIAL) LIKE UPPER('" + searchText.Replace(' ', '%') + "%') OR TO_CHAR(CODIGO) = '" + searchText + "' OR NOME_FANTASIA like upper('%" + searchText.Replace(' ', '%') + "%') OR CGC_CPF like '" + searchText.Replace(' ', '%') + "%'");
                    }
                    else
                    {
                        ds = dbOracle.Lista("DOM_PESSOA", "SELECT CODIGO, RAZAO_SOCIAL VALOR FROM DOM_PESSOA WHERE UPPER(RAZAO_SOCIAL) LIKE UPPER('" + searchText + "%') OR TO_CHAR(CODIGO) = '" + searchText + "' ");
                    }
                }
            }
            else if (tipo.Equals("concorrente"))
            {
                if (!string.IsNullOrEmpty(IDText))
                {
                    ds = dbOracle.Lista("DOM_PESSOA", "  select dp.codigo codigo, ltrim(chave1||' '|| chave2||' '|| chave3||' '|| chave4||' '|| dp.razao_social) valor from DOMCOR.DOM_PESSOA dp where 1=1 and dp.codigo in (select cc.dpes_codigo from dom_concorrente cc where empr_codigo = '" + empr + "') and TO_CHAR(CODIGO) = '" + searchText + "' ");
                }
                else
                {
                    ds = dbOracle.Lista("DOM_PESSOA", " select dp.codigo codigo, ltrim(chave1||' '|| chave2||' '|| chave3||' '|| chave4||' '|| dp.razao_social) valor from DOMCOR.DOM_PESSOA dp where 1=1 and dp.codigo in (select cc.dpes_codigo from dom_concorrente cc where empr_codigo = '" + empr + "') and (UPPER(dp.RAZAO_SOCIAL) LIKE UPPER('" + searchText + "%') OR TO_CHAR(dp.CODIGO) = '" + searchText + "') ");
                }
            }
            else if (tipo.Equals("pessoaF"))
            {
                if (!string.IsNullOrEmpty(IDText))
                {
                    ds = dbOracle.Lista("DOM_PESSOA", "SELECT CODIGO, '' || CODIGO || ' - ' || RAZAO_SOCIAL || '' VALOR FROM DOM_PESSOA WHERE TIPO_PESSOA = 'F' AND TO_CHAR(CODIGO) = '" + IDText + "'");
                }
                else
                {
                    ds = dbOracle.Lista("DOM_PESSOA", "SELECT CODIGO, '' || CODIGO || ' - ' || RAZAO_SOCIAL || '' VALOR FROM DOM_PESSOA WHERE TIPO_PESSOA = 'F' AND UPPER(RAZAO_SOCIAL) LIKE UPPER('" + searchText + "%') OR TO_CHAR(CODIGO) = '" + searchText + "' ");
                }
            }
            else if (tipo.Equals("pessoaJ"))
            {
                if (!string.IsNullOrEmpty(IDText))
                {
                    ds = dbOracle.Lista("DOM_PESSOA", "SELECT CODIGO, '' || CODIGO || ' - ' || RAZAO_SOCIAL || '' VALOR  FROM DOM_PESSOA WHERE TIPO_PESSOA = 'J' AND TO_CHAR(CODIGO) = '" + IDText + "'");
                }
                else
                {
                    ds = dbOracle.Lista("DOM_PESSOA", "SELECT CODIGO, '' || CODIGO || ' - ' || RAZAO_SOCIAL || '' VALOR  FROM DOM_PESSOA WHERE TIPO_PESSOA = 'J' AND UPPER(RAZAO_SOCIAL) LIKE UPPER('" + searchText + "%') OR TO_CHAR(CODIGO) = '" + searchText + "' ");
                }
            }
            else if (tipo.Equals("pessoaSup"))
            {
                if (!string.IsNullOrEmpty(IDText))
                {
                    ds = dbOracle.Lista("DOM_PESSOA", "select codigo, ltrim(chave1||' '|| chave2||' '|| chave3||' '|| chave4||' '|| razao_social) VALOR from DOM_PESSOA WHERE TO_CHAR(CODIGO) = '" + IDText + "'");
                }
                else
                {
                    ds = dbOracle.Lista("DOM_PESSOA", "select codigo, ltrim(chave1||' '|| chave2||' '|| chave3||' '|| chave4||' '|| razao_social) VALOR from DOM_PESSOA WHERE UPPER(RAZAO_SOCIAL) LIKE UPPER('" + searchText + "%') OR TO_CHAR(CODIGO) = '" + searchText + "' ");
                }
            }
            else if (tipo.Equals("pessoaDetalhe"))
            {
                if (!string.IsNullOrEmpty(IDText))
                {
                    string p = "";
                    p += "select dp.codigo, ";
                    p += "dp.razao_social, ";
                    p += "dp.cgc_cpf, ";
                    p += "dp.inscricao_estadual, ";
                    p += "dm.descricao cidade, ";
                    p += "de.sigla, ";
                    p += "dm.descricao||' ('||de.sigla||') - '||pa.descricao cidade_uf, ";
                    p += "pa.descricao pais, ";
                    p += "decode(dp.logradouro,'.','', dp.logradouro)||' '||dp.descricao||decode(dp.numero,'.',' ',', '||dp.numero)||decode(dp.bairro,'.','',' BAIRRO '||dp.bairro) endereco, ";
                    p += "corp10000.retorna_meio_comunicacao(1,'T', dp.codigo) telefone, ";
                    p += "corp10000.retorna_meio_comunicacao(1,'E', dp.codigo) email ";
                    p += "FROM dom_pessoa dp, ";
                    p += "     dom_municipio dm, ";
                    p += "     dom_estado de, ";
                    p += "     dom_pais pa ";
                    p += "WHERE to_char(dp.codigo) = '" + IDText + "'";
                    p += "  and dp.muni_codigo = dm.codigo ";
                    p += "  and dp.estd_codigo = dm.estd_codigo ";
                    p += "  and de.codigo = dp.estd_codigo ";
                    p += "  and pa.codigo = de.pais_codigo ";
                    p += "ORDER by dp.razao_social, dp.codigo ";
                    ds = dbOracle.Lista("Varias", p);
                }
                else
                {
                    string p = "";
                    p += "select dp.codigo, ";
                    p += "dp.razao_social, ";
                    p += "dp.cgc_cpf, ";
                    p += "dp.inscricao_estadual, ";
                    p += "dm.descricao cidade, ";
                    p += "de.sigla, ";
                    p += "dm.descricao||' ('||de.sigla||') - '||pa.descricao cidade_uf, ";
                    p += "pa.descricao pais, ";
                    p += "decode(dp.logradouro,'.','', dp.logradouro)||' '||dp.descricao||decode(dp.numero,'.',' ',', '||dp.numero)||decode(dp.bairro,'.','',' BAIRRO '||dp.bairro) endereco, ";
                    p += "corp10000.retorna_meio_comunicacao(1,'T', dp.codigo) telefone, ";
                    p += "corp10000.retorna_meio_comunicacao(1,'E', dp.codigo) email ";
                    p += "FROM dom_pessoa dp, ";
                    p += "     dom_municipio dm, ";
                    p += "     dom_estado de, ";
                    p += "     dom_pais pa ";
                    p += "WHERE dp.muni_codigo = dm.codigo ";
                    p += "and dp.estd_codigo = dm.estd_codigo ";
                    p += "and de.codigo = dp.estd_codigo ";
                    p += "and pa.codigo = de.pais_codigo ";
                    p += "and ( dp.codigo like '%" + searchText + "%' ";
                    p += "or UPPER(dp.razao_social) like UPPER('%" + searchText + "%') ";
                    p += "or dp.cgc_cpf like '%" + searchText + "%' ";
                    p += ") ORDER by dp.razao_social, dp.codigo ";
                    ds = dbOracle.Lista("Varias", p);
                }
            }
            else if (tipo.Equals("cidadeDetalhe"))
            {
                if (!string.IsNullOrEmpty(IDText))
                {
                    string p = "";
                    p += "select dm.descricao||' ('||de.sigla||') - '||pa.descricao cidade_uf_pais, ";
                    p += "dm.codigo ";
                    p += "FROM dom_municipio dm, ";
                    p += "     dom_estado de, ";
                    p += "     dom_pais pa ";
                    p += "WHERE dm.codigo = '" + IDText + "'";
                    p += "  and dm.estd_codigo  = de.codigo ";
                    p += "  and pa.codigo = de.pais_codigo ";
                    p += "ORDER by dm.descricao ";
                    ds = dbOracle.Lista("Varias", p);
                }
                else
                {
                    string p = "";
                    p += "select dm.descricao||' ('||de.sigla||') - '||pa.descricao cidade_uf_pais, ";
                    p += "dm.codigo ";
                    p += "FROM dom_municipio dm, ";
                    p += "     dom_estado de, ";
                    p += "     dom_pais pa ";
                    p += "WHERE dm.estd_codigo  = de.codigo ";
                    p += "and pa.codigo = de.pais_codigo ";
                    p += "and ( dm.codigo like '%" + searchText + "%' ";
                    p += "or UPPER(dm.descricao) like UPPER('%" + searchText + "%') ";
                    p += "or UPPER(de.sigla) like UPPER('%" + searchText + "%') ";
                    p += ") ORDER by dm.descricao ";
                    ds = dbOracle.Lista("Varias", p);
                }
            }
            else if (tipo.Equals("grupoEmpr"))//cor
            {
                if (!string.IsNullOrEmpty(IDText))
                {
                    ds = dbOracle.Lista("DOM_PESSOA", "select codigo, descricao VALOR from DOMCOR.DOM_GRUPO WHERE TO_CHAR(CODIGO) = '" + IDText + "'");
                }
                else
                {
                    ds = dbOracle.Lista("DOM_PESSOA", "select codigo, descricao VALOR from DOMCOR.DOM_GRUPO WHERE UPPER(descricao) LIKE UPPER('" + searchText + "%') OR TO_CHAR(CODIGO) = '" + searchText + "' ");
                }
            }
            else if (tipo.Equals("objeto"))//crm
            {
                if (!string.IsNullOrEmpty(IDText))
                {
                    ds = dbOracle.Lista("DOM_OBJETOS_MANUT", "SELECT CODIGO, DESCRICAO VALOR FROM DOM_OBJETOS_MANUT WHERE UPPER(CODIGO) = UPPER('" + IDText + "')");
                }
                else
                {
                    ds = dbOracle.Lista("DOM_OBJETOS_MANUT", "SELECT codigo,valor FROM (SELECT row_number() over ( ORDER BY CASE WHEN do.CODIGO LIKE upper('" + searchText + "%') THEN '1' END, do.CODIGO) linha, do.CODIGO, do.DESCRICAO VALOR FROM DOM_OBJETOS_MANUT DO WHERE UPPER(CODIGO) LIKE UPPER('" + searchText + "%') OR UPPER(DESCRICAO) LIKE UPPER('" + searchText + "%') OR UPPER(NUM_SERIE) LIKE UPPER('" + searchText + "%') OR UPPER(MOOM_CODIGO) LIKE UPPER('" + searchText + "%'))");
                    //ds = dbOracle.Lista("DOM_OBJETOS_MANUT", "SELECT CODIGO, DESCRICAO VALOR FROM DOM_OBJETOS_MANUT WHERE UPPER(CODIGO) LIKE UPPER('" + searchText + "%') OR UPPER(DESCRICAO) LIKE UPPER('" + searchText + "%')");
                }
            }
            else if (tipo.Equals("objetos_ativos"))//SImilar ao anterior, porém possui um filtro para trazer apensas objetos cuja DT_DESATIVACAO = null
            {
                if (!string.IsNullOrEmpty(IDText))
                {
                    ds = dbOracle.Lista("DOM_OBJETOS_MANUT", "SELECT CODIGO, DESCRICAO VALOR FROM DOM_OBJETOS_MANUT WHERE UPPER(CODIGO) = UPPER('" + IDText + "') AND DT_DESATIVACAO IS NULL");
                }
                else
                {
                    ds = dbOracle.Lista("DOM_OBJETOS_MANUT", "SELECT CODIGO, DESCRICAO VALOR FROM DOM_OBJETOS_MANUT WHERE (UPPER(CODIGO) LIKE UPPER('" + searchText + "%') OR UPPER(DESCRICAO) LIKE UPPER('" + searchText + "%')) AND DT_DESATIVACAO IS NULL");
                }
            }
            else if (tipo.Equals("grupo"))
            {
                if (!string.IsNullOrEmpty(IDText))
                {
                    ds = dbOracle.Lista("DOM_GRUPO", "SELECT CODIGO, DESCRICAO VALOR FROM DOM_GRUPO WHERE TO_CHAR(CODIGO) = '" + IDText + "'");

                }
                else
                {
                    ds = dbOracle.Lista("DOM_GRUPO", "SELECT CODIGO, DESCRICAO VALOR FROM DOM_GRUPO WHERE UPPER(DESCRICAO) LIKE UPPER('" + searchText + "%') OR TO_CHAR(CODIGO) = '" + searchText + "'");
                }
            }
            else if (tipo.Equals("contato"))
            {
                if (!string.IsNullOrEmpty(IDText))
                {
                    ds = dbOracle.Lista("DOM_CONTATO", "SELECT CODIGO, NOME VALOR FROM DOM_CONTATO WHERE UPPER(CODIGO) = UPPER('" + IDText + "')");
                }
                else
                {
                    if (context.Session["codCliente"] != null)
                    {
                        ds = dbOracle.Lista("DOM_CONTATO", "SELECT CODIGO, NOME VALOR, dpes_codigo FROM DOM_CONTATO WHERE UPPER(NOME) LIKE UPPER('" + searchText + "%') and DPES_CODIGO = '" + context.Session["codCliente"] + "'");
                    }
                    else
                    {
                        ds = dbOracle.Lista("DOM_CONTATO", "SELECT CODIGO, NOME VALOR FROM DOM_CONTATO WHERE UPPER(NOME) LIKE UPPER('" + searchText + "%')");
                    }
                }

            }
            else if (tipo.Equals("contatoDetalhe"))
            {
                string codCliente = context.Request.QueryString["cliente"];

                if (!string.IsNullOrEmpty(IDText))
                {
                    //ds = dbOracle.Lista("DOM_CONTATO", "SELECT dc.CODIGO ,  dc.DPES_CODIGO ,  dp.razao_social,  dc.NOME ,  dc.DATA_NASCIMENTO ,  dc.UNIDADE_ORGANIZACIONAL ,  dc.CARGO ,  CASE    WHEN DC.DDD is not null    THEN '(' || DC.DDD || ') ' || DC.TELEFONE    WHEN DC.DDD is null    THEN DC.TELEFONE  END AS telefone,  dp.LOGRADOURO || ' ' || dp.DESCRICAO || ' ' || dp.NUMERO || ' ' || dp.COMPLEMENTO || ' ' || dp.BAIRRO as ENDERECO,  dc.EMAIL ,  CASE    WHEN DC.CELULAR_DDD is not null    THEN '(' || DC.CELULAR_DDD || ') ' || DC.CELULAR    WHEN DC.CELULAR_DDD is null    THEN DC.CELULAR  END AS CELULAR FROM dom_contato dc,  dom_pessoa dp WHERE dc.dpes_codigo = dp.codigo and UPPER(dp.CODIGO) = UPPER('" + IDText + "')");
                    string p = "";
                    p += "SELECT dc.CODIGO, ";
                    p += " dc.DPES_CODIGO , ";
                    p += " dp.razao_social, ";
                    p += " dc.nome, ";
                    p += " dc.email, ";
                    p += " CASE WHEN dc.DDD is not null THEN '(' || dc.DDD || ') ' || dc.telefone WHEN dc.DDD is null THEN dc.telefone END AS fone, ";
                    p += " CASE WHEN dc.celular_ddd is not null THEN '(' || dc.celular_ddd || ') ' || dc.celular WHEN dc.celular_ddd is null THEN dc.celular END AS celular";
                    p += " FROM dom_contato dc, ";
                    p += " dom_pessoa dp ";
                    p += " WHERE dc.dpes_codigo = dp.codigo ";
                    p += "   and dc.codigo like '%" + IDText + "%' ";
                    ds = dbOracle.Lista("Varias", p);
                }
                else
                {
                    //if (context.Session["codCliente"] != null)
                    if (!string.IsNullOrEmpty(codCliente))
                    {
                        string p = "";
                        p += "SELECT dc.CODIGO, ";
                        p += " dc.DPES_CODIGO , ";
                        p += " dp.razao_social, ";
                        p += " dc.nome, ";
                        p += " dc.email, ";
                        //p += " dc.coluna0 fone, ";
                        p += " CASE WHEN dc.DDD is not null THEN '(' || dc.DDD || ') ' || dc.telefone WHEN dc.DDD is null THEN dc.telefone END AS fone, ";
                        //p += " dc.coluna2 celular ";
                        p += " CASE WHEN dc.celular_ddd is not null THEN '(' || dc.celular_ddd || ') ' || dc.celular WHEN dc.celular_ddd is null THEN dc.celular END AS celular";
                        p += " FROM dom_contato dc, ";
                        p += " dom_pessoa dp ";
                        p += " WHERE dc.dpes_codigo = dp.codigo ";
                        p += " and UPPER(NOME) LIKE UPPER('%" + searchText + "%') ";
                        p += " and dc.DPES_CODIGO = " + codCliente + " ";
                        ds = dbOracle.Lista("Varias", p);
                        //ds = dbOracle.Lista("DOM_CONTATO", "SELECT dc.CODIGO ,  dc.DPES_CODIGO ,  dp.razao_social,  dc.NOME ,  dc.DATA_NASCIMENTO ,  dc.UNIDADE_ORGANIZACIONAL ,  dc.CARGO ,  CASE    WHEN DC.DDD is not null    THEN '(' || DC.DDD || ') ' || DC.TELEFONE    WHEN DC.DDD is null    THEN DC.TELEFONE  END AS telefone,  dp.LOGRADOURO || ' ' || dp.DESCRICAO || ' ' || dp.NUMERO || ' ' || dp.COMPLEMENTO || ' ' || dp.BAIRRO as ENDERECO,  dc.EMAIL ,  CASE    WHEN DC.CELULAR_DDD is not null    THEN '(' || DC.CELULAR_DDD || ') ' || DC.CELULAR    WHEN DC.CELULAR_DDD is null    THEN DC.CELULAR  END AS CELULAR FROM dom_contato dc,  dom_pessoa dp WHERE dc.dpes_codigo = dp.codigo and UPPER(NOME) LIKE UPPER('" + searchText + "%') and dc.DPES_CODIGO = '" + codCliente + "'");
                    }
                    else
                    {
                        ds = dbOracle.Lista("DOM_CONTATO", "SELECT dc.CODIGO ,  dc.DPES_CODIGO ,  dp.razao_social,  dc.NOME ,  dc.DATA_NASCIMENTO ,  dc.UNIDADE_ORGANIZACIONAL ,  dc.CARGO ,  CASE    WHEN DC.DDD is not null    THEN '(' || DC.DDD || ') ' || DC.TELEFONE    WHEN DC.DDD is null    THEN DC.TELEFONE  END AS telefone,  dp.LOGRADOURO || ' ' || dp.DESCRICAO || ' ' || dp.NUMERO || ' ' || dp.COMPLEMENTO || ' ' || dp.BAIRRO as ENDERECO,  dc.EMAIL ,  CASE    WHEN DC.CELULAR_DDD is not null    THEN '(' || DC.CELULAR_DDD || ') ' || DC.CELULAR    WHEN DC.CELULAR_DDD is null    THEN DC.CELULAR  END AS CELULAR FROM dom_contato dc,  dom_pessoa dp WHERE dc.dpes_codigo = dp.codigo and UPPER(NOME) LIKE UPPER('" + searchText + "%')");
                    }
                }
            }
            else if (tipo.Equals("pessoaIndicadorSuperior"))
            {

                string empresa = context.Request.QueryString["empresa"];

                //AutoComplete para a lista de Pessoa do Indicador Superior da tela CRMN2081
                if (!string.IsNullOrEmpty(IDText))
                {
                    string p = "";
                    p += "select inds.EMPR_CODIGO, ";
                    p += "inds.DPES_CODIGO, ";
                    p += "dp.razao_social ";
                    p += "from dom_indicador_negocio inds, ";
                    p += "dom_pessoa dp ";
                    p += "where inds.dpes_codigo = dp.codigo ";
                    p += "and inds.empr_codigo in ";
                    p += "(select empr.codigo ";
                    p += "from dom_empresa_grupo empr ";
                    p += "connect by prior empr.codigo = empr.empr_codigo ";
                    p += "start with empr.codigo       = '" + empresa + "')";
                    p += "and ( dp.codigo like '%" + IDText + "%' ";
                    p += ") ORDER BY dp.codigo ";
                    ds = dbOracle.CmdLista("DOM_PESSOA", p);
                }

                else
                {
                    string p = "";
                    p += "select inds.EMPR_CODIGO, ";
                    p += "inds.DPES_CODIGO, ";
                    p += "dp.razao_social ";
                    p += "from dom_indicador_negocio inds, ";
                    p += "dom_pessoa dp ";
                    p += "where  inds.dpes_codigo = dp.codigo ";
                    p += "and inds.empr_codigo in ";
                    p += "(select empr.codigo ";
                    p += "from dom_empresa_grupo empr ";
                    p += "connect by prior empr.codigo = empr.empr_codigo ";
                    p += "start with empr.codigo       = '" + empresa + "')";
                    p += "and ( dp.codigo like '%" + searchText + "%' ";
                    p += "or UPPER(dp.razao_social) like UPPER('%" + searchText + "%')";
                    p += ") ORDER BY dp.codigo ";
                    ds = dbOracle.CmdLista("DOM_PESSOA", p);
                }
            }

            //AutoComplete para a lista de representante por divisão tela SOFN00001            
            else if (tipo.Equals("pessoaRepresentante"))
            {
                string empresa = context.Request.QueryString["empresa"];
                if (!string.IsNullOrEmpty(IDText))
                {
                    string p = "";
                    p += "SELECT din.empr_codigo, ";
                    p += "       din.dpes_codigo, ";
                    p += "       dp.razao_social ";
                    p += "FROM dom_indicador_negocio din, ";
                    p += "     dom_pessoa dp ";
                    p += "WHERE din.dpes_codigo = dp.codigo ";
                    p += "  and din.empr_codigo       = '" + empresa + "'";
                    p += "  and ( dp.codigo like '%" + IDText + "%') ";
                    p += "  and din.dt_desativacao is null ";
                    p += " ORDER BY din.dpes_codigo ";
                    ds = dbOracle.Lista("Varias", p);
                }
                else
                {
                    string p = "";
                    p += "SELECT din.empr_codigo, ";
                    p += "       din.dpes_codigo, ";
                    p += "       dp.razao_social ";
                    p += "FROM dom_indicador_negocio din, ";
                    p += "     dom_pessoa dp ";
                    p += "WHERE  din.dpes_codigo = dp.codigo ";
                    p += "   and din.empr_codigo       = '" + empresa + "'";
                    p += "   and ( dp.codigo like '%" + searchText + "%' ";
                    p += "or UPPER(dp.razao_social) like UPPER('%" + searchText + "%'))";
                    p += "  and din.dt_desativacao is null ";
                    p += " ORDER BY din.dpes_codigo ";
                    ds = dbOracle.Lista("Varias", p);
                }
            }
            //AutoComplete para a lista de gerentes de negócio(coordenadores) da tela SOFN00001            
            else if (tipo.Equals("pessoaCoordenador"))
            {
                string empresa = context.Request.QueryString["empresa"];
                if (!string.IsNullOrEmpty(IDText))
                {
                    string p = "";
                    p += "SELECT distinct din.dpes_codigo, ";
                    p += "       dp.razao_social ";
                    p += "FROM dom_indicador_negocio din, ";
                    p += "     dom_pessoa dp ";
                    p += "WHERE din.dpes_codigo = dp.codigo ";
                    p += "  and din.empr_codigo  in('88','302','332','380','605','635') ";
                    p += "  and ( dp.codigo like '%" + IDText + "%') ";
                    p += "  and din.dt_desativacao is null ";
                    p += "  and din.tiin_codigo = 13 ";//somente gerente de negócios
                    p += " ORDER BY dp.razao_social ";
                    ds = dbOracle.Lista("Varias", p);
                }
                else
                {
                    string p = "";
                    p += "SELECT distinct din.dpes_codigo, ";
                    p += "       dp.razao_social ";
                    p += "FROM dom_indicador_negocio din, ";
                    p += "     dom_pessoa dp ";
                    p += "WHERE  din.dpes_codigo = dp.codigo ";
                    p += "  and din.empr_codigo  in('88','302','332','380','605','635') ";
                    p += "   and ( dp.codigo like '%" + searchText + "%' ";
                    p += "or UPPER(dp.razao_social) like UPPER('%" + searchText + "%'))";
                    p += "  and din.dt_desativacao is null ";
                    p += "  and din.tiin_codigo = 13 ";//somente gerente de negócios
                    p += " ORDER BY dp.razao_social ";
                    ds = dbOracle.Lista("Varias", p);
                }
            }
            //AutoComplete para a lista de Pessoa do Indicador por região tela SOFN00001            
            else if (tipo.Equals("pessoaIndicadorRegiao"))
            {
                string empresa = context.Request.QueryString["empresa"];
                string regiaoIndic = context.Request.QueryString["regiaoIndic"];
                if (!string.IsNullOrEmpty(IDText))
                {
                    string p = "";
                    p += "SELECT dir.indn_empr_codigo empr_codigo, ";
                    p += "dir.indn_dpes_codigo dpes_codigo, ";
                    p += "dir.regi_codigo regiao, ";
                    p += "rv.descricao desc_regiao, ";
                    p += "dp.razao_social ";
                    p += "FROM dom_indicador_regiao dir, ";
                    p += "     dom_pessoa dp, ";
                    p += "     dom_regiao_venda rv ";
                    p += "WHERE dir.indn_dpes_codigo = dp.codigo ";
                    p += "  and dir.ativo = 'S' ";
                    p += "  and dir.regi_codigo = rv.codigo ";
                    p += "  and dir.indn_empr_codigo       = '" + empresa + "'";
                    p += "  and dir.regi_codigo = '" + regiaoIndic + "'";
                    p += "  and ( dp.codigo like '%" + IDText + "%' ";
                    p += ") ORDER BY dp.codigo ";
                    ds = dbOracle.Lista("Varias", p);
                }
                else
                {
                    string p = "";
                    p += "SELECT dir.indn_empr_codigo empr_codigo, ";
                    p += "dir.indn_dpes_codigo dpes_codigo, ";
                    p += "dir.regi_codigo regiao, ";
                    p += "rv.descricao desc_regiao, ";
                    p += "dp.razao_social ";
                    p += "FROM dom_indicador_regiao dir, ";
                    p += "     dom_pessoa dp, ";
                    p += "     dom_regiao_venda rv ";
                    p += "WHERE  dir.indn_dpes_codigo = dp.codigo ";
                    p += "  and dir.ativo = 'S' ";
                    p += "  and dir.regi_codigo = rv.codigo ";
                    p += "  and indn_empr_codigo       = '" + empresa + "'";
                    p += "  and ( dp.codigo like '%" + searchText + "%' ";
                    p += "or UPPER(dp.razao_social) like UPPER('%" + searchText + "%')";
                    p += ") ORDER BY dp.codigo ";
                    ds = dbOracle.Lista("Varias", p);
                }
            }
            //AutoComplete para a lista de clientes de um indicador tela SOFN00001
            else if (tipo.Equals("pessoaClienteIndicador"))
            {
                string empresa = context.Request.QueryString["empresa"];
                string indicID = context.Request.QueryString["indic"];
                if (!string.IsNullOrEmpty(IDText))
                {
                    string p = "";
                    p += "select dp.codigo, ";
                    p += "dp.razao_social, ";
                    p += "dp.cgc_cpf, ";
                    p += "dp.inscricao_estadual, ";
                    p += "dm.descricao cidade, ";
                    p += "de.sigla, ";
                    p += "dm.descricao||' ('||de.sigla||') - '||pa.descricao cidade_uf, ";
                    p += "pa.descricao pais ";
                    p += "FROM dom_pessoa dp, ";
                    p += "     dom_municipio dm, ";
                    p += "     dom_estado de, ";
                    p += "     dom_pais pa ";
                    p += "WHERE to_char(dp.codigo) = '" + IDText + "'";
                    p += "  and dp.muni_codigo = dm.codigo ";
                    p += "  and dp.estd_codigo = dm.estd_codigo ";
                    p += "  and de.codigo = dp.estd_codigo ";
                    p += "  and pa.codigo = de.pais_codigo ";
                    p += "ORDER by dp.razao_social, dp.codigo ";
                    ds = dbOracle.Lista("Varias", p);
                }
                else
                {
                    string p = "";
                    p += "select dp.codigo, ";
                    p += "dp.razao_social, ";
                    p += "dp.cgc_cpf, ";
                    p += "dp.inscricao_estadual, ";
                    p += "dm.descricao cidade, ";
                    p += "de.sigla, ";
                    p += "dm.descricao||' ('||de.sigla||') - '||pa.descricao cidade_uf, ";
                    p += "pa.descricao pais ";
                    p += "FROM dom_pessoa dp, ";
                    p += "     dom_municipio dm, ";
                    p += "     dom_estado de, ";
                    p += "     dom_pais pa ";
                    p += "WHERE exists(select 1 from dom_cliente dc ";
                    p += "              WHERE dc.empr_codigo = '" + empresa + "'";
                    p += "                and dc.indn_dpes_codigo = " + indicID + " ";
                    p += "                and dc.indn_empr_codigo = '" + empresa + "'";
                    //p += "                and dc.regi_codigo = '" + regiao + "'";
                    p += "                and dc.dpes_codigo = dp.codigo )";
                    p += "and dp.muni_codigo = dm.codigo ";
                    p += "and dp.estd_codigo = dm.estd_codigo ";
                    p += "and de.codigo = dp.estd_codigo ";
                    p += "and pa.codigo = de.pais_codigo ";
                    p += "and ( dp.codigo like '%" + searchText + "%' ";
                    p += "or UPPER(dp.razao_social) like UPPER('%" + searchText + "%') ";
                    p += "or dp.cgc_cpf like '%" + searchText + "%' ";
                    p += ") ORDER by dp.razao_social, dp.codigo ";
                    ds = dbOracle.Lista("Varias", p);
                }
            }
            //AutoComplete para a lista de clientes de um indicador/região tela SOFN00001
            else if (tipo.Equals("pessoaClienteIndicadorRegiao"))
            {

                string empresa = context.Request.QueryString["empresa"];
                string regiao = context.Request.QueryString["regiao"];
                string indicID = context.Request.QueryString["indic"];

                if (!string.IsNullOrEmpty(IDText))
                {
                    string p = "";
                    p += "select dp.codigo, ";
                    p += "dp.razao_social, ";
                    p += "dp.cgc_cpf, ";
                    p += "dp.inscricao_estadual, ";
                    p += "dm.descricao cidade, ";
                    p += "de.sigla, ";
                    p += "pa.descricao pais ";
                    p += "FROM dom_pessoa dp, ";
                    p += "     dom_municipio dm, ";
                    p += "     dom_estado de, ";
                    p += "     dom_pais pa ";
                    p += "WHERE to_char(dp.codigo) = '" + IDText + "'";
                    p += "  and dp.muni_codigo = dm.codigo ";
                    p += "  and dp.estd_codigo = dm.estd_codigo ";
                    p += "  and de.codigo = dp.estd_codigo ";
                    p += "  and pa.codigo = de.pais_codigo ";
                    p += "ORDER by dp.razao_social, dp.codigo ";
                    ds = dbOracle.Lista("Varias", p);
                }
                else
                {
                    string p = "";
                    p += "select dp.codigo, ";
                    p += "dp.razao_social, ";
                    p += "dp.cgc_cpf, ";
                    p += "dp.inscricao_estadual, ";
                    p += "dm.descricao cidade, ";
                    p += "de.sigla, ";
                    p += "pa.descricao pais ";
                    p += "FROM dom_pessoa dp, ";
                    p += "     dom_municipio dm, ";
                    p += "     dom_estado de, ";
                    p += "     dom_pais pa ";
                    p += "WHERE exists(select 1 from dom_cliente dc ";
                    p += "              WHERE dc.empr_codigo = '" + empresa + "'";
                    p += "                and dc.indn_dpes_codigo = " + indicID + " ";
                    p += "                and dc.indn_empr_codigo = '" + empresa + "'";
                    p += "                and dc.regi_codigo = '" + regiao + "'";
                    p += "                and dc.dpes_codigo = dp.codigo )";
                    p += "and dp.muni_codigo = dm.codigo ";
                    p += "and dp.estd_codigo = dm.estd_codigo ";
                    p += "and de.codigo = dp.estd_codigo ";
                    p += "and pa.codigo = de.pais_codigo ";
                    p += "and ( dp.codigo like '%" + searchText + "%' ";
                    p += "or UPPER(dp.razao_social) like UPPER('%" + searchText + "%') ";
                    p += "or dp.cgc_cpf like '%" + searchText + "%' ";
                    p += ") ORDER by dp.razao_social, dp.codigo ";
                    ds = dbOracle.Lista("Varias", p);
                }
            }
            //auto complete pra lista de tipos de negócio SOFN00001
            else if (tipo.Equals("tipo_negocio"))
            {
                if (!string.IsNullOrEmpty(IDText))
                {
                    ds = dbOracle.Lista("DOM_TIPO_NEGOCIO", "SELECT CODIGO, DESCRICAO VALOR FROM DOM_TIPO_NEGOCIO WHERE TO_CHAR(CODIGO) = '" + IDText + "' ORDER BY DESCRICAO ");

                }
                else
                {
                    ds = dbOracle.Lista("DOM_TIPO_NEGOCIO", "SELECT CODIGO, DESCRICAO VALOR FROM DOM_TIPO_NEGOCIO WHERE UPPER(DESCRICAO) LIKE UPPER('%" + searchText + "%') OR TO_CHAR(CODIGO) = '" + searchText + "' ORDER BY DESCRICAO ");
                }
            }
            else
            {
                ds = null;
            }

            string jSon = "";

            if (string.IsNullOrEmpty(IDText))
            {
                jSon = "[";
            }

            if (ds != null)
            {
                if (ds.Tables[0].Rows.Count > 0)
                {
                    foreach (DataRow dr in ds.Tables[0].Rows)
                    {
                        if (tipo.Equals("pessoa"))
                        {
                            jSon += "{\"id\":\"" + dr["CODIGO"].ToString() + "\", \"text\": \"" + dr["CODIGO"].ToString() + " - " + dr["VALOR"].ToString() + "\"},";
                        }
                        else if (tipo.Equals("objeto"))
                        {
                            jSon += "{\"id\":\"" + dr["CODIGO"].ToString() + "\", \"text\": \" Objeto: " + dr["CODIGO"].ToString() + " - " + dr["VALOR"].ToString() + "\"},";
                        }
                        else if (tipo.Equals("objetos_ativos"))
                        {
                            jSon += "{\"id\":\"" + dr["CODIGO"].ToString() + "\", \"text\": \" Objeto: " + dr["CODIGO"].ToString() + " - " + dr["VALOR"].ToString() + "\"},";
                        }
                        else if (tipo.Equals("grupo"))
                        {
                            jSon += "{\"id\":\"" + dr["CODIGO"].ToString() + "\", \"text\": \" Grupo: " + dr["CODIGO"].ToString() + " - " + dr["VALOR"].ToString() + "\"},";
                        }
                        else if (tipo.Equals("contato"))
                        {
                            jSon += "{\"id\":\"" + dr["CODIGO"].ToString() + "\", \"text\": \" Contato: " + dr["CODIGO"].ToString() + " - " + dr["VALOR"].ToString() + "\"},";
                        }
                        else    if (tipo.Equals("contatoDetalhe"))
                        {
                            //jSon += "{\"id\":\"" + dr["CODIGO"].ToString() + "-" + dr["DPES_CODIGO"].ToString() + "\", \"cliente\": \"" + dr["DPES_CODIGO"].ToString() + " - " + dr["razao_social"].ToString() + "\", \"nome\": \"" + dr["nome"].ToString() + "\", \"dtnasc\": \"" + dr["data_nascimento"].ToString() + "\", \"setor\": \"" + dr["unidade_organizacional"].ToString() + "\", \"cargo\": \"" + dr["cargo"].ToString() + "\", \"fone\": \"" + dr["telefone"].ToString() + "\", \"email\": \"" + dr["email"].ToString() + "\", \"celular\": \"" + dr["celular"].ToString() + "\", \"endereco\": \"" + dr["endereco"].ToString() + "\", \"text\": \"" + dr["nome"].ToString() + "\"},";
                            jSon += "{\"id\":\"" + dr["CODIGO"].ToString() + "\", \"text\": \"" + dr["NOME"].ToString() + " (Cód: " + dr["CODIGO"].ToString() + ")" + "\",\"email\":\"" + dr["EMAIL"].ToString() + "\",\"fone\":\"" + dr["FONE"].ToString() + "\",\"celular\":\"" + dr["CELULAR"].ToString() + "\"},";
                        }
                        else if (tipo.Equals("pessoaIndicadorSuperior"))
                        {
                            jSon += "{\"id\":\"" + dr["DPES_CODIGO"].ToString() + "\", \"text\": \"" + dr["EMPR_CODIGO"].ToString() + " - " + dr["DPES_CODIGO"].ToString() + " - " + dr["RAZAO_SOCIAL"].ToString() + "\",\"empresa\":\"" + dr["EMPR_CODIGO"].ToString() + "\"},";
                        }
                        else if (tipo.Equals("pessoaIndicadorRegiao"))
                        {
                            jSon += "{\"id\":\"" + dr["DPES_CODIGO"].ToString() + "\", \"text\": \"" + dr["DPES_CODIGO"].ToString() + " - " + dr["RAZAO_SOCIAL"].ToString() + " (Reg.: " + dr["REGIAO"].ToString() + ")" + "\", \"regiao\": \"" + dr["REGIAO"].ToString() + "\", \"desc_regiao\": \"" + dr["DESC_REGIAO"].ToString() + "\",\"empresa\":\"" + dr["EMPR_CODIGO"].ToString() + "\"},";
                        }
                        else if (tipo.Equals("pessoaRepresentante"))
                        {
                            jSon += "{\"id\":\"" + dr["DPES_CODIGO"].ToString() + "\", \"text\": \"" + dr["DPES_CODIGO"].ToString() + " - " + dr["RAZAO_SOCIAL"].ToString() + "\", \"empresa\":\"" + dr["EMPR_CODIGO"].ToString() + "\"},";
                        }
                        else if (tipo.Equals("pessoaCoordenador"))
                        {
                            jSon += "{\"id\":\"" + dr["DPES_CODIGO"].ToString() + "\", \"text\": \"" + dr["DPES_CODIGO"].ToString() + " - " + dr["RAZAO_SOCIAL"].ToString() + "\"},";
                        }
                        else if (tipo.Equals("pessoaClienteIndicadorRegiao"))
                        {
                            jSon += "{\"id\":\"" + dr["CODIGO"].ToString() + "\", \"text\": \"" + dr["CODIGO"].ToString() + " - " + dr["RAZAO_SOCIAL"].ToString() + " - " + "(CNPJ: " + dr["CGC_CPF"].ToString() + ")" + "\",\"cidade\":\"" + dr["CIDADE"].ToString() + "\",\"cnpj\":\"" + dr["CGC_CPF"].ToString() + "\",\"inscricao\":\"" + dr["INSCRICAO_ESTADUAL"].ToString() + "\",\"estado\":\"" + dr["SIGLA"].ToString() + "\",\"pais\":\"" + dr["PAIS"].ToString() + "\"},";
                        }
                        else if (tipo.Equals("pessoaClienteIndicador"))
                        {
                            jSon += "{\"id\":\"" + dr["CODIGO"].ToString() + "\", \"text\": \"" + dr["CODIGO"].ToString() + " - " + dr["RAZAO_SOCIAL"].ToString() + " - CNPJ: " + dr["CGC_CPF"].ToString() + " - " + dr["CIDADE_UF"].ToString()  + "\",\"cidade\":\"" + dr["CIDADE"].ToString() + "\",\"cnpj\":\"" + dr["CGC_CPF"].ToString() + "\",\"inscricao\":\"" + dr["INSCRICAO_ESTADUAL"].ToString() + "\",\"estado\":\"" + dr["SIGLA"].ToString() + "\",\"pais\":\"" + dr["PAIS"].ToString() + "\"},";
                        }
                        else if (tipo.Equals("pessoaDetalhe"))
                        {
                            jSon += "{\"id\":\"" + dr["CODIGO"].ToString() + "\", \"text\": \"" + dr["CODIGO"].ToString() + " - " + dr["RAZAO_SOCIAL"].ToString() + " - CNPJ: " + dr["CGC_CPF"].ToString() + " - " + dr["CIDADE_UF"].ToString() + "\",\"cidade\":\"" + dr["CIDADE"].ToString() + "\",\"cnpj\":\"" + dr["CGC_CPF"].ToString() + "\",\"inscricao\":\"" + dr["INSCRICAO_ESTADUAL"].ToString() + "\",\"estado\":\"" + dr["SIGLA"].ToString() + "\",\"pais\":\"" + dr["PAIS"].ToString() + "\",\"endereco\":\"" + dr["ENDERECO"].ToString() + "\",\"telefone\":\"" + dr["TELEFONE"].ToString() + "\",\"email\":\"" + dr["EMAIL"].ToString()+ "\"},";
                        }
                        else if (tipo.Equals("cidadeDetalhe"))
                        {
                            jSon += "{\"id\":\"" + dr["CODIGO"].ToString() + "\", \"text\": \"" + dr["CIDADE_UF_PAIS"].ToString() +  "\"},";
                        }
                        else if (tipo.Equals("tipo_negocio"))
                        {
                            jSon += "{\"id\":\"" + dr["CODIGO"].ToString() + "\", \"text\": \"" + dr["VALOR"].ToString() + " (Cód: " + dr["CODIGO"].ToString() + ")" + "\"},";
                        }
                        else
                        {
                            jSon += "{\"id\":\"" + dr["CODIGO"].ToString() + "\", \"text\": \"" + dr["VALOR"].ToString() + "\"},";
                        }
                    }
                    jSon = jSon.Remove(jSon.Length - 1, 1);
                }
            }
            if (string.IsNullOrEmpty(IDText))
            {
                jSon += "]";
            }
            //jSon = " { \"id\": 0, \"text\": \"story\" }";
            context.Response.Write(jSon);
        }
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }
}

