// ******************************************************************
// 文件名: Light.EXP.SystemFrame.SystemFramework.Utility.cs
// Copyright  (c)  2006-2007 ATA
// 作者:       叶常达
// 创建日期：  2007-10-17
// 主要内容：  常用工具函数类
// ******************************************************************

namespace Light.EXP.SystemFrameworks
{
    using System;
    using System.Web.UI;
    using System.Data;
    using System.Web.UI.WebControls;

	public sealed class Utility
    {
        private Utility() 
        {
        }

        /// <summary>
		/// 页面JavaScript消息提示
		/// </summary>
		/// <param name="page">页面类</param>
		/// <param name="message">提示消息</param>
		public static void AlertMsg(Page page, string message)
		{
			page.RegisterStartupScript("AlertMsg","<script  Language='Javascript'>alert('" + message + "');</script>");
		}

        /// <summary>
        /// 将输入字符串转换为整数
        /// </summary>
        /// <param name="args">输入字符串</param>
        /// <returns>Int</returns>
        public static int ToInt(string args)
        {
            if (args.Trim().Length == 0)
            {
                return 0;
            }
            else
            {
                return Convert.ToInt32(args);                
            }
        }

        /// <summary>
        /// 将输入字符串转换为小数
        /// </summary>
        /// <param name="args">输入字符串</param>
        /// <returns>Decimal</returns>
        public static decimal ToDecimal(string args)
        {
            if (args.Trim().Length == 0)
            {
                return 0;
            }
            else
            {
                return Convert.ToDecimal(args);
            }
        }

        /// <summary>
        /// 将输入字符串转换为单精度浮点数字
        /// </summary>
        /// <param name="args">输入字符串</param>
        /// <returns>Double</returns>
        public static Single ToSingle(string args)
        {
            if (args.Trim().Length == 0)
            {
                return 0;
            }
            else
            {
                return Convert.ToSingle(args);
            }
        }

        /// <summary>
        /// 将输入字符串转换为双精度浮点数字
        /// </summary>
        /// <param name="args">输入字符串</param>
        /// <returns>Double</returns>
        public static double ToDouble(string args)
        {
            if (args.Trim().Length == 0)
            {
                return 0;
            }
            else
            {
                return Convert.ToDouble(args);            
            }
        }

        /// <summary>
        /// 将输入字符串转换为日期
        /// </summary>
        /// <param name="args">输入字符串</param>
        /// <returns>DateTime</returns>
        public static DateTime ToDateTime(string args)
        {
            if (args.Trim().Length == 0)
            {
                return DateTime.MinValue;
            }
            else
            {
                return Convert.ToDateTime(args);
            }
        }

        /// <summary>
        /// 解析输入日期
        /// </summary>
        /// <param name="inputDateTime">输入日期</param>
        /// <returns>object</returns>
        public static object ParseDateTime(DateTime inputDateTime)
        {
            if (inputDateTime == DateTime.MinValue)
            {
                return System.DBNull.Value;
            }
            else
            {
                return inputDateTime;
            }
        }
    }	 
}
