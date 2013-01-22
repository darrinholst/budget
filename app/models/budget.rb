class Budget < ActiveRecord::Base
  has_many :categories, :dependent => :destroy
  has_many :income_buckets, :dependent => :destroy
  has_many :expense_buckets, :through => :categories, :source => :buckets

  accepts_nested_attributes_for :income_buckets
  accepts_nested_attributes_for :categories

  validates :starts_on, :presence => true

  def starts_on=(date)
    parsed = Timeliness.parse(date)
    write_attribute(:starts_on, parsed) if parsed
  end
end
