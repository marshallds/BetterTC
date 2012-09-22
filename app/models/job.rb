class Job < ActiveRecord::Base
  attr_accessible :active, :name, :hours
  has_many :events
  attr_accessor :hours 
end
