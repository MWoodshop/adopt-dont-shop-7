class Applicant < ApplicationRecord
  has_many :applicants_pets
  has_many :pets, through: :applicants_pets

  validates :name, presence: true
  validates :street_address, presence: true
  validates :city, presence: true
  validates :zip_code, presence: true, numericality: true
  # validates :description, presence: true
  validates :status, presence: true
end
