class AddJobsToEvents < ActiveRecord::Migration
  def change
    add_column :events, :jobs, :intergers
  end
end
