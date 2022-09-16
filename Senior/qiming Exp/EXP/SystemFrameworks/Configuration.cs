// ******************************************************************
// 文件名: Light.EXP.SystemFrameworks.Configuration.cs
// Copyright  (c)  2006-2007 ATA
// 作者:       叶常达
// 创建日期：  2007-10-29
// 主要内容：  读取web.config文件的配置信息
// ******************************************************************

namespace Light.EXP.SystemFrameworks
{
    using System.Configuration;

	public sealed class EXPConfiguration
	{
        private EXPConfiguration() 
        { 
        }

		/// <summary>
		/// 数据库连接字符串
		/// </summary>
		public static string ConnectionString
		{
			get
			{
				return ConfigurationSettings.AppSettings["ConnectionString"];
			}
		}

		/// <summary>
		/// 日志文件存放位置
		/// </summary>
		public static string Log
		{
			get
			{
				return ConfigurationSettings.AppSettings["Log"];
			}
		}

        /// <summary>
        /// 数据访问层名称空间
        /// </summary>
        public static string DataAccess
        {
            get
            {
                return ConfigurationSettings.AppSettings["DataAccess"];
            }
        }
	}
}
