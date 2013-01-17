class Bucket < ActiveRecord::Base
  default_scope :order => "sort_order ASC, id ASC"
  has_many :itemizations
  accepts_nested_attributes_for :itemizations
  attr_accessible :name, :budgeted, :spent, :sort_order, :itemizations_attributes
end
