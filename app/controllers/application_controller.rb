class ApplicationController < ActionController::Base
  protect_from_forgery
  
  # Always get the nav for each page
  before_filter :get_nav
  
  # Forces the user to log in, if he's not logged in.
  def require_login
    authenticate_user!
  end
  
  # Forces the user to log in, if he's not logged in and if the user
  # is not an admin, gives a "403 unauthorized" response.
  def require_admin
    require_login unless current_user
    restrict_access unless current_user.is_admin
  end
  
  private
  
  # Prevents access for this request rendering a "403 unauthorized" response
  def restrict_access
    render :file => "public/401.html", :status => :unauthorized, :layout => false
  end
  
  # Fetches the navigation item tree and the breadcrumb
  def get_nav
    @nav_item_current = get_current_nav_item
    @nav = []
    
    if(@nav_item_current)
      
      # If a navigation item is selected, get the breadcrumb to that item
      @nav_item_crumb = @nav_item_current.path
      
      # Add the first child of the current page to the end
      @nav_item_crumb.push @nav_item_current.children[0]
      
      # Fetch the sibling of each nav item: this results in an array
      # in which index 0 contains links on level 0, index 1 on level 1 etc. all the way
      # to the current nav item's children.
      @nav_item_crumb.each {|item|
        if(item)
          siblings = NavItem.order("priority").find(item.sibling_ids)
          @nav.push(siblings)
        end
      }
      
      # Remove the first child of the current page from the breadcrumb to make it accurate
      @nav_item_crumb.pop
    else
      # If no nav item is selected, the nav consists of all nav items in the root of the tree
      @nav.push NavItem.order("priority").roots
    end
  end
  
  # Returns the nav item currently displayed
  def get_current_nav_item
    # If we're on a page find it's nav item
    if (params[:controller] == 'pages' && params[:action] == 'show')
      page = Page.find(params[:id])
      if page
        return page.nav_item
      end
    end
    
    # Else get a generic nav item using path
    NavItem.find_by_explicit_path(request.fullpath[1..request.fullpath.length]);
  end
end
