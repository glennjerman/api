class ChangeTaskIdInSchedules < ActiveRecord::Migration[7.1]
  def change
    change_column_null :schedules, :task_id, true
  end
end
