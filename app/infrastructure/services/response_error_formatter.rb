module Services
  class ResponseErrorFormatter

    def self.format(controller, error)
      instance = new(controller)
      instance.format(error)
    end

    def initialize(controller)
      @controller = controller
    end

    def format(error)
      if error.is_a?(NoBrainer::Error::DocumentNotFound)
        {
          status: :not_found,
          json: {
            success: false,
            info: error.message,
            data: {}
          }
        }
      else
        {
          status: :unprocessable_entity,
          json: {
            success: false,
            info: "#{error.class}: #{error.message}",
            data: {}
          }
        }
      end
    end

  end
end

