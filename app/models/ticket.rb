class Ticket < ApplicationRecord
  validates :burger_quantity, presence: true, numericality: { greater_than: 0 }
end
