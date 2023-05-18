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
    count_of_courses = Rating.find_by(user_id: current_user.id).all_courses
    Rating.find_by(user_id: current_user.id).update(all_courses: count_of_courses+1)
    redirect_to show_cu_path
  end

  def unsubscribe
    @course = Course.find_by(id: params[:id])
    UsersAndCourse.destroy_by(user_id: current_user.id, course_id: @course.id)
    count_of_courses = Rating.find_by(user_id: current_user.id).all_courses
    Rating.find_by(user_id: current_user.id).update(all_courses: count_of_courses-1)
    redirect_to show_cu_path
  end

  def edit
    @course = Course.find_by(id: params[:id])
  end

  def update
    @course = Course.find_by(id: params[:id])
    @course.update({title: params[:title], part_fr: params[:part_fr], part_sc: params[:part_sc], main: params[:main]})
    redirect_to show_cu_path
  end

end
