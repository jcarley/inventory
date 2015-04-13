class Command
  include Virtus.model
  include ActiveModel::Validations
  include ActiveModel::Serializers::JSON

  class NotImplementedError < StandardError; end
  class CommandNotValidError < StandardError; end

  def self.from_json(json)
    klass = self.new
    klass.from_json(json)
    klass
  end

  def to_params
    ::HashWithIndifferentAccess.new(attributes).delete_if { |key, value| value.nil? }
  end
  alias_method :to_hash, :to_params

  def run
    if self.valid?
      self.execute
    else
      raise CommandNotValidError, self.errors.full_messages
    end
  end

  def execute
    raise NotImplementedError, "#{self.class.name} does not implement an execute method"
  end

  # protected

  # def event(event)
    # store event
    # publish event
  # end

  private

  # def store(event)
    # event.save! if event
  # end

  # def publish(event)
    # EventServer.publish event if event
  # end

end


