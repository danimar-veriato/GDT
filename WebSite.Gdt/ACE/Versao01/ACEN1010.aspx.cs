using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;
using Dominio.DOMACE;
using Dominio.DOMDB;
using System.IO;
using System.Text;
using System.Data;
using System.Web.Script.Services;

public partial class ACE_Versao01_ACEN1010 : System.Web.UI.Page
{
    ACEL0310 ACEL0310 = new ACEL0310();
    StringBuilder Query = new StringBuilder();
    DatabaseOracle dbOracle = new DatabaseOracle();

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (Session["codEmpresa"] != null)
            {
                if (!string.IsNullOrEmpty(Request.QueryString["token"]))
                {
                    downloadFileToken();
                }
            }
        }
        catch (Exception)
        {

            throw;
        }
    }

    private void downloadFileToken()
    {
        try
        {
            string data = "";
            string[] tokenArr = null;


            Query.Remove(0, Query.Length);
            Query.Append(" SELECT DIRETORIO_DATA FROM dom_parametro_domace WHERE empr_codigo = '" + Session["codEmpresa"] + "' ");
            DataSet ds = dbOracle.Lista("DUAL", Query.ToString());

            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                //data = ds.Tables[0].Rows[0]["DIRETORIO_DATA"].ToString();
                //data = @"D:\Fockink\PROD\SOEF\App_data\SOEF\SOLICITACOES\";
                data = @"App_Data\SOEF\SOLICITACOES\";
            }

            if (!string.IsNullOrEmpty(data))
            {
                Query.Remove(0, Query.Length);
                Query.Append(" select ACEP2010.DESCRIPTOGRAFA('" + Request.QueryString["token"] + "') token from dual ");

                DataSet dsToken = dbOracle.Lista("DUAL", Query.ToString());

                if (dsToken != null && dsToken.Tables[0].Rows.Count > 0)
                {
                    tokenArr = dsToken.Tables[0].Rows[0]["token"].ToString().Split('|');
                }
            }

            if (tokenArr != null)
            {
                string filePath = data + tokenArr[2] + tokenArr[3];
                FileInfo file = new FileInfo(filePath);
                Response.Clear();
                Response.BufferOutput = true;
                Response.ContentType = "application/octet-stream";
                Response.AddHeader("Content-Disposition", "attachment; filename=" + file.Name);
                Response.WriteFile(file.FullName);
                Response.End();
            }

        }
        catch (Exception)
        {

            throw;
        }
    }

    [System.Web.Services.WebMethod]
    public static string getToken(string directory, string name)
    {
        //classes
        HttpContext context = HttpContext.Current;
        ACEL0310 ACEL0310 = new ACEL0310();
        StringBuilder Query = new StringBuilder();
        DatabaseOracle dbOracle = new DatabaseOracle();

        if (context.Session["codEmpresa"] == null)
        {
            return JsonConvert.SerializeObject("[{ \"codigo\" : \"0\", \"retorno\" : \"Sua sessão expirou, atualize a página e tente novamente.\" }]");
        }

        //variáveis
        string strJson = "";
        string token = "";

        if (string.IsNullOrEmpty(directory))
        {
            strJson = JsonConvert.SerializeObject("[{ \"codigo\" : \"0\", \"retorno\" : \"Algo de errado aconteceu, não recebemos os dados de que precisamos para continuar, tente novamente.\" }]");
            return strJson;
        }

        try
        {

            Query.Remove(0, Query.Length);
            Query.Append(" SELECT ACEP2010.CRIPTOGRAFA(TO_CHAR(SYSDATE, 'DD/MM/YYYY HH24:MI') ");
            Query.Append("   || '|' ");
            Query.Append("   || TO_CHAR(SYSDATE + 1, 'DD/MM/YYYY HH24:MI') ");
            Query.Append("   || '|' ");
            Query.Append("   || '" + directory.Replace('$', '\\') + "' ");
            Query.Append("   || '|' ");
            Query.Append("   || '" + name + "' ");
            Query.Append("   || '|' ");
            Query.Append("   || '" + context.Session["codUsuario"] + "' ");
            Query.Append("   || '|' ");
            Query.Append("   || '" + context.Session["codEmpresa"] + "') TOKEN ");
            Query.Append(" FROM dual ");

            DataSet ds = dbOracle.Lista("DUAL", Query.ToString());

            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                token = ds.Tables[0].Rows[0]["TOKEN"].ToString();
            }

            strJson = JsonConvert.SerializeObject("[{ \"codigo\" : \"1\", \"retorno\" : \"token gerado com sucesso.\", \"token\" : \"" + token + "\"}]", Formatting.Indented);

            return strJson;
        }
        catch (Exception exc)
        {
            strJson = JsonConvert.SerializeObject("[{ \"codigo\" : \"0\",\"retorno\" : \"" + ACEL0310.trataMensagemErro(exc.Message) + "\" }]");
            return strJson;
        }
    }
}