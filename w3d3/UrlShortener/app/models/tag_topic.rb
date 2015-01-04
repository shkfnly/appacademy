class TagTopic < ActiveRecord::Base
  validates_presence_of :topic

  has_many(
  :taggings,
  :class_name => "Tagging",
  :foreign_key => :tag_id,
  :primary_key => :id
  )

  has_many(
  :urls,
  Proc.new { distinct },
  :through => :taggings,
  :source => :url
  )
end
