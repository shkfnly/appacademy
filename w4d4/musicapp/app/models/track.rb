class Track < ActiveRecord::Base
  validates :name, :album_id, :distrib, :presence => true
  belongs_to :album
end
