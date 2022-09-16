namespace Light.EXP.Business.Bill
{
    using System;
    using System.Data;
    using Light.EXP.Model.Bill;
    using Light.EXP.DataAccess.Bill;

    public class BillBusiness{
        public DataSet GetBillDispenses(string receiveBillPerson, string billType, int pageIndex, int pageSize, ref Int64 recordCount){
            BillInterface iBill = BillFactory.Create();
            return iBill.GetBillDispenses(receiveBillPerson, billType, pageIndex, pageSize, ref recordCount);
        }

        public BillDispense GetBillDispense(int pkId){
            BillInterface iBill = BillFactory.Create();
            return iBill.GetBillDispense(pkId);
        }

        public int CreateBillDispense(BillDispense billDispense){
            BillInterface iBill = BillFactory.Create();

            if (this.ExistBillDispense(billDispense.BillStartCode, billDispense.BillType, billDispense.ReceiveBillTime) == true){
                return -1;
            }

            if (this.ExistBillDispense(billDispense.BillEndCode, billDispense.BillType, billDispense.ReceiveBillTime) == true){
                return -2;
            }

            return iBill.CreateBillDispense(billDispense);
        }
        
        public bool UpdateBillDispense(BillDispense billDispense){
            BillInterface iBill = BillFactory.Create();
            return iBill.UpdateBillDispense(billDispense);
        }
        
        public bool DeleteBillDispense(int pkId){
            BillInterface iBill = BillFactory.Create();
            return iBill.DeleteBillDispense(pkId);
        }
        
        public bool ExistBillDispense(string billCode, string billType, DateTime receiveBillTime){
            BillInterface iBill = BillFactory.Create();
            return iBill.ExistBillDispense(billCode, billType, receiveBillTime);
        }
        
        public DataSet GetBillDetails(string billCode, string billType, string billStatus, DateTime beginWriteDate, DateTime endWriteDate, int pageIndex, int pageSize, ref Int64 recordCount){
            BillInterface iBill = BillFactory.Create();
            return iBill.GetBillDetails(billCode, billType, billStatus, beginWriteDate, endWriteDate, pageIndex, pageSize, ref recordCount);
        }

        public DataSet GetBillEmployees(){
            BillInterface iBill = BillFactory.Create();
            return iBill.GetBillEmployees();
        }
    }
}
