class Budget < ActiveRecord::Base
  validates :starts_on, :presence => {message: "must be a valid date"}

  def starts_on=(date)
    write_attribute(:starts_on, Chronic.parse(date) || date)
  end
end
