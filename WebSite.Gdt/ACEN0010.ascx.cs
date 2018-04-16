using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Text;
using Dominio.DOMACE;
using Dominio.DOMDB;

public partial class ACE_Versao01_ACEN0010 : System.Web.UI.UserControl
{
    StringBuilder Query = new StringBuilder();
    DatabaseOracle dbOracle = new DatabaseOracle();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["codUsuario"] != null)
        {
            codEmpr.Value = Session["codEmpresa"].ToString();
            codUsu.Value = Session["codUsuario"].ToString();
        }  
    }   
}