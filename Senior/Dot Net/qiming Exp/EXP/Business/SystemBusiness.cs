// ******************************************************************
// 文件名: Light.EXP.Business.SystemFrame.SystemBusiness.cs
// Copyright  (c)  2006-2007 ATA
// 作者:       叶常达
// 创建日期：  2007-11-14
// 主要内容：  系统框架的业务处理类文件
// ******************************************************************

namespace Light.EXP.Business.SystemFrame
{
    using System;
    using System.Data;

    using Light.EXP.DataAccess.SystemFrame;

    public class SystemBusiness
    {
        /// <summary>
        /// 登录验证
        /// </summary>
        /// <param name="loginId">登录ID</param>
        /// <param name="passowrd">密码</param>
        /// <returns>bool</returns>
        public bool ValidateUser(string loginId, string password)
        {
            SystemInterface isystem = SystemFactory.Create();
            return isystem.ValidateUser(loginId, password);
        }

        /// <summary>
        /// 权限控制
        /// </summary>
        /// <param name="loginId">登录ID</param>
        /// <param name="pageName">页面名称</param>
        /// <returns></returns>
        public bool CheckRight(string loginId, string pageName)
        {
            SystemInterface isystem = SystemFactory.Create();
            return isystem.CheckRight(loginId, pageName);
        }
    }
}
