class CreateFavoriteTasks < ActiveRecord::Migration[7.1]
  def change
    create_table :favorite_tasks do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.string :desc

      t.timestamps
    end
  end
end
