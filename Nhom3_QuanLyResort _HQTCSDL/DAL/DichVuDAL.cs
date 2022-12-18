using Nhom3_QuanLyResort__HQTCSDL.Models;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace Nhom3_QuanLyResort__HQTCSDL.DAL
{
    public class DichVuDAL
    {
        string connStr = ConfigurationManager.ConnectionStrings["QLResortEntities"].ToString();
        public List<DichVu> GetDichVus()
        {

            List<DichVu> dichVus = new List<DichVu>();
            using (SqlConnection connecttion = new SqlConnection(connStr))
            {
                SqlCommand cmd = connecttion.CreateCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "GetDichVu";
                SqlDataAdapter sqlDA = new SqlDataAdapter(cmd);
                DataTable dtDichVu = new DataTable();
                connecttion.Open();

                sqlDA.Fill(dtDichVu);
                connecttion.Close();


                foreach (DataRow item in dtDichVu.Rows)
                {
                    dichVus.Add(new DichVu
                    {
                        MaDichVu = (short)Convert.ToInt32(item["MaDichVu"].ToString()),
                        TenDichVu = item["TenDichVu"].ToString(),
                        LoaiDichVu = item["LoaiDichVu"].ToString(),
                        NgayBatDau = Convert.ToDateTime(item["NgayBatDau"]),
                        NgayKetThuc = Convert.ToDateTime(item["NgayKetThuc"]),
                    });
                }
            }

            return dichVus;
        }
    }
}