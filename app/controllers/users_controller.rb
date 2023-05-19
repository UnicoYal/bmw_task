# frozen_string_literal: true

# User controller
class UsersController < ApplicationController
  before_action :no_autorize, only: %i[new create]
  before_action :autorize, only: %i[edit update get_my_courses]
  include UsersHelper

  def index
    @users = User.all
    p @users
  end

  def new
    @user = User.new
  end

  def edit; end

  def create
    @user = User.new(user_params)
    return unless @user.save
    session[:user_id] = @user.id
    Rating.create(user_id: @user.id, all_courses: 0, finished_courses: 0)
    # UserMailer.with(user: @user).welcome_email.deliver_now
    # flash[:success] = 'На почту выслано письмо, подтвердите, пожалуйста'
    redirect_to home_path
  end

  def update
    @flag = false
    return unless current_user.update user_params

    @flag = true
    flash[:notice] = 'Профиль обновлен'
  end

  def profile
  end

  def get_my_courses
    @my_courses = UsersAndCourse.where(user_id: current_user.id)
    @param = params[:param]
  end

  def update_role
    @user = User.find_by(id: params[:id])
  end

  def changing_role
    @user = User.find_by(id: params[:id])
    @user.update!(role: params[:role])
    redirect_to all_path
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :second_name, :password, :password_confirmation, :phone, :old_password, :role)
  end
end