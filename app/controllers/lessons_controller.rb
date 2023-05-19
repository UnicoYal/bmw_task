class LessonsController < ApplicationController
  def index
  end

  def new
    @course = Course.find_by(id: params[:id])
  end

  def show
    @lesson = Lesson.find_by(id: params[:id])
  end

  def create
    @course = Course.find_by(id: params[:id])
    if Lesson.where(course_id: @course.id).count != nil
      @number = 1 
    else
      @number = Lesson.where(course_id: @course.id).count + 1
    end
    Lesson.create({title: params[:title], part_fr: params[:part_fr], part_sc: params[:part_sc], main: params[:main], course_id: @course.id, number: @number, pictures: params[:pictures], file: params[:file]})
    redirect_to home_path
  end

  private

  def lessons_params
    params.require(:lesson).permit(:file, pictures: [])
  end
end
