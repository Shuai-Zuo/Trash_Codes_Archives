namespace Light.EXP.DataAccess.Bill{
    using System;
    using System.Data;
    using System.Data.SqlClient;

    using Light.EXP.Model.Bill;
    using Light.EXP.DataAccess.SystemFrame;
    using Light.EXP.SystemFrameworks;

    public class BillSQLHandle : BillInterface {
        //获取多个票据分发实体
        public DataSet GetBillDispenses(string receiveBillPerson, string billType, int pageIndex, int pageSize, ref Int64 recordCount){
            SQLHelper helper = new SQLHelper();
            SqlParameter[] prams = {
			    new SqlParameter("@receiveBillPerson", SqlDbType.NVarChar, 50),
			    new SqlParameter("@billType", SqlDbType.NVarChar, 50),
                new SqlParameter("@pageIndex", SqlDbType.Int, 4),
                new SqlParameter("@pageSize", SqlDbType.Int, 4),
                new SqlParameter("@recordCount", SqlDbType.Int, 4)
			};
            prams[0].Value = receiveBillPerson;
            prams[1].Value = billType;
            prams[2].Value = pageIndex;
            prams[3].Value = pageSize;
            prams[4].Direction = ParameterDirection.Output;
            DataSet ds = helper.ExecuteDataSet("uspGetBillDispenses", prams);
            recordCount = int.Parse(prams[4].Value.ToString());

            return ds;
        }

        //获取单个票据分发实体
        public BillDispense GetBillDispense(int pkId){
            SQLHelper helper = new SQLHelper();
            SqlDataReader dr = null;
            SqlParameter[] prams = {
                new SqlParameter("@PKID", SqlDbType.Int, 4)
            };
            prams[0].Value = pkId;
            dr = helper.ExecuteDataReader("uspGetBillDispense", prams);
            BillDispense billDispense = new BillDispense();
            if (dr.Read()){
                billDispense.BillType = dr["BillType"] == System.DBNull.Value ? "" : dr["BillType"].ToString();
                billDispense.BillStartCode = dr["BillStartCode"] == System.DBNull.Value ? "" : dr["BillStartCode"].ToString();
                billDispense.BillEndCode = dr["BillEndCode"] == System.DBNull.Value ? "" : dr["BillEndCode"].ToString();
                billDispense.ReceiveBillPerson = dr["ReceiveBillPerson"] == System.DBNull.Value ? "" : dr["ReceiveBillPerson"].ToString();
                billDispense.AcceptStation = dr["AcceptStation"] == System.DBNull.Value ? "" : dr["AcceptStation"].ToString();
                DateTime receivebilltime;
                if (dr["ReceiveBillTime"] == System.DBNull.Value){
                    DateTime.TryParse("", out receivebilltime);
                }
                else{
                    receivebilltime = Convert.ToDateTime(dr["ReceiveBillTime"].ToString());
                }
                billDispense.ReceiveBillTime = receivebilltime;
                billDispense.ReleasePerson = dr["ReleasePerson"] == System.DBNull.Value ? "" : dr["ReleasePerson"].ToString();
            }
            return billDispense;
        }
        //增加票据分发信息
        public int CreateBillDispense(BillDispense billDispense){
            SQLHelper helper = new SQLHelper();
            SqlParameter[] prams = {
                new SqlParameter("@billType", SqlDbType.NVarChar,50), 
                new SqlParameter("@billStartCode", SqlDbType.NVarChar, 50),
                new SqlParameter("@billEndCode", SqlDbType.NVarChar, 50),
                new SqlParameter("@receiveBillPerson", SqlDbType.NVarChar, 50),
                new SqlParameter("@acceptStation",SqlDbType.VarChar,50),
                new SqlParameter("@receiveBillTime",SqlDbType.DateTime,8),
                new SqlParameter("@releasePerson",SqlDbType.VarChar,50),
                new SqlParameter("@PKID", SqlDbType.Int, 4)
            };
            prams[0].Value = billDispense.BillType;
            prams[1].Value = billDispense.BillStartCode;
            prams[2].Value = billDispense.BillEndCode;
            prams[3].Value = billDispense.ReceiveBillPerson;
            prams[4].Value = billDispense.AcceptStation;
            prams[5].Value = Utility.ParseDateTime(billDispense.ReceiveBillTime);
            prams[6].Value = billDispense.ReleasePerson;
            prams[7].Direction = ParameterDirection.Output;

            helper.ExecuteNonQuery("uspCreateBillDispense", prams);
            return Convert.ToInt32(prams[7].Value.ToString());
        }

        //修改票据分发信息
        public bool UpdateBillDispense(BillDispense billDispense){
            SQLHelper helper = new SQLHelper();
            SqlParameter[] prams = {
                new SqlParameter("@PKID", SqlDbType.Int, 4),									       
                new SqlParameter("@receiveBillPerson", SqlDbType.NVarChar, 50),
                new SqlParameter("@acceptStation",SqlDbType.VarChar, 50),
                new SqlParameter("@releasePerson",SqlDbType.VarChar, 50)
            };
            prams[0].Value = billDispense.PKId;                
            prams[1].Value = billDispense.ReceiveBillPerson;
            prams[2].Value = billDispense.AcceptStation;                
            prams[3].Value = billDispense.ReleasePerson;

            return helper.ExecuteNonQuery("uspUpdateBillDispense", prams) == 0 ? true : false;
        }
        //删除票据分发信息
        public bool DeleteBillDispense(int pkId)
        {
            SQLHelper helper = new SQLHelper();
            SqlParameter[] prams = {
                new SqlParameter("@PKID", SqlDbType.Int, 4)
            };
            prams[0].Value = pkId;

            return helper.ExecuteNonQuery("uspDeleteBillDispense", prams) == 0 ? true : false;
        }
        //判断指定票据类型的票据开始号或票据结束号在票据分发表中是否存在
        public bool ExistBillDispense(string billCode, string billType, DateTime receiveBillTime){
            SQLHelper helper = new SQLHelper();
            SqlParameter[] prams = {
                new SqlParameter("@billCode", SqlDbType.NVarChar, 50),
                new SqlParameter("@billType", SqlDbType.NVarChar, 50),
                new SqlParameter("@receiveBillTime", SqlDbType.DateTime)
            };
            prams[0].Value = billCode;
            prams[1].Value = billType;
            prams[2].Value = receiveBillTime;

            return helper.ExecuteNonQuery("uspExistBillDispense", prams) != 0 ? true : false;
        }
        //获取多个票据明细实体
        public DataSet GetBillDetails(string billCode, string billType, string billStatus, DateTime beginWriteDate, DateTime endWriteDate, int pageIndex, int pageSize, ref Int64 recordCount){
            SQLHelper helper = new SQLHelper();
            SqlParameter[] prams = {
                new SqlParameter("@billCode", SqlDbType.NVarChar, 50),
                new SqlParameter("@billType", SqlDbType.NVarChar, 50),
                new SqlParameter("@billStatus", SqlDbType.NVarChar, 50),
                new SqlParameter("@beginWriteDate", SqlDbType.DateTime, 8),
                new SqlParameter("@endWriteDate", SqlDbType.DateTime, 8),
                new SqlParameter("@pageIndex", SqlDbType.Int, 4),
                new SqlParameter("@pageSize", SqlDbType.Int, 4),
                new SqlParameter("@recordCount", SqlDbType.Int, 4)
            };
            prams[0].Value = billCode;
            prams[1].Value = billType;
            prams[2].Value = billStatus;
            prams[3].Value = Utility.ParseDateTime(beginWriteDate);
            prams[4].Value = Utility.ParseDateTime(endWriteDate);
            prams[5].Value = pageIndex;
            prams[6].Value = pageSize;
            prams[7].Direction = ParameterDirection.Output;
            DataSet ds = helper.ExecuteDataSet("uspGetBillDetails", prams);
            recordCount = int.Parse(prams[7].Value.ToString());

            return ds;
        }
        //获取多个员工信息实体
        public DataSet GetBillEmployees(){
            SQLHelper helper = new SQLHelper();
            DataSet ds = helper.ExecuteDataSet("uspGetBillEmployees", null);
            return ds;
        }
    }
}
