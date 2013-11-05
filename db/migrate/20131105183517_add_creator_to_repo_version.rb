class AddCreatorToRepoVersion < ActiveRecord::Migration
  def change
    add_reference :repo_versions, :creator, index: true
    add_foreign_key :repo_versions, :users, column: :creator_id
  end
end
