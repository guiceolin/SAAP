class AddIndexToCrowds < ActiveRecord::Migration
  def change
    add_index :crowds, :professor_id
    add_index :crowds, :subject_id
  end
end
