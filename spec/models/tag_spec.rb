require 'spec_helper'

describe Tag do
  context "#destroy" do
    it "also destroy associated taggings" do
      tag = Tag.new(name: "foo")
      tag.taggings.build
      tag.save
      Tagging.count.should == 1

      tag.destroy
      Tagging.count.should == 0
    end
  end
end
