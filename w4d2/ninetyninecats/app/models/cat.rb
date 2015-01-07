class Cat < ActiveRecord::Base
  validates :birth_date, :color, :name, :sex, :description, :presence => true
  validates :color, inclusion: { in: %w{black red white green blue metallica},
    message: "Not a valid color" }
  validates :sex, inclusion: { in: %w{M F}, message: "Not valid sex"  }

  has_many :cat_rental_requests, dependent: :destroy

  def age
    ((Time.now.to_date - birth_date) / 365).to_i
  end

end
