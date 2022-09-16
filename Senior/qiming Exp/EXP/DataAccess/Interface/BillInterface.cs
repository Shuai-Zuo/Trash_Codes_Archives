namespace Light.EXP.DataAccess.Bill{
    using System;
    using System.Data;

    using Light.EXP.Model.Bill;

    public interface BillInterface{
        //获取多个票据分发实体
        DataSet GetBillDispenses(string receiveBillPerson, string billType, int pageIndex, int pageSize, ref Int64 recordCount);
        //获取单个票据分发实体
        BillDispense GetBillDispense(int pkId);
        //增加票据分发信息
        int CreateBillDispense(BillDispense billDispense);
        //修改票据分发信息
        bool UpdateBillDispense(BillDispense billDispense);
        //删除票据分发信息
        bool DeleteBillDispense(int pkId);
        //判断指定票据类型的票据开始号或票据结束号在票据分发表中是否存在
        bool ExistBillDispense(string billCode, string billType, DateTime receiveBillTime);
        //获取多个票据明细实体
        DataSet GetBillDetails(string billCode, string billType, string billStatus, DateTime beginWriteDate, DateTime endWriteDate, int pageIndex, int pageSize, ref Int64 recordCount);
        //获取多个员工信息实体
        DataSet GetBillEmployees();
    }
}
