class CreateRepoVersions < ActiveRecord::Migration
  def change
    create_table :repo_versions do |t|
      t.string :name
      t.string :type
      t.references :group, index: true
      t.foreign_key :groups

      t.timestamps
    end
  end
end
