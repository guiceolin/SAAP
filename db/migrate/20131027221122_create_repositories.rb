class CreateRepositories < ActiveRecord::Migration
  def change
    create_table :repositories do |t|
      t.string :name
      t.string :url
      t.references :group
      t.foreign_key :groups
      t.timestamps
    end
  end
end
