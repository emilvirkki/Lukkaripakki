class NavItem < ActiveRecord::Base
  # Nav items form a tree hierarchy
  has_ancestry
  
  # If the nav item is destroyed and it relates to a page, the page must also be deleted
  # (otherwise it can't be accessed)
  has_one :page, :dependent => :destroy
  
  #Initialize the model with a priority
  after_initialize :default_values
  
  #FIXME breaks saving
  # Priority must be an integer
  validates :priority, :numericality => { :only_integer => true }
  
  # Realpath is the path where clicking the nav item should take the user.
  # The nav item can either relate to a page or have an explicitly defined path.
  # If it's  associated with a page, the realpath is the path to the page.
  # Otherwise it's the path explicitly defined by the user.
  def realpath
    if(self.page)
      return Rails.application.routes.url_helpers.page_path(self.page)
    end
    '/' + self.explicit_path
  end
  
  # Give a default priority of 0
  def default_values
    #FIXME Breaks the nav for some reason but is needed for saving
    #self.priority ||= 0
  end
  
end
