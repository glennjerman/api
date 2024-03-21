class ChangeCompletedInTasks < ActiveRecord::Migration[7.1]
  def change
    change_column :tasks, :completed, :text
  end
end
