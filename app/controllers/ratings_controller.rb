class RatingsController < ApplicationController
  def index
      @ratings = Rating.order("finished_courses desc")
  end
end
