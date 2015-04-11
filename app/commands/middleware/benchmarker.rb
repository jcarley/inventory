module Middleware
  class Benchmarker

    def initialize(app)
      @app = app
    end

    def call(env)
      elapsed = Benchmark.realtime do
        @app.call(env) if @app
      end
      env[:elapsed] = elapsed
    end

  end
end

