class Lesson < ApplicationRecord
  belongs_to :course
  has_one :test
  has_many_attached :pictures, dependent: :destroy
  has_one_attached :file, dependent: :destroy
end
