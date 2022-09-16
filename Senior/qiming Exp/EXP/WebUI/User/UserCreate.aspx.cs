// ******************************************************************
// 文件名: Light.EXP.WebUI.User.UserCreate.aspx.cs
// Copyright  (c)  2006-2007 ATA
// 作者:       叶常达
// 创建日期：  2007-10-19
// 主要内容：  用户增加页面
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

    using Light.EXP.Business.User;
    using Light.EXP.Model.User;
    using Light.EXP.SystemFrameworks;
    using Light.EXP.WebUI.SystemFrame;

	public partial class UserCreate : PageBase
	{		
		protected void Page_Load(object sender, System.EventArgs e)
		{
			if(!IsPostBack)
			{		
				// 附加日历事件
				this.txtbBirthday.Attributes["onclick"] = "javascript:setday(this)";
			}
		}

		/// <summary>
		/// 添加按钮
		/// </summary>
		/// <param name="sender"></param>
		/// <param name="e"></param>
		private void imgbCreate_Click(object sender, System.Web.UI.ImageClickEventArgs e)
		{
			if (! this.ValidateForm())
				return;

			// 声明用户实体类对象
			Users user = new Users();
		
			// 为用户实体类对象的各个属性赋值
			user.LoginId = this.txtbUserID.Text;
			user.UserName = this.txtbUserName.Text;
			user.Sex = int.Parse(this.rdblSex.SelectedValue);
			if (this.txtbBirthday.Text.Length != 0)
				user.Birthday = Convert.ToDateTime(this.txtbBirthday.Text);
			else
				user.Birthday = Convert.ToDateTime("1900-1-1");
		
			// 声明用户处理类对象
			UserBusiness userBusiness = new UserBusiness();
		
			if (userBusiness.CreateUser(user)) 
			{
				Response.Redirect("UserList.aspx");
			}// 增加操作成功
			else 
			{
				Utility.AlertMsg(this, "增加用户失败！");
			}// 增加操作失败
		}

		/// <summary>
		/// 取消按钮
		/// </summary>
		/// <param name="sender"></param>
		/// <param name="e"></param>
		private void imgbCancel_Click(object sender, System.Web.UI.ImageClickEventArgs e)
		{
			Response.Redirect("UserList.aspx");
		}

		/// <summary>
		/// 表单验证
		/// </summary>
		/// <returns>bool(true: 通过 false: 不通过)</returns>
		private bool ValidateForm()
		{
			if (this.txtbUserID.Text.Length == 0)
			{
				Utility.AlertMsg(this, "请输入用户ID！");
				return false;
			}
			if (this.txtbUserName.Text.Length == 0)
			{
				Utility.AlertMsg(this, "请输入用户名称！");
				return false;
			}
			return true;
		}

		#region Web 窗体设计器生成的代码
		override protected void OnInit(EventArgs e)
		{
			//
			// CODEGEN: 该调用是 ASP.NET Web 窗体设计器所必需的。
			//
			InitializeComponent();
			base.OnInit(e);
		}
		
		/// <summary>
		/// 设计器支持所需的方法 - 不要使用代码编辑器修改
		/// 此方法的内容。
		/// </summary>
		private void InitializeComponent()
		{    
			this.imgbCreate.Click += new System.Web.UI.ImageClickEventHandler(this.imgbCreate_Click);
			this.imgbCancel.Click += new System.Web.UI.ImageClickEventHandler(this.imgbCancel_Click);

		}
		#endregion
	}
}
