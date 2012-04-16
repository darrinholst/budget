class Category < ActiveRecord::Base
  default_scope :order => "sort_order ASC, id ASC"

  has_many :buckets, :dependent => :destroy
  accepts_nested_attributes_for :buckets
  attr_accessible :name, :buckets_attributes, :sort_order
end
