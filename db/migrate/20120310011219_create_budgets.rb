class CreateBudgets < ActiveRecord::Migration
  def change
    create_table :budgets do |t|
      t.date :starts_on
      t.integer :actual_balance, :default => 0, :null => false
      t.timestamps
    end
  end
end
