class Budget < ActiveRecord::Base
  has_many :categories
  has_many :buckets, :through => :categories

  validates :starts_on, :presence => {message: "must be a valid date"}

  include BucketAggregator

  def starts_on=(date)
    write_attribute(:starts_on, Chronic.parse(date) || date)
  end
end
