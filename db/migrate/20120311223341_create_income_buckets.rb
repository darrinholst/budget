class CreateIncomeBuckets < ActiveRecord::Migration
  def change
    create_table :income_buckets do |t|
      t.string  :name
      t.integer :budget_id
      t.integer :budgeted
      t.timestamps
    end
  end
end
