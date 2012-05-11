class NavItem < ActiveRecord::Base
  has_ancestry
  
  has_one :page, :dependent => :destroy
  
  after_initialize :default_values
  
  #FIXME breaks saving
  validates :priority, :numericality => { :only_integer => true }
  
  def realpath
    if(self.page)
      return Rails.application.routes.url_helpers.page_path(self.page)
    end
    '/' + self.explicit_path
  end
  
  def default_values
    #FIXME Breaks the nav for some reason but is needed for saving
    #self.priority ||= 0
  end
  
  def parent_items
    NavItem.to_depth(0)
  end
end
