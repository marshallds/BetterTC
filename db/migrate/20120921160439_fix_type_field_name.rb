class FixTypeFieldName < ActiveRecord::Migration
  def up
  	rename_column :events, :type, :punch_type
  end

  def down
  	rename_column :events, :punch_type, :type
  end
end
