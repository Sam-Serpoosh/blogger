class Article < ActiveRecord::Base
  attr_accessible :title, :body, :tag_list, :image
  has_many :comments
  has_many :taggings
  has_many :tags, through: :taggings
  has_attached_file :image

  def tag_list
    self.tags.join(", ")
  end

  def tag_list=(tags_string)
    self.taggings.destroy_all
    tag_names = tags_string.split(",").map(&:strip).map(&:downcase).uniq
    tag_names.each do |tag_name|
      tag = Tag.find_or_create_by_name(tag_name)
      tagging = self.taggings.new
      tagging.tag_id = tag.id
    end
  end
end
