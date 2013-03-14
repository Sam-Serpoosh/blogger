require 'spec_helper'

describe Comment do
  context "#associations" do
    it "belongs to an article" do
      article = Article.new(title: "foo", body: "baar")
      comment = article.comments.build(author_name: "bob", 
                                       body: "barbaz")
      article.save!
      comment.article.should == article
    end
  end
end
