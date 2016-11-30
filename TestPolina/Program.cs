using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Configuration;
namespace TestPolina
{
    class Program
    {

        static void Main(string[] args)
        {
            // connection string stored in app.config
            string str  = ConfigurationManager.ConnectionStrings["TEST"].ConnectionString;

            DataAdapter da = new DataAdapter(str);

            Consignment cForward = new Consignment()
            {
                ConsignmentId = 0,
                PostCode = "code",
                PhoneNumber = "number",
                City = "London",
                Address1 = "Adr",
                Address2 = "Adr",
                Address3 = "Adr",
                ConsignmentDate = new DateTime(2016, 11, 29),
                CountyISO2 = "UK",
                Packages = new List<Package>(){ new Package{ PackageDepth=2.1F, PackageHeight=2.1F,PackageWidth=2.1F, PackageType ="tttt", PackageId =0, 
                    Items = new List<Item> {new Item { ItemCode="cccc1", Quantity=20,ItemId=0,UnitWieght=3.5F} , new Item{ ItemCode="cccc22", Quantity=25,ItemId=0,UnitWieght=4.5F}} } }
            };

             int  id= da.AddConsignment(cForward);
             if (id > 0)
             {
                 Consignment cBack = da.Get(id);
             }
        }
    }
}
