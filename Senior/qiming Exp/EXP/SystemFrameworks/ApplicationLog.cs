// ******************************************************************
// 文件名: Light.EXP.SystemFrameworks.ApplicationLog.cs
// Copyright  (c)  2006-2007 ATA
// 作者:       叶常达
// 创建日期：  2007-10-17
// 主要内容：  错误处理函数，用于记录错误日志
// ******************************************************************

namespace Light.EXP.SystemFrameworks
{
    using System;
    using System.IO;

	public sealed class ApplicationLog 
	{
        private ApplicationLog() 
        {
        }

		/// <summary>
		/// 记录日志至文本文件
		/// </summary>
		/// <param name="message">记录的内容</param>
		public static void Log(string message) 
		{
			string fileName = System.Web.HttpContext.Current.Server.MapPath(EXPConfiguration.Log);
		
			if(File.Exists(fileName))
			{
				StreamWriter sr = File.AppendText(fileName);
				sr.WriteLine ("\n");
				sr.WriteLine (DateTime.Now.ToString()+message);
				sr.Close();
			}
			else
			{
				StreamWriter sr = File.CreateText(fileName);
				sr.Close();
				Log(message);
			}
		}
	}
}