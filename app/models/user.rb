class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
  has_many :budgets
  has_many :categories, :through => :budgets
  has_many :buckets, :through => :categories
end
