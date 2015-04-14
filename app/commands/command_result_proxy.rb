class CommandResultProxy

  def initialize(command_result, block)
    @command_result = command_result
    @block = block
    @receiver = block.binding.receiver
  end

  def execute
    self.instance_eval(&@block)
  end

  def is_success?(&block)
    if @command_result.is_successful?
      @receiver.instance_exec(@command_result, &block)
    end
  end

  def is_error?(&block)
    if ! @command_result.is_successful?
      @receiver.instance_exec(@command_result, &block)
    end
  end
end

