class Budget < ActiveRecord::Base
  has_many :categories
  has_many :income_buckets
  has_many :expense_buckets, :through => :categories, :source => :buckets

  def starts_on=(date)
    parsed = Chronic.parse(date)
    write_attribute(:starts_on, parsed) if parsed
  end
end
