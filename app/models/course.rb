class Course < ApplicationRecord
  has_many :courses_user
  has_many :lessons
  has_one_attached :avatar
end
