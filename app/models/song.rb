class Song < ActiveRecord::Base
  validates :name, :presence => true
  validates :lyrics, :presence => true
  acts_as_taggable
end
