class CoursesController < ApplicationController
  before_action :autorize, only: %i[sign unsubscribe]
  def index
    @courses = Course.all
  end

  def show 
    @course = Course.find_by(id: params[:id])
  end

  def sign
    @course = Course.find_by(id: params[:id])
    UsersAndCourse.create(user_id: current_user.id, course_id: @course.id)
    redirect_to show_cu_path
  end

  def unsubscribe
    @course = Course.find_by(id: params[:id])
    UsersAndCourse.destroy_by(user_id: current_user.id, course_id: @course.id)
    redirect_to show_cu_path
  end

end
