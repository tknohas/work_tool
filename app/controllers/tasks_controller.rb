class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update destroy]

  def index
    @tasks = if params[:completed].present?
               Task.complete.latest_completed
             else
               Task.incomplete.latest_created
             end
    @task = Current.user.tasks.build
  end

  def show
  end

  def new
    @task = Current.user.tasks.build
  end

  def create
    @task = Current.user.tasks.build(tasks_params)
    if @task.save
      redirect_to tasks_path, notice: '登録しました'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @task.update(tasks_params)
      redirect_to task_path(@task), notice: '変更しました'
    else
      render :edit
    end
  end

  def destroy
    @task.destroy!
    redirect_to tasks_path, notice: '削除しました'
  end

  private

  def tasks_params
    params.expect(task: %i[title description completed_at priority])
  end

  def set_task
    @task = Task.find(params[:id])
  end
end
