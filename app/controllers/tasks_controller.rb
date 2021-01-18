class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  def index
    @tasks = Task.all.order(created_at: :desc)
    if params[:deadline]
      @tasks = Task.all.order(deadline: :desc)
    elsif params[:created_at]
      @tasks = Task.all.order(created_at: :desc)
    end
    if params[:task].present? && params[:status].present?
      @tasks = Task.where('task_name LIKE ?', "%#{params[:task_name]}%", status: params[:status])
    elsif params[:task_name].present?
      @tasks = Task.where('task_name LIKE ?', "%#{params[:task_name]}%")
    elsif params[:status].present?
      @tasks = Task.where(status: params[:status])
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if params[:back]
      render :new
    else
      if @task.save
        redirect_to tasks_path, notice: "タスクを作成しました"
      else
        render :new
      end
    end
  end

  def show
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice:"タスクを編集しました"
    else
      render :new
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice:"タスクを削除しました"
  end

  def confirm
    @task = Task.new(task_params)
    render :new if @task.invalid?
  end

  private
  def task_params
    params.require(:task).permit(:task_name, :detail, :deadline, :status, :priority)
  end

  def set_task
    @task = Task.find(params[:id])
  end
end
