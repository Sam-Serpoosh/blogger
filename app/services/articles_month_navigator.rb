require 'date'
require 'active_support/core_ext/object'
require_relative "./month_name_to_number"

class ArticlesMonthNavigator
  def self.articles_in month
    month_period = period_of month
    Article.where("created_at >= ? AND created_at < ?", 
                  month_period.begins_at, month_period.ends_at)
  end

  def self.period_of month
    month_number = MonthNameToNumber.month_number_of(month)
    this_year = Date.today.year.to_s
    period = Period.new
    period.begins_at = Date.parse("#{this_year}-#{month_number}-01")
    period.ends_at = period.begins_at + 1.month
    period
  end
end

class Period
  attr_accessor :begins_at, :ends_at
end
