class AddAmounts < ActiveRecord::Migration
  def change
    add_column :buckets, :budgeted_cents, :integer, :default => 0, :null => false
    add_column :buckets, :spent_cents, :integer, :default => 0, :null => false
  end
end
