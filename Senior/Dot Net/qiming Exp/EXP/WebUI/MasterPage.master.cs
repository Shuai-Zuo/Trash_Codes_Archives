// ******************************************************************
// 文件名: Light.EXP.WebUI.SystemFrame.MasterPage
// Copyright  (c)  2006-2007 ATA
// 作者:       叶常达
// 创建日期：  2007-10-23
// 主要内容：  母版页
// ******************************************************************

namespace Light.EXP.WebUI.SystemFrame
{
    using System;
    using System.Data;
    using System.Configuration;
    using System.Collections;
    using System.Web;
    using System.Web.Security;
    using System.Web.UI;
    using System.Web.UI.WebControls;
    using System.Web.UI.WebControls.WebParts;
    using System.Web.UI.HtmlControls;

    public partial class MasterPage : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                this.trvLeft.DataBind();
                string url = Request.FilePath;
                //int indexBegin = url.IndexOf("/", 2);
                //int indexEnd = url.LastIndexOf("/");                
                //url = url.Substring(indexBegin, indexEnd - indexBegin);
                
                TreeNode rootNode = this.trvLeft.Nodes[0];
                this.ExpCollByUrl(rootNode, url);
                if (rootNode.Expanded == false)
                {
                    rootNode.Expand();
                }
            }
        }

        private bool ExpCollByUrl(TreeNode treeNode, string url)
        {
            bool canExp = false;
            if (treeNode.ChildNodes.Count == 0)
            {
                return false;
            }
            treeNode.Expand();
            foreach (TreeNode childNode in treeNode.ChildNodes)
            {
                if (url == "")
                {
                    continue;
                }

                string navigateUrl = childNode.NavigateUrl.ToLower();
                int indexBegin = navigateUrl.IndexOf("/");
                int indexEnd = navigateUrl.LastIndexOf("/");
                navigateUrl = navigateUrl.Substring(indexBegin, indexEnd - indexBegin);
                
                if (navigateUrl == url.ToLower())
                {
                    childNode.Selected = true;
                    childNode.Expand();
                    canExp = true;
                    break;
                }
                if (ExpCollByUrl(childNode, url)) 
                { 
                    canExp = true; 
                    break; 
                }
            }
            if (!canExp)
            {
                treeNode.Collapse();
            }
            return canExp;
        }
    }
}
