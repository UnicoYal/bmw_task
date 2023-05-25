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
    if Lesson.where(course_id: @course.id).count == nil
      @number = 1 
    else
      @number = Lesson.where(course_id: @course.id).count + 1
    end
    Lesson.create({title: params[:title], part_fr: params[:part_fr], part_sc: params[:part_sc], main: params[:main], course_id: @course.id, number: @number, pictures: params[:pictures], file: params[:file]})
    redirect_to show_cu_path
  end

  def destroy
    @lesson = Lesson.find_by(id: params[:id])
    @course = Course.find_by(id: @lesson.course_id)
    @lesson.destroy
    redirect_to "/courses/show/#{@course.id}"
  end

  def edit
    @lesson = Lesson.find_by(id: params[:id])
  end

  def update
    @lesson = Lesson.find_by(id: params[:id])
    if params[:pictures] == [""] && params[:file] == nil
      @lesson.update({title: params[:title], part_fr: params[:part_fr], part_sc: params[:part_sc], main: params[:main]})
    elsif params[:pictures] != [""] && params[:file] == nil
      @lesson.update({title: params[:title], part_fr: params[:part_fr], part_sc: params[:part_sc], main: params[:main], pictures: params[:pictures]})
    elsif params[:pictures] == [""] && params[:file] != nil
      @lesson.update({title: params[:title], part_fr: params[:part_fr], part_sc: params[:part_sc], main: params[:main], file: params[:file]})
    else
      @lesson.update({title: params[:title], part_fr: params[:part_fr], part_sc: params[:part_sc], main: params[:main], pictures: params[:pictures], file: params[:file]})
    end
    redirect_to show_les_path
  end

  private

  def lessons_params
    params.require(:lesson).permit(:file, pictures: [])
  end
end
