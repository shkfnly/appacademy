class Pokemon < ActiveRecord::Base
  TYPES = [
    "fire",
    "electric",
    "normal",
    "ghost",
    "psychic",
    "water",
    "bug",
    "dragon",
    "grass",
    "fighting",
    "ice",
    "flying",
    "poison",
    "ground",
    "rock",
    "steel"
  ].sort

  serialize :moves, Array

  has_many :toys

  validates :attack, :defense, :image_url, :name, :moves, :poke_type, presence: true
  validates :attack, :defense, numericality: true
  validates :poke_type, inclusion: { in: TYPES }
end
