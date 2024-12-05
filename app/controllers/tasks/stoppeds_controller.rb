class Tasks::StoppedsController < ApplicationController
  def create
    @task = Task.find(params[:task_id])
    @task.update!(stopped_at: Time.current)
    redirect_to task_path(@task)
  end
end
