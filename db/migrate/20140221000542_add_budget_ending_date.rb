class AddBudgetEndingDate < ActiveRecord::Migration
  def change
    add_column :budgets, :ends_on, :date
  end
end
