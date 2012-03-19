class Song < ActiveRecord::Base
  validates :name, :presence => true
  validates :lyrics, :presence => true
end
