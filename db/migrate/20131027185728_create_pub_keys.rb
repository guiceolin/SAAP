class CreatePubKeys < ActiveRecord::Migration
  def change
    create_table :pub_keys do |t|
      t.string :name
      t.string :value
      t.references :user
      t.foreign_key :users
    end
  end
end
