class Budget < ActiveRecord::Base
  belongs_to :user
  has_many :categories, :dependent => :destroy
  has_many :income_buckets, :dependent => :destroy
  has_many :expense_buckets, :through => :categories, :source => :buckets

  accepts_nested_attributes_for :income_buckets
  accepts_nested_attributes_for :categories

  validates :starts_on, :presence => true
  validates :ends_on, :presence => true

  def starts_on=(date)
    parsed = Timeliness.parse(date)
    write_attribute(:starts_on, parsed) if parsed
  end

  def ends_on=(date)
    parsed = Timeliness.parse(date)
    write_attribute(:ends_on, parsed) if parsed
  end

  def default_end_date!
    #sets the end date to 1 day before the next budget start date unless it's the last budget then
    #set it to 1 month - 1 day
    next_budget = user.budgets.order('starts_on').where('starts_on > ?', starts_on).first
    self.ends_on = next_budget ? (next_budget.starts_on - 1.day) : (starts_on + 1.month - 1.day)
    save!(validate: false)
  end
end
