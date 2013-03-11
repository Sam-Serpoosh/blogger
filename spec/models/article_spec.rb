require 'spec_helper'

describe Article do
  context "#validation" do
    let(:article) {
      Article.new(title: "foo",
                  body: "barbaz")
    }

    it "is not valid without title" do
      article.title = nil
      article.should_not be_valid
    end

    it "is not valid without body" do
      article.body = nil
      article.should_not be_valid
    end
  end
end
