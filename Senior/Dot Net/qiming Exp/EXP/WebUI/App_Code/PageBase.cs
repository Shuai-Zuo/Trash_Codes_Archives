// ******************************************************************
// 文件名: Light.EXP.WebUI.SystemFrame.PageBase
// Copyright  (c)  2006-2007 ATA
// 作者:       叶常达
// 创建日期：  2007-10-23
// 主要内容：  所有Web页面的基类
// ******************************************************************

namespace Light.EXP.WebUI.SystemFrame
{
    using System;
    using System.Web;
    using System.Web.UI;
    using System.ComponentModel;
    using System.Data;

    using Light.EXP.SystemFrameworks;
    using Light.EXP.Business.SystemFrame;
    
    public class PageBase : System.Web.UI.Page
    {
		/// <summary>
		/// 起始路径
		/// </summary>
		private static String pageUrlBase;

		/// <summary>
		/// URL前缀
		/// </summary>
		private static String urlSuffix;

		/// <summary>
		/// 构造函数
		/// </summary>
		public PageBase ()
		{
			try
			{
				urlSuffix =  Context.Request.Url.Host;

				if(Context.Request.Url.Port != 80)
				{
					urlSuffix += ":" + Context.Request.Url.Port.ToString();
				}
				urlSuffix += Context.Request.ApplicationPath;

				pageUrlBase = @"http://" + urlSuffix + "/Secure/Login.aspx";
			}
			catch{}
		}
		
		/// <summary>
		/// 异常处理
		/// </summary>
		/// <param name="e"></param>
        protected override void OnError(EventArgs e) 
        {
			// 获取异常
			Exception ex = Server.GetLastError();

			// 写错误日志文件
			ApplicationLog.Log(ex.Message);

			// 转向错误信息页面
            Context.Session["SystemError"] = ex.Message;
            Context.Response.Redirect(@"http://" + urlSuffix + "/ErrorPage.aspx");

            Server.ClearError();
        }

		/// <summary>
		/// 验证是否登陆及是否有此页面访问权限
		/// </summary>
		protected void CheckAuthority()
		{
			//
			//检查用户是否登陆
			//
            if (Context.Session["LoginID"] == null)
			{
                Context.Session["SystemError"] = "您还没有登陆或者登陆已经超时！";
                Context.Response.Redirect(@"http://" + urlSuffix + "/ErrorPage.aspx");
			}

            //
            //检查用户是否可以访问此页面
            //
            if (!this.IsPostBack)
            {
                string pageName = Context.Request.FilePath.Substring(Request.FilePath.LastIndexOf("/") + 1, Request.FilePath.LastIndexOf(".") - Request.FilePath.LastIndexOf("/") - 1);
                string loginID = Context.Session["LoginID"].ToString();
                SystemBusiness systemBusiness = new SystemBusiness();
                if (!systemBusiness.CheckRight(loginID, pageName))
                {
                    Context.Session["SystemError"] = "您没有权限访问此页面！";
                    Context.Response.Redirect(@"http://" + urlSuffix + "/ErrorPage.aspx");
                }
            }
		}
    }
    
}
