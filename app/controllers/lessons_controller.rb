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
    les = Lesson.create({title: params[:title], part_fr: params[:part_fr], part_sc: params[:part_sc], main: params[:main], course_id: @course.id, number: @number, pictures: params[:pictures], file: params[:file]})
    CoursesUser.where(course_id: @course.id).each do |el|
      el.update(status: false)
      UsersLesson.create(user_id: el.user_id, lesson_id: les.id)
    end
    redirect_to show_cu_path
  end

  def destroy
    @lesson = Lesson.find_by(id: params[:id])
    @course = Course.find_by(id: @lesson.course_id)
    UsersLesson.where(lesson_id: @lesson.id).each {|el| el.destroy}
    @lesson.destroy
    @les_count = Lesson.where(course_id: @course.id).count
    CoursesUser.where(course_id: @course.id).each do |el|
      counter = el.finished_count
      if el.finished_count == @les_count
        el.update(status: true)
      end
    end
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
