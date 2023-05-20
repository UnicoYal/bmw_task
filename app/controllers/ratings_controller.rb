class RatingsController < ApplicationController
  def index
    @ratings = Rating.order("finished_courses desc")
  end

  # def download
  #   pdf = Prawn::Document.new
  #   pdf.text 'Employee rating'
  #   @ratings = Rating.order("finished_courses desc")
  #   k = 1
  #   @ratings.each do |el|
  #     @user = User.find_by(id: el.user_id)
  #     name = "#{@user.first_name} #{@user.second_name}"
  #     all_courses = el.all_courses
  #     finished_courses = el.finished_courses
  #     pdf.text "#{k}) #{name}; He is in: #{all_courses} courses; Finished: #{finished_courses} of them"
  #     k += 1
  #   end
  #   send_data(pdf.render,
  #             filename: 'Rating.pdf',
  #             type: 'application/pdf',
  #             disposition: 'inline')
  # end
end
