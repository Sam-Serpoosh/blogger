require_relative "../../app/services/viewed_text"

describe ViewedText do
  it "is plural for more than one" do
    ViewedText.for(2).should == "Viewed 2 times"
  end

  it "is single for one" do
    ViewedText.for(1).should == "Viewed 1 time"
  end
end
