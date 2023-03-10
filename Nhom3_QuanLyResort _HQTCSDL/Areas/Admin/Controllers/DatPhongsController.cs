using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using Nhom3_QuanLyResort__HQTCSDL.Models;

namespace Nhom3_QuanLyResort__HQTCSDL.Areas.Admin.Controllers
{
    public class DatPhongsController : Controller
    {
        private QLResortEntities db = new QLResortEntities();

        // GET: Admin/DatPhongs
        public ActionResult Index()
        {
            var datPhongs = db.DatPhongs.Include(d => d.CheckInOut).Include(d => d.PhieuXacNhanDatPhong).Include(d => d.Phong).Include(d => d.PhuongThucThanhToan);
            return View(datPhongs.ToList());
        }

        // GET: Admin/DatPhongs/Details/5
        public ActionResult Details(short? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            DatPhong datPhong = db.DatPhongs.Find(id);
            if (datPhong == null)
            {
                return HttpNotFound();
            }
            return View(datPhong);
        }

        // GET: Admin/DatPhongs/Create
        public ActionResult Create()
        {
            ViewBag.MaDatPhong = new SelectList(db.CheckInOuts, "MaDatPhong", "TenKH");
            ViewBag.MaPhieuXacNhan = new SelectList(db.PhieuXacNhanDatPhongs, "MaPhieuXacNhan", "TenKH");
            ViewBag.MaPhong = new SelectList(db.Phongs, "MaPhong", "HinhAnh");
            ViewBag.MaPhuongThuc = new SelectList(db.PhuongThucThanhToans, "MaPhuongThuc", "TenPhuongThuc");
            return View();
        }

        // POST: Admin/DatPhongs/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "MaDatPhong,MaPhong,MaPhuongThuc,MaPhieuXacNhan,TenKH,NgayDatPhong,NgayTraPhong,YeuCauThem")] DatPhong datPhong)
        {
            if (ModelState.IsValid)
            {
                db.DatPhongs.Add(datPhong);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.MaDatPhong = new SelectList(db.CheckInOuts, "MaDatPhong", "TenKH", datPhong.MaDatPhong);
            ViewBag.MaPhieuXacNhan = new SelectList(db.PhieuXacNhanDatPhongs, "MaPhieuXacNhan", "TenKH", datPhong.MaPhieuXacNhan);
            ViewBag.MaPhong = new SelectList(db.Phongs, "MaPhong", "HinhAnh", datPhong.MaPhong);
            ViewBag.MaPhuongThuc = new SelectList(db.PhuongThucThanhToans, "MaPhuongThuc", "TenPhuongThuc", datPhong.MaPhuongThuc);
            return View(datPhong);
        }

        // GET: Admin/DatPhongs/Edit/5
        public ActionResult Edit(short? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            DatPhong datPhong = db.DatPhongs.Find(id);
            if (datPhong == null)
            {
                return HttpNotFound();
            }
            ViewBag.MaDatPhong = new SelectList(db.CheckInOuts, "MaDatPhong", "TenKH", datPhong.MaDatPhong);
            ViewBag.MaPhieuXacNhan = new SelectList(db.PhieuXacNhanDatPhongs, "MaPhieuXacNhan", "TenKH", datPhong.MaPhieuXacNhan);
            ViewBag.MaPhong = new SelectList(db.Phongs, "MaPhong", "HinhAnh", datPhong.MaPhong);
            ViewBag.MaPhuongThuc = new SelectList(db.PhuongThucThanhToans, "MaPhuongThuc", "TenPhuongThuc", datPhong.MaPhuongThuc);
            return View(datPhong);
        }

        // POST: Admin/DatPhongs/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "MaDatPhong,MaPhong,MaPhuongThuc,MaPhieuXacNhan,TenKH,NgayDatPhong,NgayTraPhong,YeuCauThem")] DatPhong datPhong)
        {
            if (ModelState.IsValid)
            {
                db.Entry(datPhong).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.MaDatPhong = new SelectList(db.CheckInOuts, "MaDatPhong", "TenKH", datPhong.MaDatPhong);
            ViewBag.MaPhieuXacNhan = new SelectList(db.PhieuXacNhanDatPhongs, "MaPhieuXacNhan", "TenKH", datPhong.MaPhieuXacNhan);
            ViewBag.MaPhong = new SelectList(db.Phongs, "MaPhong", "HinhAnh", datPhong.MaPhong);
            ViewBag.MaPhuongThuc = new SelectList(db.PhuongThucThanhToans, "MaPhuongThuc", "TenPhuongThuc", datPhong.MaPhuongThuc);
            return View(datPhong);
        }

        // GET: Admin/DatPhongs/Delete/5
        public ActionResult Delete(short? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            DatPhong datPhong = db.DatPhongs.Find(id);
            if (datPhong == null)
            {
                return HttpNotFound();
            }
            return View(datPhong);
        }

        // POST: Admin/DatPhongs/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(short id)
        {
            DatPhong datPhong = db.DatPhongs.Find(id);
            db.DatPhongs.Remove(datPhong);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
