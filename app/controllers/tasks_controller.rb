class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = Task.where(user_id:current_user.id).order(created_at: :desc).page(params[:page]).per(10)
    if params[:deadline]
      @tasks = Task.where(user_id:current_user.id).order(deadline: :desc).page(params[:page]).per(10)
    elsif params[:created_at]
      @tasks = Task.where(user_id:current_user.id).order(created_at: :desc).page(params[:page]).per(10)
    elsif params[:priority]
      @tasks = Task.where(user_id:current_user.id).order(priority: :asc).page(params[:page]).per(10)
    end

    @tasks = @tasks.joins(:labels).where(labels: { id: params[:label_id] }) if params[:label_id].present?

    if params[:task_name].present? && params[:status].present?
      @tasks = Task.where(user_id:current_user.id).task_name(params[:task_name]).status(params[:status]).page(params[:page]).per(10)
    elsif params[:task_name].present?
      @tasks = Task.where(user_id:current_user.id).task_name(params[:task_name]).page(params[:page]).per(10)
    elsif params[:status].present?
      @tasks = Task.where(user_id:current_user.id).status(params[:status]).page(params[:page]).per(10)
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.build(task_params)
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
    @labels = @task.labels
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
    @task = current_user.tasks.build(task_params)
    @labels = @task.labels
    render :new if @task.invalid?
  end

  private
  def task_params
    params.require(:task).permit(:task_name, :detail, :deadline, :status, :priority, label_ids: [] )
  end

  def set_task
    @task = Task.find(params[:id])
  end
end
