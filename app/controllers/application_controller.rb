class ApplicationController < ActionController::API
  SECRET = "shush"

  def the_current_user
    User.find(token_user_id)
  end

  def token_user_id
    decoded_token.first['id']
  end

  def token
    request.headers['Authorization']
  end

  def issue_token(payload)
    JWT.encode(payload, SECRET)
  end

  def decoded_token
    if token
      begin
        JWT.decode(token, SECRET, true)
      rescue JWT::DecodeError
        return [{}]
      end
    else
      [{}]
    end
  end
end
