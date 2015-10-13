module BackgroundCommand
  extend ActiveSupport::Concern

  included do
    include Sidekiq::Worker

    attribute :jid, String
  end

  module ClassMethods
  end

  def run
    if self.valid?
      self.jid = self.class.perform_async(self.to_params.to_json)
    else
      raise CommandNotValidError, self.errors.full_messages
    end
  end

  def perform(params)
    self.from_json(params)
    self.execute
  end

end
