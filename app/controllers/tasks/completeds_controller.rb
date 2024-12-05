class Tasks::CompletedsController < ApplicationController
  before_action :set_task, only: %i[create destroy]

  def create
    @task.update!(completed_at: Time.current)
    redirect_to task_path(@task)
  end

  def destroy
    @task.update!(completed_at: nil)
    redirect_to task_path(@task)
  end

  private

  def set_task
    @task = Task.find(params[:task_id])
  end
end
