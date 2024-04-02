class ChangeUsers < ActiveRecord::Migration[7.1]
  def change
    remove_column :users, :time_to_complete
    add_column :users, :start_time, :datetime
    add_column :users, :end_time, :datetime
  end
end
