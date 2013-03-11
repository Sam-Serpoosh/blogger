class TagProcessor
  def self.tags tags_string
    tags_string.split(",").map(&:strip).map(&:downcase).uniq
  end
end
