class Album < ActiveRecord::Base
  validates :title, :band_id, :style, :presence => true
  belongs_to :band
  has_many :tracks
end
