class CommandResult
  attr_accessor :command, :error

  def initialize(command)
    self.command = command
  end

  def success?
    self.error.nil?
  end
  alias_method :is_successful?, :success?

  def is_success?(&block)
    on_success?(&block)
  end

  def is_error?(&block)
    on_error?(&block)
  end

  def on_success?(&block)
    if self.is_successful?
      block.call(self)
    end
    self
  end

  def on_error?(&block)
    if ! self.is_successful?
      block.call(self)
    end
    self
  end

end

