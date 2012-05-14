module ApplicationHelper
  
  def user_admin?
    # TODO Admin user level
  end
  
  #FIXME possible to set item it's own child or child's child
  def nav_items_options(current)
     items = NavItem.sort_by_ancestry(NavItem.all);
     items = items.collect {|item|
       [  '--' * item.depth + item.title , item.id ]
     }
     items.unshift [ '<none>' , nil ]
     items
  end
  
  def menu(items, path, level = 0, maxlevel = 1000)
    return '' unless items
    return '' if level >= maxlevel + 1 || level >= items.size
    
    val = "<ul>";
    items[level].each {|item|
      # We're viewing a nav item in the active path, mark it active and show it's children
      if(path && path[level] && item.id == path[level].id)
        val = val + '<li class="active">' + link_to(item.title, item.realpath) + menu(items, path, level+1, maxlevel)
      else
        val = val + '<li>' + link_to(item.title, item.realpath)
      end
      val = val + '</li>'
    }
    return val + "</ul>"
  end
end
