require 'rails_helper'

RSpec.describe Categories::CreateCategoryCommand do

  describe "#execute" do

    it "sets the id field" do
      cmd = Categories::CreateCategoryCommand.new(:name => "Book")
      cmd.execute
      expect(cmd.id).to_not be_nil
    end

    it "requies a name" do
      cmd = Categories::CreateCategoryCommand.new(:name => "Book")
      expect(cmd).to be_valid
    end

    it "adds an category" do
      cmd = Categories::CreateCategoryCommand.new(:name => "Book")
      expect { cmd.execute }.to change(Category, :count).by(1)
    end

    it "creates a new event" do
      cmd = Categories::CreateCategoryCommand.new(:name => "Book")
      expect { cmd.execute }.to change(Event, :count).by(1)
    end

  end
end
