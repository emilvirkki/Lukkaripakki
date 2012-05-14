class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :get_nav
  
  def require_login
    authenticate_user!
  end
  
  def require_admin
    require_login unless current_user
    restrict_access unless current_user.is_admin
  end
  
  private
  
  def restrict_access
    render :file => "public/401.html", :status => :unauthorized, :layout => false
  end
  
  def get_nav
    @nav_item_current = get_current_nav_item
    @nav = []
    
    if(@nav_item_current)
      @nav_item_crumb = @nav_item_current.path
      @nav_item_crumb.push @nav_item_current.children[0]
      @nav_item_crumb.each {|item|
        if(item)
          siblings = NavItem.order("priority").find(item.sibling_ids)
          @nav.push(siblings)
        end
      }
      @nav_item_crumb.pop
      logger.debug @nav.inspect
    else
      @nav.push NavItem.order("priority").roots
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
    NavItem.find_by_explicit_path(request.fullpath);
  end
end
