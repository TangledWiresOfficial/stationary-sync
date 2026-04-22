class ApplicationController < ActionController::API
  before_action :require_auth!

  def require_auth!
    authorization = request.headers["Authorization"]
    unless authorization
      render json: { error: "No token provided" }, status: :unauthorized
      return
    end

    token = authorization.split(" ").last

    payload = Utils::Auth.decode_token(token)
    unless payload
      render json: { error: "Invalid token" }, status: :unauthorized
      return
    end

    @user = User.find_or_create_by(uid: payload["sub"]) do |u|
      u.name = payload["name"]
      u.email = payload["email"]
    end
  end
end
