class Event < ActiveRecord::Base
  belongs_to :user
  belongs_to :job
  attr_accessible :log, :punchtime, :type
end
