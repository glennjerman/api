class Api::V1::UsersController < ApplicationController
  before_action :authenticate, only: [:show]

  # GET user info
  def show
    render json: UserSerializer.new(@current_user).serialized_json
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: UserSerializer.new(user).serialized_json
    else
      render json: { error: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def authenticate
    Rails.logger.debug "Authorization Header: #{request.headers['Authorization']}"
    @current_user = User.find_by(token: request.headers['Authorization'])
    Rails.logger.debug "Found User: #{@current_user.inspect}"
    render json: { error: 'Not Authorized' }, status: :unauthorized unless @current_user
  end
end
