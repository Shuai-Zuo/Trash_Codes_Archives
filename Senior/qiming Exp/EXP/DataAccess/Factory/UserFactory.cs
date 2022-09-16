// ******************************************************************
// 文件名: Light.EXP.DataAccess.User.UserFactory.cs
// Copyright  (c)  2006-2007 ATA
// 作者:       叶常达
// 创建日期：  2007-10-23
// 主要内容：  用户管理的工厂类文件
// ******************************************************************

namespace Light.EXP.DataAccess.User
{
    using System;
    using System.Reflection;

    using Light.EXP.SystemFrameworks;

	public sealed class UserFactory
	{
        private UserFactory() {}

		/// <summary>
        /// UserInterface的接口创建
		/// </summary>
        /// <returns>UserInterface</returns>
		public static UserInterface Create()
		{	
			string path = EXPConfiguration.DataAccess;
			string className = path + ".User.UserSQLHandle";
            return (UserInterface)Assembly.Load(path).CreateInstance(className);
		}
	}
}
