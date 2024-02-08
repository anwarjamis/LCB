class Ticket < ApplicationRecord
  validates :burger_quantity, presence: true

  def self.ransackable_attributes(auth_object = nil)
    ["burger_quantity", "created_at", "drink_quantity", "id", "promo", "tokens", "updated_at", "veggie_quantity"]
  end
end
