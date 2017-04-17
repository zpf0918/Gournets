class Job < ApplicationRecord

  validates :title, :description, presence: true
  validates :wage_upper_bound, :wage_lower_bound, presence: true
  validates :wage_lower_bound, numericality: { greater_than: 3000} 
end
