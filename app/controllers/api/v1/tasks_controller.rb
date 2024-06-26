class Api::V1::TasksController < ApplicationController
  before_action :authenticate

  # POST /tasks
  def create
    task = @current_user.tasks.build(task_params)
    if task.save
      render json: TaskSerializer.new(task).serialized_json
    else
      render json: { error: task.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # POST /tasks/routine
  def create_routine
    task = @current_user.tasks.build(task_params)
    if task.save
      schedule = task.schedules.build(schedule_params)
      if schedule.save
        render json: TaskSerializer.new(task).serialized_json
      else
        render json: { error: schedule.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { error: task.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # GET /tasks
  def index
    render json: TaskSerializer.new(@current_user.tasks).serialized_json
  end

  # PATCH /tasks/:id
  def update
    task = @current_user.tasks.find(params[:id])
    if task.update(task_params)
      render json: 'Task updated'.to_json
    else
      render json: { error: task.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH /tasks/:id/routine
  def update_routine
    task = @current_user.tasks.find(params[:id])
    if task.update(task_params)
      schedule = task.schedules.first
      if schedule.update(schedule_params)
        render json: 'Task updated'.to_json
      else
        render json: { error: schedule.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { error: task.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /tasks/:id
  def destroy
    task = @current_user.tasks.find(params[:id])
    if task.destroy
      render json: 'Task deleted'.to_json
    else
      render json: { error: task.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH /tasks/:id/complete
  def complete
    task = @current_user.tasks.find(params[:id])
    task.completed ||= []
    date = params[:date] ? Date.strptime(params[:date], "%m/%d/%Y") : Time.now.strftime("%m/%d/%Y")
    task.completed << date
    if task.save
      render json: 'Task completed'.to_json
    else
      render json: { error: task.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH /tasks/:id/uncomplete
  def uncomplete
  task = @current_user.tasks.find(params[:id])
  date_to_remove = params[:date] ? Date.strptime(params[:date], "%m/%d/%Y").strftime("%Y-%m-%d") : Time.now.strftime("%Y-%m-%d")
  Rails.logger.warn "Task completed dates: #{task.completed.inspect}"
  Rails.logger.warn "Date to remove: #{date_to_remove}"
  if task.permanent
    task.completed = []
  else
    task.completed.delete(date_to_remove)
  end
  if task.save
    render json: 'Task uncompleted'.to_json
  else
    render json: { error: task.errors.full_messages }, status: :unprocessable_entity
  end
end

  private

  def schedule_params
    params.require(:schedule).permit(:monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday)
  end

  def task_params
    params.require(:task).permit(:desc, :title, :time_to_complete, :created_at, :start_time, :end_time, :completed, :permanent)
  end

  def authenticate
    Rails.logger.debug "Authorization Header: #{request.headers['Authorization']}"
    @current_user = User.find_by(token: request.headers['Authorization'])
    Rails.logger.debug "Found User: #{@current_user.inspect}"
    render json: { error: 'Not Authorized' }, status: :unauthorized unless @current_user
  end

end
