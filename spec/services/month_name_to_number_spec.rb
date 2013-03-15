require_relative "../../app/services/month_name_to_number"

describe MonthNameToNumber do
  it "converts january to 1" do
    MonthNameToNumber.month_number_of("january").should == 1
  end

  it "converts april to 4" do
    MonthNameToNumber.month_number_of("April").should == 4
  end

  it "returns 1 in case can't find a match" do
    MonthNameToNumber.month_number_of("Not Exists").should == 1
  end
end
