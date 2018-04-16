using System;
using System.Web.UI;
using System.Data;
using Dominio.DOMDB;
using Dominio.DOMACE;
using Dominio.DOMCOR;
using System.Text;
using GDTLibrary;

public partial class GDT_Versao01_GDT00001 : System.Web.UI.Page
{
    StringBuilder Query = new StringBuilder();
    DatabaseOracle dbOracle = new DatabaseOracle();
    ACEL0310 ACEL0310 = new ACEL0310();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["codUsuario"] != null)
        {
            try
            {
                //ValidaAcessoPrograma("GDT00001");
                if (!IsPostBack)
                {
                    populaCampos();
                }
            }
            catch (Exception exc)
            {
                ScriptManager.RegisterStartupScript(Page, typeof(Page), "ShowValidation", "javascript:alertErroDomsge('ERRO',\"" + ACEL0310.trataMensagemErro(exc.Message) + "\")", true);
            }
        }
    }

    protected void btnSalvar_Click(object sender, EventArgs e)
    {
        try
        {
            Parametro p = new Parametro(Session["codEmpresa"].ToString());
            p.ValidadeSep = int.Parse(txtValidadeSep.Text);
            p.ValidadeNr10 = int.Parse(txtValidadeNR10.Text);
            p.ValidadeNr12 = int.Parse(txtValidadeNR12.Text);
            p.ValidadeNr18 = int.Parse(txtValidadeNR18.Text);
            p.ValidadeNr33 = int.Parse(txtValidadeNR33.Text);
            p.ValidadeNr35 = int.Parse(txtValidadeNR35.Text);

            if (txtTipoOperacao.Value == "I")
            {
                p.gravaParametro("I");
            }
            else
            {
                p.gravaParametro("U");
            }
            populaCampos();
            ScriptManager.RegisterStartupScript(Page, typeof(Page), "ShowValidation", "javascript:alertDomsge('SUCESSO!', 'Operação realizada com sucesso.', 'rgba(58, 160, 52, 0.8)')", true);

        }
        catch (Exception exc)
        {
            ScriptManager.RegisterStartupScript(Page, typeof(Page), "ShowValidation", "javascript:alertErroDomsge('ERRO',\"" + ACEL0310.trataMensagemErro(exc.Message) + "\")", true);
        }
    }

    private void populaCampos()
    {
        try
        {
            Parametro p = new Parametro(Session["codEmpresa"].ToString());
            DataSet ds = p.listaParametros();
            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                txtTipoOperacao.Value = "U";
                txtValidadeSep.Text = ds.Tables[0].Rows[0]["VALIDADE_ANOS_SEP"].ToString();
                txtValidadeNR10.Text = ds.Tables[0].Rows[0]["VALIDADE_ANOS_NR_10"].ToString();
                txtValidadeNR12.Text = ds.Tables[0].Rows[0]["VALIDADE_ANOS_NR_12"].ToString();
                txtValidadeNR18.Text = ds.Tables[0].Rows[0]["VALIDADE_ANOS_NR_18"].ToString();
                txtValidadeNR33.Text = ds.Tables[0].Rows[0]["VALIDADE_ANOS_NR_33"].ToString();
                txtValidadeNR35.Text = ds.Tables[0].Rows[0]["VALIDADE_ANOS_NR_35"].ToString();
            }
            else
            {
                //Quando não encontra nenhum valor no banco, vai considerar a operação como u insert.
                txtTipoOperacao.Value = "I";
            }
        }
        catch (Exception exc)
        {
            ScriptManager.RegisterStartupScript(Page, typeof(Page), "ShowValidation", "javascript:alertErroDomsge('ERRO','" + ACEL0310.trataMensagemErro(exc.Message) + "')", true);
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