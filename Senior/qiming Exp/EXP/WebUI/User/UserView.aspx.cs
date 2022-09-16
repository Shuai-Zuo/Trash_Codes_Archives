// ******************************************************************
// 文件名: Light.EXP.WebUI.User.UserView.aspx.cs
// Copyright  (c)  2006-2007 ATA
// 作者:       叶常达
// 创建日期：  2007-10-29
// 主要内容：  用户查看
// ******************************************************************

namespace Light.EXP.WebUI.User
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
    using System.Data.SqlClient;

    using Light.EXP.Business.User;
    using Light.EXP.Model.User;
    using Light.EXP.SystemFrameworks;
    using Light.EXP.WebUI.SystemFrame;

    public partial class UserView : PageBase
    {

        protected void Page_Load(object sender, System.EventArgs e)
        {
            if (!this.IsPostBack)
            {
                // 获取从UserList页传递的变量值
                string loginId = Request.QueryString["LoginID"];

                // 绑定FormView
                this.objdUserView.TypeName = "Light.EXP.Business.User.UserBusiness";
                this.objdUserView.SelectMethod = "GetUser";
                this.objdUserView.SelectParameters.Add("loginId", loginId);
                this.objdUserView.DataBind();
            }
        }

        protected void imgbCancel_Click(object sender, System.Web.UI.ImageClickEventArgs e)
        {
            Response.Redirect("UserList.aspx");
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
