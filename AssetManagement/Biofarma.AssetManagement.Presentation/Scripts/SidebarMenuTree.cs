using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Biofarma.AssetManagement.Data.Structured;
using Biofarma.Framework.Entity;

namespace Biofarma.AssetManagement.Presentation.Scripts
{
    public class SidebarMenuTree : StructuredData
    {
        private static StringBuilder ListMenu;

        public static string GenerateMenu(string PERNR)
        {
            ListMenu = new StringBuilder();

            IList<Menu> topLevelMenus = TreeStructureModel.ConvertToForest(GetMenus(PERNR));

            foreach (Menu topLevelMenu in topLevelMenus)
            {
                RenderMenuItems(topLevelMenu);
            }

            return ListMenu.ToString();
        }

        private static void RenderMenuItems(Menu menuItem)
        {
            string menuName = menuItem.MenuName;

            if ((menuItem.Parent == null) && (menuItem.Children.Count == 0))
            {
                GenerateMenuListStructure(menuItem.Id.ToString(), menuName, "1", menuItem.NavUrl, menuItem.IconClass);
            }
            else //if (menuItem.Children.Count > 0)
            {
                if (menuItem.Parent == null)
                {
                    GenerateMenuListStructure(menuItem.Id.ToString(), menuName, "2", menuItem.NavUrl, menuItem.IconClass);
                }
                else
                {
                    GenerateMenuListStructure(menuItem.Id.ToString(), menuName, "2", menuItem.NavUrl, menuItem.IconClass);
                }

                foreach (Menu child in menuItem.Children)
                {
                    if (child.Children.Count > 0)
                    {
                        RenderMenuItems(child);
                    }
                    else
                    {
                        GenerateMenuListStructure(child.Id.ToString(), child.MenuName.ToString(), "3", child.NavUrl, child.IconClass);
                    }
                }
                ListMenu.Append("</ul>");
                ListMenu.Append("</li>");
            }
        }

        private static void GenerateMenuListStructure(string menuID, string menuName, string type, string URL, string ICO)
        {
            if (type == "1")
            {
                ListMenu.Append("<li class='sub-menu'>                                    ");
                ListMenu.Append("<a href='" + URL + "'>                                     ");
                ListMenu.Append("<i class='" + ICO + "'></i>                              ");
                ListMenu.Append("<span> " + menuName + "</span>                           ");
                ListMenu.Append("</a>                                                     ");
                ListMenu.Append("</li>                                                    ");
            }
            else if (type == "2")
            {
                ListMenu.Append("<li class='sub-menu'>                                    ");
                ListMenu.Append("<a href='javascript:;'>                                  ");
                ListMenu.Append("<i class='" + ICO + "'></i>                              ");
                ListMenu.Append("<span> " + menuName + "</span>                           ");
                ListMenu.Append("</a>                                                     ");
                ListMenu.Append("<ul class = 'sub'>");
            }
            else if (type == "3")
            {
                ListMenu.Append("<li><a href='" + URL + "'> " + menuName + " </a></li>    ");
            }
        }
    }
}
