class Itemization < ActiveRecord::Base
  default_scope :order => "created_at ASC"
  attr_accessible :name, :spent
end
