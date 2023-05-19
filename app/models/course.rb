class Course < ApplicationRecord
  has_and_belongs_to_many :users
  has_many :lessons
  has_many_attached :pictures, dependent: :destroy
  has_one_attached :file, dependent: :destroy
  has_one_attached :avatar
end
