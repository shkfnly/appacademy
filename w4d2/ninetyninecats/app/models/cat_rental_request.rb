class CatRentalRequest < ActiveRecord::Base
  validates :cat_id, :start_date, :end_date, :status, :presence => true
  validates :status, :inclusion => { in: %w[PENDING APPROVED DENIED] }
  validate :no_overlapping_approved_requests

  belongs_to :cat

  def approve!
    if overlapping_approved_requests.empty?
      CatRentalRequest.transaction do
        self.status = "APPROVED"
        self.save!
        overlapping_pending_requests.each do |request|
          request.deny!
        end
      end
    else
      return false
    end
  end

  def deny!
    if self.status == "PENDING"
      self.status = "DENIED"
      self.save!
    end
  end

  def overlapping_requests
    CatRentalRequest.where(<<-SQL, self.start_date, self.end_date, self.start_date, self.end_date)
    ((start_date BETWEEN ? AND ?) OR
    (end_date BETWEEN ? AND ?))
    SQL
  end

  def overlapping_approved_requests
    if self.id.nil?
      self.overlapping_requests.where("status = 'APPROVED' AND id IS NOT NULL")
    else
      self.overlapping_requests.where("status = 'APPROVED' AND id  <> ?", self.id)
    end
  end

  def overlapping_pending_requests
    if self.id.nil?
      self.overlapping_requests.where("status = 'PENDING' AND id IS NOT NULL")
    else
      self.overlapping_requests.where("status = 'PENDING' AND id  <> ?", self.id)
    end
  end

  private
  def no_overlapping_approved_requests
    unless self.overlapping_approved_requests.empty? || self.status == 'DENIED' || self.status == 'PENDING'
      errors[:base] << "Dates can't overlap with other requests"
    end
  end
end
