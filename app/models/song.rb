class Song < ActiveRecord::Base
  validates :name, :presence => true
  validates :lyrics, :presence => true
  
  # The songs can be tagged
  acts_as_taggable
end
