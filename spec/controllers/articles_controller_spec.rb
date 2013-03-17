require 'spec_helper'

describe ArticlesController do 
  describe "listing" do
    context "#all_articles" do
      it "fetches the list of all articles" do
        articles = [stub, stub]
        Article.stub(all: articles)
        get :index
        assigns(:articles).should == articles
      end
    end
    
#    context "#published_in_month" do
#      before do
#        a = Article.new(title: "foo", body: "bar")
#        a.created_at = Date.parse("2013-02-20")
#        a.save!
#
#        a = Article.new(title: "bar", body: "baz")
#        a.created_at = Date.parse("2013-03-1")
#        a.save!
#      end
#
#      it "fetches articles in a given month" do
#        post :published_in, month: "february"
#        assigns(:articles).count.should == 1
#        assigns(:articles).first.title.should == "foo"
#      end
#    end
  end

  describe "showing" do
    it "fetches the article by id and associate the comment with it" do
      article = stub(id: 1)
      Article.stub(:find).with("1") { article }
      comment = stub
      comment.should_receive(:article_id=).with(1)
      Comment.stub(new: comment)

      get :show, id: 1

      assigns(:article).should == article
    end
  end

  describe "manipulating articles" do
    before do
      @user = AuthorFactory.create("bob")
      login_user
    end

    after do
      logout_user
    end

    context "#new" do
      it "article should not be nil" do
        get :new
        assigns(:article).should_not be_nil
      end
    end

    context "#creating" do
      let(:attributes) do
        { title: "foo", body: "barbaz" }
      end

      it "creates article with valid attributes" do
        lambda do
          post :create, article: attributes
        end.should change(Article, :count).by 1
      end

      it "does not create article with invalid attributes" do
        lambda do
          post :create, article: attributes.merge!(title: "")
        end.should_not change(Article, :count)
      end
    end

    context "#editing" do
      it "finds the article and sets it" do
        article = stub(title: "foo")
        Article.stub(:find) { article }
        get :edit, id: 1

        assigns(:article).title.should == "foo"
      end
    end

    context "#updating" do
      let(:attributes) do
        { title: "foo", body: "barbaz" }
      end

      it "updates the article with valid attributes" do
        article = stub(title: "foo", update_attributes: true)
        Article.stub(:find) { article }
        put :update, id: 1, article: attributes

        flash.notice.should == "Article foo Updated!"
      end

      it "does not update article with invalid attributes" do
        article = stub(title: "foo", update_attributes: false)
        Article.stub(:find) { article }
        put :update, id: 1, article: attributes.merge!(title: "")

        flash.notice.should be_nil
      end
    end

    context "#deleting" do
      it "deletes the article" do
        article = stub(title: "foo")
        article.should_receive(:destroy)
        Article.stub(:find) { article }
        delete :destroy, id: 1

        flash.notice.should == "Article foo Deleted!"
      end
    end
  end
end
