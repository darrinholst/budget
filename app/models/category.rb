class Category < ActiveRecord::Base
  has_many :buckets, :dependent => :destroy
end
