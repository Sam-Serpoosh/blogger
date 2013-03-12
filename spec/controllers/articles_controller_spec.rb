require 'spec_helper'

describe ArticlesController do 
  describe "listing" do
    it "fetches the list of all articles" do
      articles = [stub, stub]
      Article.stub(:all => articles)
      get :index
      assigns(:articles).should == articles
    end
  end

  describe "showing" do
    it "fetches the article by id and associate the comment with it" do
      article = stub(:id => 1)
      Article.stub(:find).with("1") { article }
      comment = OpenStruct.new
      Comment.stub(:new => comment)

      get :show, id: 1

      assigns(:article).should == article
      comment.article_id.should == 1
    end
  end

#  describe "creating" do
#    it "creates article with valid attributes" do
#      article_param = { title: "title", body: "body" }
#      post :create, article: article_param
#
#      article = stub
#      Article.should_receive(:new) { article }
#      article.should_receive(:save)
#    end
#  end
end
