class CreateActivityLog < ActiveRecord::Migration
  def change
    create_table :activity_logs do |t|
      t.references :user, index: true
      t.foreign_key :users
      t.references :item, index: true, polymorphic: true
      t.string :action
      t.string :serialized_object
      t.datetime :occurred_at

    end
  end
end
