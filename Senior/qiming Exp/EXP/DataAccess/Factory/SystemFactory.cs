// ******************************************************************
// 文件名: Light.EXP.DataAccess.SystemFrame.SystemFactory.cs
// Copyright  (c)  2006-2007 ATA
// 作者:       叶常达
// 创建日期：  2007-11-14
// 主要内容：  系统框架的工厂类文件
// ******************************************************************

namespace Light.EXP.DataAccess.SystemFrame
{
    using System.Reflection;
    using Light.EXP.SystemFrameworks;

    public sealed class SystemFactory
    {
        private SystemFactory()
        {
        }

        /// <summary>
        /// SystemInterface的接口创建
        /// </summary>
        /// <returns>SystemInterface</returns>
        public static SystemInterface Create()
        {
            string path = EXPConfiguration.DataAccess;
            string className = path + ".SystemFrame.SystemSQLHandle";
            return (SystemInterface)Assembly.Load(path).CreateInstance(className);
        }
    }
}
