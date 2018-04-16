using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Dominio.DOMACE;
using System.Data;

public partial class ACEN0017 : System.Web.UI.UserControl
{

    ACEL0150 ACE0150L = new ACEL0150();
    Pessoa pes = new Pessoa();
    Usuario usu = new Usuario();
    Empresa emp = new Empresa();
    ParametroDomAce paramace = new ParametroDomAce();

    string HTMLMenu = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        Pessoa pes = new Pessoa();
        
        LogotipoEmpresaLogada1.ImageUrl = "~/template/logotipos/LogoDomSge.png";
        
        montaMenu();
    }

    void montaMenu()
    {
        //if (!Page.IsPostBack)
        //{
        try
        {
            phMenuAcessos.Controls.Clear();

            if (Session["codUsuario"] != null)
            {


                if (Session["phACE0150N"] == null)
                {
                    usu.Codusuario = Session["codUsuario"].ToString();
                    ACE0150L.Usuario = usu;
                    emp.Codigo = Convert.ToInt32(Session["codEmpresa"]);
                    ACE0150L.Empresa = emp;
                    DataSet dsZero = ACE0150L.MontaMenuNivelZero();
                    if (dsZero != null)
                    {
                        int con = 0;
                        foreach (DataRow dr in dsZero.Tables[0].Rows)
                        {

                            HTMLMenu += "<li class=\"icon icon-arrow-left\"><a href=\"#\" ><i></i>" + dr["DESC_TRANS"].ToString() + "</a>";
                            string cod_transa = dr["COD_TRANS"].ToString();
                            usu.Codusuario = Session["codUsuario"].ToString();
                            ACE0150L.Usuario = usu;
                            emp.Codigo = Convert.ToInt32(Session["codEmpresa"]);
                            ACE0150L.Empresa = emp;
                            ACE0150L.TransaSuperior = dr["COD_TRANS"].ToString();
                            ACE0150L.CodTransa = dr["COD_TRANS"].ToString();

                            con++;
                            MontaNivelPosteriorTransacao(Session["codUsuario"].ToString(), Session["codEmpresa"].ToString(), cod_transa, con, dr["DESC_TRANS"].ToString());

                            HTMLMenu += "</li>";

                        }
                        //Session.Remove("phMenuAcessos");
                        Session["phACE0150N"] = null;
                        Session["phACE0150N"] = HTMLMenu;

                        phMenuAcessos.Controls.Add(new LiteralControl(Session["phACE0150N"].ToString()));
                    }
                }
                else
                {
                    string x = Session["phACE0150N"].ToString();
                    phMenuAcessos.Controls.Clear();
                    phMenuAcessos.Dispose();

                    phMenuAcessos.Controls.Add(new LiteralControl(Session["phACE0150N"].ToString()));
                }
            } // Teste sessao nula
        }
        catch (Exception exc)
        {


        }

    }

    protected void MontaNivelPosteriorTransacao(string usuario, string empresa, string transacao, int id_item, string descTrans)
    {

        try
        {
            usu.Codusuario = usuario;
            ACE0150L.Usuario = usu;
            emp.Codigo = Convert.ToInt32(empresa);
            ACE0150L.Empresa = emp;
            ACE0150L.TransaSuperior = transacao;
            ACE0150L.CodTransa = transacao;
            DataSet dsTransa = ACE0150L.MontaMenuNivelPosterior();
            if (dsTransa != null)
            {
                HTMLMenu += "<div class=\"mp-level\"><h2 >" + descTrans + "</h2><a class=\"mp-back\" href=\"#\">Voltar</a><ul >";

                foreach (DataRow dr in dsTransa.Tables[0].Rows)
                {
                    ACE0150L.CodTransa = dr["COD_TRANS"].ToString();
                    string caminho = ACE0150L.RetornaCaminhoProgramaWeb();

                    

                    if (String.IsNullOrEmpty(caminho))
                    {
                        HTMLMenu += "<li class=\"icon icon-arrow-left\">";
                        HTMLMenu += "<a href=\"#\" ><i></i>" + dr["DESC_TRANS"].ToString() + "</a>";
                    }
                    else
                    {
                        HTMLMenu += "<li >";
                        // Futuramente levar estes ajustes (replaces) para a classe
                        caminho = caminho.Replace("~/", "../../");
                        caminho = caminho.Replace("//", "/");

                        HTMLMenu += "<a data-prog=\"" + dr["COD_PROG"].ToString() + "|" + dr["COD_TRANS"].ToString() + "\" href=\"" + caminho + "\">" + dr["DESC_TRANS"].ToString() + "</a>";
                        HTMLMenu += "</li>";
                    }


                    id_item++;
                    MontaNivelPosteriorTransacao(Session["codUsuario"].ToString(), Session["codEmpresa"].ToString(), dr["COD_TRANS"].ToString(), id_item, dr["DESC_TRANS"].ToString());
                }
                HTMLMenu += "</ul></div>";
            }

        }
        catch (StackOverflowException exc)
        {
            //labelHoraEntrada.Text = exc.Message;
        }

    }
}