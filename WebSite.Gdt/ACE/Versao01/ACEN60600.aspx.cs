using System;
using System.Data;
using System.Web;
using System.Web.Script.Serialization;

public partial class ACE_Versao01_ACEN60600 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    [System.Web.Services.WebMethod]
    public static string GetDados(string numero, string tipo)
    {
        if (string.IsNullOrEmpty(numero))
        {
            JavaScriptSerializer js = new JavaScriptSerializer();
            string strJson = js.Serialize("[{ \"retorno\" : \"0\" }]");
            return strJson;
        }
        else
        {
            DataSet ds = existeSolicitacao(numero, tipo);
            string sb;
            if (ds != null)
            {                
                sb = "[{ \"retorno\" : \"numsol=" + ds.Tables[0].Rows[0]["numero"].ToString()+ "&revisaoSol="+ ds.Tables[0].Rows[0]["revisao"].ToString() + "\" }]";
            }
            else
            {
                sb = "[{ \"retorno\" : \"0\" }]";
            }

            JavaScriptSerializer js = new JavaScriptSerializer();
            string strJson = js.Serialize(sb.ToString());
            return strJson;
        }

    }

    private static DataSet existeSolicitacao(string numeroSol, string tipo)
    {
        try
        {
            HttpContext context = HttpContext.Current;
            string empresa = context.Session["codEmpresa"].ToString();
            string usuario = context.Session["codUsuario"].ToString();

            //SOEFL00001 s = new SOEFL00001();            
            //DataSet ds = s.existeSolicitacao(empresa, numeroSol, usuario, tipo);
            //if (ds != null && ds.Tables[0].Rows.Count > 0)
            //{
            //    return ds;
            //}
            //else
            //{
            //    return null;
            //}
            return null;
        }
        catch (Exception exc)
        {
            throw exc;
        }
    }
}