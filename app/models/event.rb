class Event < ActiveRecord::Base
  belongs_to :user
  attr_accessible :log, :punchtime, :type
end
