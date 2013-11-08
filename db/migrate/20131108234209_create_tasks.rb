class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.date :start_date
      t.date :end_date
      t.date :scheduled_start_date
      t.date :scheduled_end_date
      t.references :group, index: true
      t.foreign_key :groups
      t.string :description
      t.references :parent, index: true
      t.foreign_key :tasks, column: :parent_id

      t.timestamps
    end
  end
end
