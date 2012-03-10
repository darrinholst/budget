class CreateBudgets < ActiveRecord::Migration
  def change
    create_table :budgets do |t|
      t.date :starts_on
      t.timestamps
    end
  end
end
