class AddTimestampsToMessagesMessage < ActiveRecord::Migration
  def change
    change_table :messages_messages do |t|
      t.timestamps
    end
  end
end
