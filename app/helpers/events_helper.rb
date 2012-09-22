module EventsHelper
	def job_totals 
		jobs = Job.where({:active => true})


		jobs.each do |job|
			job.hours = 0		
			Employee.all.each do |employee|
				job_users_events = employee.events.where :job_id => job.id
				job_users_events.each do |event|
					job.hours -= event.punchtime.to_i if event.punch_type == "IN"
					job.hours += event.punchtime.to_i if event.punch_type == "OUT" 
						
				end
			end
			job.hours /= 3600.0

		end
		jobs
	end
end
