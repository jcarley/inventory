class TranscodeController < ApplicationController

  def invoke

    cmd = Processing::TranscodeCommand.new

    Domain.execute(cmd) do
      is_success? { |result| render status: :ok, json: "{}" }
      is_error? { |result| render status: :ok, json: "{}" }
    end

  end
end
