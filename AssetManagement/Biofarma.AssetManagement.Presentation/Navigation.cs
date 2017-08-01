using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Configuration;
using Biofarma.AssetManagement.Presentation.Scripts;

namespace Biofarma.AssetManagement.Presentation
{
    public class Navigation
    {
        public static string SetMenuAuthority(string MENU)
        {
            StringBuilder sb = new StringBuilder();
            List<object[]> menuparent = new List<object[]>();
            List<object[]> menuchild = new List<object[]>();
            //begin all
            sb.Append("<aside>                                                  ");
            sb.Append("<div id='sidebar' class='nav-collapse'>                  ");
            sb.Append("<!-- sidebar menu start-->                               ");
            sb.Append("<ul class='sidebar-menu' id='nav-accordion'>             ");
            //dashboard
            sb.Append("<li>                                                     ");
            sb.Append("<a href='" + ConfigurationManager.AppSettings["Dashboard"] + "'>         ");
            sb.Append("<i class='fa fa-dashboard'></i>                          ");
            sb.Append("<span>Dashboard</span>                                   ");
            sb.Append("</a>                                                     ");
            sb.Append("</li>                                                    ");
            //end dashboard menu

            //physical monitoring
            sb.Append("<li>                                                     ");
            sb.Append("<a href='#'>                                             ");
            sb.Append("<i class='fa fa-desktop'></i>                            ");
            sb.Append("<span>Physical Monitoring</span>                         ");
            sb.Append("</a>                                                     ");
            // second level
            sb.Append("<ul class='nav nav-second-level'>                        ");
            // alat
            sb.Append("<li>                                                     ");
            sb.Append("<a href='SpecAlat.aspx'>                                 ");
            sb.Append("<span>Spesifikasi Alat</span>                            ");
            sb.Append("</a>                                                     ");
            sb.Append("</li>                                                    ");
            // end alat
            // temperature
            sb.Append("<li>                                                     ");
            sb.Append("<a href='MonitoringTemp.aspx'>                     ");
            sb.Append("<span>Monitoring Temperature Ruangan</span>              ");
            sb.Append("</a>                                                     ");
            sb.Append("</li>                                                    ");
            // end temperature
            //humidity
            sb.Append("<li>                                                     ");
            sb.Append("<a href='MonitoringHum.aspx'>                     ");
            sb.Append("<span>Monitoring Kelembaban Ruangan</span>               ");
            sb.Append("</a>                                                     ");
            sb.Append("</li>                                                    ");
            // end humidity
            //pressure
            sb.Append("<li>                                                     ");
            sb.Append("<a href='MonitoringDiff.aspx'>                            ");
            sb.Append("<span>Monitoring Perbedaan Tekanan Ruangan</span>        ");
            sb.Append("</a>                                                     ");
            sb.Append("</li>                                                    ");
            // end pressure
            //peminjaman
            //sb.Append("<li>                                                     ");
            //sb.Append("<a href='Peminjaman.aspx'>                               ");
            //sb.Append("<span>Peminjaman</span>                                  ");
            //sb.Append("</a>                                                     ");
            //sb.Append("</li>                                                    ");
            // end peminjaman
            //penerimaan
            //sb.Append("<li>                                                     ");
            //sb.Append("<a href='Penerimaan.aspx'>                               ");
            //sb.Append("<span>Penerimaan</span>                                  ");
            //sb.Append("</a>                                                     ");
            //sb.Append("</li>                                                    ");
            //end penerimaan
            sb.Append("</ul>                                                    ");
            // end second level
            sb.Append("</li>                                                    ");
            //end physical monitoring menu

            //laporan monitoring
            sb.Append("<li>                                                     ");
            sb.Append("<a href='#'>                                             ");
            sb.Append("<i class='fa fa-file-pdf-o'></i>                            ");
            sb.Append("<span>Laporan Monitoring</span>                         ");
            sb.Append("</a>                                                     ");
            // second level
            sb.Append("<ul class='nav nav-second-level'>                        ");
            //perbulan
            sb.Append("<li>                                                     ");
            sb.Append("<a href='Laporanperbulan.aspx'>                            ");
            sb.Append("<span>Laporan Monitoring Per Bulan</span>        ");
            sb.Append("</a>                                                     ");
            sb.Append("</li>                                                    ");
            // end perbulan
            //perquartal
            sb.Append("<li>                                                     ");
            sb.Append("<a href='Laporanperquartal.aspx'>                            ");
            sb.Append("<span>Laporan Monitoring Per Quartal</span>        ");
            sb.Append("</a>                                                     ");
            sb.Append("</li>                                                    ");
            // end perquartal
            //persemester
            sb.Append("<li>                                                     ");
            sb.Append("<a href='Laporanpersemester.aspx'>                            ");
            sb.Append("<span>Laporan Monitoring Per Semester</span>        ");
            sb.Append("</a>                                                     ");
            sb.Append("</li>                                                    ");
            // end persemester
            //pertahun
            sb.Append("<li>                                                     ");
            sb.Append("<a href='Laporanpertahun.aspx'>                            ");
            sb.Append("<span>Laporan Monitoring Per Tahun</span>        ");
            sb.Append("</a>                                                     ");
            sb.Append("</li>                                                    ");
            // end pertahun
            sb.Append("</ul>                                                    ");
            // end second level
            sb.Append("</li>                                                    ");
            //end laporan monitoring menu

            sb.Append(MENU);

            //Menu Static End Here
            sb.Append("</ul>                                                    ");
            sb.Append("<!-- sidebar menu end-->                                 ");
            sb.Append("</div>                                                   ");
            sb.Append("</aside>                                                 ");

            return sb.ToString();
        }

