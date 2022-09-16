// ******************************************************************
// 文件名: Light.EXP.DataAccess.User.UserInterface.cs
// Copyright  (c)  2006-2007 ATA
// 作者:       叶常达
// 创建日期：  2007-10-23
// 主要内容：  用户管理的接口文件
// ******************************************************************

namespace Light.EXP.DataAccess.User
{
    using System;
    using System.Data;
    using System.Data.SqlClient;
    using Light.EXP.Model.User;

	public interface UserInterface
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
        DataSet GetUsers(string userName, int sex, string sortField, string sortOrder, int pageIndex, int pageSize, ref Int64 recordCount);

		/// <summary>
		/// 获取单个用户实体
		/// </summary>
        /// <param name="loginId">登录Id</param>
		/// <returns>User实体</returns>
        Users GetUser(string loginId);
		
		/// <summary>
		/// 增加用户
		/// </summary>
		/// <param name="users">用户实体</param>
		/// <returns>bool</returns>
		bool CreateUser(Users user);
		
		/// <summary>
		/// 修改用户
		/// </summary>
		/// <param name="users">用户实体</param>
		/// <returns>bool</returns>
		bool UpdateUser(Users user);

		/// <summary>
		/// 删除用户
		/// </summary>
        /// <param name="loginId">登录Id</param>
		/// <returns>bool</returns>
        bool DeleteUser(string loginId);

        /// <summary>
        /// 批量删除多个用户
        /// </summary>
        /// <param name="loginIds"></param>
        void BatchDeleteUsers(string loginIds);
	}
}
