class Destination < ApplicationRecord
  belongs_to :trip, inverse_of: :destinations
  validates :city, :state, :arrival_date, :departure_date, presence: true
end
