using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;
using Dominio.DOMACE;
using System.Data;
using Dominio.DOMDB;
using System.Text;

public partial class ACE_Versao01_ACEE0404 : System.Web.UI.Page
{
    ParametroDomAce param = new ParametroDomAce();
    Dominio.DOMACE.Login login = new Dominio.DOMACE.Login();
    DatabaseOracle db = new DatabaseOracle();
    StringBuilder Query = new StringBuilder();
    string parametros = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (Request.QueryString["aspxerrorpath"] != "")
            {
                ArrayList url = new ArrayList(Request.QueryString["aspxerrorpath"].Split('/'));

                string programa = url[url.Count - 1].ToString().ToUpper().Split('.')[0];
                
                if (url[url.Count - 1].ToString().ToUpper().Split('?').Count() > 1)
                {
                    parametros = url[url.Count - 1].ToString().ToUpper().Split('?')[1];
                }                

                lblUrl.Text = programa;

                if (Session["codEmpresa"] != null)
                {
                    string url_destino = retornaUrlPrograma(Session["codEmpresa"].ToString(), programa);
                    if (url_destino != null)
                    {
                        //string teste = Request.Url.AbsoluteUri.Split('/')[3];
                        //string teste2 = url_destino.Split('/')[3];
                        if (!Request.Url.AbsoluteUri.Split('/')[2].Equals(url_destino.Split('/')[2]) || !Request.Url.AbsoluteUri.Split('/')[3].Equals(url_destino.Split('/')[3]))
                        {
                            string token = login.criaToken(Session["codUsuario"].ToString(), Session["codEmpresa"].ToString(), programa, parametros);

                            Response.Redirect(url_destino + token, false);
                        }
                        else
                        {
                            //erro 404
                        }
                    }
                }
                else
                {
                    Response.Redirect("~/ACE/Versao01/ACE0003N.aspx?url=" + HttpUtility.UrlEncode(Request.RawUrl), false);
                }
            }
        }
        catch (Exception)
        {

            throw;
        }
    }

    public string retornaUrlPrograma(string codEmpresa, string codPrograma)
    {
        try
        {
            Query.Remove(0, Query.Length);
            Query.Append(" SELECT NVL(p.url, d.url_controle_acesso) url ");
            Query.Append(" FROM dom_parametro_domace d, ");
            Query.Append("   dom_programa p ");
            Query.Append(" WHERE d.empr_codigo = '" + codEmpresa + "' ");
            Query.Append(" AND p.cod_prog      = '" + codPrograma + "'");

            DataSet ds = db.Lista("varias", Query.ToString());

            if (ds != null && ds.Tables[0].Rows.Count > 0 && !ds.Tables[0].Rows[0]["url"].Equals(DBNull.Value))
            {
                return ds.Tables[0].Rows[0]["url"].ToString();
            }
            else
            {
                return null;
            }
        }
        catch (Exception)
        {
            throw;
        }
    }
}