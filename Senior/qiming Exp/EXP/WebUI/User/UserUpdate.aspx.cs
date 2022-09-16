// ******************************************************************
// 文件名: Light.EXP.WebUI.User.UserUpdate.aspx.cs
// Copyright  (c)  2006-2007 ATA
// 作者:       叶常达
// 创建日期：  2007-10-19
// 主要内容：  用户修改，删除
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

	public partial class UserUpdate : PageBase
	{	
		protected void Page_Load(object sender, System.EventArgs e)
		{
			if(!this.IsPostBack)
			{					
				// 获取从UserList页传递的变量值
				string LoginID = Request.QueryString["LoginID"];

				// 声明用户处理类对象
				UserBusiness userBusiness = new UserBusiness();

				// 根据登录ID获取用户实体
				Users user = new Users();
				user = userBusiness.GetUser(LoginID);

				// 用取得的用户DataTable填充表单
				this.txtbUserID.Text = user.LoginId;
				this.txtbUserName.Text = user.UserName;
				this.rdblSex.SelectedValue = user.Sex.ToString();
				if (user.Birthday.ToShortDateString() != "1900-1-1")
					this.txtbBirthday.Text = user.Birthday.ToShortDateString();
				else
					this.txtbBirthday.Text = string.Empty;

				// 增加删除确认提示
				this.imgbDelete.Attributes.Add("onclick", "javascript:return confirm('您确实要删除该记录吗？'); ");
			}
		}

		/// <summary>
		/// 修改按钮
		/// </summary>
		/// <param name="sender"></param>
		/// <param name="e"></param>
		private void imgbUpdate_Click(object sender, System.Web.UI.ImageClickEventArgs e)
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

			if (userBusiness.UpdateUser(user)) 
			{
				Response.Redirect("UserList.aspx");
			}// 修改操作成功
			else 
			{
				Utility.AlertMsg(this, "修改用户失败！");
			}// 修改操作失败
		}

		/// <summary>
		/// 删除按钮
		/// </summary>
		/// <param name="sender"></param>
		/// <param name="e"></param>
		private void imgbDelete_Click(object sender, System.Web.UI.ImageClickEventArgs e)
		{
			// 声明用户处理类对象
			UserBusiness userBusiness = new UserBusiness();
			
			if (userBusiness.DeleteUser(this.txtbUserID.Text)) 
			{
				Response.Redirect("UserList.aspx");
			}// 删除操作成功
			else 
			{
				Utility.AlertMsg(this, "删除用户失败！");
			}// 删除操作失败
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
			this.imgbUpdate.Click += new System.Web.UI.ImageClickEventHandler(this.imgbUpdate_Click);
			this.imgbDelete.Click += new System.Web.UI.ImageClickEventHandler(this.imgbDelete_Click);
			this.imgbCancel.Click += new System.Web.UI.ImageClickEventHandler(this.imgbCancel_Click);

		}
		#endregion
	}
}
