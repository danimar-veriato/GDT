using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Dominio.DOMACE;
using System.Data;
using Dominio.DOMDB;
using System.IO;

public partial class DOMSGE : System.Web.UI.MasterPage
{
    Pessoa pes = new Pessoa();
    ParametroDomAce paramace = new ParametroDomAce();
    DatabaseOracle dbOracle = new DatabaseOracle();

    protected void Page_Load(object sender, EventArgs e)
    {
        string url;
        url = HttpUtility.UrlEncode(Request.RawUrl);

        if (Session["codUsuario"] == null || Session["codEmpresa"] == null || Session["empresaLogada"] == null)
        {
            Response.Redirect("~/ACE/Versao01/ACE0003N.aspx?url=" + url, true);
        }

        iconAlert.Style["color"] = "#ED5565";

        if (Session["codProg"] != null && Session["codTrans"] != null)
        {
            lblPrograma.Text = Session["codProg"].ToString();
            lblTransacao.Text = Session["codTrans"].ToString();

            if (Session["codProg"].ToString() == Path.GetFileName(Request.Url.AbsolutePath).Split('.')[0])
            {
                linkWiki.Visible = true;
                linkWiki.HRef = paramace.MontaLinkAcessoWiki(Session["codEmpresa"].ToString(), Session["codUsuario"].ToString(), "P", Session["codProg"].ToString(), DateTime.Now.ToString("dd/MM/yyyy HH:mm"));
                iconAlert.Style["color"] = "#88D866";
            }
        }

        lblEmp.Text = Session["codEmpresa"].ToString() + " - " + Session["empresaLogada"].ToString();
        lblUsuarioLogado.Text = Session["codUsuario"].ToString();

        lblDbName.Text = "Banco de dados: <strong>" + dbOracle.DatabaseName() + "</strong>";

        if (!IsPostBack)
        {
            populaListaEmpr();
        }

        Pessoa pes = new Pessoa();
        string logo = pes.retornaLogoWeb(Session["codEmpresa"].ToString());
        if (logo != "")
        {
            LogEmprLogada.ImageUrl = "~" + logo;
        }
        else
        {
            LogEmprLogada.ImageUrl = "~/template/logotipos/LogoDomSge.png";
        }
    }

    private void populaListaEmpr()
    {
        Dominio.DOMACE.Login login = new Dominio.DOMACE.Login();
        DataSet ds = login.ListaEmpresaGrupoPorUsuario(Session["codUsuario"].ToString());
        foreach (DataRow dr in ds.Tables[0].Rows)
        {
            {
                ListItem li = new ListItem();
                int valor = Convert.ToInt32(dr["nivel"].ToString()) * 3;
                li.Attributes.Add("data-content", "<span style=\"margin-left:" + valor.ToString() + "px;\"> " + dr["composicao"].ToString() + "</span>");
                li.Text = Server.HtmlDecode(dr["composicao"].ToString());

                li.Value = dr["codigo"].ToString();
                selEmpresa.Items.Add(li);

            }
        }

        selEmpresa.SelectedValue = Session["codEmpresa"].ToString();
    }

    public void btnWiki_OnClick(object sender, EventArgs e)
    {

    }

    public void btnEmp_OnClick(object sender, EventArgs e)
    {
        Dominio.DOMACE.Login login = new Dominio.DOMACE.Login();
        DataSet ds = new DataSet();
        ds = login.ListaEmpresaGrupoPorUsuario(Session["codUsuario"].ToString());
        if (ds.Tables[0].Rows.Count > 1)
        {
            Response.Redirect("~/ACE/Versao01/ACE0003N.aspx?loginEmpresa=1&url=" + Request.RawUrl);
        }
    }

    protected void btnLogout_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/ACE/Versao01/ACE0003N.aspx?sessioninvalidate=y");
    }

    protected void selEmpresa_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            Empresa emp = new Empresa();
            Dominio.DOMACE.Login log = new Dominio.DOMACE.Login();
            DataSet ds = log.retornaEmpresaGrupo(selEmpresa.SelectedValue);
            string cod_empresa = ds.Tables[0].Rows[0]["CODIGO"].ToString();
            string empresa = ds.Tables[0].Rows[0]["NOME"].ToString();

            Session["codEmpresa"] = cod_empresa;
            Session["empresaLogada"] = empresa;

            //seta parametros do relatorio
            emp.Codigo = Convert.ToInt32(cod_empresa);
            paramace.Emp = emp;

            Session["diretorio_rel"] = paramace.retornaCaminhoReport();
            Session["caminho_rel"] = paramace.retornaCaminhoWebReport();

            //LIMPA DADOS DO MENU, POIS PODE MUDAR DE ACORDO COM A EMPRESA
            Session.Remove("phMenuAcessos");
            Session.Remove("phACE0150N");

            Response.Redirect(Request.RawUrl);
        }
        catch (Exception)
        {
            throw;
        }
    }
}
