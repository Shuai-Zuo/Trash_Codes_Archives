namespace Light.EXP.WebUI.Bill
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

    using Light.EXP.Business.Bill;
    using Light.EXP.Model.Bill;
    using Light.EXP.SystemFrameworks;
    using Light.EXP.WebUI.SystemFrame;

   public partial class BillDispenseUpdate : PageBase 
   {
        protected void Page_Load(object sender, EventArgs e)
        {
            /// <summary>
            /// 页面载入
            /// </summary>
            /// <param name="sender"></param>
            /// <param name="e"></param>
            if (!IsPostBack)
            {
                // 获取从票据分发查询页面传递过来的变量值
                int pkId = Int32.Parse(Request.QueryString[0].ToString());
                ViewState["pkId"] = pkId;

                //绑定下拉框
                BindBillDispensePersonsInfor();

                // 声明票据处理类对象
                BillBusiness billBusiness = new BillBusiness();

                // 根据PKID获取票据实体
                BillDispense bill = new BillDispense();
                bill = billBusiness.GetBillDispense(Int32.Parse(ViewState["pkId"].ToString()));

                // 用取得的票据DataTable填充表单
                this.drdlBillType.SelectedItem.Text = bill.BillType;
                this.txtbBillStartCode.Text = bill.BillStartCode;
                this.txtbBillEndCode.Text = bill.BillEndCode;                
                this.drdlReceiveBillPerson.SelectedValue = bill.ReceiveBillPerson;
                this.txtbAcceptStation.Text = bill.AcceptStation;
                if (bill.ReceiveBillTime == DateTime.MinValue)
                    this.txtbReceiveBillTime.Text = string.Empty;
                else
                    this.txtbReceiveBillTime.Text = bill.ReceiveBillTime.ToShortDateString();
                this.drdlReleasePerson.SelectedValue = bill.ReleasePerson;                

                //增加删除确认提示
                this.imgbDelete.Attributes.Add("onclick", "javascript:return confirm('您确实要删除该记录吗？'); ");
            }
        }

        /// <summary>
        /// 绑定有关票据人员信息
        /// </summary>
        private void BindBillDispensePersonsInfor()
        {
            // 声明票据业务类对象
            BillBusiness billBusiness = new BillBusiness();
            drdlReceiveBillPerson.DataTextField = "Employee";
            drdlReceiveBillPerson.DataValueField = "Employee";
            drdlReceiveBillPerson.DataSource = billBusiness.GetBillEmployees();
            drdlReceiveBillPerson.DataBind();
            drdlReceiveBillPerson.Items.Insert(0, new ListItem("[请选择]", ""));
            drdlReleasePerson.DataTextField = "Employee";
            drdlReleasePerson.DataValueField = "Employee";
            drdlReleasePerson.DataSource = billBusiness.GetBillEmployees();
            drdlReleasePerson.DataBind();
            drdlReleasePerson.Items.Insert(0, new ListItem("[请选择]", ""));
        }

        /// <summary>
        /// 修改按钮单击事件
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
       protected void imgbModify_Click(object sender, ImageClickEventArgs e)
       {
           // 声明票据实体类对象

           BillDispense billDispense = new BillDispense();

           // 为票据实体类对象的各个属性赋值

           billDispense.PKId = Int32.Parse(ViewState["pkId"].ToString());
           billDispense.ReceiveBillPerson = this.drdlReceiveBillPerson.SelectedValue;
           billDispense.AcceptStation = this.txtbAcceptStation.Text;               
           billDispense.ReleasePerson = this.drdlReleasePerson.SelectedValue;

           // 声明票据业务类对象

           BillBusiness billBusiness = new BillBusiness();

           // 修改票据分发信息
           if(billBusiness.UpdateBillDispense(billDispense) == true)
           {
               Response.Redirect("BillDispenseList.aspx");
           }
           else
           {
               Utility.AlertMsg(this, "修改票据分发信息失败");
           }
       }

       /// <summary>
       /// 删除按钮单击事件
       /// </summary>
       /// <param name="sender"></param>
       /// <param name="e"></param>
       protected void imgbDelete_Click(object sender, ImageClickEventArgs e)
       {
           // 声明票据业务类对象
           BillBusiness billBusiness = new BillBusiness();

           // 删除票据分发信息
           if (billBusiness.DeleteBillDispense(Int32.Parse(ViewState["pkId"].ToString())) == true)
           {              
               Response.Redirect("BillDispenseList.aspx");
           }
           else
           {
               Utility.AlertMsg(this, "删除票据分发信息失败！");
           }
		}

        /// <summary>
        /// 取消按钮单击事件
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void imgbCancel_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("BillDispenseList.aspx");
        }
    }
}


