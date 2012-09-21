class Job < ActiveRecord::Base
  attr_accessible :active, :name
  has_many :events
end
