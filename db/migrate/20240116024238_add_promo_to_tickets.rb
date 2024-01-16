class AddPromoToTickets < ActiveRecord::Migration[7.0]
  def change
    add_column :tickets, :promo, :boolean
  end
end
