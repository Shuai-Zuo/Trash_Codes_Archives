// ******************************************************************
// 文件名: Light.EXP.WebUI.User.UserList.aspx.cs
// Copyright  (c)  2006-2007 ATA
// 作者:       叶常达
// 创建日期：  2007-10-19
// 主要内容：  显示用户信息
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

    public partial class UserList : PageBase
    {
        /// <summary>
        /// 页面载入
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void Page_Load(object sender, System.EventArgs e)
        {
            if (!this.IsPostBack)
            {
                // 绑定DataList
                this.BindDataList();
                // 增加删除确认提示
                this.lnkbBatchDelete.Attributes.Add("onclick", "javascript:return confirm('您确实要删除这些记录吗？'); ");
            }
        }

        /// <summary>
        /// 搜索按钮
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void imgbSearch_Click(object sender, System.Web.UI.ImageClickEventArgs e)
        {
            this.BindDataList();
        }

        /// <summary>
        /// 批量删除
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void lnkbBatchDelete_Click(object sender, EventArgs e)
        {
            string loginIDs = string.Empty;
            foreach (DataListItem item in this.dtlUser.Items)
            {
                HtmlInputCheckBox chkbUserID = (HtmlInputCheckBox)item.FindControl("chkbUserID");
                if (chkbUserID.Checked)
                {
                    if (loginIDs == string.Empty)
                        loginIDs = "'" + chkbUserID.Value + "'";
                    else
                        loginIDs = loginIDs + "," + "'" + chkbUserID.Value + "'";
                }
            }
            if (loginIDs.Length != 0)
            {
                loginIDs = "(" + loginIDs + ")";
                UserBusiness userBusiness = new UserBusiness();
                userBusiness.BatchDeleteUsers(loginIDs);
            }
            this.BindDataList();
        }

        #region 工具条
        /// <summary>
        /// 每页显示5条记录
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void imgbFive_Click(object sender, ImageClickEventArgs e)
        {
            ViewState["pageSize"] = 5;
            this.BindDataList();
        }

        /// <summary>
        /// 每页显示10条记录
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void imgbTen_Click(object sender, ImageClickEventArgs e)
        {
            ViewState["pageSize"] = 10;
            this.BindDataList();
        }

        /// <summary>
        /// 每页显示15条记录
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void imgbFifteen_Click(object sender, ImageClickEventArgs e)
        {
            ViewState["pageSize"] = 15;
            this.BindDataList();
        }

        /// <summary>
        /// 升序排列
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void imgbUp_Click(object sender, ImageClickEventArgs e)
        {
            ViewState["sortField"] = this.drdlSortField.SelectedValue;
            ViewState["sortOrder"] = "ASC";
            this.BindDataList();
        }

        /// <summary>
        /// 降序排列
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void imgbDown_Click(object sender, ImageClickEventArgs e)
        {
            ViewState["sortField"] = this.drdlSortField.SelectedValue;
            ViewState["sortOrder"] = "DESC";
            this.BindDataList();
        }

        /// <summary>
        /// 全选
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void imgbAllSelect_Click(object sender, ImageClickEventArgs e)
        {
            foreach (DataListItem item in this.dtlUser.Items)
            {
                HtmlInputCheckBox chkbUserID = (HtmlInputCheckBox)item.FindControl("chkbUserID");
                chkbUserID.Checked = true;
            }
        }

        /// <summary>
        /// 取消全选
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void imgbCancelSelect_Click(object sender, ImageClickEventArgs e)
        {
            foreach (DataListItem item in this.dtlUser.Items)
            {
                HtmlInputCheckBox chkbUserID = (HtmlInputCheckBox)item.FindControl("chkbUserID");
                chkbUserID.Checked = false;
            }
        }
        #endregion

        /// <summary>
        /// 每个需要分页查询的页面都需要实现此方法
        /// 此方法为分页控件提供分页数据的读取．
        /// </summary>
        /// <param name="pageIndex">当前要读取的页, 从１开始</param>
        /// <param name="recordCount">总的数据行数(不分页时)</param>
        /// <returns>一页数据</returns>
        private DataSet GetPagerData(int pageIndex, ref Int64 recordCount)
        {
            string userName = txtbUserName.Text;
            int sex = int.Parse(this.drdlSex.SelectedValue);
            string sortField = "LoginId";
            string sortOrder = "ASC";
            if (ViewState["sortField"] != null)
                sortField = ViewState["sortField"].ToString();
            if (ViewState["sortOrder"] != null)
                sortOrder = ViewState["sortOrder"].ToString();

            // 获取数据源
            UserBusiness userBusiness = new UserBusiness();
            int pageSize = 10;
            if (ViewState["pageSize"] != null)
                pageSize = int.Parse(ViewState["pageSize"].ToString());
            DataSet dsUser = userBusiness.GetUsers(userName, sex, sortField, sortOrder, pageIndex, pageSize, ref recordCount);
            return dsUser;
        }

        /// <summary>
        /// 绑定DataList
        /// </summary>
        private void BindDataList()
        {
            int pageSize = 10;
            if (ViewState["pageSize"] != null)
                pageSize = int.Parse(ViewState["pageSize"].ToString());
            this.dtpUser.BindDataPage(this.GetPagerData, pageSize);
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
        private void InitializeComponent(){}
        #endregion
    }
}
