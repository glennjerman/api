class RenameWednsdayToWednesdayInSchedules < ActiveRecord::Migration[7.1]
  def change
    rename_column :schedules, :wednsday, :wednesday
  end
end
