class IncomeBucket < ActiveRecord::Base
  default_scope :order => "sort_order ASC, id ASC"
end
