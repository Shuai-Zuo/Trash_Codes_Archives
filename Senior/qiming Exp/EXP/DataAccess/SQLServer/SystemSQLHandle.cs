// ******************************************************************
// 文件名: Light.EXP.DataAccess.SystemFrame.SystemSQLHandle.cs
// Copyright  (c)  2006-2007 ATA
// 作者:       叶常达
// 创建日期：  2007-11-14
// 主要内容：  系统框架的数据访问类文件
// ******************************************************************

namespace Light.EXP.DataAccess.SystemFrame
{
    using System.Data;
    using System.Data.SqlClient;

    public class SystemSQLHandle : SystemInterface
    {
        /// <summary>
        /// 登录验证
        /// </summary>
        /// <param name="loginId">登录ID</param>
        /// <param name="passowrd">密码</param>
        /// <returns>bool</returns>
        public bool ValidateUser(string loginId, string password)
        {
            SQLHelper helper = new SQLHelper();
            SqlParameter[] prams = {
										new SqlParameter("@loginID", SqlDbType.NVarChar, 20),
										new SqlParameter("@password", SqlDbType.NVarChar, 40)
								   };
            prams[0].Value = loginId;
            prams[1].Value = password;
            return helper.ExecuteNonQuery("uspValidateUser", prams) == 1 ? true : false;
        }

        /// <summary>
        /// 权限控制
        /// </summary>
        /// <param name="loginId">登录ID</param>
        /// <param name="pageName">页面名称</param>
        /// <returns></returns>
        public bool CheckRight(string loginId, string pageName)
        {
            SQLHelper helper = new SQLHelper();
            SqlParameter[] prams = {
										new SqlParameter("@loginID", SqlDbType.NVarChar, 20),
										new SqlParameter("@pageName", SqlDbType.NVarChar, 40)
								   };
            prams[0].Value = loginId;
            prams[1].Value = pageName;
            return helper.ExecuteNonQuery("uspCheckRight", prams) == 1 ? true : false;
        }
    }
}
