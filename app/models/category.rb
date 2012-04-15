class Category < ActiveRecord::Base
  has_many :buckets, :dependent => :destroy
  accepts_nested_attributes_for :buckets
  attr_accessible :name, :buckets_attributes
end
