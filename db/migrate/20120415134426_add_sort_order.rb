class AddSortOrder < ActiveRecord::Migration
  def up
    add_column :buckets, :sort_order, :integer, :default => 0
    add_column :categories, :sort_order, :integer, :default => 0
    add_column :income_buckets, :sort_order, :integer, :default => 0
  end

  def down
  end
end
