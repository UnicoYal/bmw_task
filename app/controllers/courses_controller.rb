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
    @course.update({title: params[:title], description: params[:description]})
    redirect_to show_cu_path
  end

  def add_user
    @course = Course.find_by(id: params[:id])
    @wrong_users = UsersAndCourse.where(course_id: @course.id).map {|el| el.user_id}
    @users = User.where.not(id: @wrong_users)
  end

  def adding_to_course
    UsersAndCourse.create({user_id: params[:user_id], course_id: params[:id]}) 
    count_of_courses = Rating.find_by(user_id: params[:user_id]).all_courses
    Rating.find_by(user_id: params[:user_id]).update(all_courses: count_of_courses+1)
    redirect_to show_cu_path
  end

  def remove_user
    @course = Course.find_by(id: params[:id])
    @good_users = UsersAndCourse.where(course_id: @course.id, status: false).map {|el| el.user_id}
    @users = User.where(id: @good_users)
  end

  def removing_from_course
    UsersAndCourse.find_by({user_id: params[:user_id], course_id: params[:id]}).destroy 
    count_of_courses = Rating.find_by(user_id: params[:user_id]).all_courses
    Rating.find_by(user_id: params[:user_id]).update(all_courses: count_of_courses-1)
    redirect_to show_cu_path
  end

  def create_course

  end

  def create
    Course.create({title: params[:title], description: params[:description], avatar: params[:avatar]})
    redirect_to home_path
  end

  private

  def course_params
    params.require(:course).permit(:avatar)
  end

end
