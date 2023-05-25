class CoursesController < ApplicationController
  before_action :autorize, only: %i[sign unsubscribe]
  def index
    @courses = Course.all
  end

  def show 
    @course = Course.find_by(id: params[:id])
    @lessons = Lesson.where(course_id: params[:id])
  end

  def sign
    @course = Course.find_by(id: params[:id])
    CoursesUser.create(user_id: current_user.id, course_id: @course.id)
    redirect_to show_cu_path
  end

  def unsubscribe
    @course = Course.find_by(id: params[:id])
    CoursesUser.destroy_by(user_id: current_user.id, course_id: @course.id)
    redirect_to show_cu_path
  end

  def edit
    @course = Course.find_by(id: params[:id])
  end

  def update
    @course = Course.find_by(id: params[:id])
    @course.update({title: params[:title], description: params[:description]})
    redirect_to show_cu_path
  end

  def create_course
  end

  def create
    Course.create({title: params[:title], description: params[:description], avatar: params[:avatar]})
    redirect_to home_path
  end

  def destroy
    @course = Course.find_by(id: params[:id])
    @course.destroy
    redirect_to home_path
  end

  private

  def course_params
    params.require(:course).permit(:avatar)
  end

end
