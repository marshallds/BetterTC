class EventsController < ApplicationController
  # GET /events
  # GET /events.json
  def index
    @events = Event.order :punchtime
    @events = @events.where :employee_id => params[:employee_id] if params[:employee_id]

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @events }
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @event = Event.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/new
  # GET /events/new.json
  def new
    @event = Event.new
    @jobs = Job.where({:active => true})
    @users = Employee.order(:lastname)
    @types = ['IN','OUT','LOG']

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
    @jobs = Job.where({:active => true})
    @users = Employee.order(:firstname)
    @types = ['IN','OUT','LOG']
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(params[:event])

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render json: @event, status: :created, location: @event }
      else
        format.html { render action: "new" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.json
  def update
    @event = Event.find(params[:id])

    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    respond_to do |format|
      format.html { redirect_to events_url }
      format.json { head :no_content }
    end
  end

  def periods
    rows = Array.new
    Employee.all.each do |employee| # loop though employees
      events = employee.events.order :punchtime
      events.each do |event| # loop though events (events are in clock order)
          rows.push Hash.new if ! rows.length || rows.last[:out]
          rows.last[:in] = event.punchtime
=begin
        if event.punch_type == "IN"
          if rows.last :out == nil
            rows.last :out = event.punchtime # if there an open rows.last: uh oh, event.punchtime to currentrow.out
          end
          rows.push Hash.new if ! rows.length || rows.last[:out]
          rows.last :in = event.punchtime # event.punchtime to newrow.in; event.job_id to newrow.job
          rows.last :job = event.job_id
        elsif event.punch_type == "OUT"
          if rows.last :out != nil
            rows.push Hash.new
            rows.last :in = event.punchtime # event.punchtime to newrow.in; event.job_id to newrow.job
            # else: event.punchtime to newrow.in; event.punchtime to newrow.out
            rows.last :out = event.punchtime # if there is a open row: yay event.punchtime to currentrow.out
          else 
            rows.last :out = event.punchtime # if there is a open row: yay event.punchtime to currentrow.out
          end
        end  
        currentrow :log += "\n" + event.log if event.log != nil
=end

      end
    end
    hash = { :log => "something" }
    rows.push(hash)
    rows
  end


  # Report view
  # GET /events/report
  def report
    @events = Event.order :punchtime
    @events = @events.where :employee_id => params[:employee_id] if params[:employee_id]
    @events = @events.where :job_id => params[:job_id] if params[:job_id]

    @jobs = Job.where({:active => true})
    @employees = Employee.order(:lastname)

    @periods = periods

    respond_to do |format|
      format.html # report.html.erb
      format.json { render json: periods }
    end
  end

end