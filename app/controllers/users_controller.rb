# frozen_string_literal: true

# User controller
class UsersController < ApplicationController
  before_action :no_autorize, only: %i[new create]
  before_action :autorize, only: %i[edit update get_my_courses]
  include UsersHelper

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def edit; end

  def create
    @user = User.new(user_params)
    return unless @user.save
    session[:user_id] = @user.id
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
    @my_courses = CoursesUser.where(user_id: current_user.id)
    @rdy_courses = []
    @not_rdy_courses = []
    @my_courses.each do |el| 
      @course = Course.find_by(id: el.course_id)
      curr_hash = {}
      if el.status == false
        @pass_count = CoursesUser.find_by(user_id: current_user.id, course_id: @course.id)
        if @pass_count == nil
          @pass_count = 0
        else
          @pass_count = @pass_count.finished_count
        end
        @all = Lesson.where(course_id: @course.id).count
        @percent = @pass_count*100/@all
        curr_hash[:course] = @course
        curr_hash[:percent] = @percent
        @rdy_courses.push(curr_hash)
      else
        @not_rdy_courses.push(@course)
      end
    end
    @param = params[:param]
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :second_name, :patronymic,:password, :password_confirmation, :phone, :old_password, :role)
  end
end