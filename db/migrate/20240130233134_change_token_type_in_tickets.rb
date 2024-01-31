class ChangeTokenTypeInTickets < ActiveRecord::Migration[7.0]
  def change
    change_column :tickets, :tokens, :float
  end
end
