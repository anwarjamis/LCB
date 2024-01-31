class AddTokensToTickets < ActiveRecord::Migration[7.0]
  def change
    add_column :tickets, :tokens, :integer
  end
end
