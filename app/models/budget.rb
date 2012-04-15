class Budget < ActiveRecord::Base
  has_many :categories, :dependent => :destroy
  has_many :income_buckets, :dependent => :destroy
  has_many :expense_buckets, :through => :categories, :source => :buckets

  accepts_nested_attributes_for :income_buckets
  accepts_nested_attributes_for :categories

  attr_accessible :starts_on, :actual_balance, :income_buckets_attributes, :categories_attributes

  def starts_on=(date)
    parsed = Chronic.parse(date)
    write_attribute(:starts_on, parsed) if parsed
  end
end
