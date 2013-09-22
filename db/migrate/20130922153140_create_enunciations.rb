class CreateEnunciations < ActiveRecord::Migration
  def change
    create_table :enunciations do |t|
      t.string :name
      t.string :description
      t.date :end_at
      t.references :crowd, index: true

      t.timestamps
    end
  end
end
