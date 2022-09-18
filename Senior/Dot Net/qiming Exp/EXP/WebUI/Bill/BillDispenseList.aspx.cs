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

   public partial class BillDispenseList : PageBase
   {
       /// <summary>
       /// 页面载入
       /// </summary>
       /// <param name="sender"></param>
       /// <param name="e"></param>
       protected void Page_Load(object sender, EventArgs e)
       {
           BindGridView();
       }

       /// <summary>
       /// 每个需要分页查询的页面都需要实现此方法
       /// 此方法为分页控件提供分页数据的读取．
       /// </summary>
       /// <param name="pageIndex">当前要读取的页, 从１开始</param>
       /// <param name="recordCount">总的数据行数(不分页时)</param>
       /// <returns>一页数据</returns>
       private DataSet GetPagerData(int pageIndex, ref Int64 recordCount)
       {
           string billStatus = drdlBillStatus.SelectedItem.Text == "[全部]" ? "" : drdlBillStatus.SelectedItem.Text;
           string receiveBillPerson = txtbReceiveBillPerson.Text;

           // 获取数据源
           BillBusiness billBusiness = new BillBusiness();
           int pageSize = 10;           
           DataSet dsBill = billBusiness.GetBillDispenses(receiveBillPerson, billStatus, pageIndex, pageSize, ref recordCount);
           return dsBill;
       }

       /// <summary>
       /// 绑定票据分发列表
       /// </summary>
       private void BindGridView()
       {
           int pageSize = 10;      
           this.dtpBillDepense.BindDataPage(this.GetPagerData, pageSize);
       }

       ///<summary>
       /// 搜索按钮单击事件
       /// </summary>
       /// <param name="sender"></param>
       /// <param name="e"></param>
       protected void imgbQuery_Click(object sender, ImageClickEventArgs e)
       {
          BindGridView();
       }
    }
}

