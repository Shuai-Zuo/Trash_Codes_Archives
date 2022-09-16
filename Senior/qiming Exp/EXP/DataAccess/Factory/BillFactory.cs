namespace Light.EXP.DataAccess.Bill{
    using System.Reflection;
    using Light.EXP.SystemFrameworks;

    public sealed class BillFactory{
        private BillFactory(){}
        public static BillInterface Create(){
            string path = EXPConfiguration.DataAccess;
            string className = path + ".Bill.BillSQLHandle";
            return (BillInterface)Assembly.Load(path).CreateInstance(className);
        }
    }
}