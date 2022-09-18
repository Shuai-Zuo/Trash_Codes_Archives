// ******************************************************************
// 文件名:Light.EXP.Business.Dispatch.BillReturnParentBusiness.cs
// Copyright  (c)  2006-2007 ATA
// 作者:       刘道营
//5/1/as/p/x/==5=1=as-px======
// 创建日期：  2007-11-29
// 主要内容：  运输合同的业务处理类文件
// ******************************************************************

namespace Light.EXP.Business.Dispatch
{
    using System;
    using System.Data;
    using System.Data.SqlClient;
    using Light.EXP.Model.Dispatch ;
    using Light.EXP.DataAccess.Dispatch;

    public class BillReturnParentBusiness 
    {
        /// <summary>
        /// 获取多个主要城市实体, 用于配车管理模块发货地或交货地下拉框的数据绑定
        /// </summary>
        /// <returns>DataSet</returns>
        public DataSet GetDispatchCitys()
        {
            BillReturnParentInterface iBillReturnParent = DispatchFactory.CreateBillReturnParent();
            return iBillReturnParent.GetDispatchCitys();
        }

        /// <summary>
        /// 获取多个司机信息实体, 用于配车管理模块承运人下拉框的数据绑定 
        /// </summary>
        /// <returns>DataSet</returns>
        public DataSet GetDispatchDrivers()
        {
            BillReturnParentInterface iBillReturnParent = DispatchFactory.CreateBillReturnParent();
            return iBillReturnParent.GetDispatchDrivers();
        }

        /// <summary>
        /// 获取单个司机信息实体, 用于填写运输合同或编辑运输合同页面承运人下拉框的SelectIndexChanged事件处理
        /// </summary>
        /// <param name="intPKID">司机ID</param>
        /// <returns>string</returns>
        public DataTable GetDispatchDriver(int pkId)
        {
            BillReturnParentInterface iBillReturnParent = DispatchFactory.CreateBillReturnParent();
            return iBillReturnParent.GetDispatchDriver(pkId);
        }

        /// <summary>
        /// 判断运输合同主表中是否存在指定运输合同编号的记录, 用于配车管理模块增加或修改运输合同之前的逻辑判断
        /// </summary>
        /// <param name="strGoodsRevertBillCode">运输合同编号</param>
        /// <returns>bool</returns>
        public bool ExistBillReturn(string goodsRevertBillCode, int pkId)
        {
            BillReturnParentInterface iBillReturnParent = DispatchFactory.CreateBillReturnParent();
            return iBillReturnParent.ExistBillReturn(goodsRevertBillCode, pkId);

        } 
        /// <summary>
        /// 获取接货点信息, 用于增加或修改运输合同信息之前的逻辑判断
        /// </summary>
        /// <param name="goodsRevertBillCode">运输合同编号</param>
        /// <returns>string</returns>
        public string GetDispatchAcceptStation(string goodsRevertBillCode)
        {
            BillReturnParentInterface iBillReturnParent = DispatchFactory.CreateBillReturnParent();
            return iBillReturnParent.GetDispatchAcceptStation(goodsRevertBillCode);
        }

        /// <summary>
        /// 增加运输合同, 用于填写运输合同页面添加按钮的单击事件处理
        /// </summary>
        /// <param name="billReturnParent">运输合同实体</param>
        /// <returns>int</returns>
        public int CreateBillReturn(BillReturnParent billReturnParent)
        {
            BillReturnParentInterface iBillReturnParent = DispatchFactory.CreateBillReturnParent();
            return iBillReturnParent.CreateBillReturn(billReturnParent);
        }

        /// <summary>
        /// 修改运输合同, 用于编辑运输合同页面修改按钮的单击事件处理
        /// </summary>
        /// <param name="billReturnParent">运输合同实体</param>
        /// <returns>bool</returns>
        public bool UpdateBillReturn(BillReturnParent billReturnParent)
        {
            BillReturnParentInterface iBillReturnParent = DispatchFactory.CreateBillReturnParent();
            return iBillReturnParent.UpdateBillReturn(billReturnParent);
        }

        /// <summary>
        /// 判断运输合同详表中是否存在指定运输合同编号的货物信息, 用于配车管理模块删除运输合同之前的逻辑判断
        /// </summary>
        /// <param name="goodsRevertBillPKID">运输合同ID</param>
        /// <returns>bool</returns>
        public bool ExistDispatchGoods(int goodsRevertBillPKID)
        {
            BillReturnParentInterface iBillReturnParent = DispatchFactory.CreateBillReturnParent();
            return iBillReturnParent.ExistDispatchGoods(goodsRevertBillPKID);
        }
 
        /// <summary>
        /// 删除运输合同, 用于编辑运输合同页面删除按钮的单击事件处理
        /// </summary>
        /// <param name="pkId">运输合同ID</param>
        /// <returns>bool</returns>
        public bool DeleteBillReturn(int pkId)
        {
            BillReturnParentInterface iBillReturnParent = DispatchFactory.CreateBillReturnParent();
            return iBillReturnParent.DeleteBillReturn(pkId);
        }

        /// <summary>
        /// 获取多个运输合同实体, 用于运输合同信息查询页面GridView的数据绑定
        /// </summary>
        /// <param name="backBillState">运输合同状态</param>
        /// <param name="driverName">司机名称</param>
        /// <param name="goodsRevertBillCode">运输合同编号</param>
        /// <param name="beginSignTime">签订起始时间</param>
        /// <param name="endSignTime">签订起始时间</param>
        /// <returns>DataSet</returns>
        public DataSet GetBillReturns(string backBillState, string driverName, string goodsRevertBillCode, DateTime beginSignTime, DateTime endSignTime, int pageIndex, int pageSize, ref Int64 recordCount)
        {
            BillReturnParentInterface iBillReturnParent = DispatchFactory.CreateBillReturnParent();
            return iBillReturnParent.GetBillReturns(backBillState, driverName, goodsRevertBillCode, beginSignTime, endSignTime, pageIndex, pageSize, ref recordCount);
        }

        /// <summary>
        /// 获取单个运输合同实体, 用于编辑运输合同页面表单的数据填充
        /// </summary>
        /// <param name="pkId">运输合同ID<</param>
        /// <returns>实体BillReturnParent</returns>
        public BillReturnParent GetBillReturn(int pkId)
        {
            BillReturnParentInterface iBillReturnParent = DispatchFactory.CreateBillReturnParent();
            return iBillReturnParent.GetBillReturn(pkId);
        }

        /// <summary>
        /// 查询出刚刚插入的运输合同的pkId, 用于由编辑运输合同页面向运输货物信息编辑(查看)页面的参数传递
        /// </summary>     
        /// <returns>bool</returns>
        public int GetBillRenturnPKID()
        {
            BillReturnParentInterface iBillReturnParent = DispatchFactory.CreateBillReturnParent();
            return iBillReturnParent.GetBillRenturnPKID();
        }
    }
}
