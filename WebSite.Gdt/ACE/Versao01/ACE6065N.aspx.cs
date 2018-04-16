using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Dominio.DOMACE;
using System.Data;

public partial class ACE_Versao01_ACE6065N : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // Trata formato de erro anterior (versão antiga)
        if (Request.QueryString["erroSGE"] != null)
        {
            Response.Redirect("ACE6065N.aspx?erro=" + Request.QueryString["erroSGE"].ToString());
        }

        if (Request.QueryString["erro"] != null)
        {
            int result = 0;
            if (Int32.TryParse(Request.QueryString["erro"], out result))
            {
                montaMensagem(Convert.ToInt32(Request.QueryString["erro"]));
            }
            else
            {
                montaMensagem(Request.QueryString["erro"].ToString());
            }
        }
    }

    public void montaMensagem(int codigo)
    {
        MensagemErro me = new MensagemErro();
        me.Codigo = codigo;
        DataSet ds = me.retornaErroSGE();

        if (ds != null)
        {
            lblCodigo.Text = "Erro  DSGE-" + codigo.ToString().PadLeft(4, '0');
            lblDescricao.Text = ds.Tables[0].Rows[0]["DESCRICAO"].ToString();
            lblDetalhe.Text = "<strong>AÇÃO:</strong> " + ds.Tables[0].Rows[0]["ACAO"].ToString() + "";
        }
        else
        {
            lblCodigo.Text = "Erro Desconhecido";
            lblDescricao.Text = "Erro não documentado.";
            lblDetalhe.Text = "DSGE-" + codigo.ToString().PadLeft(4, '0') + " - Erro não documentado";
        }
    }

    public void montaMensagem(string msg)
    {
        if (msg.Contains("Ação"))
        {
            lblCodigo.Text = "Erro interno";
            lblDescricao.Text = msg.Substring(0, msg.IndexOf("Ação"));
            lblDetalhe.Text = "<strong>AÇÃO:</strong> " + msg.Substring(msg.IndexOf("Ação")) + "";

        }
        else
        {
            lblCodigo.Text = "Erro interno";
            lblDescricao.Text = msg;
            lblDetalhe.Text = msg;
        }

    }
}