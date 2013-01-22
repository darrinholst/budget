class Bucket < ActiveRecord::Base
  default_scope :order => "sort_order ASC, id ASC"
  has_many :itemizations, :dependent => :destroy
  accepts_nested_attributes_for :itemizations
end
