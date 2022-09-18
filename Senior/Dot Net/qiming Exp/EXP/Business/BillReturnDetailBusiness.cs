// ******************************************************************
// 文件名:Light.EXP.Business.Dispatch.BillReturnParentBusiness.cs
// Copyright  (c)  2006-2007 ATA
// 作者:       刘道营
// 创建日期：  2007-11-29
// 主要内容：  运输合同的运输货物的业务处理类文件
// ******************************************************************

namespace Light.EXP.Business.Dispatch
{
    using System;
    using System.Data;
    using System.Data.SqlClient;

    using Light.EXP.Model.Dispatch;
    using Light.EXP.DataAccess.Dispatch;

    public class BillReturnDetailBusiness: BillReturnDetailInterface
    {
        /// <summary>
        /// 获取多个已装货物实体, 用于运输货物信息编辑页面已装货物列表的绑定
        /// </summary>
        /// <param name="intGoodsRevertBillPKID">运输合同ID</param>
        /// <returns>DataSet</returns>
        public DataSet GetLoadedGoods(int goodsRevertBillPKID)
        {
            BillReturnDetailInterface iBillReturnDetail = DispatchFactory.CreateBillReturnDetail();
            return iBillReturnDetail.GetLoadedGoods(goodsRevertBillPKID);
        }

        /// <summary>
        /// 获取多个待装货物实体, 用于运输货物信息编辑页面待装货物列表的绑定
        /// </summary>
        /// <param name="strSendGoodsAddr">起点</param>
        /// <param name="strReceiveGoodsAddr">终点</param>
        /// <returns>DataSet</returns>
        public DataSet GetUnloadGoods(string sendGoodsAddr, string receiveGoodsAddr)
        {
            BillReturnDetailInterface iBillReturnDetail = DispatchFactory.CreateBillReturnDetail();
            return iBillReturnDetail.GetUnloadGoods(sendGoodsAddr, receiveGoodsAddr);
        }

        /// <summary>
        /// 装(卸)货, 用于运输货物信息编辑页面装车(卸货)按钮的单击事件处理
        /// </summary>
        /// <param name="BillReturnDetail">运输货物实体</param>
        /// <returns>bool</returns>
        public bool LoadGood(BillReturnDetail billReturnDetail)
        {
            BillReturnDetailInterface iBillReturnDetail = DispatchFactory.CreateBillReturnDetail();
            return iBillReturnDetail.LoadGood(billReturnDetail);
        }

        /// <summary>
        /// 发货, 用于运输货物信息编辑页面装车发货按钮的单击事件处理
        /// </summary>
        /// <param name="intGoodsRevertBillPKID">运输合同ID</param>
        /// <param name="strGoodsBillCodes">货运单编号字符串</param>
        /// <returns>bool</returns>
        public bool TransportGood(int goodsRevertBillPKID, string goodsBillCodes)
        {
            BillReturnDetailInterface iBillReturnDetail = DispatchFactory.CreateBillReturnDetail();
            return iBillReturnDetail.TransportGood(goodsRevertBillPKID, goodsBillCodes);
        }

        /// <summary>
        /// 判断该运输合同司机是否为空值, 在this.TransportGood()方法调用之前调用
        /// </summary>
        /// <param name="pkId">运输合同pkId</param>
        /// <returns>bool</returns>
        public bool ExistDriver(int pkId)
        {
            BillReturnDetailInterface iBillReturnDetail = DispatchFactory.CreateBillReturnDetail();
            return iBillReturnDetail.ExistDriver(pkId);
        }
    }
}
