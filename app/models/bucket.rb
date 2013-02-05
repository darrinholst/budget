class Bucket < ActiveRecord::Base
  default_scope :order => "sort_order ASC, id ASC"
  has_many :itemizations, :dependent => :destroy
end
