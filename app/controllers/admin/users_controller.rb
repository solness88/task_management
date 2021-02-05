class Admin::UsersController < ApplicationController
before_action :set_user, only:[:show, :edit, :update, :destroy]
before_action :authenticate_user

  def index
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if params[:back]
      render :new
    else
      if @user.save
        redirect_to admin_users_path, notice: "ユーザーを作成しました"
      else
        render :new
      end
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path, notice:"ユーザーを編集しました"
    else
      render :new
    end
  end

  def show
    @user_tasks = User.where(id:params[:id])
    @user_task = User.where(id:params[:id]).count
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path, notice:"ユーザーを削除しました"
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def authenticate_user
    @users = User.all
    if logged_in?
      render action: "index"
    else
      redirect_to tasks_path, notice:"管理者以外はアクセスできません"
    end
  end
end
