using Dominio.DOMACE;
using Dominio.DOMCOR;
using Dominio.DOMDB;
using GDTLibrary;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class GDT_Versao01_GDT00003 : System.Web.UI.Page
{
    ACEL0310 ACEL0310 = new ACEL0310();
    StringBuilder Query = new StringBuilder();
    DatabaseOracle dbOracle = new DatabaseOracle();

    protected void Page_Load(object sender, EventArgs e)
    {

        if (Session["codUsuario"] != null)
        {
            try
            {
                //ValidaAcessoPrograma("GDT00003");
                txtEmpresaFiltro.Value = Session["codEmpresa"].ToString();

            }
            catch (Exception)
            {

                throw;
            }
        }
    }

    [System.Web.Services.WebMethod()]
    public static string GetTerceiros(string empresa)
    {
        try
        {
            Terceiro ter = new Terceiro();
            DataSet ds = ter.consultaTerceiro(empresa, null);
            var terceiros = new List<TerceiroList>();

            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                foreach (DataRow dr in ds.Tables[0].Rows)
                {
                    var terceiro = new TerceiroList
                    {
                        EmprCodigo = dr["EMPR_CODIGO"].ToString(),
                        DpesCodigo = Convert.ToInt32(dr["DPES_CODIGO"].ToString()),
                        RazaoSocial = dr["RAZAO_SOCIAL"].ToString(),
                        Situacao = dr["SITUACAO_EXT"].ToString(),
                        DtVencAlvara = dr["DT_VENC_ALVARA"].ToString(),
                        DtVencCndFederal = dr["DT_VENC_CND_FEDERAL"].ToString(),
                        DtVencCndMunicipal = dr["DT_VENC_CND_MUNICIPAL"].ToString()
                    };
                    terceiros.Add(terceiro);
                }
                var js = new JavaScriptSerializer();

                return js.Serialize(terceiros);
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