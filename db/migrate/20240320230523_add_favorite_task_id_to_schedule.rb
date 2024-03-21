class AddFavoriteTaskIdToSchedule < ActiveRecord::Migration[7.1]
  def change
    add_column :schedules, :favorite_task_id, :integer
  end
end
