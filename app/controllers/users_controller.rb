class UsersController < ApplicationController
  before_action :require_user, except: [:new, :create]
  before_action :redirect_user, only: [:new, :create]

  def show
    @user = current_user
    @leagues = [@user.admin_leagues, @user.member_leagues]
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to dashboard_path
    else
      render :new
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to dashboard_path
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :first_name, :last_name, :invited)
  end
end
