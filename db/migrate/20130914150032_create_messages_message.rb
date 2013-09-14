class CreateMessagesMessage < ActiveRecord::Migration
  def change
    create_table :messages_messages do |t|
      t.text :body
      t.references :sender, index: true
      t.references :topic, index: true
      t.timestamp
    end
  end
end
