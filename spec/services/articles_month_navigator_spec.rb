require_relative "../../app/services/articles_month_navigator"
require 'date'

class Article; end

describe ArticlesMonthNavigator do
  let(:february) { Date.parse("2013-02-19") }
  let(:january) { Date.parse("2013-01-28") }
  let(:march) { Date.parse("2013-03-01") }

  it "returns articles published in a given month" do
    a1 = stub(title: "foo", created_at: stub(to_date: february))
    a2 = stub(title: "bar", created_at: stub(to_date: january))
    a3 = stub(title: "baz", created_at: stub(to_date: march))
    Article.should_receive(:where).
      with("created_at >= ? AND created_at < ?", 
           Date.parse("2013-02-01"), 
           Date.parse("2013-03-01")) { [a1] }

    articles = ArticlesMonthNavigator.articles_in("february")

    articles.count.should == 1
    articles.first.title.should == "foo"
  end

  context "#period" do
    it "creates the period for selected month" do
      period = ArticlesMonthNavigator.period_of("february")
      period.begins_at.should == Date.parse("2013-02-01")
      period.ends_at.should == Date.parse("2013-03-01")
    end

    it "set the next month jan next year in case of december" do
      period = ArticlesMonthNavigator.period_of("december")
      period.begins_at.should == Date.parse("2013-12-01")
      period.ends_at.should == Date.parse("2014-01-01")
    end
  end
end
