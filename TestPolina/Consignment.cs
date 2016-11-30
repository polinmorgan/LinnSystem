using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TestPolina
{
    public class Consignment
    {
        public int ConsignmentId;
        public DateTime ConsignmentDate;
        public string Address1;
        public string Address2;
        public string Address3;
        public string City;
        public string PhoneNumber;
        public string CountyISO2;
        public string PostCode;
         public List<Package> Packages; 
    }
}
