class Page < ActiveRecord::Base
  belongs_to :nav_item, :dependent => :destroy
  
  validates :title, :presence => true
  validates :content, :presence => true
  
  accepts_nested_attributes_for :nav_item
end
