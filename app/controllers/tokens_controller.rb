class TokensController  < ApplicationController

  skip_before_action :grant_access, :only => :access_token

  def access_token

    # raise SomeError unless ApiKey.system_key?(api_key)

    token_record = Token.create_access_token_for(current_user, user_agent)
    token_repo = TokenRepository.new
    token_repo.save(token_record)

    render json: token_record
  end

end
