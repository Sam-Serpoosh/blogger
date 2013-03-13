require_relative "../../app/services/tag_processor"

describe TagProcessor do
  it "removes extra white space & downcase tags" do
    tags_string = "   ruby     , RaILs   "
    TagProcessor.tags_from(tags_string).should == ["ruby", "rails"]
  end

  it "eliminate duplicate items in the tags" do
    tags_string = "ruby, rails, ruby"
    TagProcessor.tags_from(tags_string).should == ["ruby", "rails"]
  end
end
