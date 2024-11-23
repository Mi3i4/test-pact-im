class User < ApplicationRecord
  has_and_belongs_to_many :interests
  has_and_belongs_to_many :skills, class_name: 'Skill'

  validates :name, presence: true
  validates :surname, presence: true
  validates :email, presence: true, uniqueness: true
  validates :age, presence: true, numericality: { greater_than: 0, less_than: 90 }
  validates :gender, presence: true, inclusion: { in: ['male', 'female'] }
end
