// ******************************************************************
// 文件名: Light.EXP.WebUI.SystemFrame.DataPager
// Copyright  (c)  2006-2007 ATA
// 作者:       叶常达
// 创建日期：  2007-10-23
// 主要内容：  分页控件
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

    public partial class DataPager : System.Web.UI.UserControl
    {
        #region 分页相关变量定义
        /// <summary>
        /// 每页显示的数据个数
        /// </summary>
        private int PageSize
        {
            get
            {
                if (this.ViewState["PageSize"] != null)
                {
                    return Convert.ToInt32(this.ViewState["PageSize"]);
                }
                return 10;
            }
            set
            {
                this.ViewState["PageSize"] = value;
            }
        }

        /// <summary>
        /// 当前要显示的页数
        /// </summary>
        private int CurrentPage
        {
            get
            {
                if (this.ViewState["CurrentPage"] != null)
                {
                    return Convert.ToInt32(this.ViewState["CurrentPage"]);
                }
                return 1;
            }
            set
            {
                this.ViewState["CurrentPage"] = value;
            }
        }

        /// <summary>
        /// 待分页控件的ID
        /// </summary>
        public string ControlNameToPager
        {
            get
            {
                if (this.ViewState["ControlNameToPager"] != null)
                {
                    return this.ViewState["ControlNameToPager"].ToString();
                }
                return string.Empty;
            }
            set
            {
                this.ViewState["ControlNameToPager"] = value;
            }
        }

        /// <summary>
        /// 本次执行分页数据的总的数据行数
        /// </summary>
        private Int64 TotalCount
        {
            get
            {
                if (this.ViewState["TotalCount"] != null)
                {
                    return Convert.ToInt64(this.ViewState["TotalCount"]);
                }
                return 0;
            }
            set
            {
                this.ViewState["TotalCount"] = value;
            }
        }


        /// <summary>
        /// 委托函数变量
        /// </summary>
        //private GetPagerDataDelegate GetPagerData
        //{
        //    get
        //    {
        //        if (this.ViewState["GetPagerData"] != null)
        //        {
        //            return (GetPagerDataDelegate)this.ViewState["GetPagerData"];
        //        }
        //        return _GetPagerData;
        //    }
        //    set
        //    {
        //        this.ViewState["GetPagerData"] = value;
        //    }
        //}
        
        
        private static GetPagerDataDelegate _GetPagerData = null;
        //------------------------------------------------------------------------------------
        public delegate DataSet GetPagerDataDelegate(int pageIndex, ref Int64 totalCount);
        //------------------------------------------------------------------------------------         
        #endregion

        #region 分页事件
        /// <summary>
        /// 首页
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void lnkbHome_Click(object sender, EventArgs e)
        {
            CurrentPage = 1;
            this.ShowData();
        }

        /// <summary>
        /// 上一页
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void lnkbPriv_Click(object sender, EventArgs e)
        {
            CurrentPage--;
            this.ShowData();
        }

        /// <summary>
        /// 下一页
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void lnkbNext_Click(object sender, EventArgs e)
        {
            CurrentPage++;
            this.ShowData();
        }

        /// <summary>
        /// 尾页
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void lnkbLast_Click(object sender, EventArgs e)
        {
            CurrentPage = (int)Math.Ceiling((decimal)(TotalCount / (decimal)PageSize));
            this.ShowData();
        }

        /// <summary>
        /// 跳转到第几页
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void lnkbGo_Click(object sender, EventArgs e)
        {
            if (this.txtbNum.Text.Trim().Length == 0)
            {
                CurrentPage = 1;
            }
            else
            {
                CurrentPage = int.Parse(this.txtbNum.Text);
            }
            this.ShowData();
        }
        #endregion

        #region 分页实现
        /// <summary>
        /// 引用此分页控件的Web页面调用的分页实现方法
        /// </summary>
        /// <param name="GetPagerData"></param>
        /// <param name="PageSize"></param>
        public void BindDataPage(GetPagerDataDelegate getPagerData, int pageSize)
        {
            PageSize = pageSize;
            _GetPagerData = getPagerData;
            
            this.ShowData();
        }

        /// <summary>
        /// 显示数据
        /// </summary>
        /// <param name="GetPagerData"></param>
        private void ShowData()
        {
            Int64 totalCount = 0;
            DataSet ds = _GetPagerData(CurrentPage, ref totalCount);

            TotalCount = totalCount;
            
            //绑定数据
            object listControl = this.Parent.FindControl(this.ControlNameToPager);

            if (listControl.GetType().ToString() == "System.Web.UI.WebControls.DataList")
            {
                DataList list = (DataList)listControl;
                list.DataSource = ds;
                list.DataBind();
            }
            if (listControl.GetType().ToString() == "System.Web.UI.WebControls.GridView")
            {
                GridView list = (GridView)listControl;                

                //查询时，如果没有数据，GridView控件表头需显示出来 -- 2007-12-02 刘道营添加
                if (ds.Tables[0].Rows.Count == 0)
                {
                    ds.Tables[0].Rows.Add(ds.Tables[0].NewRow());
                    list.DataSource = ds;
                    list.DataBind();
                    int columnCount = list.Rows[0].Cells.Count;
                    list.Rows[0].Cells.Clear();
                    list.Rows[0].Cells.Add(new TableCell());
                    list.Rows[0].Cells[0].ColumnSpan = columnCount;
                    list.Rows[0].Cells[0].Text = "没有符合条件的数据！";
                }
                else
                {
                    list.DataSource = ds;
                    list.DataBind();
                }
            }

            this.SetPagerUI();
        }

        /// <summary>
        /// 设置分页控件的UI显示
        /// </summary>
        /// <param name="TotalCount"></param>
        private void SetPagerUI()
        {
            this.DisableControl();

            int totalPages = (int)Math.Ceiling((decimal)(TotalCount / (decimal)PageSize));

            string CurrentPageText = "总数{0}条&nbsp;每页{1}条&nbsp;共{2}页&nbsp;当前第{3}页";

            if (totalPages < 1)
            {
                this.lbCurrentPageText.Text = "没有可以显示的数据";
                this.txtbNum.Text = "";
            }
            else
            {
                this.lbCurrentPageText.Text = string.Format(CurrentPageText, new object[] { TotalCount, PageSize, totalPages, CurrentPage });
                this.txtbNum.Text = CurrentPage.ToString();
            }    

            if (totalPages > 1)
            {
                if (CurrentPage != 1)
                {
                    this.lnkbHome.Enabled = true;
                    this.lnkbPriv.Enabled = true;
                }
                else
                {
                    this.lnkbHome.Enabled = false;
                    this.lnkbPriv.Enabled = false;
                }
                if (CurrentPage < totalPages)
                {
                    this.lnkbNext.Enabled = true;
                    this.lnkbLast.Enabled = true;
                }
                else
                {
                    this.lnkbNext.Enabled = false;
                    this.lnkbLast.Enabled = false;
                }
                this.txtbNum.Enabled = true;
                this.lnkbGo.Enabled = true;

                //验证跳转到的值是否在正常范围内
                RangeValidator rv = new RangeValidator();
                rv.ControlToValidate = this.txtbNum.ID;
                rv.MaximumValue = totalPages.ToString();
                rv.MinimumValue = "1";
                rv.Type = ValidationDataType.Integer;
                rv.EnableClientScript = true;
                rv.ToolTip = "页号必须为数值，且位于" + rv.MinimumValue + " - " + rv.MaximumValue + "之间。";
                rv.ErrorMessage = "*";

                this.pnlValid.Controls.Add(rv);
            }
        }

        /// <summary>
        /// 禁用分页控制按钮
        /// </summary>
        private void DisableControl()
        {            
            this.lnkbHome.Enabled = false;
            this.lnkbLast.Enabled = false;
            this.lnkbNext.Enabled = false;
            this.lnkbPriv.Enabled = false;
            this.lnkbGo.Enabled = false;
            this.txtbNum.Enabled = false;
        }
        #endregion
    }
}
