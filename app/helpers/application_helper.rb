module ApplicationHelper
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
    return '' if level >= maxlevel + 1 || level >= items.size
    
    val = "<ul>";
    items[level].each {|item|
      if(item.id == path[level].id)
        val = val + '<li class="active">' + link_to(item.title, item.realpath) + menu(items, path, level+1, maxlevel)
      else
        val = val + '<li>' + link_to(item.title, item.realpath)
      end
      val = val + '</li>'
    }
    return val + "</ul>"
  end
end
