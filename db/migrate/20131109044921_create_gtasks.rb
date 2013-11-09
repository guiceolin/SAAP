class CreateGtasks < ActiveRecord::Migration
  def change
    create_table :gtasks do |t|
      t.references :user, index: true
      t.foreign_key :users
      t.references :task, index: true
      t.foreign_key :tasks
      t.string :gevent_id
    end
  end
end
