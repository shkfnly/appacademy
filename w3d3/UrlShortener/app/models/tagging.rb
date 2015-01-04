class Tagging < ActiveRecord::Base
  validates_presence_of :tag_id, :url_id

  belongs_to(
    :url,
    :class_name => "ShortenedUrl",
    :foreign_key => :url_id,
    :primary_key => :id
  )

  belongs_to(
    :tag,
    :class_name => "TagTopic",
    :foreign_key => :tag_id,
    :primary_key => :id
  )
end
