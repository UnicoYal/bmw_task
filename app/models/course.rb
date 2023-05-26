class Course < ApplicationRecord
  has_many :courses_user, dependent: :destroy
  has_many :lessons, dependent: :destroy
  has_one_attached :avatar, dependent: :destroy
  before_destroy :purge_attached_file
  
  private
  
  def purge_attached_file
    avatar.purge if avatar.attached?
  end
end
