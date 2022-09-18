namespace Light.EXP.Model.Bill{
    using System;
    using System.Collections.Generic;
    using System.Text;

    public class BillDispense{
        private int pkId = 0;
        private string billType = "";
        private string billStartCode = "";
        private string billEndCode = "";
        private string receiveBillPerson = "";
        private string acceptStation = "";
        private DateTime receiveBillTime = DateTime.Now;
        private string releasePerson = "";
        public int PKId{
            get { 
                return pkId;
            }
            set { 
                pkId = value; 
            }
        }

        public string BillType{
            get { 
                return billType; 
            }
            set {
                billType = value;
            }
        }
        public string BillStartCode{
            get { 
                return billStartCode; 
            }
            set { 
                billStartCode = value; 
            }
        }

        public string BillEndCode{
            get {
                return billEndCode;
            }
            set{
                billEndCode = value; 
            }
        }
        public string ReceiveBillPerson{
            get {
                return receiveBillPerson; 
            }
            set { 
                receiveBillPerson = value;
            }
        }

        public string AcceptStation{
            get {
                return acceptStation; 
            }
            set { 
                acceptStation = value; 
            }
        }
        public DateTime ReceiveBillTime{
            get { 
                return receiveBillTime; 
            }
            set { 
                receiveBillTime = value; 
            }
        }

        public string ReleasePerson{
            get {
                return releasePerson;
            }
            set { 
                releasePerson = value; 
            }
        }
    }
}