        public static string SetApplicationHeader(string username)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("<header class='header fixed-top clearfix'>                                       ");
            sb.Append("<div class='brand'>                                                              ");
            sb.Append("<a href='" + ConfigurationManager.AppSettings["Dashboard"] + "' class='logo'>    ");
            sb.Append("<img src='" + ConfigurationManager.AppSettings["App_Icon"] + "' alt=''></img>    ");
            sb.Append("</a>                                                                             ");
            sb.Append("<div class='sidebar-toggle-box'>                                                 ");
            sb.Append("<div class='fa fa-bars'></div>                                                   ");
            sb.Append("</div>                                                                           ");
            sb.Append("</div>                                                                           ");
            sb.Append("<div class='top-nav clearfix'>                                                   ");
            sb.Append("<!--search & user info start-->                                                  ");
            sb.Append("<ul class='nav pull-right top-menu'>                                             ");
            sb.Append("<!-- user login dropdown start-->                                                ");
            sb.Append("<li class='dropdown'>                                                            ");
            sb.Append("<a data-toggle='dropdown' class='dropdown-toggle' href='#'>                      ");
            sb.Append("<img alt='' src='" + ConfigurationManager.AppSettings["User_Icon"] + "'>         ");
            sb.Append("<span class='username'>" + username + "</span>                                   ");
            sb.Append("<b class='caret'></b>                                                            ");
            sb.Append("</a>                                                                             ");
            sb.Append("<ul class='dropdown-menu extended logout'>                                       ");

            //Logout
            sb.Append("<li><a href='" + ConfigurationManager.AppSettings["LogoutTo"] + "'>              ");
            sb.Append("<i class='fa fa-key'></i> Log Out</a></li>                                       ");

            sb.Append("</ul>                                                                            ");
            sb.Append("</li>                                                                            ");
            sb.Append("<!-- user login dropdown end -->                                                 ");
            sb.Append("</ul>                                                                            ");
            sb.Append("<!--search & user info end-->                                                    ");
            sb.Append("</div>                                                                           ");
            sb.Append("</header>                                                                        ");

            return sb.ToString();
        }
    }
}
