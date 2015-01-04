require 'securerandom'

class ShortenedUrl < ActiveRecord::Base
  validates_presence_of :short_url, :long_url, :submitter_id

  belongs_to(
    :submitter,
    :class_name => "User",
    :foreign_key => :submitter_id,
    :primary_key => :id
  )

  has_many(
    :visits,
    :class_name => "Visit",
    :foreign_key => :visited_url,
    :primary_key => :id
  )

  has_many(
    :visitors,
    Proc.new {distinct},
    :through => :visits,
    :source => :visitor
  )

  has_many(
  :taggings,
  :class_name => "Tagging",
  :foreign_key => :url_id,
  :primary_key => :id
  )

  has_many(
  :tags,
  Proc.new { distinct },
  :through => :taggings,
  :source => :tag
  )

  def self.random_code
    url = SecureRandom::urlsafe_base64(4)
    while ShortenedUrl.exists?(url)
      url = SecureRandom::urlsafe_base64(4)
    end
    url
  end

  def self.create_for_user_and_long_url!(user, long_url, tag = null)
    ShortenedUrl.create!({:long_url => long_url, :short_url => random_code, :submitter_id => user.id, :tag_topic => tag})
    Tagging.create!({:url_id => ShortenedUrl.last.id, :tag_id => TagTopic.find_by(:topic => "#{tag}").id})
  end

  def num_clicks
    visits.group(:visited_url).count[id]
  end

  def num_uniques
    visitors.count
  end

  def num_recent_uniques
    recent_time = 10.minutes.ago
    visits.where("created_at > '#{recent_time}'").distinct.count
  end
end
