class Student < ApplicationRecord
  has_many :exams, dependent: :destroy
end
