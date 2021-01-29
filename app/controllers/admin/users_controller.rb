class Admin::UsersController < ApplicationController
before_action :set_user, only:[:show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    User.create(user_params)
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
  end

  def destroy
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end


end
