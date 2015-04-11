class Domain
  include Singleton

  def self.execute(command)
    instance.execute(command)
  end

  def execute(command)
    env = {:command => command}
    default_middleware.call(env)
    env[:command_result]
  end

  def default_middleware
    @stack ||= Middleware::Builder.new do
      use Middleware::Benchmarker
      use Middleware::CommandRunner
    end
    @stack
  end

end

