class AdminsController < ApplicationController

  def modal_create_user
  end

  def create_user
   @user = User.new(user_params)
   return unless @user.save
   Rating.create(user_id: @user.id, all_courses: 0, finished_courses: 0)
   redirect_to all_path
 end

  def update_role
    @user = User.find_by(id: params[:id])
  end

  def changing_role
    @user = User.find_by(id: params[:id])
    @user.update!(role: params[:role])
    redirect_to all_path
  end

  def add_user
    @course = Course.find_by(id: params[:id])
    @wrong_users = CoursesUser.where(course_id: @course.id).map {|el| el.user_id}
    @users = User.where.not(id: @wrong_users)
  end

  def adding_to_course
    CoursesUser.create({user_id: params[:user_id], course_id: params[:id]}) 
    count_of_courses = Rating.find_by(user_id: params[:user_id]).all_courses
    Rating.find_by(user_id: params[:user_id]).update(all_courses: count_of_courses+1)
    redirect_to show_cu_path
  end

  def remove_user
    @course = Course.find_by(id: params[:id])
    @good_users = CoursesUser.where(course_id: @course.id, status: false).map {|el| el.user_id}
    @users = User.where(id: @good_users)
  end

  def removing_from_course
    CoursesUser.find_by({user_id: params[:user_id], course_id: params[:id]}).destroy 
    count_of_courses = Rating.find_by(user_id: params[:user_id]).all_courses
    Rating.find_by(user_id: params[:user_id]).update(all_courses: count_of_courses-1)
    redirect_to show_cu_path
  end

  def destroy_user
    User.find_by(id: params[:id]).destroy
    redirect_to all_path
  end

  private
  def user_params
    params.permit(:email, :first_name, :second_name, :patronymic,:password, :password_confirmation, :phone, :role)
  end

end
