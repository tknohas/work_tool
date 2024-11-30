class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  def index
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(tasks_params)
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
      redirect_to tasks_path, notice: '変更しました'
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
