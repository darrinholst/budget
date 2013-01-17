class AddItemizations < ActiveRecord::Migration
  def change
    create_table(:itemizations) do |t|
      t.string :name
      t.integer :bucket_id
      t.integer :spent, :default => 0, :null => false
      t.timestamps
    end
  end
end
