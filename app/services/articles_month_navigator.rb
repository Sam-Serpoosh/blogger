class ArticlesMonthNavigator
  def self.articles_in month
    Article.all.select do |article|
      published_month = article.created_at.to_date.month
      month_number = MonthNameToNumber.month_number_of(month)
      published_month == month_number
    end
  end
end
