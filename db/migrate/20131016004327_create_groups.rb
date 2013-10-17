class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.references :enunciation, index: true
      t.foreign_key :enunciations

      t.timestamps
    end
  end
end
