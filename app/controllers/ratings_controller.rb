class RatingsController < ApplicationController
  def index
    @ratings = {}
    CoursesUser.all.each do |el|
      @ratings[el.user_id] ||= 0
      @ratings[el.user_id] += 1
    end
  end
end
