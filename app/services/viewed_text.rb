class ViewedText
  def self.for(number)
    times = number == 1 ? "time" : "times"
    "Viewed #{number} #{times}"
  end
end
