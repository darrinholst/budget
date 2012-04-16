class IncomeBucket < ActiveRecord::Base
  default_scope :order => "sort_order ASC, id ASC"
  attr_accessible :name, :budgeted, :sort_order
end
