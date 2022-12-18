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
    public class TienIchResortsController : Controller
    {
        private QLResortEntities db = new QLResortEntities();

        // GET: Admin/TienIchResorts
        public ActionResult Index()
        {
            return View(db.TienIchResorts.ToList());
        }

        // GET: Admin/TienIchResorts/Details/5
        public ActionResult Details(short? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            TienIchResort tienIchResort = db.TienIchResorts.Find(id);
            if (tienIchResort == null)
            {
                return HttpNotFound();
            }
            return View(tienIchResort);
        }

        // GET: Admin/TienIchResorts/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: Admin/TienIchResorts/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "MaTienIch,TenTienIch")] TienIchResort tienIchResort)
        {
            if (ModelState.IsValid)
            {
                db.TienIchResorts.Add(tienIchResort);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(tienIchResort);
        }

        // GET: Admin/TienIchResorts/Edit/5
        public ActionResult Edit(short? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            TienIchResort tienIchResort = db.TienIchResorts.Find(id);
            if (tienIchResort == null)
            {
                return HttpNotFound();
            }
            return View(tienIchResort);
        }

        // POST: Admin/TienIchResorts/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "MaTienIch,TenTienIch")] TienIchResort tienIchResort)
        {
            if (ModelState.IsValid)
            {
                db.Entry(tienIchResort).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(tienIchResort);
        }

        // GET: Admin/TienIchResorts/Delete/5
        public ActionResult Delete(short? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            TienIchResort tienIchResort = db.TienIchResorts.Find(id);
            if (tienIchResort == null)
            {
                return HttpNotFound();
            }
            return View(tienIchResort);
        }

        // POST: Admin/TienIchResorts/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(short id)
        {
            TienIchResort tienIchResort = db.TienIchResorts.Find(id);
            db.TienIchResorts.Remove(tienIchResort);
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
