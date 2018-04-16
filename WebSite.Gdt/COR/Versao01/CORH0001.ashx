<%@ WebHandler Language="C#" Class="CORH0001" %>

using System;
using System.Web;
using Dominio.DOMDB;
using System.Data;
using Dominio.DOMCRM;
using Dominio.DOMCOR;

public class CORH0001 : IHttpHandler, System.Web.SessionState.IReadOnlySessionState
{

    CORL0001 CORL0001 = new CORL0001();
    ParametroDomCrm paramCRM = new ParametroDomCrm();
    DatabaseOracle dbOracle = new DatabaseOracle();

    public void ProcessRequest(HttpContext context)
    {
        if (context.Session["codUsuario"] != null)
        {
            string searchText = context.Request.QueryString["q"];
            string empr = context.Session["codEmpresa"].ToString();

            DataSet ds = null;
            string tipo = "";
            string grupo = "";

            if (context.Request.QueryString["tipo"] != null)
            {
                grupo = context.Request.QueryString["grupo"];
            }

            if (context.Request.QueryString["tipo"] != null)
            {
                tipo = context.Request.QueryString["tipo"];
            }

            if (tipo.Equals("grupo"))
            {
                ds = dbOracle.Lista("DOM_GRUPO", "SELECT COD_GRUPO CODIGO, DESCRICAO VALOR FROM DOM_GRUPO_USUARIO WHERE UPPER(DESCRICAO) LIKE UPPER('" + searchText + "%') OR TO_CHAR(COD_GRUPO) = '" + searchText + "'");
            }
            else if (tipo.Equals("usuario"))
            {
                if (!string.IsNullOrEmpty(grupo))
                {
                    ds = dbOracle.Lista("DOM_GRUPO", "SELECT COD_USUARIO CODIGO, DESC_USUARIO VALOR FROM DOM_USUARIO WHERE cod_usuario in (select USU_COD_USUARIO from dom_usuario_grupo where GRUS_COD_GRUPO = " + grupo + ")  AND ( UPPER(DESC_USUARIO) LIKE UPPER('" + searchText + "%') OR TO_CHAR(COD_USUARIO) = '" + searchText + "') ");
                }
                else
                {
                    ds = dbOracle.Lista("DOM_GRUPO", "SELECT COD_USUARIO CODIGO, DESC_USUARIO VALOR FROM DOM_USUARIO WHERE UPPER(DESC_USUARIO) LIKE UPPER('" + searchText + "%') OR TO_CHAR(COD_USUARIO) = '" + searchText + "'");
                }

            }

            string jSon = "";

            jSon = "[";

            if (ds != null)
            {
                if (ds.Tables[0].Rows.Count > 0)
                {
                    foreach (DataRow dr in ds.Tables[0].Rows)
                    {
                        if (tipo.Equals("usuario"))
                        {
                            jSon += "{\"id\":\"" + dr["CODIGO"].ToString() + "\", \"text\": \"" + dr["CODIGO"].ToString() + "\"},";
                        }
                        else
                        {
                            jSon += "{\"id\":\"" + dr["CODIGO"].ToString() + "\", \"text\": \"" + dr["CODIGO"].ToString() + " - " + dr["VALOR"].ToString() + "\"},";
                        }
                    }

                    jSon = jSon.Remove(jSon.Length - 1, 1);
                }
            }

            jSon += "]";

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