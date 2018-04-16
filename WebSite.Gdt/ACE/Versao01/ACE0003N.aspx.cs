using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web.Security;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Dominio.DOMACE;

public partial class ACE_Versao01_ACE0003N : System.Web.UI.Page
{
    Dominio.DOMACE.Login log = new Dominio.DOMACE.Login();
    Programa prog = new Programa();
    ParametroDomAce paramace = new ParametroDomAce();
    Empresa emp = new Empresa();
    private string url;

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (Request.QueryString["codpessoa"] != null)
            {
                throw new Exception("Este usuário não  está associado a uma pessoa no sistema, esta associação é necessária para a utilização do sistema.");
            }

            if (Request.QueryString["codParam"] != null)
            {
                Session["codParam"] = Request.QueryString["codParam"].ToString();
                log.Token = Request.QueryString["codParam"].ToString();
                DataSet dsLogin = log.verificaToken();

                log.deletaToken();

                if (dsLogin != null)
                {

                    prog.Cod_programa = dsLogin.Tables[0].Rows[0]["coluna3"].ToString();

                    url = prog.retornaUrlPrograma();

                    if (String.IsNullOrEmpty(url))
                    {
                        throw new Exception("Programa " + prog.Cod_programa.ToString() + " e/ou caminho não cadastrados.");
                    }
                    else
                    {
                        Session["codUsuario"] = dsLogin.Tables[0].Rows[0]["coluna1"].ToString();
                        Session["codEmpresa"] = dsLogin.Tables[0].Rows[0]["coluna2"].ToString();

                        DataSet dsEmpresaUsuario = log.retornaEmpresaGrupo(Session["codEmpresa"].ToString());
                        if (dsEmpresaUsuario.Tables[0].Rows.Count > 0)
                        {
                            Session["empresaLogada"] = dsEmpresaUsuario.Tables[0].Rows[0]["nome"].ToString();
                        }
                        else
                        {
                            throw new Exception("Usuário não está associado a nenhuma empresa");
                        }

                        if (!DBNull.Value.Equals(dsLogin.Tables[0].Rows[0]["coluna2"]))
                        {
                            Response.Redirect("~" + url + "?" + dsLogin.Tables[0].Rows[0]["parametros_url"].ToString());
                        }
                        else
                        {
                            Response.Redirect("~" + url);
                        }
                    }
                }
                else
                {
                    divMsg.Visible = true;
                    lblMsg.Text = "Token inválido ou já utilizado";
                }
            }

            if (Request.QueryString["sessioninvalidate"] == "y")
            {
                Session.Clear();
                Session.Abandon();
                Session.Remove("codUsuario");
                Response.Redirect("ACE0003N.aspx");
                lblMsg.Text = "Logoff realizado com sucesso!";
                divMsg.Visible = true;
            }

            if (Request.QueryString["invaliduser"] == "y")
            {
                lblMsg.Text = "Sua sessão expirou.";
                divMsg.Visible = true;
            }

            if (Request.QueryString["loginEmpresa"] == "1")
            {
                tabelaLogin.Visible = false;
                PanelLoginEmpresa.Visible = true;
                populaListaEmpr();
            }
        }
        catch (Exception exc)
        {
            lblMsg.Text = exc.Message;
            divMsg.Visible = true;
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
    }

    protected void Page_PreRender(object sender, EventArgs e)
    {
        if (Request.QueryString["loginEmpresa"] != null)
        {
            codEmpresa.Focus();
        }
        else
        {
            txtLogin.Focus();
        }
    }

    protected void btnLogin_onClick(object sender, EventArgs e)
    {
        try
        {
            Dominio.DOMACE.Login log = new Dominio.DOMACE.Login();
            string retorno = log.ConfereLoginUsuario(txtLogin.Text, txtSenha.Text);

            string url = HttpUtility.HtmlDecode(Request.QueryString["url"]);

            Session["menuVisible"] = "S";


            if (retorno != null)
            {
                Session["codUsuario"] = retorno;

                Dominio.DOMACE.Login l = new Dominio.DOMACE.Login();

                DataSet ds = l.ListaEmpresaGrupoPorUsuario(retorno.ToString());
                int count = ds.Tables[0].Rows.Count;

                if (count == 1)
                {
                    Session["empresaLogada"] = ds.Tables[0].Rows[0]["descricao"].ToString();
                    Session["codEmpresa"] = ds.Tables[0].Rows[0]["CODIGO"].ToString();

                    //seta parametros do relatorio
                    emp.Codigo = Convert.ToInt32(ds.Tables[0].Rows[0]["CODIGO"]);
                    paramace.Emp = emp;

                    Session["diretorio_rel"] = paramace.retornaCaminhoReport();
                    Session["caminho_rel"] = paramace.retornaCaminhoWebReport();

                    if (url == null)
                    {
                        Response.Redirect("~/ACE/Versao01/ACEN60600.aspx"); // Dashboard                        
                    }
                    else
                    {
                        Response.Redirect(url);

                    }

                }
                else
                {
                    if (url == null)
                    {
                        Response.Redirect("ACE0003N.aspx?loginEmpresa=1");
                    }
                    else
                    {
                        Response.Redirect("ACE0003N.aspx?loginEmpresa=1&url=" + HttpUtility.UrlEncode(url.ToString()));
                    }
                }


            }
            else
            {
                lblMsg.Text = "Usuário ou senha inválido(s)!";
                divMsg.Visible = true;
            }
        }
        catch (Exception exc)
        {
            lblMsg.Text = exc.Message;
            divMsg.Visible = true;
        }
    }

    protected void LoginEmpresa_Click(object sender, EventArgs e)
    {
        if (selEmpresa.SelectedValue.ToString() == "") { }
        else
        {
            if (codEmpresa.Text != "")
            {
                try
                {
                    selEmpresa.SelectedValue = codEmpresa.Text;
                }
                catch (Exception)
                {
                    divMsg.Visible = true;
                    lblMsg.Text = "O código informado não está na lista de empresas!";
                    codEmpresa.Focus();
                    codEmpresa.Text = "";
                    selEmpresa.Items.Clear();
                    populaListaEmpr();
                    return;
                }
            }
            Dominio.DOMACE.Login log = new Dominio.DOMACE.Login();
            DataSet ds = log.retornaEmpresaGrupo(selEmpresa.SelectedValue.ToString());
            string cod_empresa = ds.Tables[0].Rows[0]["CODIGO"].ToString();
            string empresa = ds.Tables[0].Rows[0]["NOME"].ToString();
            string url = HttpUtility.HtmlDecode(Request.QueryString["url"]);

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

            if (url == null)
            {
                Response.Redirect("~/ACE/Versao01/ACEN60600.aspx"); // Dashboard
            }
            else
            {
                Response.Redirect(url);
            }
        }
    }
}