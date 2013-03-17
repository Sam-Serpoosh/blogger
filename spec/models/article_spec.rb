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
end

class MyTag
  def initialize(name) 
    @name = name
  end

  def to_s
    @name
  end
end
