class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :get_nav
  
  private
  
  def get_nav
    @nav_item_current = get_current_nav_item
    @nav = []
    
    if(@nav_item_current)
      @nav_item_crumb = @nav_item_current.path
      #TODO Breadcrumb would now contain the first child of the current page
      @nav_item_crumb.push @nav_item_current.children[0]
      @nav_item_crumb.each {|item|
        @nav.push(item.siblings) if item
      }
      @nav_item_crumb.pop
      logger.debug @nav.inspect
    else
      @nav.push NavItem.roots
    end
  end
  
  def get_current_nav_item
    # If we're on a page find it's nav item
    if (params[:controller] == 'pages' && params[:action] == 'show')
      page = Page.find(params[:id])
      if page
        return page.nav_item
      end
    end
    
    # Else get a generic nav item using path
    NavItem.find_by_path(request.fullpath);
  end
end
