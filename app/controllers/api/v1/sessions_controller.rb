class Api::V1::SessionsController < ApplicationController

  def create
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      user.update!(token: SecureRandom.hex)
      render json: { token: user.token }
    else
      render json: { error: "Invalid username or password" }, status: :unauthorized
    end
  end

  def destroy
    user = User.find_by(token: request.headers["Authorization"])
    if user
      user.update!(token: nil)
      head :no_content
    else
      render json: { error: "Invalid token" }, status: :unauthorized
    end
  end
end
