class TranscodeController < ApplicationController

  def invoke

    cmd = Processing::TranscodeCommand.new(:id => "1234", :name => "Transcoder", :description => "Something useful")

    Domain.execute(cmd) do
      is_success? { |result| render status: :ok, json: "{\"jid\":\"#{cmd.jid}\"}" }
      is_error? { |result| render status: :ok, json: "{\"error\":\"#{result.error}\"}" }
    end

  end
end
