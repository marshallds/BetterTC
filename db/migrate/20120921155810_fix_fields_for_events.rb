class FixFieldsForEvents < ActiveRecord::Migration
  def up
  	rename_column :events, :jobs, :job_id
  	change_column :events, :punchtime, :datetime
  end

  def down
  	rename_column :events, :job_id, :jobs
  	change_column :events, :punchtime, :integer
  end
end
