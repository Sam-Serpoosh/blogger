require_relative "../../app/services/articles_month_navigator"
require 'date'

class Article; end

describe ArticlesMonthNavigator do
  let(:february) { Date.parse("2013-02-19") }
  let(:january) { Date.parse("2013-01-28") }

  it "returns articles published in a given month" do
    a1 = stub(title: "foo", created_at: stub(to_date: february))
    a2 = stub(title: "bar", created_at: stub(to_date: january))
    Article.stub(all: [a1, a2])
    articles = ArticlesMonthNavigator.articles_in("february")

    articles.count.should == 1
    articles.first.title.should == "foo"
  end
end
