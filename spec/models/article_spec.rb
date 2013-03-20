require 'spec_helper'
require_relative "../../app/services/articles_month_navigator"

describe Article do
  let(:article) {
    Article.new(title: "foo",
                body: "barbaz")
  }

  context "#validation" do
    it "is not valid without title" do
      article.title = nil
      article.should_not be_valid
    end

    it "is not valid without body" do
      article.body = nil
      article.should_not be_valid
    end
  end

  context"#tags" do
    it "gives the articles tags" do
      tags = [MyTag.new("1"), MyTag.new("2")]
      article = Article.new
      article.stub(:tags => tags)
      article.tag_list.should == "1, 2"
    end

    it "creates or finds the tags for the article" do
      article.tag_list = "ruby  ,    rAILs  "
      article.save
      article.tag_list.should == "ruby, rails"
    end
  end

  context "#attachments" do
    it "fetches the images" do
      attachments = [stub(:image => "1.png"), stub(:image => "2.png")]
      article = Article.new
      article.stub(:attachments => attachments)
      article.images.should == ["1.png", "2.png"]
    end
  end

  context "#viewed_count" do
    it "sets the viewed_count to 0 by default" do
      article.save!
      article.viewed_count.should == 0
    end

    it "increments the viewed count" do
      article.save!
      article.viewed
      from_db = Article.find(article.id)
      from_db.viewed_count.should == 1
    end
  end

  context "popular articles" do
    it "fetches 3 most popular articles" do
      articles = []
      4.times do
        articles << Article.create!(title: "foo", body: "bar")
      end
      view_many_times(articles[0], 10)
      view_many_times(articles[1], 8)
      view_many_times(articles[3], 5)

      popular = Article.popular_articles
      popular.should == [articles[0], articles[1], articles[3]]
    end

    def view_many_times(an_article, number)
      number.times { an_article.viewed }
    end
  end
end

class MyTag
  def initialize(name) 
    @name = name
  end

  def to_s
    @name
  end
end
