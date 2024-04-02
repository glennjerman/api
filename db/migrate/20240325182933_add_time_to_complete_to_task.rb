class AddTimeToCompleteToTask < ActiveRecord::Migration[7.1]
  def change
    add_column :tasks, :time_to_complete, :integer
  end
end
