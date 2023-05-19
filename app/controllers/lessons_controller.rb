class LessonsController < ApplicationController
  def index
  end

  def show
    @lesson = Lesson.find_by(id: params[:id])
  end
end
