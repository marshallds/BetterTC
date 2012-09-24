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

	def periods
		# loop though employees
			# loop though events (events are in clock order from the controller)
				# if event.punch_type == "IN"
					# if there an open row: uh oh, event.punchtime to currentrow.out
					# event.punchtime to newrow.in; event.job_id to newrow.job
					# event.job to newrow.job
				# if event.punch_type == "OUT"
					# if there is a open row: yay event.punchtime to currentrow.out
					# else: event.punchtime to newrow.in; event.punchtime to newrow.out
				# if event.punch_type == "LOG" 
					# currentrow.log += event.log
	end
end