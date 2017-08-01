using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Biofarma.Framework.Entity
{
    public class Menu : ITreeNode<Menu>
    {
        protected int _menuId;
        protected string _menuName;
        protected string _navUrl;
        protected string _iconClass;
        protected Menu _parent;
        protected IList<Menu> _children;

        public int Id
        {
            get { return _menuId; }
            set { _menuId = value; }
        }

        public string MenuName
        {
            get { return _menuName; }
            set { _menuName = value; }
        }

        public string NavUrl
        {
            get { return _navUrl; }
            set { _navUrl = value; }
        }

        public string IconClass
        {
            get { return _iconClass; }
            set { _iconClass = value; }
        }

        public Menu Parent
        {
            get { return _parent; }
            set { _parent = value; }
        }

        public IList<Menu> Children
        {
            get { return _children; }
            set { _children = value; }
        }

        public Menu() { }

        public Menu(int menuId, string menuName, Menu parentId, string navUrl)
        {
            _menuId = menuId;
            _menuName = menuName;
            _parent = parentId;
            _navUrl = navUrl;
        }

        public Menu(int menuId, string menuName, Menu parentId, string navUrl, string iconClass)
        {
            _menuId = menuId;
            _menuName = menuName;
            _parent = parentId;
            _navUrl = navUrl;
            _iconClass = iconClass;
        }
    }
}
