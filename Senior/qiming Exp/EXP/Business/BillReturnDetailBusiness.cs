// ******************************************************************
// �ļ���:Light.EXP.Business.Dispatch.BillReturnParentBusiness.cs
// Copyright  (c)  2006-2007 ATA
// ����:       ����Ӫ
// �������ڣ�  2007-11-29
// ��Ҫ���ݣ�  �����ͬ����������ҵ�������ļ�
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
        /// ��ȡ�����װ����ʵ��, �������������Ϣ�༭ҳ����װ�����б�İ�
        /// </summary>
        /// <param name="intGoodsRevertBillPKID">�����ͬID</param>
        /// <returns>DataSet</returns>
        public DataSet GetLoadedGoods(int goodsRevertBillPKID)
        {
            BillReturnDetailInterface iBillReturnDetail = DispatchFactory.CreateBillReturnDetail();
            return iBillReturnDetail.GetLoadedGoods(goodsRevertBillPKID);
        }

        /// <summary>
        /// ��ȡ�����װ����ʵ��, �������������Ϣ�༭ҳ���װ�����б�İ�
        /// </summary>
        /// <param name="strSendGoodsAddr">���</param>
        /// <param name="strReceiveGoodsAddr">�յ�</param>
        /// <returns>DataSet</returns>
        public DataSet GetUnloadGoods(string sendGoodsAddr, string receiveGoodsAddr)
        {
            BillReturnDetailInterface iBillReturnDetail = DispatchFactory.CreateBillReturnDetail();
            return iBillReturnDetail.GetUnloadGoods(sendGoodsAddr, receiveGoodsAddr);
        }

        /// <summary>
        /// װ(ж)��, �������������Ϣ�༭ҳ��װ��(ж��)��ť�ĵ����¼�����
        /// </summary>
        /// <param name="BillReturnDetail">�������ʵ��</param>
        /// <returns>bool</returns>
        public bool LoadGood(BillReturnDetail billReturnDetail)
        {
            BillReturnDetailInterface iBillReturnDetail = DispatchFactory.CreateBillReturnDetail();
            return iBillReturnDetail.LoadGood(billReturnDetail);
        }

        /// <summary>
        /// ����, �������������Ϣ�༭ҳ��װ��������ť�ĵ����¼�����
        /// </summary>
        /// <param name="intGoodsRevertBillPKID">�����ͬID</param>
        /// <param name="strGoodsBillCodes">���˵�����ַ���</param>
        /// <returns>bool</returns>
        public bool TransportGood(int goodsRevertBillPKID, string goodsBillCodes)
        {
            BillReturnDetailInterface iBillReturnDetail = DispatchFactory.CreateBillReturnDetail();
            return iBillReturnDetail.TransportGood(goodsRevertBillPKID, goodsBillCodes);
        }

        /// <summary>
        /// �жϸ������ͬ˾���Ƿ�Ϊ��ֵ, ��this.TransportGood()��������֮ǰ����
        /// </summary>
        /// <param name="pkId">�����ͬpkId</param>
        /// <returns>bool</returns>
        public bool ExistDriver(int pkId)
        {
            BillReturnDetailInterface iBillReturnDetail = DispatchFactory.CreateBillReturnDetail();
            return iBillReturnDetail.ExistDriver(pkId);
        }
    }
}
