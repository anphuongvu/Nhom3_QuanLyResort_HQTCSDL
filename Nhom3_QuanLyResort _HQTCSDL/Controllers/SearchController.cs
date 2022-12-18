using Nhom3_QuanLyResort__HQTCSDL.DAL;
using Nhom3_QuanLyResort__HQTCSDL.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Nhom3_QuanLyResort__HQTCSDL.Controllers
{
    public class SearchController : Controller
    {
        private QLResortEntities db = new QLResortEntities();
        DatPhongDAL datPhongDAL = new DatPhongDAL();
        // GET: Search

        [HttpPost]
        public ActionResult TimKiem(string value, DateTime ngayBatDau, DateTime ngayKetThuc)
        {
            //ViewBag.baiviets = db.BaiViets.Where(bv => bv.CongBo).OrderByDescending(bv => bv.NgayBatDau).Take(3).ToList();
            //ViewBag.nhoms = db.Nhoms.OrderByDescending(nh => nh.BaiVietNhoms.Count).Take(5).ToList();
            //ViewBag.alltags = db.Thes.ToList();
            //List<BaiViet> baiViets = db.BaiViets.Where(bv => bv.CongBo && (bv.TieuDe.Contains(searchValue) || bv.NoiDungBaiViet.Contains(searchValue))).ToList();

            //ViewBag.thes = db.Thes.Where(tt => tt.Ten.Contains(searchValue)).ToList();
            //ViewBag.trangCaNhans = db.TrangCaNhans.Where(tcn => tcn.TenTrang.Contains(searchValue) || tcn.GioiThieu.Contains(searchValue) || tcn.MoTa.Contains(searchValue)).ToList();
            //return View(baiViets);
            var data = datPhongDAL.timKiemPhong(value);
            return View(data);
        }
    }
}