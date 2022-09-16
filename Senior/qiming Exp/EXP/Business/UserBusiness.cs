// ******************************************************************
// 文件名: Light.EXP.Business.User.UserBusiness.cs
// Copyright  (c)  2006-2007 ATA
// 作者:       叶常达
// 创建日期：  2007-10-24
// 主要内容：  用户管理的业务处理类文件
// ******************************************************************

namespace Light.EXP.Business.User
{
    using System;
    using System.Data;

    using Light.EXP.DataAccess.User;
    using Light.EXP.Model.User;

	public class UserBusiness
	{
		/// <summary>
		/// 获取多个用户实体, 用于用户信息查询页面DataList的数据绑定
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
            UserInterface iuser = UserFactory.Create();
            return iuser.GetUsers(userName, sex, sortField, sortOrder, pageIndex, pageSize, ref recordCount);
		}

		/// <summary>
		/// 获取单个用户实体, 用于用户信息编辑或查看页面表单的数据绑定
		/// </summary>
        /// <param name="loginId">登录Id</param>
		/// <returns>User实体</returns>
        public Users GetUser(string loginId)
		{
            UserInterface iuser = UserFactory.Create();
            return iuser.GetUser(loginId);
		}
		
		/// <summary>
		/// 增加用户, 用于用户信息增加页面添加按钮的单击事件处理
		/// </summary>
		/// <param name="users">用户实体</param>
		/// <returns>bool</returns>
		public bool CreateUser(Users user)
		{
            UserInterface iuser = UserFactory.Create();
			return iuser.CreateUser(user);
		}
		
		/// <summary>
		/// 修改用户, 用于用户信息编辑页面修改按钮的单击事件处理
		/// </summary>
		/// <param name="users">用户实体</param>
		/// <returns>bool</returns>
		public bool UpdateUser(Users user)
		{
            UserInterface iuser = UserFactory.Create();
			return iuser.UpdateUser(user);			
		}

		/// <summary>
        /// 删除用户, 用于用户信息编辑页面删除按钮的单击事件处理
		/// </summary>
        /// <param name="loginId">登录Id</param>
		/// <returns>bool</returns>
        public bool DeleteUser(string loginId)
		{
            UserInterface iuser = UserFactory.Create();
            return iuser.DeleteUser(loginId);					
		}

        /// <summary>
        /// 批量删除多个用户, 用于用户信息查询页面批量删除按钮的单击事件处理
        /// </summary>
        /// <param name="logOnIds"></param>
        public void BatchDeleteUsers(string logOnIds)
        {
            UserInterface iuser = UserFactory.Create();
            iuser.BatchDeleteUsers(logOnIds);	
        }
	}
}
