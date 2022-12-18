using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace Nhom3_QuanLyResort__HQTCSDL
{
    public class RouteConfig
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");


            routes.MapRoute(
                "AdminPage",
                "Admin/{controller}/{action}",
                new { area = "Admin", controller = "Home", action = "Index" },
                new[] { typeof(Areas.Admin.Controllers.HomeController).Namespace }
            );

            routes.MapRoute(
                name: "Default",
                url: "{controller}/{action}/{id}",
                new { controller = "NguoiDung", action = "Index", id = UrlParameter.Optional },
                new[] { "Nhom3_QuanLyResort_HQTCSDL.Controllers" }
            );

            //routes.MapRoute(
            //    name: "Default",
            //    url: "{controller}/{action}/{id}",
            //    defaults: new { controller = "Home", action = "Index", id = UrlParameter.Optional }
            //);

        }
    }
}
