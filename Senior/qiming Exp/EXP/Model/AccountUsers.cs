// ******************************************************************
// 文件名: Light.EXP.Model.User.Users.cs
// Copyright  (c)  2006-2007 ATA
// 作者:       叶常达
// 创建日期：  2007-10-17
// 主要内容：  用户管理的实体类文件
// ******************************************************************

namespace Light.EXP.Model.User
{
    using System;

	public class Users
	{
		private string loginId = "";
        private string userName = "";
		private string password = "";
		private int sex = 0;
		private DateTime birthday = DateTime.Now;
		
		/// <summary>
		/// 登录ID
		/// </summary>
		public string LoginId
		{
            get 
            {
                return loginId; 
            }
            set 
            {
                loginId = value; 
            }
		}

		/// <summary>
		/// 用户姓名
		/// </summary>
		public string UserName
		{
			get
            {
                return userName;
            }
			set
            {
                userName = value;
            }
		}

		/// <summary>
		/// 密码
		/// </summary>
		public string Password
		{
			get
            {
                return password;
            }
			set
            {
                password = value;
            }
		}

		/// <summary>
		/// 性别
		/// </summary>
		public int Sex
		{
			get
            {
                return sex;
            }
			set
            {
                sex = value;
            }
		}

		/// <summary>
		/// 出生日期
		/// </summary>
		public DateTime Birthday
		{
			get
            {
                return birthday;
            }
			set
            {
                birthday = value;
            }
		}        
	}
}
