using Nhom3_QuanLyResort__HQTCSDL.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Nhom3_QuanLyResort__HQTCSDL.Areas.Admin.Controllers
{
    public class PhongController : Controller
    {
        private QLResortEntities db = new QLResortEntities();
        // GET: Admin/Phong
        public ActionResult Index()
        {
            var data = db.sp_GetAllPhong().ToList();
            return View(data);
        }
    }
}