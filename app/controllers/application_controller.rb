class ApplicationController < ActionController::API
  include ActionController::Serialization

  class NotAuthorizedError < StandardError; end;

  rescue_from NotAuthorizedError, with: :deny_access

  before_action :check_credentials
  before_action :grant_access

  attr_reader :current_user, :auth_token, :api_key

  protected

    def user_agent
      request.user_agent
    end

    def deny_access
      render status: :unauthorized, json: ""
    end

    def show_errors(exception)
    end

  private

    def check_credentials
      @auth_token = authorization_header
      @api_key = api_key_header
      @current_user = find_current_user
    end

    def grant_access

      # ActionController::HttpAuthentication::Token
      # encode_credentials(token, options = {})

      # if ApiKey.system_key?(api_key)
        # authenticate_with_http_token do |token, options|

        # end
      # end

    end

    def authorization_header
      header_value = request.env["Authorization"]
      raise NotAuthorizedError if header_value.blank?
      header_value
    end

    def api_key_header
      key = request.env["Api-Key"]
      raise NotAuthorizedError if key.blank?
      key
    end

    def access_key
      access_key = request.env["AccessKey"]

    end

    def find_current_user
      user_id = extract_user_id
      user = User.find(user_id)
      raise NotAuthorizedError unless user.enabled
      user
    end

    def extract_user_id
      token_data(auth_token)[:user_id]
    end

    def token_data(sts_token)
      token = sts_token.split(":")[0]
      user_id = sts_token.split(":")[1]
      { token: token, user_id: user_id }
    end
end
