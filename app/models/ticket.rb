class Ticket < ApplicationRecord
  validates :burger_quantity, presence: true
end
