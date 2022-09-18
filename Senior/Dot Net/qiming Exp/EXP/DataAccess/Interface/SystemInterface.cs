// ******************************************************************
// 文件名: Light.EXP.DataAccess.SystemFrame.SystemInterface.cs
// Copyright  (c)  2006-2007 ATA
// 作者:       叶常达
// 创建日期：  2007-11-14
// 主要内容：  系统框架的接口文件
// ******************************************************************

namespace Light.EXP.DataAccess.SystemFrame
{
    public interface SystemInterface
    {
        /// <summary>
        /// 登录验证
        /// </summary>
        /// <param name="loginId">登录ID</param>
        /// <param name="passowrd">密码</param>
        /// <returns>bool</returns>
        bool ValidateUser(string loginId, string password);

        /// <summary>
        /// 权限控制
        /// </summary>
        /// <param name="loginId">登录ID</param>
        /// <param name="pageName">页面名称</param>
        /// <returns></returns>
        bool CheckRight(string loginId, string pageName);
    }
}
