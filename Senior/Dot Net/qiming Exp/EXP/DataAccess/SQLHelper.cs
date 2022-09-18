// ******************************************************************
// 文件名: Light.EXP.DataAccess.SystemFrame.SQLHelper.cs
// Copyright  (c)  2006-2007 ATA
// 作者:       叶常达
// 创建日期：  2007-10-17
// 主要内容：  通用的数据库处理类，通过ado.net与数据库连接
// ******************************************************************

namespace Light.EXP.DataAccess.SystemFrame 
{
    using System;
    using System.Data;
    using System.Data.SqlClient;

    using Light.EXP.SystemFrameworks;

	public class SQLHelper : IDisposable
	{
		/// <summary>
		/// 声明数据库连接
		/// </summary>
		private SqlConnection conn = new SqlConnection(EXPConfiguration.ConnectionString);

		/// <summary>
		/// 执行存储过程返回DataSet
		/// </summary>
		/// <param name="procName">存储过程名称</param>
		/// <param name="prams">参数列表</param>
		/// <returns>DataSet</returns>
		public DataSet ExecuteDataSet(string procName, SqlParameter[] prams)
		{
			DataSet ds = new DataSet();

			SqlCommand command = new SqlCommand(procName, conn);
			command.CommandType = CommandType.StoredProcedure;

			if (prams != null) 
			{
				foreach (SqlParameter parameter in prams)
					command.Parameters.Add(parameter);
			}

			SqlDataAdapter da = new SqlDataAdapter(command);
			da.Fill(ds);
			command.Parameters.Clear();
			return ds;		
		}

		/// <summary>
		/// 执行存储过程返回DataTable
		/// </summary>
		/// <param name="procName">存储过程名称</param>
		/// <param name="prams">参数列表</param>
		/// <returns>DataTable</returns>
		public DataTable ExecuteDataTable(string procName, SqlParameter[] prams)
		{
			DataTable dt = new DataTable();

			SqlCommand command = new SqlCommand(procName, conn);
			command.CommandType = CommandType.StoredProcedure;

			if (prams != null) 
			{
				foreach (SqlParameter parameter in prams)
					command.Parameters.Add(parameter);
			}

			SqlDataAdapter da = new SqlDataAdapter(command);
			da.Fill(dt);
			command.Parameters.Clear();
			return dt;		
		}

		/// <summary>
		/// 执行存储过程返回DataReader
		/// </summary>
		/// <param name="procName">存储过程名称</param>
		/// <param name="prams">参数列表</param>
		/// <returns>DataReader</returns>
		public SqlDataReader ExecuteDataReader(string procName, SqlParameter[] prams)
		{
			SqlCommand command = new SqlCommand(procName, conn);
			command.CommandType = CommandType.StoredProcedure;

			if (prams != null) 
			{
				foreach (SqlParameter parameter in prams)
					command.Parameters.Add(parameter);
			}

			conn.Open();

			SqlDataReader reader = command.ExecuteReader(CommandBehavior.CloseConnection);
			command.Parameters.Clear();
			return reader;		
		}

		/// <summary>
		/// 执行存储过程无结果集返回
		/// </summary>
		/// <param name="procName">存储过程名称</param>
		/// <param name="prams">参数列表</param>
		/// <returns>INT</returns>
		public int ExecuteNonQuery(string procName, SqlParameter[] prams)
		{
			SqlCommand command = new SqlCommand(procName, conn);
			command.CommandType = CommandType.StoredProcedure;

			conn.Open();

			if (prams != null) 
			{
				foreach (SqlParameter parameter in prams)
					command.Parameters.Add(parameter);
			}

			command.Parameters.Add(
				new SqlParameter("ReturnValue", SqlDbType.Int, 4,
				ParameterDirection.ReturnValue, false, 0, 0,
				string.Empty, DataRowVersion.Default, null));

			command.ExecuteNonQuery();

			conn.Close();

			return (int)command.Parameters["ReturnValue"].Value;
		}

        /// <summary>
        /// 批量删除
        /// </summary>
        /// <param name="selectcCmmandText">查询语句</param>
        /// <param name="deleteCommandText">删除语句</param>
        /// <param name="batchSize">批量删除记录数量</param>
        public void BatchDelete(string selectCmmandText, string deleteCommandText, Int32 batchSize)
        {
            DataTable dataTable = new DataTable("Table");
            SqlDataAdapter adapter = new SqlDataAdapter();
            adapter.SelectCommand = new SqlCommand(selectCmmandText, conn);
            adapter.Fill(dataTable);
            adapter.DeleteCommand = new SqlCommand(deleteCommandText, conn);
            adapter.DeleteCommand.UpdatedRowSource = UpdateRowSource.None;
            adapter.UpdateBatchSize = batchSize;
            conn.Open();
            adapter.DeleteCommand.ExecuteNonQuery();
            conn.Close();
            adapter.Update(dataTable);
        }

        /// <summary>
        /// 释放资源
        /// </summary>
        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }

        /// <summary>
        /// 释放连接
        /// </summary>
        protected virtual void Dispose(bool disposing)
        {
            if (disposing != true)
            {
                return;
            }
            if (conn != null)
            {
                conn.Dispose();
                conn = null;
            }
        }
	}
}
