require 'spec_helper'

describe CommentsController do
  describe "creating" do
    it "creates comment associated with related article" do
      article = Article.create!(title: "foo", body: "bar")
      attributes = { author_name: "bob", body: "lorem ipsum", 
                     article_id: article.id }
      lambda do
        post :create, comment: attributes
      end.should change(Comment, :count).by 1
      Comment.first.article.should == article
    end
  end
end
