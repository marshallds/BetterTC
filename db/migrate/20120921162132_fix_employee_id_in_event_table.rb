class FixEmployeeIdInEventTable < ActiveRecord::Migration
  def up
  	rename_column :events, :user_id, :employee_id
  end

  def down
  	rename_column :events, :employee_id, :user_id
  end
end
