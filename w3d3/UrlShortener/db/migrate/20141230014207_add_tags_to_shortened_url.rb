class AddTagsToShortenedUrl < ActiveRecord::Migration
  def change
    add_column :shortened_urls, :tag_topic, :string
  end
end
