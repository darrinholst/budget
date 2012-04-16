class Bucket < ActiveRecord::Base
  default_scope :order => "sort_order ASC, id ASC"
  attr_accessible :name, :budgeted, :spent, :sort_order
end
