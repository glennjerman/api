class ChangeTables < ActiveRecord::Migration[7.1]
  def change
    remove_column :users, :start_time
    remove_column :users, :end_time
    add_column :tasks, :start_time, :datetime
    add_column :tasks, :end_time, :datetime
  end
end
