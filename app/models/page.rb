class Page < ActiveRecord::Base
  # Each page must have a nav item.
  # Destroy the nav item relating to the page if the page is distroyed.
  belongs_to :nav_item, :dependent => :destroy
  
  validates :title, :presence => true
  validates :content, :presence => true
  
  # This is to make it possible to embed the nav item fields in the page form
  accepts_nested_attributes_for :nav_item
end
