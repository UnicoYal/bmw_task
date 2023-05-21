class Course < ApplicationRecord
  has_many :courses_user, dependent: :destroy
  has_many :lessons, dependent: :destroy
  has_one_attached :avatar, dependent: :destroy
end
