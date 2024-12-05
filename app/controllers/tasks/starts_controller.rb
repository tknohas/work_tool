class Tasks::StartsController < ApplicationController
  def create
    @task = Task.find(params[:task_id])
    @task.update!(start_at: Time.current)
    redirect_to task_path(@task)
  end
end
