class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.references :student, index: true
      t.references :group, index: true
      t.foreign_key :users, column: 'student_id', dependent: :delete
      t.foreign_key :groups, dependent: :delete
    end
  end
end
