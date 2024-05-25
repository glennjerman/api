class AddPermanentToTasks < ActiveRecord::Migration[7.1]
  def change
    add_column :tasks, :permanent, :boolean
  end
end
