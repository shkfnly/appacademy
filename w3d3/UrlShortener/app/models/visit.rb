class Visit < ActiveRecord::Base
  validates_presence_of :visitor_id, :visited_url

  def self.record_visit!(user, shortened_url)
    Visit.create!({:visitor_id => user.id, :visited_url => shortened_url.id})
  end

  belongs_to(
    :visitor,
    :class_name => "User",
    :foreign_key => :visitor_id,
    :primary_key => :id
  )

  belongs_to(
    :url,
    :class_name => "ShortenedUrl",
    :foreign_key => :visited_url,
    :primary_key => :id
  )

end
