class Event < ActiveRecord::Base
  belongs_to :employee
  belongs_to :job
  attr_accessible :log, :punchtime, :punch_type, :job_id, :employee_id
end
