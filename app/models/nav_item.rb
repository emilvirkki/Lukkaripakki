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
    self.path
  end
  
  def default_values
    self.priority ||= 0;
  end
  
  def parent_items
    NavItem.to_depth(0)
  end
end
