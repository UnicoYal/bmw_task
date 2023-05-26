class Lesson < ApplicationRecord
  belongs_to :course
  has_one :test, dependent: :destroy
  has_one_attached :picture, dependent: :destroy
  has_one_attached :file, dependent: :destroy
  has_many :users_lessons, dependent: :destroy

  before_destroy :purge_file
  
  private
  
  def purge_file
    picture.purge if picture.attached?
    file.purge if file.attached?
  end
end
