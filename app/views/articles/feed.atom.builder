atom_feed language: "en-US" do |feed|
  feed.title @feed_title
  feed.updated @feed_updated

  @articles.each do |article|
    next if article.updated_at.blank?
    feed.entry(article) do |entry|
      entry.url article_url(article)
      entry.title article.title
      entry.content article.body, type: "html"
      entry.updated(article.updated_at.strftime("%Y-%m-%dT%H:%M:%SZ"))
    end
  end
end
