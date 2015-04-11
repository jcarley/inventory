require 'rails_helper'

RSpec.describe Assets::CreateAssetCommand do

  describe "#execute" do

    it "requies a name" do
      cmd = Assets::CreateAssetCommand.new(:name => "Book")
      expect(cmd).to be_valid
    end

    it "adds an asset" do
      cmd = Assets::CreateAssetCommand.new(:name => "Book")
      expect { cmd.execute }.to change(Asset, :count).by(1)
    end

    it "creates a new event" do
      cmd = Assets::CreateAssetCommand.new(:name => "Book")
      expect { cmd.execute }.to change(Event, :count).by(1)
    end

  end

end
