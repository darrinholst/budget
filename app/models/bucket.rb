class Bucket < ActiveRecord::Base
  attr_accessible :name, :budgeted, :spent
end
