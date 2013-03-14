require 'spec_helper'

describe Author do
  context "#validations" do
    it "is not valid without password confirmation" do
      author = Author.new(username: "bob", email: "bob@example.com", 
                          password: "password",
                          password_confirmation: "no match")
      author.should_not be_valid
    end

    it "is valid with matching password confirmation" do
      author = Author.new(username: "bob", email: "bob@example.com", 
                          password: "password",
                          password_confirmation: "password")
      author.should be_valid
    end
  end
end
