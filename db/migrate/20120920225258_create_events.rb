class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.references :user
      t.string :type
      t.integer :punchtime
      t.text :log

      t.timestamps
    end
    add_index :events, :user_id
  end
end
