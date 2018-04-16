<%@ WebHandler Language="C#" Class="ACEN0018" %>

using System;
using System.Collections.ObjectModel;
using System.Data;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.SessionState;

public class ACEN0018 : IHttpHandler, System.Web.SessionState.IReadOnlySessionState
{

    public void ProcessRequest(HttpContext context)
    {
        if (context.Session["codUsuario"] != null)
        {
            context.Session["codTrans"] = context.Request.QueryString["codTrans"];
            context.Session["codProg"] = context.Request.QueryString["codProg"];
        }

        context.Response.ContentType = "text/plain";
        context.Response.Write("OKAY");
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}