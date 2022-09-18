// ******************************************************************
// 文件名: Light.EXP.DataAccess.User.UserSQLHandle.cs
// Copyright  (c)  2006-2007 ATA
// 作者:       叶常达
// 创建日期：  2007-10-17
// 主要内容：  用户管理的数据访问类文件
// ******************************************************************

namespace Light.EXP.DataAccess.User
{
    using System;
    using System.Data;
    using System.Data.SqlClient;
    using Light.EXP.Model.User;
    using Light.EXP.DataAccess.SystemFrame;

    public class UserSQLHandle : UserInterface
	{
		/// <summary>
        /// 获取多个用户实体
		/// </summary>
		/// <param name="userName">用户名称</param>
		/// <param name="sex">性别</param>
		/// <param name="sortField">排序字段</param>
		/// <param name="sortOrder">排序次序</param>
        /// <param name="pageIndex">待读取的页索引</param>
        /// <param name="pageSize">每页显示的记录数</param>
        /// <param name="recordCount">总记录数</param>
		/// <returns>DataSet</returns>
        public DataSet GetUsers(string userName, int sex, string sortField, string sortOrder, int pageIndex, int pageSize, ref Int64 recordCount)
		{
			SQLHelper helper = new SQLHelper();
			SqlParameter[] prams = {
									   new SqlParameter("@userName", SqlDbType.NVarChar, 40),
									   new SqlParameter("@sex", SqlDbType.TinyInt, 1),
									   new SqlParameter("@sortField", SqlDbType.NVarChar, 255),
									   new SqlParameter("@sortOrder", SqlDbType.NVarChar, 40),
                                       new SqlParameter("@pageIndex", SqlDbType.Int, 4),
                                       new SqlParameter("@pageSize", SqlDbType.Int, 4),
                                       new SqlParameter("@recordCount", SqlDbType.Int, 4)
								   };
			prams[0].Value = userName;
			prams[1].Value = sex;
			prams[2].Value = sortField;
			prams[3].Value = sortOrder;
            prams[4].Value = pageIndex;
            prams[5].Value = pageSize;
            prams[6].Direction = ParameterDirection.Output;
			DataSet ds = helper.ExecuteDataSet("uspGetUsers",prams);
            recordCount = int.Parse(prams[6].Value.ToString());
            return ds;
		}

		/// <summary>
        /// 获取单个用户实体
		/// </summary>
        /// <param name="loginId">登录Id</param>
		/// <returns>User实体</returns>
        public Users GetUser(string loginId)
		{
			SQLHelper helper = new SQLHelper();
			SqlDataReader dr = null;
			SqlParameter[] prams = {
									   new SqlParameter("@loginId", SqlDbType.NVarChar, 20)
								   };
            prams[0].Value = loginId;
			dr = helper.ExecuteDataReader("uspGetUser",prams);

            Users user = new Users();

            if (dr.Read())
            {                
                user.LoginId = dr["LoginId"].ToString();
                user.UserName = dr["Username"].ToString();
                user.Sex = int.Parse(dr["Sex"].ToString());
                if (dr["Birthday"] == System.DBNull.Value)
                    user.Birthday = Convert.ToDateTime("1900-1-1");
                else
                    user.Birthday = Convert.ToDateTime(dr["Birthday"].ToString());
            }
            
            return user;           
		}
		
		/// <summary>
        /// 增加用户
		/// </summary>
		/// <param name="users">用户实体</param>
		/// <returns>bool</returns>
		public bool CreateUser(Users user)
		{
			SQLHelper helper = new SQLHelper();
			SqlParameter[] prams = {
                                        new SqlParameter("@loginId", SqlDbType.NVarChar,20), 
                                        new SqlParameter("@userName", SqlDbType.NVarChar, 40),
                                        new SqlParameter("@sex", SqlDbType.TinyInt, 1),
                                        new SqlParameter("@birthday", SqlDbType.DateTime, 40)
                                    };
            prams[0].Value = user.LoginId;
			prams[1].Value = user.UserName;
			prams[2].Value = user.Sex;
			prams[3].Value = user.Birthday;

            return helper.ExecuteNonQuery("uspCreateUser", prams) == 0 ? true : false;
		}
		
		/// <summary>
        /// 修改用户
		/// </summary>
		/// <param name="users">用户实体</param>
		/// <returns>bool</returns>
		public bool UpdateUser(Users user)
		{
            SQLHelper helper = new SQLHelper();
			SqlParameter[] prams = {
									   new SqlParameter("@loginId", SqlDbType.NVarChar,20), 
									   new SqlParameter("@userName", SqlDbType.NVarChar, 40),
									   new SqlParameter("@sex", SqlDbType.TinyInt, 1),
									   new SqlParameter("@birthday", SqlDbType.DateTime, 40)
								   };
			prams[0].Value = user.LoginId;
			prams[1].Value = user.UserName;
			prams[2].Value = user.Sex;
			prams[3].Value = user.Birthday;
			return helper.ExecuteNonQuery("uspUpdateUser",prams) == 0 ? true : false;
		}

		/// <summary>
        /// 删除用户
		/// </summary>
        /// <param name="loginId">登录ID</param>
		/// <returns>bool</returns>
		public bool DeleteUser(string loginId)
		{ 
			SQLHelper helper = new SQLHelper();
			SqlParameter[] prams = {
									   new SqlParameter("@loginId", SqlDbType.NVarChar, 20)
								   };
            prams[0].Value = loginId;
			return helper.ExecuteNonQuery("uspDeleteUser",prams) == 0 ? true : false;
		}

        /// <summary>
        /// 批量删除多个用户
        /// </summary>
        /// <param name="loginIds"></param>
        public void BatchDeleteUsers(string loginIds)
        {
            SQLHelper helper = new SQLHelper();
            string selectCommandText = "SELECT * FROM Account_Users";
            string deleteCommandText = "DELETE Account_Users WHERE LoginID IN " + loginIds;
            helper.BatchDelete(selectCommandText, deleteCommandText, 10);
        }
	}
}
