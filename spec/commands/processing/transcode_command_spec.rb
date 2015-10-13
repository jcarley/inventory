require 'rails_helper'

RSpec.describe Processing::TranscodeCommand do

  describe "#execute" do

    it "gets enqueued into redis" do
      cmd = Processing::TranscodeCommand.new(:id => "1234", :name => "Transcoder", :description => "Something useful")
      expect {
        Domain.execute(cmd)
      }.to change(Processing::TranscodeCommand.jobs, :size).by(1)
    end

  end

end

