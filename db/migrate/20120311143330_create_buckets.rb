class CreateBuckets < ActiveRecord::Migration
  def change
    create_table :buckets do |t|
      t.string :name
      t.integer :category_id
      t.integer :budgeted, :default => 0, :null => false
      t.integer :spent, :default => 0, :null => false
      t.timestamps
    end
  end
end
