class Domain
  include Singleton

  def self.execute(command)
    if block_given?
      block = Proc.new
      instance.execute(command, &block)
    else
      instance.execute(command)
    end
  end

  def execute(command)
    env = {:command => command}
    default_middleware.call(env)
    if block_given?
      cr = env[:command_result]
      block = Proc.new
      proxy = CommandResultProxy.new(cr, block)
      proxy.execute
      cr
    else
      env[:command_result]
    end
  end

  def default_middleware
    @stack ||= Middleware::Builder.new do
      use Middleware::Benchmarker
      use Middleware::CommandRunner
    end
    @stack
  end

end
