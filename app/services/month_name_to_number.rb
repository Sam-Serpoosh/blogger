require 'date'

class MonthNameToNumber
  def self.month_number_of(month_name)
    (1..12).each do |num|
      return num if month_name.downcase == Date::MONTHNAMES[num].downcase
    end
    1
  end
end
