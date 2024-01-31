class AddDrinksToTickets < ActiveRecord::Migration[7.0]
  def change
    add_column :tickets, :veggie_quantity, :integer
    add_column :tickets, :drink_quantity, :integer
  end
end
