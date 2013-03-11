require_relative "../services/tag_processor"

class Article < ActiveRecord::Base
  attr_accessible :title, :body, :tag_list, :attachment
  has_many :comments
  has_many :taggings
  has_many :tags, through: :taggings
  has_many :attachments

  validates :title, presence: true
  validates :body, presence: true

  def tag_list
    self.tags.join(", ")
  end

  def tag_list=(tags_string)
    self.taggings.destroy_all
    tag_names = TagProcessor.tags(tags_string)
    tag_names.each do |tag_name|
      tag = Tag.find_or_create_by_name(tag_name)
      tagging = self.taggings.new
      tagging.tag_id = tag.id
    end
  end

  def images
    self.attachments.map(&:image)
  end

  def attachment=(file)
    self.attachments.build(image: file)
  end
end
