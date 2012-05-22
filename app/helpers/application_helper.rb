module ApplicationHelper
  
  # Returns an array of key-value pairs to be used as options for the nav item's parent
  # dropdown. Dashes are used to represent the item depth.
  def nav_items_options(current)
     items = NavItem.sort_by_ancestry(NavItem.all);
     items = items.collect {|item|
       [  '--' * item.depth + item.title , item.id ]
     }
     items.unshift [ t('nav_items.none_option') , nil ]
     items
  end
  
  # Generates a nested html list of links representing the navigation.
  # You can use level and maxlevel to build a menu that displays links for certain nesting levels only.
  # items: the subtree containing the navigation items - root of this is considered level 0
  # path: an array containing the nav items in the active path (aka breadcrumb) - used so they can be marked
  #   with a special class.
  # level: the level where the rendering is started.
  # maxlevel: meny levels are displayed this list is proceeded
  def menu(items, path, level = 0, maxlevel = 1000)
    return '' unless items # No items, nothing to display
    return '' if level >= maxlevel + 1 || level >= items.size # We've gone too deep or there aren't this many levels
    
    val = "<ul>";
    # Go through each item on this level and render them as list items
    items[level].each {|item|
      # We're viewing a nav item in the active path, mark it active and show it's children recursively
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
