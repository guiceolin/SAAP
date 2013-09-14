class CreateTopics < ActiveRecord::Migration
  def change
    create_table :messages_topics do |t|
      t.references :circle, index: true, polymorphic: true
      t.references :creator, index: true, polymorphic: true
      t.string :subject
      t.boolean :approved, default: true

      t.timestamps
    end
  end
end
