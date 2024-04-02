class AddStartTimeAndEndTimeToFavoriteTasks < ActiveRecord::Migration[7.1]
  def change
    add_column :favorite_tasks, :start_time, :datetime
    add_column :favorite_tasks, :end_time, :datetime
  end
end
