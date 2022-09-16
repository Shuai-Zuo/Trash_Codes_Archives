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

    public partial class BillDispenseCreate : PageBase
    {
        /// <summary>
        /// 页面载入
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void Page_Load(object sender, EventArgs e)
        {            
            if (!IsPostBack)
            { 
                BindBillDispensePersonsInfor();
            }
        }

        /// <summary>
        /// 绑定有关票据人员信息
        /// </summary>
        private void BindBillDispensePersonsInfor()
        {
            // 声明票据业务类对象

            BillBusiness billBusiness = new BillBusiness();

            // 绑定领票人下拉框
            drdlReceiveBillPerson.DataTextField = "Employee";
            drdlReceiveBillPerson.DataValueField = "Employee";
            drdlReceiveBillPerson.DataSource = billBusiness.GetBillEmployees();
            drdlReceiveBillPerson.DataBind();
            drdlReceiveBillPerson.Items.Insert(0, new ListItem("[请选择]", ""));

            // 绑定分发人下拉框
            drdlReleasePerson.DataTextField = "Employee";
            drdlReleasePerson.DataValueField = "Employee";
            drdlReleasePerson.DataSource = billBusiness.GetBillEmployees();
            drdlReleasePerson.DataBind();
            drdlReleasePerson.Items.Insert(0, new ListItem("[请选择]", ""));
        }

        ///<summary>
        /// 添加按钮单击事件
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void imgbCreate_Click(object sender, ImageClickEventArgs e)
        {
            if (Int32.Parse(txtbBillStartCode.Text) > Int32.Parse(txtbBillEndCode.Text))
            {
                Utility.AlertMsg(this.Page, "单据开始号必须小于单据结束号！");
                return;
            }

            // 声明票据实体类对象

            BillDispense bill = new BillDispense();

            // 为票据实体类对象的各个属性赋值

            bill.BillType = drdlBillType.SelectedItem.Text;
            bill.BillStartCode = txtbBillStartCode.Text;
            bill.BillEndCode = txtbBillEndCode.Text;
            bill.ReceiveBillPerson = drdlReceiveBillPerson.SelectedValue;
            bill.AcceptStation = txtbAcceptStation.Text;
            bill.ReceiveBillTime = Utility.ToDateTime(txtbReceiveBillTime.Text);
            bill.ReleasePerson = drdlReleasePerson.SelectedValue;

            // 声明票据业务类对象

            BillBusiness billBusiness = new BillBusiness();

            // 增加票据分发信息
            int rtnCode=billBusiness.CreateBillDispense(bill);
            if (rtnCode > 0)
            {
                 Response.Redirect("BillDispenseList.aspx");
            }
            else
            {
                string errorMessage="";
                switch (rtnCode)
                { 
                    case 0:
                        errorMessage = "增加票据分发信息操作失败! "; 
                        break;
                    case -1:
                        errorMessage = "票据开始编号已经存在！"; 
                        break;
                    case -2:
                        errorMessage = "票据结束编号已经存在！"; 
                        break;
                }

                Utility.AlertMsg(this, errorMessage);
            }
        }

        /// <summary>
        /// 取消按钮单击事件
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void imgbCancel_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("BillDispenseCreate.aspx");
        }
    }
}



