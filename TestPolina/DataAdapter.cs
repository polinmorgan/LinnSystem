using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TestPolina
{
    public class DataAdapter
    {
        private SqlConnection Con;
        public DataAdapter(string connectionString)
        {
            Con = new SqlConnection(connectionString);

        }
        public int AddConsignment(Consignment cons) {
           int id = 0, retry=0;
            try{
                while (retry < 10)
           {
               
               if (Con.State == ConnectionState.Closed )
               {
                   try
                   {
                       Con.Open();
                       
                   }
                   catch {
                       retry++; 
                   }
               }
               else { 
          
            
           foreach ( var p in cons.Packages)
           {
               foreach ( var i in p.Items)
               {
           string sql = string.Format( "exec [TEST].[sp_TempConsignment_Insert] @ConsignmentDate='{0}',@Address1='{1}', @Address2='{2}', @Address3='{3}',@City='{4}', @phonenumber= '{5}',@countryISO2 ='{6}', @postcode='{7}', @packageWidth={8} ,@packageHeight={9}, @packageDepth={10}, @packageType='{11}', @itemcode='{12}', @quantity={13}, @unitWeight={14}"
                                                                                    , cons.ConsignmentDate.ToString("yyyyMMdd"), cons.Address1, cons.Address2, cons.Address3, cons.City, cons.PhoneNumber, cons.CountyISO2, cons.PostCode, p.PackageWidth, p.PackageHeight, p.PackageDepth, p.PackageType, i.ItemCode, i.Quantity, i.UnitWieght);
           SqlCommand comm_load = new SqlCommand(sql, Con );
           comm_load.ExecuteNonQuery();
           }
           }
           
 
            string sql2 = string.Format ("exec [TEST].[sp_Consignment_Insert]  @ConsignmentDate='{0}',@Address1='{1}', @Address2='{2}', @Address3='{3}',@City='{4}',  @phonenumber= '{5}',@countryISO2 ='{6}', @postcode='{7}'",
                                                                                    cons.ConsignmentDate.ToString("yyyyMMdd"), cons.Address1, cons.Address2, cons.Address3, cons.City, cons.PhoneNumber, cons.CountyISO2, cons.PostCode); 
           SqlCommand comm_add = new SqlCommand(sql2, Con);
          
       
               
                   object o = comm_add.ExecuteScalar();

                   if (o != null)
                   {
                       id = (int)o;
                   }
                   Con.Close();
               }
           }
          }
              catch{
                  Con.Close(); 
              return 0; 
              }
           
    
           return id; 
       
       }

        public Consignment Get(int id) {
           List< ConsignmentTemp>cons_list = new List<ConsignmentTemp>();
            string sql = string.Format("exec TEST.sp_Consignment_Select @ConsignmentId={0}" , id);
            Con.Open(); 
            SqlCommand comm_get = new SqlCommand(sql, Con);
            using (SqlDataReader reader = comm_get.ExecuteReader())
            {
                while (reader.Read())
                {
                    ConsignmentTemp c = new ConsignmentTemp();
                    c.ConsignmentId = (int)reader["ConsignmentId"];
                    c.ConsignmentDate =(DateTime) reader["ConsignmentDate"];
                    c.Address1 = reader["Address1"].ToString();
                    c.Address2 = reader["Address2"].ToString();
                    c.Address3 = reader["Address3"].ToString();
                    c.City=reader["City"].ToString(); 
                    c.PhoneNumber= reader["PhoneNumber"].ToString();
                    c.CountyISO2 = reader["CountryISO2"].ToString();
                    c.PostCode=reader["PostCode"].ToString();
                    c.PackageId = (int)reader["PackgeId"];
                    c.PackageWidth=float.Parse( reader["PackageWidth"].ToString());
                    c.PackageHeight = float.Parse(reader["PackageHeight"].ToString());
                    c.PackageDepth=float.Parse (reader["PackageDepth"].ToString()); 
                    c.PackageType=reader["PackageType"].ToString(); 
                    c.ItemId= (int)reader["ItemId"];
                    c.ItemCode=reader["ItemCode"].ToString(); 
                    c.Quantity=(int)reader["Quantity"];
                    c.UnitWeight = float.Parse(reader["UnitWeight"].ToString()); 
                    cons_list.Add(c);
                }
            }
            Con.Close(); 
            Consignment cons = new Consignment();
            cons = cons_list.GroupBy(x => new { x.ConsignmentId, x.ConsignmentDate, x.Address1,x.Address2,x.Address3, x.City,
                x.PhoneNumber, x.CountyISO2, x.PostCode })
                .Select(x => new Consignment()
                        { ConsignmentId=x.Key.ConsignmentId, ConsignmentDate=x.Key.ConsignmentDate,Address1=x.Key.Address1,
                            Address2=x.Key.Address2, Address3=x.Key.Address3, City= x.Key.City, PhoneNumber=x.Key.PhoneNumber, 
                            CountyISO2=x.Key.CountyISO2, PostCode =x.Key.PostCode,
                            Packages = x.GroupBy(p => new { p.PackageId, p.PackageWidth, p.PackageHeight, p.PackageDepth,p.PackageType })
.Select(p => new Package ()
                            {PackageId = p.Key.PackageId, 
                               PackageWidth =p.Key.PackageWidth ,
                               PackageHeight=p.Key.PackageHeight,
                               PackageDepth =p.Key.PackageDepth,
                               PackageType=p.Key.PackageType,

                                Items = p.Select(i => new Item ()
                                {
                                    ItemId = i.ItemId,

                                    ItemCode = i.ItemCode,
                                    Quantity = i.Quantity,
                                    UnitWieght=i.UnitWeight
                                   
                                }).ToList()
                            }).ToList()
                        }).FirstOrDefault();
                        
                        
            return cons; 
        
        } 

    }
}
