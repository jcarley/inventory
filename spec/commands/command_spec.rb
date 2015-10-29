require 'rails_helper'

RSpec.describe Command do

  describe "#run" do

    context "when not valid" do
      it "raises an CommandInvalidError" do
        command = Command.new
        allow(command).to receive(:valid?).and_return(false)
        expect { command.run }.to raise_error(CommandNotValidError)
      end
    end
  end
end
