class ActualBalance < ActiveRecord::Migration
  def change
    add_column :budgets, :actual_balance_cents, :integer, :default => 0, :null => false
  end
end
