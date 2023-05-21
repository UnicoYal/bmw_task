class Test < ApplicationRecord
  belongs_to :lesson
  has_many :questions, dependent: :destroy
end
