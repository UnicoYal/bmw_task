class RatingsController < ApplicationController
  def index
   hash = {}
    CoursesUser.all.each do |el|
      hash[el.user_id] ||= 0
      hash[el.user_id] += 1
    end
    sorted_array = hash.sort_by { |key, value| -value }
    @ratings = Hash[sorted_array]
  end
end
