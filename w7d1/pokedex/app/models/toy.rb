class Toy < ActiveRecord::Base
  belongs_to :pokemon

  validates :happiness, :image_url, :name, :pokemon, :price, presence: true
  validates :happiness, :price, numericality: true
end
