class DefaultExistingEndDates < ActiveRecord::Migration
  def up
    Budget.all.each {|b| b.default_end_date!}
  end

  def down
  end
end
