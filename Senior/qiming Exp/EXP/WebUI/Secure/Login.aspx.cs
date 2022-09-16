// ******************************************************************
// 文件名: Light.EXP.WebUI.SystemFrame.Login
// Copyright  (c)  2006-2007 ATA
// 作者:       叶常达
// 创建日期：  2007-10-17
// 主要内容：  用户登录页面
// ******************************************************************

namespace Light.EXP.WebUI.SystemFrame
{
	using System;
	using System.Collections;
	using System.ComponentModel;
	using System.Data;
	using System.Drawing;
	using System.Web;
	using System.Web.SessionState;
	using System.Web.UI;
	using System.Web.UI.WebControls;
	using System.Web.UI.HtmlControls;
	using System.Web.Security;

	public partial class Login : System.Web.UI.Page
	{
	    protected void Page_Load(object sender, System.EventArgs e)
		{
            if (!IsPostBack)
            {
                //移除身份验证
                FormsAuthentication.SignOut();
                //消除会话状态中的所有值
                HttpContext.Current.Session.Clear();
                //取消当前会话
                HttpContext.Current.Session.Abandon();
            }
		}

        protected void lgnUserLogin_LoggedIn(object sender, EventArgs e)
        {
            Session["LoginID"] = this.lgnUserLogin.UserName;
        }

		#region Web Form Designer generated code
		override protected void OnInit(EventArgs e)
		{
			//
			// CODEGEN: This call is required by the ASP.NET Web Form Designer.
			//
			InitializeComponent();
			base.OnInit(e);
		}
		
		/// <summary>
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent(){}
		#endregion
    }
}
