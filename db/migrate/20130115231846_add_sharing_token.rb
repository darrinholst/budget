class AddSharingToken < ActiveRecord::Migration
  def change
    add_column :budgets, :token, :string
  end
end
