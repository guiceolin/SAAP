class CreateCrowds < ActiveRecord::Migration
  def change
    create_table :crowds do |t|
      t.string :name
      t.integer :semester
      t.integer :year
      t.string :code
      t.belongs_to :professor
      t.belongs_to :subject

      t.timestamps
    end
  end
end
