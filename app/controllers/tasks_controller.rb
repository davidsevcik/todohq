class TasksController < ApplicationController
  before_filter :authenticate_user!
  respond_to :json

  def index
    respond_with current_user.tasks #.order priority: :desc, id: :asc
  end

  def create
    task = current_user.tasks.create task_params
    respond_with task
  end

  def update
    with_task do |task|
      task.update_attributes(task_params)
      respond_with task
    end
  end

  def destroy
    with_task do |task|
      task.destroy
      render json: {}, status: :no_content
    end
  end


private

  def task_params
    params.permit :title, :priority, :done
  end

  def with_task
    if task = current_user.tasks.find_by(id: params[:id])
      yield task
    else
      render json: {}, status: :not_found
    end
  end

end
