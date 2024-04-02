class Api::V1::FavoriteTasksController < ApplicationController
  before_action :authenticate

  # POST /favorite_tasks
  def create
    task = @current_user.favorite_tasks.build(task_params)
    if task.save
      render json: FavoriteTasksSerializer.new(task).serialized_json
    else
      render json: { error: task.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH /favorite_tasks/:id
  def update
    task = @current_user.favorite_tasks.find(params[:id])
    if task.update(task_params)
      render json: 'Favorite Task Updated'.to_json
    else
      render json: { error: task.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # GET /favorite_tasks
  def index
    render json: FavoriteTasksSerializer.new(@current_user.favorite_tasks).serialized_json
  end

  # DELETE /favorite_tasks/:id
  def destroy
    task = @current_user.favorite_tasks.find(params[:id])
    if task.destroy
      render json: 'Favorite Task Deleted'.to_json
    else
      render json: { error: task.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # POST /favorite_tasks/routine
  def create_routine
    task = @current_user.favorite_tasks.build(task_params)
    if task.save
      schedule = task.schedules.build(schedule_params)
      if schedule.save
        render json: FavoriteTasksSerializer.new(task).serialized_json
      else
        render json: { error: schedule.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { error: task.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH /favorite_tasks/:id/routine
  def update_routine
    task = @current_user.favorite_tasks.find(params[:id])
    if task.update(task_params)
      schedule = task.schedules.first
      if schedule.update(schedule_params)
        render json: 'Favorite Task Updated'.to_json
      else
        render json: { error: schedule.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { error: task.errors.full_messages }, status: :unprocessable_entity
    end
  end


  private

  def task_params
    params.require(:task).permit(:desc, :title, :start_time, :end_time)
  end

  def schedule_params
    params.require(:schedule).permit(:monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday)
  end

  def authenticate
    Rails.logger.debug "Authorization Header: #{request.headers['Authorization']}"
    @current_user = User.find_by(token: request.headers['Authorization'])
    Rails.logger.debug "Found User: #{@current_user.inspect}"
    render json: { error: 'Not Authorized' }, status: :unauthorized unless @current_user
  end
end
