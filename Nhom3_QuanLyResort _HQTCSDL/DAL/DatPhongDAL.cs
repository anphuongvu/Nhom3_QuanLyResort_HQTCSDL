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
    public class DatPhongDAL
    {
        string connStr = ConfigurationManager.ConnectionStrings["ResortDb_conn"].ToString();
        public List<DatPhong> xemDatPhong()
        {

            List<DatPhong> datPhongs = new List<DatPhong>();
            using (SqlConnection connecttion = new SqlConnection(connStr))
            {
                SqlCommand cmd = connecttion.CreateCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "sp_GetDonDatPhong";
                SqlDataAdapter sqlDA = new SqlDataAdapter(cmd);
                DataTable dtDichVu = new DataTable();
                connecttion.Open();

                sqlDA.Fill(dtDichVu);
                connecttion.Close();

                foreach (DataRow item in dtDichVu.Rows)
                {
                    datPhongs.Add(new DatPhong
                    {
                        MaDatPhong = (short)Convert.ToInt32(item["MaDatPhong"].ToString()),
                        MaPhong = (short)Convert.ToInt32(item["MaPhong"].ToString()),
                        MaPhieuXacNhan = (short?)(item["MaPhieuXacNhan"].ToString() == "" ? 0: (short)Convert.ToInt32(item["MaPhieuXacNhan"].ToString())),
                        TenKH = item["TenKH"].ToString(),
                        NgayDatPhong = Convert.ToDateTime(item["NgayDatPhong"]),
                        NgayTraPhong = Convert.ToDateTime(item["NgayTraPhong"]),
                        YeuCauThem = item["YeuCauThem"].ToString()
                    });
                }
            }

            return datPhongs;
        }

        public bool themDatPhong(DatPhong datPhong)
        {
            int id = 0;
            using (SqlConnection connecttion = new SqlConnection(connStr))
            {
                SqlCommand cmd = connecttion.CreateCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "sp_ThemDonDatPhong";
                cmd.Parameters.AddWithValue("@MaPhong", datPhong.MaPhong);
                cmd.Parameters.AddWithValue("@MaPhuongThuc", datPhong.MaPhuongThuc);
                cmd.Parameters.AddWithValue("@MaPhieuXacNhan", datPhong.MaPhieuXacNhan);
                cmd.Parameters.AddWithValue("@TenKH", datPhong.TenKH);
                cmd.Parameters.AddWithValue("@NgayDatPhong", datPhong.NgayDatPhong);
                cmd.Parameters.AddWithValue("@NgayTraPhong", datPhong.NgayTraPhong);
                cmd.Parameters.AddWithValue("@YeuCauThem", datPhong.YeuCauThem);

                connecttion.Open();

                id = cmd.ExecuteNonQuery();

                connecttion.Close();

                if (id > 0)
                {
                    return true;
                }
                else
                {
                    return false;
                }    
                    
            }
        }

        public bool suaDatPhong(DatPhong datPhong)
        {
            int id = 0;
            using (SqlConnection connecttion = new SqlConnection(connStr))
            {
                SqlCommand cmd = connecttion.CreateCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "sp_SuaDonDatPhong";
                cmd.Parameters.AddWithValue("@MaDatPhong", datPhong.MaDatPhong);
                cmd.Parameters.AddWithValue("@MaPhong", datPhong.MaPhong);
                cmd.Parameters.AddWithValue("@MaPhuongThuc", datPhong.MaPhuongThuc);
                cmd.Parameters.AddWithValue("@MaPhieuXacNhan", datPhong.MaPhieuXacNhan);
                cmd.Parameters.AddWithValue("@TenKH", datPhong.TenKH);
                cmd.Parameters.AddWithValue("@NgayDatPhong", datPhong.NgayDatPhong);
                cmd.Parameters.AddWithValue("@NgayTraPhong", datPhong.NgayTraPhong);
                cmd.Parameters.AddWithValue("@YeuCauThem", datPhong.YeuCauThem);

                connecttion.Open();

                 id = cmd.ExecuteNonQuery();

                connecttion.Close();

                if (id > 0)
                {
                    return true;
                }
                else
                {
                    return false;
                }

            }
        }

        public bool xoaDatPhong(short MaDatPhong)
        {
            int id = 0;
            using (SqlConnection connecttion = new SqlConnection(connStr))
            {
                SqlCommand cmd = connecttion.CreateCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "sp_XoaDonDatPhong";
                cmd.Parameters.AddWithValue("@MaDatPhong", MaDatPhong);

                connecttion.Open();

                id = cmd.ExecuteNonQuery();

                connecttion.Close();

                if (id > 0)
                {
                    return true;
                }
                else
                {
                    return false;
                }

            }
        }

        public List<Phong> timKiemPhong(string value)
        {

            List<Phong> phongs = new List<Phong>();
            using (SqlConnection connecttion = new SqlConnection(connStr))
            {
                SqlCommand cmd = connecttion.CreateCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "sp_TimKiemPhong";
                cmd.Parameters.AddWithValue("@GiaTri", value);
                cmd.Parameters.AddWithValue("@GiaThap", 0);
                cmd.Parameters.AddWithValue("@GiaCao", 10000000);
                SqlDataAdapter sqlDA = new SqlDataAdapter(cmd);
                DataTable dtPhong = new DataTable();
                connecttion.Open();

                sqlDA.Fill(dtPhong);
                connecttion.Close();

                foreach (DataRow item in dtPhong.Rows)
                {
                    phongs.Add(new Phong
                    {
                        MaPhong = (short)Convert.ToInt32(item["MaPhong"].ToString()),
                        MaLoai = (short)Convert.ToInt32(item["MaLoai"].ToString()),
                        SoGiuong = (short)Convert.ToInt32(item["SoGiuong"].ToString()),
                        DonGia = (decimal)Convert.ToDouble(item["DonGia"].ToString()),
                        HinhAnh = item["HinhAnh"].ToString(),
                        MoTaThongTin = item["MoTaThongTin"].ToString(),
                        TrangThai = item["TrangThai"].ToString()
                    });
                }
            }

            return phongs;
        }
    }
}