using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class GDT_Versao01_GDT00004 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        
        if (Session["codUsuario"] != null)
        {
            try
            {
                //ValidaAcessoPrograma("GDT00004");

                if (Request.QueryString["codEmpr"] != null && Request.QueryString["codPessoa"] != null)
                {
                    txtEmprTerceiro.Value = Request.QueryString["codEmpr"];
                    txtDpesTerceiro.Value = Request.QueryString["codPessoa"];
                }

            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}