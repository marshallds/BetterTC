class Employee < ActiveRecord::Base
  attr_accessible :firstname, :lastname, :username
end
